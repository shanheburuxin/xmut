package cm.stu.service;

import cm.stu.bean.Person;
import cm.stu.dao.UserLoginDao;
import cm.stu.dao.imp.UserLoginDaoImpl;

public class UserLoginServiceImpl implements UserLoginService  {
    UserLoginDao ud = new UserLoginDaoImpl();

    @Override
    public Person getLogin(Person person) {
        return ud.getLogin(person);
    }
}
