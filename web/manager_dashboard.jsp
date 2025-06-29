<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Manager Dashboard - Hệ thống quản lý nghỉ phép</title>
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
                    <p><i class="fas fa-user-tie"></i> ${userRole} - ${userDivision}</p>
                </div>
            </div>
            
            <nav class="sidebar-nav">
                <div class="nav-section">
                    <div class="nav-section-title">Tổng quan</div>
                    <div class="nav-item">
                        <a href="manager_dashboard.jsp" class="nav-link active">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Quản lý nhóm</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-users"></i>
                            Nhân viên bộ phận ${userDivision}
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-week"></i>
                            Lịch làm việc bộ phận
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Duyệt nghỉ phép</div>
                    <div class="nav-item">
                        <a href="pending-requests" class="nav-link">
                            <i class="fas fa-inbox"></i>
                            Đơn chờ duyệt
                            <span class="badge">8</span>
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-check-double"></i>
                            Đơn đã duyệt
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-history"></i>
                            Lịch sử duyệt
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Cá nhân</div>
                    <div class="nav-item">
                        <a href="create-leave-request" class="nav-link">
                            <i class="fas fa-calendar-plus"></i>
                            Tạo đơn nghỉ phép
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="my-leave-requests" class="nav-link">
                            <i class="fas fa-list-alt"></i>
                            Đơn nghỉ phép của tôi
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-user-edit"></i>
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
                    <h1>Dashboard Manager - ${userDivision}</h1>
                </div>
                <div class="header-actions">
                    <a href="pending-requests" class="btn btn-outline">
                        <i class="fas fa-bell"></i>
                        Đơn chờ duyệt
                        <span class="badge">3</span>
                    </a>
                    <a href="create-leave-request" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Tạo đơn nghỉ phép
                    </a>
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
                                <h3>12</h3>
                                <p>Nhân viên bộ phận ${userDivision}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon warning">
                                <i class="fas fa-clock"></i>
                            </div>
                            <div class="card-content">
                                <h3>8</h3>
                                <p>Đơn chờ duyệt</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon success">
                                <i class="fas fa-user-check"></i>
                            </div>
                            <div class="card-content">
                                <h3>9</h3>
                                <p>Nhân viên đang làm việc</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="dashboard-card">
                        <div class="card-header">
                            <div class="card-icon error">
                                <i class="fas fa-user-times"></i>
                            </div>
                            <div class="card-content">
                                <h3>3</h3>
                                <p>Nhân viên đang nghỉ</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="dashboard-card">
                    <h3 class="mb-4">Thao tác nhanh</h3>
                    <div class="quick-actions">
                        <a href="pending-requests" class="quick-action-item">
                            <div class="quick-action-icon warning">
                                <i class="fas fa-inbox"></i>
                            </div>
                            <div class="quick-action-content">
                                <h4>Duyệt đơn nghỉ phép</h4>
                                <p>8 đơn đang chờ duyệt</p>
                            </div>
                        </a>
                        
                        <a href="create-leave-request" class="quick-action-item">
                            <div class="quick-action-icon primary">
                                <i class="fas fa-plus-circle"></i>
                            </div>
                            <div class="quick-action-content">
                                <h4>Tạo đơn nghỉ phép</h4>
                                <p>Tạo đơn xin nghỉ phép mới</p>
                            </div>
                        </a>
                        
                        <a href="#" class="quick-action-item">
                            <div class="quick-action-icon success">
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="quick-action-content">
                                <h4>Quản lý nhân viên</h4>
                                <p>Xem thông tin nhân viên bộ phận</p>
                            </div>
                        </a>
                    </div>
                </div>
                
                <!-- Pending Approvals -->
                <div class="dashboard-card">
                    <h3 class="mb-4">Đơn nghỉ phép chờ duyệt - Bộ phận ${userDivision}</h3>
                    <div class="approval-list">
                        <div class="approval-item">
                            <div class="approval-info">
                                <div class="employee-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="approval-details">
                                    <h4>Nguyễn Văn A</h4>
                                    <p>Nghỉ phép năm: 15/01/2024 - 17/01/2024</p>
                                    <span class="approval-reason">Lý do: Đi du lịch cùng gia đình</span>
                                    <span class="approval-division">Bộ phận: ${userDivision}</span>
                                </div>
                            </div>
                            <div class="approval-actions">
                                <button class="btn btn-success btn-sm">
                                    <i class="fas fa-check"></i>
                                    Duyệt
                                </button>
                                <button class="btn btn-error btn-sm">
                                    <i class="fas fa-times"></i>
                                    Từ chối
                                </button>
                            </div>
                        </div>
                        
                        <div class="approval-item">
                            <div class="approval-info">
                                <div class="employee-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="approval-details">
                                    <h4>Trần Thị B</h4>
                                    <p>Nghỉ bệnh: 20/01/2024 - 22/01/2024</p>
                                    <span class="approval-reason">Lý do: Khám bệnh định kỳ</span>
                                    <span class="approval-division">Bộ phận: ${userDivision}</span>
                                </div>
                            </div>
                            <div class="approval-actions">
                                <button class="btn btn-success btn-sm">
                                    <i class="fas fa-check"></i>
                                    Duyệt
                                </button>
                                <button class="btn btn-error btn-sm">
                                    <i class="fas fa-times"></i>
                                    Từ chối
                                </button>
                            </div>
                        </div>
                        
                        <div class="approval-item">
                            <div class="approval-info">
                                <div class="employee-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="approval-details">
                                    <h4>Lê Văn C</h4>
                                    <p>Nghỉ việc riêng: 25/01/2024</p>
                                    <span class="approval-reason">Lý do: Giải quyết việc cá nhân</span>
                                </div>
                            </div>
                            <div class="approval-actions">
                                <button class="btn btn-success btn-sm">
                                    <i class="fas fa-check"></i>
                                    Duyệt
                                </button>
                                <button class="btn btn-error btn-sm">
                                    <i class="fas fa-times"></i>
                                    Từ chối
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="text-center mt-4">
                        <a href="pending-requests" class="btn btn-outline">
                            <i class="fas fa-list"></i>
                            Xem tất cả đơn chờ duyệt
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>