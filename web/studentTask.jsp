<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>任务列表</title>
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
    <div class="card shadow-sm">
        <div class="card-header bg-white py-3">
            <h5 class="mb-0 text-primary"><i class="bi bi-list-task"></i> 任务列表</h5>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle text-center mb-0">
                    <thead class="table-primary">
                    <tr>
                        <th>
                            <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                        </th>
                        <c:if test="${session_person.getUserIdentify()!=0}">
                            <th>学生姓名</th>
                        </c:if>
                        <th>题目</th>
                        <th>答案</th>
                        <th>状态</th>
                        <th>分数</th>
                        <c:if test="${session_person.getUserIdentify()==0}">
                            <th>操作</th>
                        </c:if>
                        <c:if test="${session_person.getUserIdentify()==1}">
                            <th>批改</th>
                        </c:if>
                        <th>删除</th>
                        <th>详细</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${arr}" var="stuTask">
                        <tr>
                            <td>
                                <input type="checkbox" class="task-checkbox" value="${stuTask.taskAccount}">
                            </td>
                            <c:if test="${session_person.getUserIdentify()!=0}">
                                <td>${stuTask.getUserName()}</td>
                            </c:if>

                            <td class="text-truncate" style="max-width: 200px;" title="${stuTask.getTaskName()}">
                                ${stuTask.getTaskName()}
                            </td>

                            <td class="text-truncate" style="max-width: 150px;">
                                ${stuTask.getStudentAnswer()}
                            </td>

                            <td>
                                <c:if test="${stuTask.getIsFinish()==0}">
                                    <span class="badge bg-danger">未完成</span>
                                </c:if>
                                <c:if test="${stuTask.getIsFinish()==1}">
                                    <span class="badge bg-warning text-dark">未批改</span>
                                </c:if>
                                <c:if test="${stuTask.getIsFinish()==2}">
                                    <span class="badge bg-success">已完成</span>
                                </c:if>
                            </td>

                            <td class="fw-bold text-primary">${stuTask.getIsScore()}</td>

                            <c:if test="${session_person.getUserIdentify()==0}">
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" onclick="doAnswer('${stuTask.getTaskAccount()}','${stuTask.getIsFinish()}')">
                                        <i class="bi bi-pencil-square"></i> 答题
                                    </button>
                                </td>
                            </c:if>

                            <c:if test="${session_person.getUserIdentify()==1}">
                                <td>
                                    <button class="btn btn-sm btn-outline-success" onclick="doFenshu('${stuTask.getTaskAccount()}','${stuTask.getStudentAccount()}',${stuTask.getIsFinish()})">
                                        <i class="bi bi-check2-square"></i> 批改
                                    </button>
                                </td>
                            </c:if>

                            <td>
                                <button class="btn btn-sm btn-danger" onclick="delThisTask('${stuTask.getTaskAccount()}','${stuTask.getStudentAccount()}','${stuTask.getIsFinish()}')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-info text-white" title="查看详情">
                                    <i class="bi bi-info-circle"></i>
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
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
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeaTask&teacherAccount=${param.teacherAccount}&currentPage=1">首页</a></li>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeaTask&teacherAccount=${param.teacherAccount}&currentPage=${pageBean.currentPage - 1}">上一页</a></li>
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
                                <li class="page-item"><a class="page-link" href="student.action?action=goMyTeaTask&teacherAccount=${param.teacherAccount}&currentPage=${i}">${i}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${pageBean.currentPage == pageBean.totalPage}">
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">下一页</a></li>
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">末页</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeaTask&teacherAccount=${param.teacherAccount}&currentPage=${pageBean.currentPage + 1}">下一页</a></li>
                            <li class="page-item"><a class="page-link" href="student.action?action=goMyTeaTask&teacherAccount=${param.teacherAccount}&currentPage=${pageBean.totalPage}">末页</a></li>
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
    function doFenshu(taskAccount,studentAccount,isFinish) {
        if (isFinish!=1){
            alert("暂时没有批改权限 (学生未提交或已批改)");
            return;
        }
        window.open("student.action?action=doFenshu&taskAccount="+taskAccount+"&studentAccount="+studentAccount, "批改", "width=700,height=400,left=400,top=150,location=no");
    }

    function doAnswer(taskAccount,isFinish) {
        if (isFinish!=0){
            alert("已经作答，无法再次提交");
            return;
        }
        window.open("student.action?action=doAnswer&taskAccount="+taskAccount+"", "答题", "width=700,height=400,left=400,top=150,location=no");
    }

    function delThisTask(taskAccount,studentAccount,isFinish) {
        // JSP中直接嵌入的逻辑保持不变
        <c:if test="${session_person.getUserIdentify()==1}">
            if(isFinish==1){
                alert("老师未批改不能删除");
            }else{
                if(confirm("确定要删除此任务记录吗？")) {
                    window.location.href="tea.action?action=deleteTask&taskAccount="+taskAccount+"&studentAccount="+studentAccount+"&isFinish="+isFinish;
                }
            }
        </c:if>
        <c:if test="${session_person.getUserIdentify()!=1}">
             if(isFinish==2){
                 // 原逻辑这里是空的，可能是允许删除已完成的？
                 if(confirm("确定要删除吗？")) {
                     // 这里原代码没写跳转，可能需要补全，或者遵循原意
                 }
            }else {
                alert("任务正在进行，不能删除");
            }
        </c:if>
    }
    
    // 全选/反选功能
    function toggleSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.task-checkbox');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
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
        });
    });
    
    // 改变每页显示条数
    function changePageSize() {
        const pageSize = document.getElementById('pageSize').value;
        window.location.href = 'student.action?action=goMyTeaTask&teacherAccount=${param.teacherAccount}&pageSize=' + pageSize;
    }
</script>
</body>
</html>