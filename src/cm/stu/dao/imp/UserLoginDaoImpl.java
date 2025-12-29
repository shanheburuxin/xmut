package cm.stu.dao.imp;

import cm.stu.bean.Person;

import cm.stu.dao.UserLoginDao;
import cm.stu.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserLoginDaoImpl implements UserLoginDao {


    @Override
    public Person getLogin(Person person) {
        String sql="select * from person where userAccount='"+person.getUserAccount()+"' and userPassword='"+person.getUserPassword()+"'";//不理解
        Connection connection = DBUtil.getConn();
        PreparedStatement pre = null;
        ResultSet res = null;
        Person newPerson = null; //检索不出来为空//userAccount,userName,usersex,userBirthday,userIdCard,userPassword,userIdentify,userOtherName
        try {
            pre = connection.prepareStatement(sql);
            res = pre.executeQuery();
            while (res.next()){
                newPerson = new Person();

                newPerson.setUserAccount(res.getString("userAccount"));
                newPerson.setUserName(res.getString("userName"));;
                newPerson.setUserSex(res.getString("userSex"));
                newPerson.setUserBirthday(res.getString("userBirthday"));
                newPerson.setUserIdCard(res.getString("userIdCard"));
                newPerson.setUserPassword(res.getString("userPassword"));
                newPerson.setUserIdentify(res.getInt("userIdentify"));
                newPerson.setUserOtherName(res.getString("userOtherName"));

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return newPerson;

    }
}
