package cm.stu.serlet;

import cm.stu.bean.Person;
import cm.stu.service.ManageService;
import cm.stu.service.ManageServiceImpl;
import cm.stu.service.StudentService;
import cm.stu.service.StudentServicempl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
@WebServlet("/common.action")
public class commonserlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action =req.getParameter("action");
        StudentService ss=new StudentServicempl();
        Person person=(Person) req.getSession().getAttribute("session_person");
        String userAccount =person.getUserAccount();
        ManageService ms=new ManageServiceImpl();

        if (action.equals("index")) {
            req.setAttribute("mainRight","blank.jsp");
            req.getRequestDispatcher("main.jsp").forward(req,resp);

        }else if(action.equals("goMyDetail")) {
            req.setAttribute("mainRight", "detail.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        }else if(action.equals("upPassword")) {

            req.setAttribute("mainRight", "upPassword.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);

        }else if(action.equals("sureUpPassword")) {
            String userPassword = req.getParameter("userPassword");
            ms.sureUpPassword(userAccount,userPassword);
            req.setAttribute("tip", "修改成功，请关闭此页面");
            req.getRequestDispatcher("success.jsp").forward(req,resp);
        }

    }
}
