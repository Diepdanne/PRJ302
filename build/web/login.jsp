<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link rel="stylesheet" href="css/style.css">
    <!-- Thêm Font Awesome để có icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="login-container">
        <h2>Đăng nhập</h2>
        <form action="login" method="post">
            <div class="input-group">
                <i class="fas fa-envelope icon"></i>
                <input type="email" id="email" name="email" required placeholder="Nhập email của bạn">
            </div>
            <div class="input-group">
                <i class="fas fa-lock icon"></i>
                <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu của bạn">
            </div>
            
            <%-- Hiển thị thông báo lỗi bằng JSTL & EL --%>
            <c:if test="${not empty errorMessage}">
                <p class="error-message">${errorMessage}</p>
            </c:if>

            <button type="submit" class="login-button">Đăng nhập</button>
        </form>
        <p class="footer-text">Bạn chưa có tài khoản? <a href="#">Đăng ký ngay</a></p>
    </div>
</body>
</html>
