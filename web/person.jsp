<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>人员列表</title>
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
<div class="container-fluid">

    <div class="row mb-3">
        <div class="col-md-12">
            <div class="card bg-light">
                <div class="card-body py-2">
                    <div class="d-flex justify-content-end">
                        <c:if test="${session_person.getUserIdentify()==0}">
                            <form action="student.action?action=searchTeacher" method="post" class="d-flex gap-2">
                                <input type="text" name="matchText" class="form-control" placeholder="搜索老师..." style="width: 300px;">
                                <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> 查询</button>
                            </form>
                        </c:if>
                        <c:if test="${session_person.getUserIdentify()==1}">
                            <form action="tea.action?action=searchMyStudent" method="post" class="d-flex gap-2">
                                <input type="text" name="matchText" class="form-control" placeholder="搜索学生..." style="width: 300px;">
                                <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> 查询</button>
                            </form>
                        </c:if>
                        <c:if test="${session_person.getUserIdentify()==2}">
                            <form action="man.action?action=search" method="post" class="d-flex gap-2">
                                <input type="text" name="matchText" class="form-control" placeholder="搜索人员..." style="width: 300px;">
                                <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i> 查询</button>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered align-middle text-center">
            <thead class="table-dark">
            <tr>
                <th>
                    <input type="checkbox" id="selectAll" onclick="toggleSelectAll()">
                </th>
                <th>账户</th>
                <th>姓名</th>
                <th>性别</th>
                <c:if test="${session_person.getUserIdentify()!=0}">
                    <th>生日</th>
                    <th>身份证号码</th>
                    <th>角色</th>
                </c:if>
                <th>职务/别名</th>
                <c:if test="${session_person.getUserIdentify()!=0}">
                    <th>删除</th>
                </c:if>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${arr}" var="person">
                <tr>
                    <td>
                        <input type="checkbox" class="person-checkbox" value="${person.userAccount}">
                    </td>
                    <td>${person.getUserAccount()}</td>
                    <td>${person.getUserName()}</td>
                    <td><span class="badge ${person.getUserSex()=='男'?'bg-info':'bg-danger'}">${person.getUserSex()}</span></td>

                    <c:if test="${session_person.getUserIdentify()!=0}">
                        <td>${person.getUserBirthday()}</td>
                        <td>${person.getUserIdCard()}</td>
                        <td>
                            <c:if test="${person.getUserIdentify()==0}"><span class="badge bg-secondary">学生</span></c:if>
                            <c:if test="${person.getUserIdentify()==1}"><span class="badge bg-success">老师</span></c:if>
                        </td>
                    </c:if>

                    <td>${person.getUserOtherName()}</td>

                    <c:if test="${session_person.getUserIdentify()==1}">
                        <td>
                            <button class="btn btn-outline-danger btn-sm" onclick="deleteThisPersonByTeacher('${person.getUserAccount()}')">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </c:if>
                    <c:if test="${session_person.getUserIdentify()==2}">
                        <td>
                            <button class="btn btn-outline-danger btn-sm" onclick="delThisPerson('${person.getUserAccount()}','${person.getUserIdentify()}')">
                                <i class="bi bi-trash"></i>
                            </button>
                        </td>
                    </c:if>

                    <td>
                        <c:if test="${session_person.getUserIdentify()==1}">
                            <button class="btn btn-info btn-sm text-white" onclick="detailTesk('${person.getUserAccount()}')">
                                <i class="bi bi-file-text"></i> 任务详情
                            </button>
                        </c:if>
                        <c:if test="${session_person.getUserIdentify()==0}">
                            <button class="btn btn-success btn-sm" onclick="addTeacher('${person.getUserAccount()}')">
                                <i class="bi bi-plus-circle"></i> 选课
                            </button>
                        </c:if>
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
                            <c:choose>
                                <c:when test="${session_person.getUserIdentify()==0}">
                                    <li class="page-item"><a class="page-link" href="student.action?action=list&currentPage=1">首页</a></li>
                                    <li class="page-item"><a class="page-link" href="student.action?action=list&currentPage=${pageBean.currentPage - 1}">上一页</a></li>
                                </c:when>
                                <c:when test="${session_person.getUserIdentify()==1}">
                                    <li class="page-item"><a class="page-link" href="tea.action?action=list&currentPage=1">首页</a></li>
                                    <li class="page-item"><a class="page-link" href="tea.action?action=list&currentPage=${pageBean.currentPage - 1}">上一页</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="man.action?action=list&currentPage=1">首页</a></li>
                                    <li class="page-item"><a class="page-link" href="man.action?action=list&currentPage=${pageBean.currentPage - 1}">上一页</a></li>
                                </c:otherwise>
                            </c:choose>
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
                                <c:choose>
                                    <c:when test="${session_person.getUserIdentify()==0}">
                                        <li class="page-item"><a class="page-link" href="student.action?action=list&currentPage=${i}">${i}</a></li>
                                    </c:when>
                                    <c:when test="${session_person.getUserIdentify()==1}">
                                        <li class="page-item"><a class="page-link" href="tea.action?action=list&currentPage=${i}">${i}</a></li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="page-item"><a class="page-link" href="man.action?action=list&currentPage=${i}">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    
                    <c:choose>
                        <c:when test="${pageBean.currentPage == pageBean.totalPage}">
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">下一页</a></li>
                            <li class="page-item disabled"><a class="page-link" href="javascript:void(0)">末页</a></li>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${session_person.getUserIdentify()==0}">
                                    <li class="page-item"><a class="page-link" href="student.action?action=list&currentPage=${pageBean.currentPage + 1}">下一页</a></li>
                                    <li class="page-item"><a class="page-link" href="student.action?action=list&currentPage=${pageBean.totalPage}">末页</a></li>
                                </c:when>
                                <c:when test="${session_person.getUserIdentify()==1}">
                                    <li class="page-item"><a class="page-link" href="tea.action?action=list&currentPage=${pageBean.currentPage + 1}">下一页</a></li>
                                    <li class="page-item"><a class="page-link" href="tea.action?action=list&currentPage=${pageBean.totalPage}">末页</a></li>
                                </c:when>
                                <c:otherwise>
                                    <li class="page-item"><a class="page-link" href="man.action?action=list&currentPage=${pageBean.currentPage + 1}">下一页</a></li>
                                    <li class="page-item"><a class="page-link" href="man.action?action=list&currentPage=${pageBean.totalPage}">末页</a></li>
                                </c:otherwise>
                            </c:choose>
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
    function delThisPerson(userAccount,userIdentify){
        if(confirm('确定要删除该用户吗？')){
            window.location.href="man.action?action=delThisPerson&userAccount="+userAccount+"&userIdentify="+userIdentify;
        }
    }
    function addTeacher(teacherAccount){
        window.location.href="student.action?action=addTeacher&teacherAccount="+teacherAccount;
    }
    function detailTesk(studentAccount){
        window.location.href="tea.action?action=goStudentTaskDetail&studentAccount="+studentAccount;
    }
    function deleteThisPersonByTeacher(studentAccount){
        if(confirm('确定要移除该学生吗？')){
            window.location.href="tea.action?action=deleteThisPersonByTeacher&studentAccount="+studentAccount;
        }
    }
    
    // 全选/反选功能
    function toggleSelectAll() {
        const selectAllCheckbox = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.person-checkbox');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAllCheckbox.checked;
        });
    }
    
    // 监听单个复选框变化，更新全选状态
    document.querySelectorAll('.person-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', function() {
            const allCheckboxes = document.querySelectorAll('.person-checkbox');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            // 检查是否所有人员复选框都被选中
            const allChecked = Array.from(allCheckboxes).every(cb => cb.checked);
            // 检查是否有任何人员复选框被选中
            const anyChecked = Array.from(allCheckboxes).some(cb => cb.checked);
            
            // 更新全选复选框状态
            selectAllCheckbox.checked = allChecked;
            selectAllCheckbox.indeterminate = !allChecked && anyChecked; // 半选状态
        });
    });
    
    // 改变每页显示条数
    function changePageSize() {
        const pageSize = document.getElementById('pageSize').value;
        const userIdentify = ${session_person.getUserIdentify()};
        
        if (userIdentify == 0) {
            window.location.href = 'student.action?action=list&pageSize=' + pageSize;
        } else if (userIdentify == 1) {
            window.location.href = 'tea.action?action=list&pageSize=' + pageSize;
        } else {
            window.location.href = 'man.action?action=list&pageSize=' + pageSize;
        }
    }
</script>
</body>
</html>