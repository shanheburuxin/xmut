package cm.stu.service;

import cm.stu.bean.PageBean;
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
    public PageBean<Task> getAllMyTaskByPage(String userAccount, int currentPage, int pageSize) {
        // 获取所有任务数据
        List<Task> allTasks = td.getAllMyTask(userAccount);
        
        // 创建分页对象
        PageBean<Task> pageBean = new PageBean<>();
        pageBean.setCurrentPage(currentPage);
        pageBean.setPageSize(pageSize);
        pageBean.setTotalCount(allTasks.size());
        
        // 计算起始索引
        int startIndex = (currentPage - 1) * pageSize;
        if (startIndex < 0) startIndex = 0;
        
        // 计算结束索引
        int endIndex = Math.min(startIndex + pageSize, allTasks.size());
        
        // 截取当前页数据
        List<Task> pageData = allTasks.subList(startIndex, endIndex);
        pageBean.setDataList(pageData);
        
        return pageBean;
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
    
    @Override
    public void batchDeleteTask(String[] taskAccounts) {
        if (taskAccounts != null) {
            for (String taskAccount : taskAccounts) {
                td.deleteThisTask(taskAccount);
            }
        }
    }
    
    @Override
    public void batchDeleteStudentTask(String[] taskAccounts, String[] studentAccounts) {
        if (taskAccounts != null && studentAccounts != null) {
            for (int i = 0; i < taskAccounts.length && i < studentAccounts.length; i++) {
                td.deleteTask(taskAccounts[i], studentAccounts[i], "0");
            }
        }
    }


}