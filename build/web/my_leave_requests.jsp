<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đơn nghỉ phép của tôi</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="dashboard-container">
        <!-- Include Sidebar based on role -->
        <c:choose>
            <c:when test="${userRole == 'Admin'}">
                <jsp:include page="view/admin_sidebar.jsp">
                    <jsp:param name="page" value="my-requests" />
                </jsp:include>
            </c:when>
            <c:when test="${userRole == 'Manager'}">
                <jsp:include page="view/manager_sidebar.jsp">
                    <jsp:param name="page" value="my-requests" />
                </jsp:include>
            </c:when>
            <c:otherwise>
                <jsp:include page="view/staff_sidebar.jsp">
                    <jsp:param name="page" value="my-requests" />
                </jsp:include>
            </c:otherwise>
        </c:choose>
        
        <!-- Main Content -->
        <main class="main-content">
            <header class="header">
                <div class="header-title">
                    <h1>Đơn nghỉ phép của tôi</h1>
                </div>
                <div class="header-actions">
                    <a href="create-leave-request" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Tạo đơn mới
                    </a>
                </div>
            </header>
            
            <div class="content">
                <!-- Request Table -->
                <div class="table-card">
                    <div class="table-header">
                        <h3>
                            <i class="fas fa-list-alt"></i>
                            Danh sách đơn nghỉ phép (${leaveRequests.size()} đơn)
                        </h3>
                    </div>
                    
                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Loại nghỉ phép</th>
                                    <th>Từ ngày</th>
                                    <th>Đến ngày</th>
                                    <th>Số ngày</th>
                                    <th>Lý do</th>
                                    <th>Trạng thái</th>
                                    <th>Ngày tạo</th>
                                    <th>Ghi chú</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty leaveRequests}">
                                        <tr>
                                            <td colspan="9" class="text-center">
                                                <div class="empty-state">
                                                    <i class="fas fa-calendar-times"></i>
                                                    <p>Bạn chưa có đơn nghỉ phép nào</p>
                                                    <a href="create-leave-request" class="btn btn-primary mt-2">
                                                        <i class="fas fa-plus"></i>
                                                        Tạo đơn đầu tiên
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="request" items="${leaveRequests}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>
                                                    <span class="leave-type-badge">
                                                        ${request.leaveTypeName}
                                                    </span>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${request.fromDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${request.toDate}" pattern="dd/MM/yyyy"/>
                                                </td>
                                                <td>
                                                    <c:set var="days" value="${(request.toDate.time - request.fromDate.time) / (1000 * 60 * 60 * 24) + 1}" />
                                                    <span class="days-count">${days} ngày</span>
                                                </td>
                                                <td>
                                                    <div class="reason-text" title="${request.reason}">
                                                        ${request.reason}
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="status-badge status-${request.status.toLowerCase()}">
                                                        <c:choose>
                                                            <c:when test="${request.status == 'Inprogress'}">
                                                                <i class="fas fa-clock"></i> Chờ duyệt
                                                            </c:when>
                                                            <c:when test="${request.status == 'Approved'}">
                                                                <i class="fas fa-check"></i> Đã duyệt
                                                            </c:when>
                                                            <c:when test="${request.status == 'Rejected'}">
                                                                <i class="fas fa-times"></i> Từ chối
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${request.status}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${request.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                                </td>
                                                <td>
                                                    <c:if test="${not empty request.managerNote}">
                                                        <div class="manager-note" title="${request.managerNote}">
                                                            ${request.managerNote}
                                                        </div>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
