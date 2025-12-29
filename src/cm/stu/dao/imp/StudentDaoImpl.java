package cm.stu.dao.imp;

import cm.stu.bean.PageBean;
import cm.stu.bean.Person;
import cm.stu.bean.StudentAnswer;
import cm.stu.dao.Deal;
import cm.stu.dao.StudentDao;

import java.util.List;

public class StudentDaoImpl implements StudentDao {

    @Override
    public List<Person> getAllTeacher() {
        String sql = "SELECT * FROM person WHERE userIdentify=1";
        return Deal.getAllPerson(sql);
    }

    @Override
    public PageBean<Person> getAllTeacherByPage(String userAccount, int currentPage, int pageSize) {
        return null;
    }

    @Override
    public List<Person> getSearchTeacher(String matchText) {
        String sql = "SELECT * FROM person WHERE userIdentify=1 AND (userAccount='" + matchText + "' OR userName LIKE'%" + matchText + "%' OR userOtherName LIKE'%" + matchText + "%')";
        return Deal.getAllPerson(sql);
    }

    @Override
    public List<Person> getMyTeacher(String userAccount) {
        String sql = "SELECT * FROM person WHERE userAccount IN (SELECT teacherAccount AS userAccount FROM userteacher ut WHERE userAccount = '" + userAccount + "')";
        return Deal.getAllPerson(sql);
    }

    @Override
    public PageBean<Person> getMyTeacherByPage(String userAccount, int currentPage, int pageSize) {
        return null;
    }

    @Override
    public void addTeacher(String userAccount, String teacherAccount) {
        String sql = "INSERT INTO userteacher  VALUES ('" + userAccount + "','" + teacherAccount + "')";
        Deal.deal(sql);
        // 根据数据库实际表结构插入数据，如果isScore字段不存在则暂时不插入
        sql = "INSERT INTO studenttask(taskAccount,studentAccount,studentAnswer,isFinish) SELECT taskAccount, '" + userAccount + "',NULL,0 FROM task WHERE teacherAccount ='" + teacherAccount + "'";
        Deal.deal(sql);
    }

    @Override
    public List<StudentAnswer> goMyTeaTask(String userAccount, String teacherAccount) {
        String sql = "SELECT s.*,p.userName,taskName FROM studenttask s INNER JOIN person p ON s.studentAccount=p.userAccount INNER JOIN task t ON s.taskAccount = t.taskAccount WHERE(s.studentAccount='" + userAccount + "' AND t.teacherAccount ='" + teacherAccount + "')";
        return Deal.getTaskDetail(sql);
    }

    @Override
    public PageBean<StudentAnswer> goMyTeaTaskByPage(String userAccount, String teacherAccount, int currentPage, int pageSize) {
        return null;
    }

    @Override
    public void deleteMyTeacher(String userAccount, String teacherAccount) {
        String sql = "DELETE FROM userteacher WHERE userAccount='" + userAccount + "' AND teacherAccount = '" + teacherAccount + "'";
        Deal.deal(sql);
        sql = "DELETE from studenttask WHERE taskAccount IN(SELECT taskAccount FROM task WHERE teacherAccount='" + teacherAccount + "')AND studentAccount='" + userAccount + "'";
        Deal.deal(sql);
    }

    @Override
    public void batchDeleteMyTeacher(String[] teacherAccounts, String userAccount) {

    }

    @Override
    public void doAnswer(String userAccount, String taskAccount, String answer, String fileName) {
        // 先尝试更新 uploadFileName 字段，如果失败则不更新该字段
        String sql;
        if (fileName != null && !fileName.isEmpty()) {
            sql = "UPDATE studenttask SET studentAnswer='" + answer + "', uploadFileName='" + fileName + "', isFinish=1 WHERE taskAccount='" + taskAccount + "' AND studentAccount = '" + userAccount + "'";
        } else {
            sql = "UPDATE studenttask SET studentAnswer='" + answer + "', isFinish=1 WHERE taskAccount='" + taskAccount + "' AND studentAccount = '" + userAccount + "'";
        }
        
        try {
            Deal.deal(sql);
        } catch (Exception e) {
            // 如果 uploadFileName 字段不存在，则不包含该字段
            sql = "UPDATE studenttask SET studentAnswer='" + answer + "', isFinish=1 WHERE taskAccount='" + taskAccount + "' AND studentAccount = '" + userAccount + "'";
            Deal.deal(sql);
        }
    }

    @Override
    public void dealFenshu(String taskAccount, String studentAccount, String fenshu) {
        // 先尝试更新 isScore 字段，如果失败则只更新 isFinish 字段
        String sql = "UPDATE studenttask SET isScore=" + fenshu + ",isFinish=2 WHERE taskAccount='" + taskAccount + "' AND studentAccount = '" + studentAccount + "'";
        try {
            Deal.deal(sql);
        } catch (Exception e) {
            // 如果 isScore 字段不存在，则只更新 isFinish 字段
            sql = "UPDATE studenttask SET isFinish=2 WHERE taskAccount='" + taskAccount + "' AND studentAccount = '" + studentAccount + "'";
            Deal.deal(sql);
        }
    }
}