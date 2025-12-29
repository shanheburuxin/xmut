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

@WebServlet("/registerUser")
public class UserRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
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
        
        ManageService ms = new ManageServiceImpl();
        ms.addPerson(newPerson);

        // 注册成功后跳转到登录页面
        req.setAttribute("tip", "注册成功，请登录");
        req.getRequestDispatcher("userLogin.jsp").forward(req, resp);
    }
}