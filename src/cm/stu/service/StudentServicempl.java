package cm.stu.service;

import cm.stu.bean.Person;
import cm.stu.bean.StudentAnswer;
import cm.stu.dao.StudentDao;
import cm.stu.dao.imp.StudentDaoImpl;

import java.util.List;

public class StudentServicempl implements StudentService {
    StudentDao sd = new StudentDaoImpl();

    @Override
    public List<Person> getAllTeacher() {
        return sd.getAllTeacher();
    }

    @Override
    public List<Person> getSearchTeacher(String matchText) {
        return sd.getSearchTeacher(matchText);
    }

    @Override
    public List<Person> getMyTeacher(String userAccount) {
        return sd.getMyTeacher(userAccount);
    }

    @Override
    public void addTeacher(String userAccount, String teacherAccount) {
        sd.addTeacher(userAccount, teacherAccount);
    }

    @Override
    public List<StudentAnswer> goMyTeaTask(String userAccount, String teacherAccount) {
        return sd.goMyTeaTask(userAccount, teacherAccount);
    }

    @Override
    public void deleteMyTeacher(String userAccount, String teacherAccount) {
        sd.deleteMyTeacher(userAccount, teacherAccount);
    }

    @Override
    public void doAnswer(String userAccount, String taskAccount, String answer, String fileName) {
        sd.doAnswer(userAccount, taskAccount, answer, fileName);
    }

    @Override
    public void dealFenshu(String taskAccount, String studentAccount, String fenshu) {
        sd.dealFenshu(taskAccount, studentAccount, fenshu);
    }
}