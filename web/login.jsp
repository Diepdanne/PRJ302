<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập hệ thống</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <h2>Đăng nhập</h2>
        <form action="login" method="post">
            <div class="input-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required placeholder="Nhập email của bạn">
            </div>
            <div class="input-group">
                <label for="password">Mật khẩu:</label>
                <input type="password" id="password" name="password" required placeholder="Nhập mật khẩu của bạn">
            </div>
            <%-- Hiển thị thông báo lỗi nếu có --%>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <p class="error-message"><%= errorMessage %></p>
            <%
                }
            %>
            <button type="submit" class="login-button">Đăng nhập</button>
        </form>
        <p class="footer-text">Bạn chưa có tài khoản? <a href="#">Đăng ký ngay</a></p>
    </div>
</body>
</html>

