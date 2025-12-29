package cm.stu.service;

import cm.stu.bean.Person;

import java.util.List;

public interface ManageService {
    List<Person> getAllPerson();
    List<Person> getSearch(String matchText);
    void addPerson(Person newPerson);
    void sureUpPassword(String userAccount, String userPassword);
    void delThisPerson(String delAccount, String userIdentify);
    
}