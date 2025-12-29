package cm.stu.service;

import cm.stu.bean.Person;
import cm.stu.dao.ManageDao;
import cm.stu.dao.imp.ManageDaoImpl;
import java.util.List;

public class ManageServiceImpl implements ManageService {
    ManageDao md = new ManageDaoImpl();

    @Override
    public List<Person> getAllPerson() {
        return md.getAllPerson();
    }

    @Override
    public List<Person> getSearch(String matchText) {
        return md.getSearch(matchText);
    }

    @Override
    public void addPerson(Person newPerson) {
        md.addPerson(newPerson);
    }

    @Override
    public void sureUpPassword(String userAccount, String userPassword) {
        md.sureUpPassword(userAccount, userPassword);
    }

    @Override
    public void delThisPerson(String delAccount, String userIdentify) {
        md.delThisPerson(delAccount, userIdentify);
    }
}
