package cm.stu.dao.imp;

import cm.stu.bean.Person;
import cm.stu.dao.Deal;
import cm.stu.dao.ManageDao;

import java.util.List;

public class ManageDaoImpl implements ManageDao {

    @Override
    public List<Person> getAllPerson() {
        String sql = "SELECT * FROM person WHERE userIdentify != 2";
        return Deal.getAllPerson(sql);
    }

    @Override
    public List<Person> getSearch(String matchText) {
        String sql = "SELECT * FROM person WHERE userIdentify!= 2 and (userAccount ='"+matchText+"' or userName like '%"+matchText+"%' or userIdCard = '"+matchText+"')";
        return Deal.getAllPerson(sql);
    }

    @Override
    public void addPerson(Person newPerson) {
        String sql = "INSERT INTO person  VALUES ('"+newPerson.getUserAccount()+"', '"+newPerson.getUserName()+"', '"+newPerson.getUserSex()+"','"+newPerson.getUserBirthday()+"', '"+newPerson.getUserIdCard()+"', '"+newPerson.getUserPassword()+"', '"+newPerson.getUserIdentify()+"', '"+newPerson.getUserOtherName()+"')";
        Deal.deal(sql);
    }

    @Override
    public void sureUpPassword(String userAccount, String userPassword) {
        String sql = "UPDATE person SET userPassword = '"+userPassword+"' WHERE userAccount = '"+userAccount+"'";
        Deal.deal(sql);
    }

    @Override
    public void delThisPerson(String delAccount, String userIdentify) {
        if(Integer.parseInt(userIdentify)==0){
            //删除学生
            String sql = "DELETE FROM userteacher WHERE userAccount = '"+delAccount+"'";
            Deal.deal(sql);
            sql = "DELETE FROM studenttask WHERE studentAccount ='"+delAccount+"'";
            Deal.deal(sql);
        }else {
            //删除老师
            String sql="DELETE FROM studenttask WHERE taskAccount IN (SELECT taskAccount FROM task WHERE teacherAccount='"+delAccount+"')";
            Deal.deal(sql);
            sql ="DELETE FROM task WHERE teacherAccount = '"+delAccount+"'";
            Deal.deal(sql);
            sql="DELETE FROM userteacher WHERE teacherAccount ='"+delAccount+"'";
            Deal.deal(sql);
        }
        String sql="DELETE FROM person WHERE userAccount ='"+delAccount+"'";
        Deal.deal(sql);
    }
}
