<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập hệ thống quản lý nghỉ phép</title>
    <link rel="stylesheet" href="style.css">
    <!-- Thêm Font Awesome để có icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body class="login-body">
    <div class="login-wrapper">
        <div class="login-container">
            <div class="login-header">
                <div class="logo">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <h2>Hệ thống quản lý nghỉ phép</h2>
                <p class="subtitle">Đăng nhập để tiếp tục</p>
            </div>
            
            <form action="login" method="post" class="login-form">
                <div class="input-group">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" required 
                           placeholder="Nhập email của bạn"
                           value="${cookie.rememberedEmail.value}">
                </div>
                
                <div class="input-group">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" required 
                           placeholder="Nhập mật khẩu của bạn"
                           value="${cookie.rememberedPassword.value}">
                    <span class="password-toggle" onclick="togglePassword()">
                        <i class="fas fa-eye" id="toggleIcon"></i>
                    </span>
                </div>
                
                <div class="remember-forgot">
                    <label class="remember-checkbox">
                        <input type="checkbox" name="rememberMe" value="true" 
                               ${not empty cookie.rememberedEmail ? 'checked' : ''}>
                        <span class="checkmark"></span>
                        Ghi nhớ mật khẩu
                    </label>
                    <a href="#" class="forgot-link">Quên mật khẩu?</a>
                </div>
                
                <%-- Hiển thị thông báo lỗi bằng JSTL & EL --%>
                <c:if test="${not empty errorMessage}">
                    <div class="error-message">
                        <i class="fas fa-exclamation-circle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <button type="submit" class="login-button">
                    <span>Đăng nhập</span>
                    <i class="fas fa-arrow-right"></i>
                </button>
            </form>
            
            <div class="login-footer">
                <p>© 2024 Hệ thống quản lý nghỉ phép. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>