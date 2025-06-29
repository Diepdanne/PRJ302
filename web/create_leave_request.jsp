<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Tạo đơn nghỉ phép - Hệ thống quản lý nghỉ phép</title>
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
                        <a href="staff_dashboard.jsp" class="nav-link">
                            <i class="fas fa-tachometer-alt"></i>
                            Dashboard
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Nghỉ phép</div>
                    <div class="nav-item">
                        <a href="create-leave-request" class="nav-link active">
                            <i class="fas fa-plus-circle"></i>
                            Tạo đơn nghỉ phép
                        </a>
                    </div>
                    <div class="nav-item">
                        <a href="my-leave-requests" class="nav-link">
                            <i class="fas fa-list-alt"></i>
                            Đơn nghỉ phép của tôi
                        </a>
                    </div>
                </div>
                
                <div class="nav-section">
                    <div class="nav-section-title">Cá nhân</div>
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
                    <h1>Tạo đơn nghỉ phép</h1>
                </div>
                <div class="header-actions">
                    <a href="my-leave-requests" class="btn btn-outline">
                        <i class="fas fa-list"></i>
                        Xem đơn của tôi
                    </a>
                </div>
            </header>
            
            <div class="content">
                <div class="form-container">
                    <div class="form-card">
                        <div class="form-header">
                            <h2>
                                <i class="fas fa-calendar-plus"></i>
                                Thông tin đơn nghỉ phép
                            </h2>
                            <p>Vui lòng điền đầy đủ thông tin để tạo đơn nghỉ phép</p>
                        </div>
                        
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
                        
                        <form action="create-leave-request" method="post" class="leave-form" id="leaveForm">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="leaveTypeId" class="form-label">
                                        <i class="fas fa-tag"></i>
                                        Loại nghỉ phép <span class="required">*</span>
                                    </label>
                                    <select id="leaveTypeId" name="leaveTypeId" class="form-select" required>
                                        <option value="">-- Chọn loại nghỉ phép --</option>
                                        <c:forEach var="leaveType" items="${leaveTypes}">
                                            <option value="${leaveType.leaveTypeId}">${leaveType.name} - ${leaveType.description}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="fromDate" class="form-label">
                                        <i class="fas fa-calendar-alt"></i>
                                        Từ ngày <span class="required">*</span>
                                    </label>
                                    <input type="date" id="fromDate" name="fromDate" class="form-input" required>
                                </div>
                                
                                <div class="form-group">
                                    <label for="toDate" class="form-label">
                                        <i class="fas fa-calendar-alt"></i>
                                        Đến ngày <span class="required">*</span>
                                    </label>
                                    <input type="date" id="toDate" name="toDate" class="form-input" required>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="reason" class="form-label">
                                        <i class="fas fa-comment"></i>
                                        Lý do nghỉ phép <span class="required">*</span>
                                    </label>
                                    <textarea id="reason" name="reason" class="form-textarea" rows="4" 
                                              placeholder="Nhập lý do nghỉ phép..." required></textarea>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="proofFile" class="form-label">
                                        <i class="fas fa-paperclip"></i>
                                        File đính kèm (nếu có)
                                    </label>
                                    <div class="file-upload">
                                        <input type="file" id="proofFile" name="proofFile" class="form-file" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png">
                                        <label for="proofFile" class="file-upload-label">
                                            <i class="fas fa-cloud-upload-alt"></i>
                                            Chọn file hoặc kéo thả vào đây
                                        </label>
                                        <small class="file-note">Hỗ trợ: PDF, DOC, DOCX, JPG, PNG (Tối đa 5MB)</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-actions">
                                <button type="button" class="btn btn-outline" onclick="history.back()">
                                    <i class="fas fa-times"></i>
                                    Hủy bỏ
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-paper-plane"></i>
                                    Gửi đơn nghỉ phép
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script>
        // Set minimum date to today
        document.addEventListener('DOMContentLoaded', function() {
            const today = new Date().toISOString().split('T')[0];
            document.getElementById('fromDate').setAttribute('min', today);
            document.getElementById('toDate').setAttribute('min', today);
            
            // Update toDate minimum when fromDate changes
            document.getElementById('fromDate').addEventListener('change', function() {
                const fromDate = this.value;
                document.getElementById('toDate').setAttribute('min', fromDate);
                
                // Clear toDate if it's before fromDate
                const toDate = document.getElementById('toDate').value;
                if (toDate && toDate < fromDate) {
                    document.getElementById('toDate').value = '';
                }
            });
            
            // Form validation
            document.getElementById('leaveForm').addEventListener('submit', function(e) {
                const fromDate = new Date(document.getElementById('fromDate').value);
                const toDate = new Date(document.getElementById('toDate').value);
                
                if (fromDate > toDate) {
                    e.preventDefault();
                    alert('Ngày bắt đầu không thể sau ngày kết thúc!');
                    return false;
                }
                
                const reason = document.getElementById('reason').value.trim();
                if (reason.length < 10) {
                    e.preventDefault();
                    alert('Lý do nghỉ phép phải có ít nhất 10 ký tự!');
                    return false;
                }
            });
            
            // File upload handling
            const fileInput = document.getElementById('proofFile');
            const fileLabel = document.querySelector('.file-upload-label');
            
            fileInput.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    const fileName = this.files[0].name;
                    const fileSize = this.files[0].size;
                    
                    // Check file size (5MB limit)
                    if (fileSize > 5 * 1024 * 1024) {
                        alert('File không được vượt quá 5MB!');
                        this.value = '';
                        return;
                    }
                    
                    fileLabel.innerHTML = `<i class="fas fa-file"></i> ${fileName}`;
                } else {
                    fileLabel.innerHTML = '<i class="fas fa-cloud-upload-alt"></i> Chọn file hoặc kéo thả vào đây';
                }
            });
        });
    </script>
</body>
</html>
