package batdongsan.controllers.admin;

import java.sql.Date;
import java.util.Calendar;
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
	public String index(ModelMap model, HttpServletRequest request) {
		Session session = factory.openSession();
		// Phân trang
		int pageSize = 6;
		String pageParam = request.getParameter("page");
		int currentPage = 1;
		if (pageParam != null && !pageParam.isEmpty()) {
			currentPage = Integer.parseInt(pageParam);
		}
		int startIndex = (currentPage - 1) * pageSize;

		String filter = request.getParameter("filter");
		String search = request.getParameter("search");
		String hql = "FROM CategoryModel c";
		boolean hasWhereClause = false;

		if (filter != null && !filter.isEmpty()) {
			switch (filter) {
			case "sell":
				hql += " WHERE c.type = :type";
				hasWhereClause = true;
				break;
			case "rent":
				hql += hasWhereClause ? " AND c.type = :type" : " WHERE c.type = :type";
				hasWhereClause = true;
				break;
			default:
				break;
			}
		}

		if (search != null && !search.isEmpty()) {
			hql += hasWhereClause ? " AND (LOWER(c.name) LIKE :search OR LOWER(c.type) LIKE :search)"
					: " WHERE LOWER(c.name) LIKE :search OR LOWER(c.type) LIKE :search";
		}

		hql += " ORDER BY c.type ASC, c.categoryId ASC";
		Query query = session.createQuery(hql);

		if (filter != null && !filter.isEmpty()) {
			query.setParameter("type", filter.equals("sell") ? "Nhà đất bán" : "Nhà đất cho thuê");
		}
		if (search != null && !search.isEmpty()) {
			query.setParameter("search", "%" + search.toLowerCase() + "%");
		}

		query.setFirstResult(startIndex);
		query.setMaxResults(pageSize);
		List<CategoryModel> list = query.list();

		// Tính toán tổng số trang
		String countHql = "SELECT count(c.categoryId) FROM CategoryModel c";
		hasWhereClause = false;

		if (filter != null && !filter.isEmpty()) {
			countHql += " WHERE c.type = :type";
			hasWhereClause = true;
		}

		if (search != null && !search.isEmpty()) {
			countHql += hasWhereClause ? " AND (LOWER(c.name) LIKE :search OR LOWER(c.type) LIKE :search)"
					: " WHERE LOWER(c.name) LIKE :search OR LOWER(c.type) LIKE :search";
		}

		Query countQuery = session.createQuery(countHql);
		if (filter != null && !filter.isEmpty()) {
			countQuery.setParameter("type", filter.equals("sell") ? "Nhà đất bán" : "Nhà đất cho thuê");
		}
		if (search != null && !search.isEmpty()) {
			countQuery.setParameter("search", "%" + search.toLowerCase() + "%");
		}

		Long countResult = (Long) countQuery.uniqueResult();
		int totalPages = (int) Math.ceil((double) countResult / pageSize);

		model.addAttribute("categories", list);
		model.addAttribute("category", new CategoryModel());
		model.addAttribute("totalCategory", countResult);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("filter", filter);
		model.addAttribute("search", search); // Add search attribute for view
		
		EmployeeModel emp = getEmployeeFromCookies(request);
        model.addAttribute("loginEmp", emp);
		
		session.close();
		return "admin/Category/listCategory";
	}

	// Thêm danh mục
	@RequestMapping(value = "listCategory/add", method = RequestMethod.GET)
	public String add(ModelMap model, HttpServletRequest request) {
		loadListOfCategory(model);
		EmployeeModel emp = getEmployeeFromCookies(request);
        model.addAttribute("loginEmp", emp);
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
        model.addAttribute("loginEmp", emp);
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
}
