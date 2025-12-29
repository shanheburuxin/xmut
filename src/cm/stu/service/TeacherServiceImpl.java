package cm.stu.service;

import cm.stu.bean.StudentAnswer;
import cm.stu.bean.Task;
import cm.stu.dao.TeacherDao;
import cm.stu.dao.imp.TeacherDaoImpl;

import java.util.List;

public class TeacherServiceImpl implements TeacherService {
    TeacherDao td = new TeacherDaoImpl();

    @Override
    public List AllStundentsByTeacherAccount(String userAccount) {
        return td.AllStundentsByTeacherAccount(userAccount);
    }

    @Override
    public List<Task> getAllMyTask(String userAccount) {
        return td.getAllMyTask(userAccount);
    }

    @Override
    public List<StudentAnswer> getTaskdetail(String taskAccount) {
        return td.getTaskDetail(taskAccount);
    }

    @Override
    public void AddTask(Task task) {
        td.AddTask(task);
    }

    @Override
    public List getSearchStudentByTeacherAccount(String userAccount,String matchText) {
        return td.getSearchStudentByTeacherAccount(userAccount,matchText);
    }

    @Override
    public List<StudentAnswer> goStudentTaskDetail(String userAccount, String studentAccount) {
        return td.goStudentTaskDetail(userAccount,studentAccount);
    }

    @Override
    public void deleteTask(String taskAccount, String studentAccount, String isFinish) {
        td.deleteTask(taskAccount,studentAccount,isFinish);
    }

    @Override
    public void deleteThisTask(String taskAccount) {
        td.deleteThisTask(taskAccount);
    }

    @Override
    public void deleteThisPersonByTeacher(String studentAccount, String userAccount) {
        td.deleteThisPersonByTeacher(studentAccount,userAccount);
    }


}
