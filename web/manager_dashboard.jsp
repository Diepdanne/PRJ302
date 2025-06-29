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
                    <p><i class="fas fa-user-tie"></i> ${userRole}</p>
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
                            <i class="fas fa-chart-line"></i>
                            Báo cáo nhóm
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Quản lý nhóm</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-users"></i>
                            Nhân viên trong nhóm
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-week"></i>
                            Lịch làm việc nhóm
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Duyệt nghỉ phép</div>
                    <div class="nav-item">
                        <a href="#" class="nav-link">
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
                        <a href="#" class="nav-link">
                            <i class="fas fa-calendar-plus"></i>
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
                    <h1>Dashboard Manager</h1>
                </div>
                <div class="header-actions">
                    <button class="btn btn-outline">
                        <i class="fas fa-bell"></i>
                        Thông báo
                        <span class="badge">3</span>
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
                                <i class="fas fa-users"></i>
                            </div>
                            <div class="card-content">
                                <h3>12</h3>
                                <p>Nhân viên trong nhóm</p>
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
                
                <!-- Pending Approvals -->
                <div class="dashboard-card">
                    <h3 class="mb-4">Đơn nghỉ phép chờ duyệt</h3>
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
                </div>
            </div>
        </main>
    </div>
</body>
</html>