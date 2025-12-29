package cm.stu.dao;

public class Generate {
    public static int isExistTaskAccount(String taskAccount) {
        String sql = "SELECT COUNT(*) num FROM task WHERE taskAccount ='" + taskAccount + "'";
        return Deal.isExist(sql);
    }

    public static int IsExistStuTea(String userAccount, String teacherAccount) {
        String sql = "SELECT COUNT(*) num FROM userteacher WHERE userAccount ='" + userAccount + "' AND teacherAccount ='" + teacherAccount + "'";
        return Deal.isExist(sql);
    }

    public static int isExistPersonAccount(String userAccount) {
        String sql = "SELECT COUNT(*) num FROM person WHERE userAccount ='" + userAccount + "'";
        return Deal.isExist(sql);
    }
}
