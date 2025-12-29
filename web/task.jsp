<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的任务</title>
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
<body class="bg-light">
<div class="container-fluid mt-3">
    <h4 class="mb-3 text-secondary">已发布任务管理</h4>
    <div class="d-flex justify-content-between mb-3">
        <div>
            <button class="btn btn-danger" onclick="batchDelete()" id="batchDeleteBtn" disabled>
                <i class="bi bi-trash"></i> 批量删除
            </button>
        </div>
        <div>
            <span id="selectedCount">已选择 0 项</span>
        </div>
    </div>
    <div class="table-responsive bg-white shadow-sm rounded">
        <table class="table table-hover align-middle text-center mb-0">
            <thead class="table-dark">
            <tr>
                <th>
                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                </th>
                <th>任务账户</th>
                <th>任务内容 (摘要)</th>
                <th>发布时间</th>
                <th>删除</th>
                <th>详细</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${arr}" var="task">
                <tr>
                    <td>
                        <input type="checkbox" class="task-checkbox" value="${task.taskAccount}" onchange="updateSelectedCount()">
                    </td>
                    <td><span class="badge bg-secondary">${task.getTaskAccount()}</span></td>
                    <td class="text-start text-truncate" style="max-width: 300px;">${task.getTaskName()}</td>
                    <td>${task.getTaskDate()}</td>
                    <td>
                        <button class="btn btn-outline-danger btn-sm" onclick="deleteThisTask('${task.getTaskAccount()}')">
                            <i class="bi bi-trash"></i> 删除
                        </button>
                    </td>
                    <td>
                        <button class="btn btn-outline-info btn-sm" onclick="skimDetail('${task.getTaskAccount()}')">
                            <i class="bi bi-eye"></i> 查看
                        </button>
                    </td>
                </tr>
            </c:forEach>
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
                            <li class="page-item"><a class="page-link" href="tea.action?action=goMyTask&currentPage=1">首页</a></li>
                            <li class="page-item"><a class="page-link" href="tea.action?action=goMyTask&currentPage=${pageBean.currentPage - 1}">上一页</a></li>
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
                                <li class="page-item"><a class="page-link" href="tea.action?action=goMyTask&currentPage=${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${pageBean.currentPage == pageBean.totalPage}">
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">下一页</a></li>
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">末页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="tea.action?action=goMyTask&currentPage=${pageBean.currentPage + 1}">下一页</a></li>
                            <li class="page-item"><a class="page-link" href="tea.action?action=goMyTask&currentPage=${pageBean.totalPage}">末页</a></li>
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
    function deleteThisTask(taskAccount) {
        if(confirm("确定要删除该任务吗？这将删除所有学生的作答记录。")){
            window.location.href="tea.action?action=deleteThisTask&taskAccount="+taskAccount;
        }
    }

    function skimDetail(taskAccount){
        window.location.href = "tea.action?action=goSkimDetail&taskAccount="+taskAccount;
    }
    
    // 全选/反选功能
    function toggleSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.task-checkbox');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
        
        // 更新选中计数和按钮状态
        updateSelectedCount();
    }
    
    // 监听单个复选框变化，更新全选状态
    document.querySelectorAll('.task-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allCheckboxes = document.querySelectorAll('.task-checkbox');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            // 检查是否所有任务复选框都被选中
            const allChecked = Array.from(allCheckboxes).every(cb => cb.checked);
            // 检查是否有任何任务复选框被选中
            const anyChecked = Array.from(allCheckboxes).some(cb => cb.checked);
            
            // 更新全选复选框状态
            selectAllCheckbox.checked = allChecked;
            selectAllCheckbox.indeterminate = !allChecked && anyChecked; // 半选状态
            
            // 更新选中计数和按钮状态
            updateSelectedCount();
        });
    });
    
    // 改变每页显示条数
    function changePageSize() {
        const pageSize = document.getElementById('pageSize').value;
        window.location.href = 'tea.action?action=goMyTask&pageSize=' + pageSize;
    }
    
    // 更新选中计数和按钮状态
    function updateSelectedCount() {
        const selectedCheckboxes = document.querySelectorAll('.task-checkbox:checked');
        const count = selectedCheckboxes.length;
        document.getElementById('selectedCount').textContent = '已选择 ' + count + ' 项';
        document.getElementById('batchDeleteBtn').disabled = count === 0;
    }
    
    // 批量删除功能
    function batchDelete() {
        const selectedCheckboxes = document.querySelectorAll('.task-checkbox:checked');
        if (selectedCheckboxes.length === 0) {
            alert('请先选择要删除的任务');
            return;
        }
        
        if (confirm(`确定要删除选中的 ${selectedCheckboxes.length} 个任务吗？这将删除所有相关学生的作答记录。`)) {
            const taskAccounts = Array.from(selectedCheckboxes).map(checkbox => checkbox.value);
            
            // 创建一个临时表单来提交批量删除请求
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'tea.action?action=batchDeleteTask';
            
            taskAccounts.forEach(taskAccount => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'taskAccounts';
                input.value = taskAccount;
                form.appendChild(input);
            });
            
            document.body.appendChild(form);
            form.submit();
        }
    }
</script>
</body>
</html>