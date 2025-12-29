<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的老师</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
        }
        .pagination-info {
            margin-right: 15px;
        }
    </style>
</head>
<body>
<div class="container-fluid mt-3">
    <h3 class="mb-4 border-bottom pb-2">我的任课老师</h3>
    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle text-center shadow-sm">
            <thead class="table-primary">
            <tr>
                <th>
                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                </th>
                <th>老师账户</th>
                <th>老师姓名</th>
                <th>性别</th>
                <th>科目</th>
                <th>操作</th>
                <th>管理</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${arr}" var="person">
                <tr>
                    <td>
                        <input type="checkbox" class="teacher-checkbox" value="${person.userAccount}">
                    </td>
                    <td>${person.getUserAccount()}</td>
                    <td>${person.getUserName()}</td>
                    <td>${person.getUserSex()}</td>
                    <td>${person.getUserOtherName()}</td>
                    <td>
                        <button class="btn btn-primary btn-sm" onclick="goMyTeaTask('${person.getUserAccount()}')">
                            <i class="bi bi-journal-text"></i> 查看任务
                        </button>
                    </td>
                    <td>
                        <button class="btn btn-danger btn-sm" onclick="deleteThisPerson('${person.getUserAccount()}')">
                            <i class="bi bi-trash"></i> 删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty arr}">
                <tr>
                    <td colspan="7" class="text-muted py-4">暂无数据，请先选择老师</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
    
    <!-- 分页控件 -->
    <c:if test="${pageBean != null}">
        <div class="pagination-container">
            <div class="pagination-info">
                共 ${pageBean.totalCount} 条记录，第 ${pageBean.currentPage} / ${pageBean.totalPage} 页
            </div>
            <nav>
                <ul class="pagination">
                    <c:choose>
                        <c:when test="${pageBean.currentPage == 1}">
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">首页</a></li>
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">上一页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeacher&currentPage=1">首页</a></li>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeacher&currentPage=${pageBean.currentPage - 1}">上一页</a></li>
                        </c:otherwise>
                    </c:choose>
                    
                    <!-- 显示当前页码附近的页码 -->
                    <c:forEach begin="${pageBean.currentPage > 2 ? pageBean.currentPage - 2 : 1}" 
                               end="${pageBean.currentPage + 2 <= pageBean.totalPage ? pageBean.currentPage + 2 : pageBean.totalPage}" 
                               var="i">
                        <c:choose>
                            <c:when test="${i == pageBean.currentPage}">
                                <li class="page-item active"><a class="page-link" href="javascript:void(0)">${i}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="student.action?action=goMyTeacher&currentPage=${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${pageBean.currentPage == pageBean.totalPage}">
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">下一页</a></li>
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">末页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeacher&currentPage=${pageBean.currentPage + 1}">下一页</a></li>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeacher&currentPage=${pageBean.totalPage}">末页</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </div>
        
        <!-- 每页显示条数选择 -->
        <div class="d-flex justify-content-center mt-3">
            <div class="me-3">
                <label for="pageSize">每页显示：</label>
                <select id="pageSize" class="form-select d-inline-block w-auto" onchange="changePageSize()">
                    <option value="5" ${pageBean.pageSize == 5 ? 'selected' : ''}>5条</option>
                    <option value="10" ${pageBean.pageSize == 10 ? 'selected' : ''}>10条</option>
                    <option value="20" ${pageBean.pageSize == 20 ? 'selected' : ''}>20条</option>
                    <option value="50" ${pageBean.pageSize == 50 ? 'selected' : ''}>50条</option>
                </select>
            </div>
        </div>
    </c:if>
</div>

<script>
    function goMyTeaTask(teacherAccount) {
        window.location.href ="student.action?action=goMyTeaTask&teacherAccount="+teacherAccount;
    }

    function deleteThisPerson(teacherAccount) {
        if(confirm('确定要删除这位老师吗？')){
            window.location.href ="student.action?action=deleteMyTeacher&teacherAccount="+teacherAccount;
        }
    }
    
    // 全选/反选功能
    function toggleSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.teacher-checkbox');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }
    
    // 监听单个复选框变化，更新全选状态
    document.querySelectorAll('.teacher-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allCheckboxes = document.querySelectorAll('.teacher-checkbox');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            // 检查是否所有老师复选框都被选中
            const allChecked = Array.from(allCheckboxes).every(cb => cb.checked);
            // 检查是否有任何老师复选框被选中
            const anyChecked = Array.from(allCheckboxes).some(cb => cb.checked);
            
            // 更新全选复选框状态
            selectAllCheckbox.checked = allChecked;
            selectAllCheckbox.indeterminate = !allChecked && anyChecked; // 半选状态
        });
    });
    
    // 改变每页显示条数
    function changePageSize() {
        const pageSize = document.getElementById('pageSize').value;
        window.location.href = 'student.action?action=goMyTeacher&pageSize=' + pageSize;
    }
</script>
</body>
</html>