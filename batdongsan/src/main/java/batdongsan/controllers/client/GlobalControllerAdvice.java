package batdongsan.controllers.client;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import batdongsan.models.CategoryModel;

import javax.transaction.Transactional;
import java.util.List;

@ControllerAdvice // Áp dụng cho tất cả controller
public class GlobalControllerAdvice {

    @Autowired
    private SessionFactory factory;

    @ModelAttribute("categoriesSell")
    @Transactional // Đảm bảo phiên làm việc của Hibernate được quản lý đúng
    public List<CategoryModel> getTypesSell() {
        Session session = factory.openSession();
        try {
            String hql = "FROM CategoryModel WHERE type = :type AND status=1";
            Query<CategoryModel> query = session.createQuery(hql, CategoryModel.class);
            query.setParameter("type", "Nhà đất bán");
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            session.close();
        }
    }
}
