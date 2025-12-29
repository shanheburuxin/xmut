package cm.stu.serlet;

import cm.stu.bean.Person;
import cm.stu.bean.StudentAnswer;
import cm.stu.bean.Task;
import cm.stu.service.TeacherService;
import cm.stu.service.TeacherServiceImpl;
import cm.stu.util.Test;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet("/tea.action")
public class TeacherSerlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action =req.getParameter("action");
        TeacherService ts=new TeacherServiceImpl();
        Person person=(Person) req.getSession().getAttribute("session_person");
        String userAccount =person.getUserAccount();
        if(action.equals("list")||action.equals("searchMyStudent")||action.equals("deleteThisPersonByTeacher")){
            List arr = null;
            if (action.equals("searchMyStudent")) {
                String matchText = req.getParameter("matchText");
                arr=ts.getSearchStudentByTeacherAccount(userAccount,matchText);
            }else {
                if(action.equals("deleteThisPersonByTeacher")) {
                    String studentAccount = req.getParameter("studentAccount");
                    ts.deleteThisPersonByTeacher(studentAccount,userAccount);
                }
                arr = ts.AllStundentsByTeacherAccount(userAccount);
            }
            //获取所有有选这个老师的学生的信息
            req.setAttribute("arr",arr);
            req.setAttribute("mainRight","person.jsp");
            req.getRequestDispatcher("main.jsp").forward(req,resp);
        }else if(action.equals("goMyTask")||action.equals("deleteThisTask")){
            if(action.equals("deleteThisTask")){
                String taskAccount = req.getParameter("taskAccount");
                ts.deleteThisTask(taskAccount);
            }



            List<Task> arr = ts.getAllMyTask(userAccount);
            req.setAttribute("arr",arr);
            req.setAttribute("mainRight","task.jsp");
            req.getRequestDispatcher("main.jsp").forward(req,resp);
        }
        else if (action.equals("goSkimDetail")||action.equals("goStudentTaskDetail")){
            List<StudentAnswer> arr;

            if(action.equals("goSkimDetail")){
                String taskAccount = req.getParameter("taskAccount");
                arr = ts.getTaskdetail(taskAccount);
            }else{
                req.setAttribute("sign","goStudentTaskDetail");
                String studentAccount = req.getParameter("studentAccount");
                arr = ts.goStudentTaskDetail(userAccount,studentAccount);
            }
            String taskAccount = req.getParameter("taskAccount");

            req.setAttribute("arr",arr);
            req.setAttribute("mainRight","studentTask.jsp");
            req.getRequestDispatcher("main.jsp").forward(req,resp);
        }else if(action.equals("deleteTask")){
            //&isFinish="+isFinish
            String studentAccount = req.getParameter("studentAccount");
            String taskAccount = req.getParameter("taskAccount");
            String isFinish = req.getParameter("isFinish");
            ts.deleteTask(taskAccount,studentAccount,isFinish);
            req.setAttribute("tip","删除成功");
            req.setAttribute("mainRight","blank.jsp");
            req.getRequestDispatcher("main.jsp").forward(req,resp);
        }else if(action.equals("goAddTask")||action.equals("addTask")){
            if(action.equals("addTask")){
                String taskName = req.getParameter("taskName");
                taskName = taskName.trim();
                if (taskName.trim().equals("")){
                    req.setAttribute("tip","添加失败，任务不能为空");
                }else{
                    //朝数据库存入
                    String date = Test.getDate();
                    String taskAccount = Test.getTaskAccount();
                    Task task = new Task(taskAccount,userAccount,date,taskName);
                    ts.AddTask(task);
                    req.setAttribute("tip","添加成功");
                }
            }
            req.setAttribute("mainRight","addTask.jsp");
            req.getRequestDispatcher("main.jsp").forward(req,resp);
        }
    }
}

