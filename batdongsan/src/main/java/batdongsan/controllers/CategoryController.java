package batdongsan.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import batdongsan.models.CategoryModel;

@Controller
@RequestMapping("/admin/")
public class CategoryController {
	@Autowired
	SessionFactory factory;

	@RequestMapping("listCategory")
	public String index(ModelMap model) {
		Session session = factory.openSession();
		String hql = "FROM CategoryModel";
		Query query = session.createQuery(hql);
		List<CategoryModel> list = query.list();
		model.addAttribute("categories", list);
		model.addAttribute("category", new CategoryModel());
		return "admin/listCategory";
	}

	// ==============================
	@Transactional
	@RequestMapping(value = "listCategory/add", method = RequestMethod.POST)
	public String addCategory(ModelMap model, @ModelAttribute("category") CategoryModel category) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			// Thêm mới danh mục
			session.save(category);
			t.commit();
			model.addAttribute("message", "Thêm mới thành công");
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "Thao tác thất bại: " + e.getMessage());
		} finally {
			session.close();
		}
		return "redirect:/admin/listCategory.html";
	}
	// ==============================
	@RequestMapping(value = "update/{categoryId}", method = RequestMethod.GET)
	public String getUpdate(ModelMap model, @PathVariable("categoryId") int categoryId) {
	    Session session = factory.openSession();
	    //
	    String hql = "FROM CategoryModel";
		Query query = session.createQuery(hql);
		List<CategoryModel> list = query.list();
		model.addAttribute("categories", list);
		model.addAttribute("category", new CategoryModel());
	    //
	    CategoryModel category = (CategoryModel) session.get(CategoryModel.class, categoryId);
	    model.addAttribute("category", category);
	    return "admin/listCategoryUpdate";
	}

	@RequestMapping(value = "update/listCategory/update", method = RequestMethod.POST)
	public String updateCategory(ModelMap model, @ModelAttribute("category") CategoryModel category) {
	    Session session = factory.openSession();
	    Transaction t = session.beginTransaction();
	    try {
	        // Cập nhật danh mục	
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


	// ==============================
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

}
