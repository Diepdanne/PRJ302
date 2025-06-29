<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Staff Dashboard - Hệ thống quản lý nghỉ phép</title>
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
                    <p><i class="fas fa-user"></i> ${userRole}</p>
                </div>
            </div>
            
            <nav class="sidebar-nav">
                <div class="nav-section">
                    <div class="nav-section-title">Tổng quan</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link active">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            Lịch làm việc
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Nghỉ phép</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-plus-circle"></i>
                            Tạo đơn nghỉ phép
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-list-alt"></i>
                            Đơn nghỉ phép của tôi
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-chart-pie"></i>
                            Thống kê nghỉ phép
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Chấm công</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-clock"></i>
                            Chấm công hôm nay
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-history"></i>
                            Lịch sử chấm công
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Cá nhân</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-user-edit"></i>
                            Thông tin cá nhân
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-key"></i>
                            Đổi mật khẩu
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
                    <h1>Dashboard Nhân viên</h1>
                </div>
                <div class="header-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-bell"></i>
                        Thông báo
                    </button>
                    <button class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Tạo đơn nghỉ phép
                    </button>
                </div>
            </header>
            
            <div class="content">
                <!-- Dashboard Cards -->
                <div class="dashboard-grid">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon primary">
                                <i class="fas fa-calendar-day"></i>
                            </div>
                            <div class="card-content">
                                <h3>12</h3>
                                <p>Ngày phép còn lại</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon warning">
                                <i class="fas fa-hourglass-half"></i>
                            </div>
                            <div class="card-content">
                                <h3>2</h3>
                                <p>Đơn chờ duyệt</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon success">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="card-content">
                                <h3>3</h3>
                                <p>Đơn đã duyệt</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Other content -->
            </div>
        </main>
    </div>
</body>
</html>