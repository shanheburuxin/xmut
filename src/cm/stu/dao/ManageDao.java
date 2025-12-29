package cm.stu.dao;

import cm.stu.bean.Person;
import java.util.List;

public interface ManageDao {
    List<Person> getAllPerson();
    List<Person> getSearch(String matchText);
    void addPerson(Person newPerson);
    void sureUpPassword(String userAccount, String userPassword);
    void delThisPerson(String delAccount, String userIdentify);
}