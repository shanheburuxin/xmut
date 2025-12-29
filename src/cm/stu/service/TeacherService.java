package cm.stu.service;

import cm.stu.bean.PageBean;
import cm.stu.bean.StudentAnswer;
import cm.stu.bean.Task;

import java.util.List;

public interface TeacherService {
    List AllStundentsByTeacherAccount(String userAccount);

    List<Task> getAllMyTask(String userAccount);
    
    PageBean<Task> getAllMyTaskByPage(String userAccount, int currentPage, int pageSize);

    List<StudentAnswer> getTaskdetail(String taskAccount);

    void AddTask(Task task);

    List getSearchStudentByTeacherAccount(String userAccount,String matchText);


    List<StudentAnswer> goStudentTaskDetail(String userAccount, String studentAccount);

    void deleteTask(String taskAccount,String studentAccount, String isFinish);

    void deleteThisTask(String taskAccount);

    void deleteThisPersonByTeacher(String studentAccount, String userAccount);
}
