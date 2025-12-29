package cm.stu.bean;

import java.util.List;

public class PageBean<T> {
    // 当前页码
    private int currentPage;
    // 每页显示的记录数
    private int pageSize;
    // 总记录数
    private int totalCount;
    // 总页数
    private int totalPage;
    // 当前页的数据
    private List<T> dataList;

    public PageBean() {
    }

    // 计算总页数
    public void calculateTotalPage() {
        if (this.pageSize == 0) {
            this.totalPage = 0;
            return;
        }
        this.totalPage = this.totalCount / this.pageSize;
        if (this.totalCount % this.pageSize != 0) {
            this.totalPage++;
        }
    }

    // getter和setter方法
    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
        calculateTotalPage();
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }
}