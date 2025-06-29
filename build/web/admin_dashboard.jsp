<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Dashboard - Hệ thống quản lý nghỉ phép</title>
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
                        <a href="#" class="nav-link active">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-chart-bar"></i>
                            Báo cáo thống kê
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Quản lý người dùng</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-users"></i>
                            Danh sách nhân viên
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-user-plus"></i>
                            Thêm nhân viên
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-user-cog"></i>
                            Phân quyền
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Quản lý nghỉ phép</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-alt"></i>
                            Tất cả đơn nghỉ phép
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-clock"></i>
                            Đơn chờ duyệt
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-cogs"></i>
                            Cấu hình loại nghỉ phép
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Hệ thống</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-cog"></i>
                            Cài đặt hệ thống
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-history"></i>
                            Lịch sử hoạt động
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
                    <h1>Dashboard Admin</h1>
                </div>
                <div class="header-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-bell"></i>
                        Thông báo
                    </button>
                    <button class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm mới
                    </button>
                </div>
            </header>
            
            <div class="content">
                <!-- Dashboard Cards -->
                <div class="dashboard-grid">
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon primary">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="card-content">
                                <h3>156</h3>
                                <p>Tổng số nhân viên</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon warning">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="card-content">
                                <h3>23</h3>
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
                                <h3>89</h3>
                                <p>Đơn đã duyệt tháng này</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon error">
                                <i class="fas fa-times-circle"></i>
                            </div>
                            <div class="card-content">
                                <h3>12</h3>
                                <p>Đơn bị từ chối</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Activities -->
                <div class="dashboard-card">
                    <h3 class="mb-4">Hoạt động gần đây</h3>
                    <div class="activity-list">
                        <div class="activity-item">
                            <div class="activity-icon success">
                                <i class="fas fa-check"></i>
                            </div>
                            <div class="activity-content">
                                <p><strong>Nguyễn Văn A</strong> đã duyệt đơn nghỉ phép của <strong>Trần Thị B</strong></p>
                                <span class="activity-time">5 phút trước</span>
                            </div>
                        </div>
                        
                        <div class="activity-item">
                            <div class="activity-icon primary">
                                <i class="fas fa-plus"></i>
                            </div>
                            <div class="activity-content">
                                <p><strong>Lê Văn C</strong> đã gửi đơn xin nghỉ phép</p>
                                <span class="activity-time">15 phút trước</span>
                            </div>
                        </div>
                        
                        <div class="activity-item">
                            <div class="activity-icon warning">
                                <i class="fas fa-edit"></i>
                            </div>
                            <div class="activity-content">
                                <p><strong>Phạm Thị D</strong> đã cập nhật thông tin cá nhân</p>
                                <span class="activity-time">1 giờ trước</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        // Toggle sidebar on mobile
        function toggleSidebar() {
            const sidebar = document.querySelector('.sidebar');
            sidebar.classList.toggle('open');
        }
        
        // Add mobile menu button functionality if needed
        document.addEventListener('DOMContentLoaded', function() {
            // Add any additional JavaScript functionality here
        });
    </script>
</body>
</html>