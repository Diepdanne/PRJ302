<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Danh sách nhân viên - Admin</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <i class="fas fa-calendar-check"></i>
                    <h3>LeaveManager</h3>
                </div>
                <div class="user-info">
                    <h4>${userName}</h4>
                    <p><i class="fas fa-crown"></i> ${userRole}</p>
                </div>
            </div>
            
            <nav class="sidebar-nav">
                <div class="nav-section">
                    <div class="nav-section-title">Tổng quan</div>
                    <div class="nav-item">
                        <a href="admin_dashboard.jsp" class="nav-link">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Quản lý nhân viên</div>
                    <div class="nav-item">
                        <a href="employee-list" class="nav-link active">
                            <i class="fas fa-users"></i>
                            Danh sách nhân viên
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="add-employee" class="nav-link">
                            <i class="fas fa-user-plus"></i>
                            Thêm nhân viên
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Quản lý nghỉ phép</div>
                    <div class="nav-item">
                        <a href="all-requests" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            Tất cả đơn nghỉ phép
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="pending-requests" class="nav-link">
                            <i class="fas fa-clock"></i>
                            Đơn chờ duyệt
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Cá nhân</div>
                    <div class="nav-item">
                        <a href="user-profile" class="nav-link">
                            <i class="fas fa-user"></i>
                            Thông tin cá nhân
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="login.jsp" class="nav-link">
                            <i class="fas fa-sign-out-alt"></i>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </nav>
        </aside>
        
        <!-- Main Content -->
        <main class="main-content">
            <header class="header">
                <div class="header-title">
                    <h1>Danh sách nhân viên</h1>
                </div>
                <div class="header-actions">
                    <a href="add-employee" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm nhân viên
                    </a>
                </div>
            </header>
            
            <div class="content">
                <!-- Search and Filter -->
                <div class="search-filter-card">
                    <form method="get" action="employee-list" class="search-filter-form">
                        <div class="search-group">
                            <div class="search-input-group">
                                <i class="fas fa-search"></i>
                                <input type="text" name="search" placeholder="Tìm kiếm theo tên, email, số điện thoại..." 
                                       value="${searchTerm}" class="search-input">
                            </div>
                        </div>
                        
                        <div class="filter-group">
                            <select name="roleFilter" class="filter-select">
                                <option value="all">Tất cả vai trò</option>
                                <option value="Admin" ${roleFilter == 'Admin' ? 'selected' : ''}>Admin</option>
                                <option value="Manager" ${roleFilter == 'Manager' ? 'selected' : ''}>Manager</option>
                                <option value="Staff" ${roleFilter == 'Staff' ? 'selected' : ''}>Staff</option>
                            </select>
                            
                            <select name="divisionFilter" class="filter-select">
                                <option value="all">Tất cả bộ phận</option>
                                <c:forEach var="division" items="${divisions}">
                                    <option value="${division}" ${divisionFilter == division ? 'selected' : ''}>${division}</option>
                                </c:forEach>
                            </select>
                            
                            <button type="submit" class="btn btn-outline">
                                <i class="fas fa-filter"></i>
                                Lọc
                            </button>
                            
                            <a href="employee-list" class="btn btn-outline">
                                <i class="fas fa-times"></i>
                                Xóa bộ lọc
                            </a>
                        </div>
                    </form>
                </div>
                
                <!-- Employee Table -->
                <div class="table-card">
                    <div class="table-header">
                        <h3>
                            <i class="fas fa-users"></i>
                            Danh sách nhân viên (${employees.size()} người)
                        </h3>
                    </div>
                    
                    <div class="table-container">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>STT</th>
                                    <th>Họ tên</th>
                                    <th>Email</th>
                                    <th>Vai trò</th>
                                    <th>Bộ phận</th>
                                    <th>Phòng ban</th>
                                    <th>Số điện thoại</th>
                                    <th>Ngày vào làm</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty employees}">
                                        <tr>
                                            <td colspan="9" class="text-center">
                                                <div class="empty-state">
                                                    <i class="fas fa-users"></i>
                                                    <p>Không tìm thấy nhân viên nào</p>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="employee" items="${employees}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>
                                                    <div class="user-info-cell">
                                                        <div class="user-avatar">
                                                            <i class="fas fa-user"></i>
                                                        </div>
                                                        <div class="user-details">
                                                            <strong>${employee.userName}</strong>
                                                            <c:if test="${not empty employee.managerName}">
                                                                <small>Quản lý: ${employee.managerName}</small>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${employee.email}</td>
                                                <td>
                                                    <span class="role-badge role-${employee.role.toLowerCase()}">
                                                        ${employee.role}
                                                    </span>
                                                </td>
                                                <td>${employee.division}</td>
                                                <td>${employee.department}</td>
                                                <td>${employee.phoneNumber}</td>
                                                <td>
                                                    <c:if test="${not empty employee.hireDate}">
                                                        <fmt:formatDate value="${employee.hireDate}" pattern="dd/MM/yyyy"/>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="edit-employee?id=${employee.userId}" class="btn btn-sm btn-outline" title="Sửa">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <button onclick="deleteEmployee(${employee.userId}, '${employee.userName}')" 
                                                                class="btn btn-sm btn-error" title="Xóa">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
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
    
    <script>
        function deleteEmployee(userId, userName) {
            if (confirm(`Bạn có chắc chắn muốn xóa nhân viên "${userName}"?\nHành động này không thể hoàn tác.`)) {
                // Create form and submit
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'delete-employee';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'userId';
                input.value = userId;
                
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // Auto submit form when filter changes
        document.addEventListener('DOMContentLoaded', function() {
            const filterSelects = document.querySelectorAll('.filter-select');
            filterSelects.forEach(select => {
                select.addEventListener('change', function() {
                    this.form.submit();
                });
            });
        });
    </script>
</body>
</html>
