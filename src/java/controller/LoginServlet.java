package controller;

import dao.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT UserID, UserName, Role FROM Users WHERE Email = ? AND Password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            rs = ps.executeQuery();

            if (rs.next()) {
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                session.setAttribute("userID", rs.getInt("UserID"));
                session.setAttribute("userName", rs.getString("UserName"));
                String role = rs.getString("Role");
                session.setAttribute("userRole", role);

                // Chuyển hướng dựa trên vai trò (Role)
                switch (role) {
                    case "Admin":
                        response.sendRedirect("admin_dashboard.jsp");
                        break;
                    case "Manager":
                        response.sendRedirect("manager_dashboard.jsp");
                        break;
                    case "Staff":
                        response.sendRedirect("staff_dashboard.jsp");
                        break;
                    default:
                        // Nếu có vai trò không xác định, quay về trang login
                        response.sendRedirect("login.jsp");
                        break;
                }
            } else {
                // Đăng nhập thất bại
                request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            // Đóng tài nguyên
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
