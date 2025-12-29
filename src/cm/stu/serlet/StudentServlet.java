package cm.stu.serlet;

import cm.stu.bean.PageBean;
import cm.stu.bean.Person;
import cm.stu.bean.StudentAnswer;
import cm.stu.bean.Task;
import cm.stu.dao.Generate;
import cm.stu.service.StudentService;
import cm.stu.service.StudentServicempl;
import cm.stu.service.TeacherService;
import cm.stu.service.TeacherServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/student.action")
@MultipartConfig(
        maxFileSize = 10 * 1024 * 1024,      // 10MB
        maxRequestSize = 20 * 1024 * 1024,   // 20MB
        fileSizeThreshold = 1024 * 1024      // 1MB
)
public class StudentServlet extends HttpServlet {

    // 文件上传目录
    private static final String UPLOAD_DIR = "uploads";

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        StudentService ss = new StudentServicempl();
        Person person = (Person) req.getSession().getAttribute("session_person");
        String userAccount = person.getUserAccount();

        if (action.equals("list") || action.equals("searchTeacher")) {
            // 获取分页参数
            String currentPageStr = req.getParameter("currentPage");
            String pageSizeStr = req.getParameter("pageSize");
            
            int currentPage = 1;
            int pageSize = 10; // 默认每页10条记录
            
            if (currentPageStr != null && !currentPageStr.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(currentPageStr);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            
            if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeStr);
                } catch (NumberFormatException e) {
                    pageSize = 10;
                }
            }
            
            List<Person> arr;
            if (action.equals("list")) {
                PageBean<Person> pageBean = ss.getAllTeacherByPage(userAccount, currentPage, pageSize);
                req.setAttribute("pageBean", pageBean);
                arr = pageBean.getDataList();
            } else {
                String matchText = req.getParameter("matchText");
                arr = ss.getSearchTeacher(matchText);
            }
            req.setAttribute("arr", arr);
            req.setAttribute("mainRight", "person.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("goMyTeacher") || action.equals("deleteMyTeacher")) {
            if (action.equals("deleteMyTeacher")) {
                String teacherAccount = req.getParameter("teacherAccount");
                ss.deleteMyTeacher(userAccount, teacherAccount);
            }
            
            // 获取分页参数
            String currentPageStr = req.getParameter("currentPage");
            String pageSizeStr = req.getParameter("pageSize");
            
            int currentPage = 1;
            int pageSize = 10; // 默认每页10条记录
            
            if (currentPageStr != null && !currentPageStr.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(currentPageStr);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            
            if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeStr);
                } catch (NumberFormatException e) {
                    pageSize = 10;
                }
            }
            
            PageBean<Person> pageBean = ss.getMyTeacherByPage(userAccount, currentPage, pageSize);
            req.setAttribute("pageBean", pageBean);
            
            List<Person> arr = pageBean.getDataList();
            req.setAttribute("arr", arr);
            req.setAttribute("mainRight", "myTeacher.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("addTeacher")) {
            String teacherAccount = req.getParameter("teacherAccount");
            int flag = Generate.IsExistStuTea(userAccount, teacherAccount);
            if (flag == 0) {
                ss.addTeacher(userAccount, teacherAccount);
                req.setAttribute("tip", "添加成功");
            } else {
                req.setAttribute("tip", "你已经选择了这个老师，本次选择失败");
            }
            req.setAttribute("mainRight", "blank.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("goMyTeaTask")) {
            String teacherAccount = req.getParameter("teacherAccount");
            
            // 获取分页参数
            String currentPageStr = req.getParameter("currentPage");
            String pageSizeStr = req.getParameter("pageSize");
            
            int currentPage = 1;
            int pageSize = 10; // 默认每页10条记录
            
            if (currentPageStr != null && !currentPageStr.isEmpty()) {
                try {
                    currentPage = Integer.parseInt(currentPageStr);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            
            if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeStr);
                } catch (NumberFormatException e) {
                    pageSize = 10;
                }
            }
            
            PageBean<StudentAnswer> pageBean = ss.goMyTeaTaskByPage(userAccount, teacherAccount, currentPage, pageSize);
            req.setAttribute("pageBean", pageBean);
            
            List<StudentAnswer> arr = pageBean.getDataList();
            req.setAttribute("arr", arr);
            req.setAttribute("mainRight", "studentTask.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("doAnswer")) {
            String taskAccount = req.getParameter("taskAccount");
            req.setAttribute("taskAccount", taskAccount);
            req.getRequestDispatcher("doAnswer.jsp").forward(req, resp);
        } else if (action.equals("dealAnswer")) {
            // 处理文件上传和答案提交
            String taskAccount = req.getParameter("taskAccount");
            String answer = req.getParameter("answer") != null ? req.getParameter("answer").trim() : "";
            String fileName = null;

            // 处理文件上传
            Part filePart = req.getPart("uploadFile");
            if (filePart != null && filePart.getSize() > 0) {
                fileName = saveUploadedFile(filePart, getServletContext().getRealPath(""));
            }

            ss.doAnswer(userAccount, taskAccount, answer, fileName);
            req.setAttribute("tip", "作答成功，请关闭此界面，等老师批改");
            req.setAttribute("mainRight", "success.jsp");
            req.getRequestDispatcher("main.jsp").forward(req, resp);
        } else if (action.equals("doFenshu")) {
            String taskAccount = req.getParameter("taskAccount");
            String studentAccount = req.getParameter("studentAccount");
            req.setAttribute("taskAccount", taskAccount);
            req.setAttribute("studentAccount", studentAccount);
            req.getRequestDispatcher("getFenshu.jsp").forward(req, resp);
        } else if (action.equals("getFenshu")) {
            String taskAccount = req.getParameter("taskAccount");
            String studentAccount = req.getParameter("studentAccount");
            String fenshu = req.getParameter("fenshu");
            ss.dealFenshu(taskAccount, studentAccount, fenshu);
            req.setAttribute("tip", "已修改分数");
            req.getRequestDispatcher("success.jsp").forward(req, resp);
        }
    }

    /**
     * 保存上传的文件
     */
    private String saveUploadedFile(Part filePart, String appPath) throws IOException {
        // 创建上传目录
        String uploadPath = appPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 生成唯一文件名
        String originalFileName = getFileName(filePart);
        String fileExtension = "";
        if (originalFileName != null && originalFileName.contains(".")) {
            fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
        }

        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
        String filePath = uploadPath + File.separator + uniqueFileName;

        // 保存文件
        filePart.write(filePath);

        return uniqueFileName;
    }

    /**
     * 获取上传文件的原始文件名（修复版本）
     */
    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) {
            return "";
        }

        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            token = token.trim();
            if (token.startsWith("filename")) {
                // 更安全的文件名提取方式
                String fileName = token.substring(token.indexOf("=") + 1).trim();
                // 移除可能的引号
                if (fileName.startsWith("\"") && fileName.endsWith("\"")) {
                    fileName = fileName.substring(1, fileName.length() - 1);
                }
                return fileName;
            }
        }
        return "";
    }
}