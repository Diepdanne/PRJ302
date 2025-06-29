<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thông tin cá nhân - ${userRole}</title>
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
                        <a href="${userRole.toLowerCase()}_dashboard.jsp" class="nav-link">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                    </div>
                </div>
                
                <c:if test="${userRole == 'Admin'}">
                    <div class="nav-section">
                        <div class="nav-section-title">Quản lý nhân viên</div>
                        <div class="nav-item">
                            <a href="employee-list" class="nav-link">
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
                </c:if>
                
                <div class="nav-section">
                    <div class="nav-section-title">Cá nhân</div>
                    <div class="nav-item">
                        <a href="user-profile" class="nav-link active">
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
                    <h1>Thông tin cá nhân</h1>
                </div>
            </header>
            
            <div class="content">
                <!-- Hiển thị thông báo -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-error">
                        <i class="fas fa-exclamation-circle"></i>
                        ${errorMessage}
                    </div>
                </c:if>
                
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i>
                        ${successMessage}
                    </div>
                </c:if>
                
                <div class="profile-container">
                    <!-- Profile Info -->
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="profile-info">
                                <h2>${user.userName}</h2>
                                <p>${user.role} - ${user.division}</p>
                                <p class="profile-email">${user.email}</p>
                            </div>
                        </div>
                        
                        <div class="profile-details">
                            <div class="detail-item">
                                <span class="detail-label">Phòng ban:</span>
                                <span class="detail-value">${user.department}</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Số điện thoại:</span>
                                <span class="detail-value">${user.phoneNumber}</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-label">Ngày vào làm:</span>
                                <span class="detail-value">
                                    <c:if test="${not empty user.hireDate}">
                                        <fmt:formatDate value="${user.hireDate}" pattern="dd/MM/yyyy"/>
                                    </c:if>
                                </span>
                            </div>
                            <c:if test="${not empty user.managerName}">
                                <div class="detail-item">
                                    <span class="detail-label">Quản lý trực tiếp:</span>
                                    <span class="detail-value">${user.managerName}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Update Profile Form -->
                    <div class="form-card">
                        <div class="form-header">
                            <h3>
                                <i class="fas fa-edit"></i>
                                Cập nhật thông tin
                            </h3>
                        </div>
                        
                        <form action="user-profile" method="post" class="profile-form">
                            <input type="hidden" name="action" value="updateProfile">
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="userName" class="form-label">
                                        Họ và tên <span class="required">*</span>
                                    </label>
                                    <input type="text" id="userName" name="userName" class="form-input" 
                                           value="${user.userName}" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="email" class="form-label">
                                        Email <span class="required">*</span>
                                    </label>
                                    <input type="email" id="email" name="email" class="form-input" 
                                           value="${user.email}" required>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="phoneNumber" class="form-label">
                                        Số điện thoại
                                    </label>
                                    <input type="tel" id="phoneNumber" name="phoneNumber" class="form-input" 
                                           value="${user.phoneNumber}">
                                </div>
                                
                                <div class="form-group">
                                    <label for="dateOfBirth" class="form-label">
                                        Ngày sinh
                                    </label>
                                    <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-input" 
                                           value="${user.dateOfBirth}">
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="gender" class="form-label">
                                        Giới tính
                                    </label>
                                    <select id="gender" name="gender" class="form-select">
                                        <option value="">-- Chọn giới tính --</option>
                                        <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Nam</option>
                                        <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Nữ</option>
                                        <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Khác</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="address" class="form-label">
                                        Địa chỉ
                                    </label>
                                    <textarea id="address" name="address" class="form-textarea" rows="3">${user.address}</textarea>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    Cập nhật thông tin
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Change Password Form -->
                    <div class="form-card">
                        <div class="form-header">
                            <h3>
                                <i class="fas fa-key"></i>
                                Đổi mật khẩu
                            </h3>
                        </div>
                        
                        <form action="user-profile" method="post" class="password-form" id="passwordForm">
                            <input type="hidden" name="action" value="changePassword">
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="currentPassword" class="form-label">
                                        Mật khẩu hiện tại <span class="required">*</span>
                                    </label>
                                    <input type="password" id="currentPassword" name="currentPassword" class="form-input" required>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="newPassword" class="form-label">
                                        Mật khẩu mới <span class="required">*</span>
                                    </label>
                                    <input type="password" id="newPassword" name="newPassword" class="form-input" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="confirmPassword" class="form-label">
                                        Xác nhận mật khẩu mới <span class="required">*</span>
                                    </label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-input" required>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-key"></i>
                                    Đổi mật khẩu
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        document.getElementById('passwordForm').addEventListener('submit', function(e) {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                e.preventDefault();
                alert('Mật khẩu mới và xác nhận mật khẩu không khớp!');
                return false;
            }
            
            if (newPassword.length < 6) {
                e.preventDefault();
                alert('Mật khẩu mới phải có ít nhất 6 ký tự!');
                return false;
            }
        });
    </script>
</body>
</html>
