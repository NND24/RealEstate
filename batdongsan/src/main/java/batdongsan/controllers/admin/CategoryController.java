package batdongsan.controllers.admin;

import java.sql.Date;
import java.util.Calendar;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import batdongsan.models.CategoryModel;
import batdongsan.models.EmployeeModel;
import batdongsan.models.NewsModel;
import batdongsan.models.PermissionModel;
import batdongsan.models.RoleModel;
import batdongsan.utils.Vadilator;

@Controller
@RequestMapping("/admin/")
public class CategoryController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("listCategory")
	public String index(ModelMap model, HttpServletRequest request,
			@RequestParam(name = "searchInput", required = false) String searchInput,
            @RequestParam(name = "pageAll", defaultValue = "1") int pageAll,
            @RequestParam(name = "size", defaultValue = "5") int size) {
		Session session = factory.openSession();
		try {
			String hql = "FROM CategoryModel c WHERE 1=1";
	        if (searchInput != null && !searchInput.isEmpty()) {
	            hql += " AND (c.name LIKE :searchInput OR c.type LIKE :searchInput)";
	        }
	        hql += " ORDER BY categoryId ASC";
	        Query<CategoryModel> queryAll = session.createQuery(hql, CategoryModel.class);
	        if (searchInput != null && !searchInput.isEmpty()) {
	            queryAll.setParameter("searchInput", "%" + searchInput + "%");
	        }
	        int totalAllResults = queryAll.list().size();
	        queryAll.setFirstResult((pageAll - 1) * size);
	        queryAll.setMaxResults(size);

	        List<CategoryModel> allCategories = queryAll.list();

	        request.setAttribute("categories", allCategories);
	        request.setAttribute("currentAllPage", pageAll);
	        request.setAttribute("totalAllResults", totalAllResults);
	        request.setAttribute("totalAllPages", (int) Math.ceil((double) totalAllResults / size));

	        EmployeeModel emp = getEmployeeFromCookies(request);
	        if (emp != null) {
	            model.addAttribute("loginEmp", emp);
	            List<Integer> permissions = getPermissions(emp.getId(), session);
	            model.addAttribute("permissions", permissions);
	        } else {
	            model.addAttribute("employee", null);
	            model.addAttribute("permissions", Collections.emptyList());
	        }
	        return "admin/Category/listCategory";
	    } finally {
	    	session.close();
	    }		
	}

	// Thêm danh mục
	@RequestMapping(value = "listCategory/add", method = RequestMethod.GET)
	public String add(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		loadListOfCategory(model);
		EmployeeModel emp = getEmployeeFromCookies(request);
        if (emp != null) {
        	model.addAttribute("loginEmp", emp);
        	List<Integer> permissions = getPermissions(emp.getId(), session);
            model.addAttribute("permissions", permissions);
        } else {
            model.addAttribute("employee", null);
            model.addAttribute("permissions", Collections.emptyList());
        }
        
		return "admin/Category/listCategoryAdd";
	}

	@Transactional
	@RequestMapping(value = "listCategory/addCategory", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @ModelAttribute("category") CategoryModel category,
			BindingResult errors) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		if (category.getName() == null || category.getName().isEmpty()) {
			errors.rejectValue("name", "category", "Vui lòng nhập tên danh mục!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Có lỗi");
			String hql = "FROM CategoryModel";
			Query query = session.createQuery(hql);
			List<CategoryModel> list = query.list();
			model.addAttribute("categories", list);
			return "admin/Category/listCategoryAdd";
		} else {
			try {
				category.setName(category.getName());
				category.setType(category.getType());
				category.setStatus(category.getStatus());
				session.save(category);
				t.commit();
			} catch (Exception e) {
				t.rollback();
				model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
			} finally {
				session.close();
			}
			return "redirect:/admin/listCategory.html";
		}
	}

	// Cập nhật danh mục
	@RequestMapping(value = "listCategory/update/{categoryId}", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("categoryId") int categoryId,  HttpServletRequest request) {
		Session session = factory.openSession();
		String hql = "FROM CategoryModel";
		Query query = session.createQuery(hql);
		List<CategoryModel> list = query.list();
		model.addAttribute("categories", list);
		model.addAttribute("category", new CategoryModel());
		CategoryModel category = (CategoryModel) session.get(CategoryModel.class, categoryId);
		model.addAttribute("category", category);
		EmployeeModel emp = getEmployeeFromCookies(request);
        if (emp != null) {
        	model.addAttribute("loginEmp", emp);
        	List<Integer> permissions = getPermissions(emp.getId(), session);
            model.addAttribute("permissions", permissions);
        } else {
            model.addAttribute("employee", null);
            model.addAttribute("permissions", Collections.emptyList());
        }
		return "admin/Category/listCategoryUpdate";
	}

	@RequestMapping(value = "listCategory/update/{categoryId}", method = RequestMethod.POST)
	public String updateCategory(ModelMap model, @ModelAttribute("category") CategoryModel category,
			BindingResult errors, HttpServletRequest request) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		if (category.getName() == null || category.getName().isEmpty()) {
			errors.rejectValue("name", "category", "Vui lòng nhập tên danh mục!");
		}
		if (errors.hasErrors()) {
			model.addAttribute("message", "Có lỗi");
			loadListOfCategory(model);
			return "admin/Category/listCategoryUpdate";
		}
		try {
			CategoryModel existingCategory = (CategoryModel) session.get(CategoryModel.class, category.getCategoryId());
			if (existingCategory != null) {
				existingCategory.setName(category.getName());
				existingCategory.setType(category.getType());
				existingCategory.setStatus(category.getStatus());
				session.update(existingCategory);
				t.commit();
				model.addAttribute("message", "Cập nhật thành công");
			}
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		// Chuyển hướng người dùng về trang danh sách các danh mục sau khi cập nhật
		return "redirect:/admin/listCategory.html";
	}

	@RequestMapping(value = "update/cancel", method = RequestMethod.GET)
	public String cancelUpdate() {
		// Redirect về trang danh sách danh mục
		return "redirect:/admin/listCategory.html";
	}

	// Xóa danh mục
	@RequestMapping(value = "listCategory/delete/{categoryId}", method = RequestMethod.GET)
	public String deleteCategory(ModelMap model, @PathVariable("categoryId") int categoryId) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			CategoryModel categoryToDelete = session.get(CategoryModel.class, categoryId);
			if (categoryToDelete != null) {
				session.delete(categoryToDelete);
				t.commit();
				model.addAttribute("message", "Xóa thành công!");
			} else {
				model.addAttribute("message", "Không tồn tại!");
			}
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Xóa thất bại!");
		} finally {
			session.close();
		}
		return "redirect:/admin/listCategory.html";
	}

	// =======================================
	private void loadListOfCategory(ModelMap model) {
		Session session = factory.openSession();
		String hql = "FROM CategoryModel";
		Query query = session.createQuery(hql);
		List<CategoryModel> list = query.list();
		model.addAttribute("categories", list);
		model.addAttribute("category", new CategoryModel());
		session.close();
	}
	
	// lấy id Nhân viên từ khi đăng nhập
		private EmployeeModel getEmployeeFromCookies(HttpServletRequest request) {
			Session session = factory.openSession();
			Cookie[] cookies = request.getCookies();
		    String empId = null;

		    if (cookies != null) {
		        for (Cookie cookie : cookies) {
		            if (cookie.getName().equals("id")) {
		                empId = cookie.getValue();
		                System.out.println(empId);
		                break;
		            }
		        }
		    }

		    if (empId != null) {
		        String hqlEmp = "FROM EmployeeModel WHERE id = :id";
		        Query<EmployeeModel> queryEmp = session.createQuery(hqlEmp, EmployeeModel.class);
		        queryEmp.setParameter("id", empId);
		        EmployeeModel emp = queryEmp.uniqueResult();
		        return emp;
		    } else {
		        System.out.println("Không tìm thấy");
		        return null;
		    }
		}
		
		private List<Integer> getPermissions(String empId, Session session) {
		    String hqlPermissions = "SELECT role.roleId FROM PermissionModel WHERE employee.id = :idEmp AND status = true";
		    Query<Integer> queryPermissions = session.createQuery(hqlPermissions, Integer.class);
		    queryPermissions.setParameter("idEmp", empId);
		    return queryPermissions.getResultList();
		}
}
