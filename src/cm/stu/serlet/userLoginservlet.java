package cm.stu.serlet;

import cm.stu.bean.Person;
import cm.stu.service.UserLoginService;
import cm.stu.service.UserLoginServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/userLogin")
public class userLoginservlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //先拿到前端穿过来的信息
        String userAccount = req.getParameter("userAccount");
        String userPassword = req.getParameter("userPassword");
        String inputVerifyCode = req.getParameter("verifyCode");

        // 验证验证码
        HttpSession session = req.getSession();
        String verifyCode = (String) session.getAttribute("verifyCode");

        if (verifyCode == null || !verifyCode.equalsIgnoreCase(inputVerifyCode)) {
            req.setAttribute("tip", "验证码错误");
            req.getRequestDispatcher("userLogin.jsp").forward(req, resp);
            return;
        }

        Person person = new Person(userAccount, userPassword);
        UserLoginService ul = new UserLoginServiceImpl();
        Person newPerson = ul.getLogin(person);

        if (newPerson != null) { // 进入主界面
            session.setAttribute("session_person", newPerson);
            req.setAttribute("mainRight", "blank.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else {
            // 回到登录注册界面
            req.setAttribute("tip", "账号密码不一致");
            req.getRequestDispatcher("userLogin.jsp").forward(req, resp);
        }
    }
}
