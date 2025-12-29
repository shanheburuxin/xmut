package cm.stu.serlet;

import cm.stu.bean.Person;
import cm.stu.service.ManageService;
import cm.stu.service.ManageServiceImpl;
import cm.stu.util.Test;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/man.action")
public class ManageSerlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        ManageService ms = new ManageServiceImpl();
        if (action.equals("list") || action.equals("search") || action.equals("delThisPerson")) {
            if (action.equals("delThisPerson")) {
                String delAccount = req.getParameter("userAccount");
                String userIdentify = req.getParameter("userIdentify");
                ms.delThisPerson(delAccount, userIdentify);
            }
            List<Person> arr;
            if (action.equals("list") || action.equals("delThisPerson")) {
                arr = ms.getAllPerson();
            } else {
                String matchText = req.getParameter("matchText").trim();
                arr = ms.getSearch(matchText);
            }
            req.setAttribute("arr", arr);
            req.setAttribute("mainRight", "person.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("goAddPerson")) {
            req.setAttribute("mainRight", "addPerson.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("addThisPerson")) {
            String newUserAccount = Test.getPersonAccount();
            String userName = req.getParameter("userName");
            String userSex = req.getParameter("userSex");
            String userBirthday = req.getParameter("userBirthday");
            String userIdCard = req.getParameter("userIdCard");
            String userPhone = req.getParameter("userPhone");
            String userPassword = req.getParameter("userPassword");
            int userIdentify = Integer.parseInt(req.getParameter("userIdentify"));
            String userOtherName = req.getParameter("userOtherName");

            Person newPerson = new Person(newUserAccount, userName, userSex, userBirthday, userIdCard, userPassword, userIdentify, userOtherName);
            ms.addPerson(newPerson);

            req.setAttribute("tip", "添加完成");
            req.setAttribute("mainRight", "blank.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        }
    }
}