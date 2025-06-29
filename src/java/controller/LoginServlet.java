package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import model.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        UserDAO userDAO = new UserDAO();
        
        try {
            User user = userDAO.checkLogin(email, password);

            if (user != null) {
                // Đăng nhập thành công
                HttpSession session = request.getSession();
                session.setAttribute("userID", user.getUserId());
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("userRole", user.getRole());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userDivision", user.getDivision());
                session.setAttribute("managerID", user.getManagerId());
                session.setAttribute("managerName", user.getManagerName());

                // Xử lý Remember Me
                if ("true".equals(rememberMe)) {
                    Cookie emailCookie = new Cookie("rememberedEmail", email);
                    Cookie passwordCookie = new Cookie("rememberedPassword", password);
                    
                    emailCookie.setMaxAge(7 * 24 * 60 * 60);
                    passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                    
                    emailCookie.setPath("/");
                    passwordCookie.setPath("/");
                    
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                } else {
                    Cookie emailCookie = new Cookie("rememberedEmail", "");
                    Cookie passwordCookie = new Cookie("rememberedPassword", "");
                    
                    emailCookie.setMaxAge(0);
                    passwordCookie.setMaxAge(0);
                    
                    emailCookie.setPath("/");
                    passwordCookie.setPath("/");
                    
                    response.addCookie(emailCookie);
                    response.addCookie(passwordCookie);
                }

                // Chuyển hướng dựa trên vai trò
                switch (user.getRole()) {
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
                        response.sendRedirect("login.jsp");
                        break;
                }
            } else {
                request.setAttribute("errorMessage", "Email hoặc mật khẩu không đúng.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}