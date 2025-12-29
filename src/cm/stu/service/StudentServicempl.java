package cm.stu.service;

import cm.stu.bean.PageBean;
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
    public PageBean<Person> getAllTeacherByPage(String userAccount, int currentPage, int pageSize) {
        // 获取所有教师数据
        List<Person> allTeachers = sd.getAllTeacher();
        
        // 创建分页对象
        PageBean<Person> pageBean = new PageBean<>();
        pageBean.setCurrentPage(currentPage);
        pageBean.setPageSize(pageSize);
        pageBean.setTotalCount(allTeachers.size());
        
        // 计算起始索引
        int startIndex = (currentPage - 1) * pageSize;
        if (startIndex < 0) startIndex = 0;
        
        // 计算结束索引
        int endIndex = Math.min(startIndex + pageSize, allTeachers.size());
        
        // 截取当前页数据
        List<Person> pageData = allTeachers.subList(startIndex, endIndex);
        pageBean.setDataList(pageData);
        
        return pageBean;
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
    public PageBean<Person> getMyTeacherByPage(String userAccount, int currentPage, int pageSize) {
        // 获取我的教师数据
        List<Person> myTeachers = sd.getMyTeacher(userAccount);
        
        // 创建分页对象
        PageBean<Person> pageBean = new PageBean<>();
        pageBean.setCurrentPage(currentPage);
        pageBean.setPageSize(pageSize);
        pageBean.setTotalCount(myTeachers.size());
        
        // 计算起始索引
        int startIndex = (currentPage - 1) * pageSize;
        if (startIndex < 0) startIndex = 0;
        
        // 计算结束索引
        int endIndex = Math.min(startIndex + pageSize, myTeachers.size());
        
        // 截取当前页数据
        List<Person> pageData = myTeachers.subList(startIndex, endIndex);
        pageBean.setDataList(pageData);
        
        return pageBean;
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
    public PageBean<StudentAnswer> goMyTeaTaskByPage(String userAccount, String teacherAccount, int currentPage, int pageSize) {
        // 获取我的教师任务数据
        List<StudentAnswer> allTasks = sd.goMyTeaTask(userAccount, teacherAccount);
        
        // 创建分页对象
        PageBean<StudentAnswer> pageBean = new PageBean<>();
        pageBean.setCurrentPage(currentPage);
        pageBean.setPageSize(pageSize);
        pageBean.setTotalCount(allTasks.size());
        
        // 计算起始索引
        int startIndex = (currentPage - 1) * pageSize;
        if (startIndex < 0) startIndex = 0;
        
        // 计算结束索引
        int endIndex = Math.min(startIndex + pageSize, allTasks.size());
        
        // 截取当前页数据
        List<StudentAnswer> pageData = allTasks.subList(startIndex, endIndex);
        pageBean.setDataList(pageData);
        
        return pageBean;
    }

    @Override
    public void deleteMyTeacher(String userAccount, String teacherAccount) {
        sd.deleteMyTeacher(userAccount, teacherAccount);
    }
    
    @Override
    public void batchDeleteMyTeacher(String[] teacherAccounts, String userAccount) {
        if (teacherAccounts != null) {
            for (String teacherAccount : teacherAccounts) {
                sd.deleteMyTeacher(userAccount, teacherAccount);
            }
        }
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