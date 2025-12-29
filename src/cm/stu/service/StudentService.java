package cm.stu.service;

import cm.stu.bean.PageBean;
import cm.stu.bean.Person;
import cm.stu.bean.StudentAnswer;

import java.util.List;

public interface StudentService {

    List<Person> getAllTeacher();
    
    PageBean<Person> getAllTeacherByPage(String userAccount, int currentPage, int pageSize);

    List<Person> getSearchTeacher(String matchText);

    List<Person> getMyTeacher(String userAccount);
    
    PageBean<Person> getMyTeacherByPage(String userAccount, int currentPage, int pageSize);

    void addTeacher(String userAccount, String teacherAccount);

    List<StudentAnswer> goMyTeaTask(String userAccount, String teacherAccount);
    
    PageBean<StudentAnswer> goMyTeaTaskByPage(String userAccount, String teacherAccount, int currentPage, int pageSize);

    void deleteMyTeacher(String userAccount, String teacherAccount);
    
    void batchDeleteMyTeacher(String[] teacherAccounts, String userAccount);

    void doAnswer(String userAccount, String taskAccount, String answer, String fileName);

    void dealFenshu(String taskAccount, String studentAccount, String fenshu);
}
