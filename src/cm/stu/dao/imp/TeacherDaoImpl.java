package cm.stu.dao.imp;

import cm.stu.bean.StudentAnswer;
import cm.stu.bean.Task;
import cm.stu.dao.Deal;
import cm.stu.dao.TeacherDao;

import java.util.List;

public class TeacherDaoImpl implements TeacherDao {

    @Override
    public List AllStundentsByTeacherAccount(String userAccount) {
        String sql = "SELECT * FROM person WHERE userAccount IN (SELECT userAccount FROM userteacher WHERE teacherAccount ='"+userAccount+"')";
        return Deal.getAllPerson(sql);
    }

    @Override
    public List<Task> getAllMyTask(String userAccount) {
        String sql ="SELECT * FROM task WHERE teacherAccount ='"+userAccount+"'";
        return Deal.getAllMyTask(sql);

        }

    @Override
    public List <StudentAnswer> getTaskDetail(String taskAccount) {
        String sql="SELECT s.*,p.userName,taskName FROM studenttask s INNER JOIN person p ON s.studentAccount=p.userAccount INNER JOIN task t on s.taskAccount=t.taskAccount WHERE s.taskAccount = '"+taskAccount+"'";
        return Deal.getTaskDetail(sql);
    }

    @Override
    public void AddTask(Task task) {
        String sql ="INSERT INTO task VALUES('"+task.getTaskAccount()+"','"+task.getTeacherAccount()+"','"+task.getTaskDate()+"','"+task.getTaskName()+"')";
        Deal.deal(sql);

        sql= "INSERT INTO studenttask(taskAccount,studentAccount,studentAnswer,isFinish) SELECT'"+task.getTaskAccount()+"',B.C,NULL,0 FROM (SELECT userAccount C FROM userteacher WHERE teacherAccount='"+task.getTeacherAccount()+"')AS B";
        Deal.deal(sql);
    }

    @Override
    public List getSearchStudentByTeacherAccount(String userAccount,String matchText) {
        String sql="SELECT * FROM person WHERE userAccount IN (SELECT userAccount FROM userteacher WHERE teacherAccount ='"+userAccount+"') AND (userAccount='"+matchText+"'OR userName LIKE'%"+matchText+"%' OR userIdCard = '"+matchText+"')";
        return  Deal.getAllPerson(sql);
    }

    @Override
    public List<StudentAnswer> goStudentTaskDetail(String userAccount, String studentAccount) {
        String sql="SELECT s.*,p.userName,taskName FROM studenttask s INNER JOIN person p ON s.studentAccount=p.userAccount INNER JOIN task t ON s.taskAccount = t.taskAccount WHERE(s.studentAccount='"+studentAccount+"' AND t.teacherAccount ='"+userAccount+"')";
        return Deal.getTaskDetail(sql);
    }

    @Override
    public void deleteTask(String taskAccount,String studentAccount, String isFinish) {
        if(Integer.parseInt(isFinish)==0){
            //直接删除
            String sql="DELETE FROM studenttask WHERE taskAccount='"+taskAccount+"' AND studentAccount ='"+studentAccount+"'";
            Deal.deal(sql);
        }else{

        }
    }

    @Override
    public void deleteThisTask(String taskAccount) {
        String sql="DELETE FROM task WHERE taskAccount='"+taskAccount+"'";
        Deal.deal(sql);
        sql="DELETE FROM studenttask WHERE taskAccount='"+taskAccount+"'";
        Deal.deal(sql);

    }

    @Override
    public void deleteThisPersonByTeacher(String studentAccount, String userAccount) {
        String sql="DELETE FROM userteacher WHERE userAccount='"+studentAccount+"' AND teacherAccount = '"+userAccount+"'";
        Deal.deal(sql);
        sql ="DELETE from studenttask WHERE taskAccount IN(SELECT taskAccount FROM task WHERE teacherAccount='"+userAccount+"')AND studentAccount='"+studentAccount+"'";
        Deal.deal(sql);
    }




}

