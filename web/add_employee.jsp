<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thêm nhân viên - Admin</title>
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
                        <a href="employee-list" class="nav-link">
                            <i class="fas fa-users"></i>
                            Danh sách nhân viên
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="add-employee" class="nav-link active">
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
                    <h1>Thêm nhân viên mới</h1>
                </div>
                <div class="header-actions">
                    <a href="employee-list" class="btn btn-outline">
                        <i class="fas fa-list"></i>
                        Danh sách nhân viên
                    </a>
                </div>
            </header>
            
            <div class="content">
                <div class="form-container">
                    <div class="form-card">
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
                        
                        <form action="add-employee" method="post" class="employee-form" id="employeeForm">
                            <div class="form-section">
                                <h3>Thông tin cơ bản</h3>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="userName" class="form-label">
                                            Họ và tên <span class="required">*</span>
                                        </label>
                                        <input type="text" id="userName" name="userName" class="form-input" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="email" class="form-label">
                                            Email <span class="required">*</span>
                                        </label>
                                        <input type="email" id="email" name="email" class="form-input" required>
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="password" class="form-label">
                                            Mật khẩu <span class="required">*</span>
                                        </label>
                                        <input type="password" id="password" name="password" class="form-input" required>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="phoneNumber" class="form-label">
                                            Số điện thoại
                                        </label>
                                        <input type="tel" id="phoneNumber" name="phoneNumber" class="form-input">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-section">
                                <h3>Thông tin công việc</h3>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="role" class="form-label">
                                            Vai trò <span class="required">*</span>
                                        </label>
                                        <select id="role" name="role" class="form-select" required>
                                            <option value="">-- Chọn vai trò --</option>
                                            <option value="Staff">Nhân viên</option>
                                            <option value="Manager">Quản lý</option>
                                            <option value="Admin">Quản trị viên</option>
                                        </select>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="division" class="form-label">
                                            Bộ phận <span class="required">*</span>
                                        </label>
                                        <select id="division" class="form-select" required>
                                            <option value="">-- Chọn bộ phận --</option>
                                            <option value="Staff">IT</option>
                                            <option value="Manager">QA</option>
                                            <option value="Admin">Sale</option>
                                        </select>
                                        <input type="text" id="newDivision" name="newDivision" class="form-input mt-2" 
                                               placeholder="Nhập tên bộ phận mới" style="display: none;">
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="department" class="form-label">
                                            Phòng ban
                                        </label>
                                        <input type="text" id="department" name="department" class="form-input" 
                                               placeholder="VD: Phòng Phát triển, Phòng Kinh doanh...">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="managerId" class="form-label">
                                            Quản lý trực tiếp
                                        </label>
                                        <select id="managerId" name="managerId" class="form-select">
                                            <option value="0">-- Không có --</option>
                                            <c:forEach var="manager" items="${managers}">
                                                <option value="${manager.userId}">${manager.userName} (${manager.division})</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="hireDate" class="form-label">
                                            Ngày vào làm
                                        </label>
                                        <input type="date" id="hireDate" name="hireDate" class="form-input">
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-section">
                                <h3>Thông tin cá nhân</h3>
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="dateOfBirth" class="form-label">
                                            Ngày sinh
                                        </label>
                                        <input type="date" id="dateOfBirth" name="dateOfBirth" class="form-input">
                                    </div>
                                    
                                    <div class="form-group">
                                        <label for="gender" class="form-label">
                                            Giới tính
                                        </label>
                                        <select id="gender" name="gender" class="form-select">
                                            <option value="">-- Chọn giới tính --</option>
                                            <option value="Male">Nam</option>
                                            <option value="Female">Nữ</option>
                                            <option value="Other">Khác</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="form-row">
                                    <div class="form-group full-width">
                                        <label for="address" class="form-label">
                                            Địa chỉ
                                        </label>
                                        <textarea id="address" name="address" class="form-textarea" rows="3" 
                                                  placeholder="Nhập địa chỉ đầy đủ..."></textarea>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="button" class="btn btn-outline" onclick="history.back()">
                                    <i class="fas fa-times"></i>
                                    Hủy bỏ
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    Thêm nhân viên
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Handle division selection
            const divisionSelect = document.getElementById('division');
            const newDivisionInput = document.getElementById('newDivision');
            
            divisionSelect.addEventListener('change', function() {
                if (this.value === 'other') {
                    newDivisionInput.style.display = 'block';
                    newDivisionInput.required = true;
                } else {
                    newDivisionInput.style.display = 'none';
                    newDivisionInput.required = false;
                    newDivisionInput.value = '';
                }
            });
            
            // Form validation
            document.getElementById('employeeForm').addEventListener('submit', function(e) {
                const password = document.getElementById('password').value;
                if (password.length < 6) {
                    e.preventDefault();
                    alert('Mật khẩu phải có ít nhất 6 ký tự!');
                    return false;
                }
                
                // If "other" division is selected, use the new division value
                if (divisionSelect.value === 'other') {
                    const newDivValue = newDivisionInput.value.trim();
                    if (!newDivValue) {
                        e.preventDefault();
                        alert('Vui lòng nhập tên bộ phận mới!');
                        return false;
                    }
                    // Set the division value to the new division
                    divisionSelect.innerHTML += `<option value="${newDivValue}" selected>${newDivValue}</option>`;
                    divisionSelect.value = newDivValue;
                }
            });
            
            // Set default hire date to today
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('hireDate').value = today;
        });
    </script>
</body>
</html>
