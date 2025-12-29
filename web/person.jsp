<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>人员列表</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
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
</script>
</body>
</html>