package batdongsan.controllers;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import batdongsan.models.ProvincesModel;
import batdongsan.models.RealEstateModel;

@Controller
@RequestMapping("/sellernet/")
public class PostController {
    @Autowired
    SessionFactory factory;
    
    @RequestMapping(value= {"dang-tin"}, method = RequestMethod.GET)
    public String index(ModelMap model) {
        model.addAttribute("realEstate", new RealEstateModel());
        return "client/sellernet/post";
    }
    
    @RequestMapping(value = "insert", method = RequestMethod.POST)
    public String insert(ModelMap model, @ModelAttribute("realEstate") RealEstateModel realEstate) {
        Session session = factory.openSession();
        Transaction t = session.beginTransaction();
        try {
            session.save(realEstate);
            t.commit();
            model.addAttribute("message", "Thêm mới thành công!");
        } catch (Exception e) {
            t.rollback();
            model.addAttribute("message", "Thêm mới thất bại! ");
            System.out.println(e);
        } finally {
            session.close();
        }
        return "client/sellernet/post";
    }
    
    @ModelAttribute("typesSell")
    public List<String> getTypesSell() {
        List<String> types = new ArrayList<>();
        types.add("Bán căn hộ chung cư");
        types.add("Bán nhà riêng");
        types.add("Bán nhà biệt thự, liền kề");
        types.add("Bán nhà mặt phố");
        return types;
    }
    
    @ModelAttribute("typesRent")
    public List<String> getTypesRent() {
        List<String> types = new ArrayList<>();
        types.add("Cho thuê căn hộ chung cư");
        types.add("Cho thuê nhà riêng");
        types.add("Cho thuê nhà biệt thự, liền kề");
        types.add("Cho thuê nhà mặt phố");
        return types;
    }
    
    @ModelAttribute("provinces")
    public List<ProvincesModel> getProvinces() {
       Session session = factory.openSession(); // Use openSession() instead of getCurrentSession()
       String hql = "FROM ProvincesModel";
       Query<ProvincesModel> query = session.createQuery(hql);
       List<ProvincesModel> list = query.list();
       session.close(); // Remember to close the session
       return list;
    }

}
