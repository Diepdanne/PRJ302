package controller;

import dao.UserDAO;
import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "UserProfileServlet", urlPatterns = {"/user-profile"})
public class UserProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userID");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            List<User> managers = userDAO.getManagers();
            List<String> divisions = userDAO.getAllDivisions();
            
            request.setAttribute("user", user);
            request.setAttribute("managers", managers);
            request.setAttribute("divisions", divisions);
            request.getRequestDispatcher("user_profile.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải thông tin cá nhân.");
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userID");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response, userId);
        } else if ("changePassword".equals(action)) {
            changePassword(request, response, userId);
        } else {
            doGet(request, response);
        }
    }
    
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        
        try {
            // Lấy dữ liệu từ form
            String userName = request.getParameter("userName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String gender = request.getParameter("gender");
            
            // Validation
            if (userName == null || userName.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên và email không được để trống.");
            }
            
            UserDAO userDAO = new UserDAO();
            
            // Kiểm tra email đã tồn tại (trừ user hiện tại)
            if (userDAO.isEmailExists(email, userId)) {
                throw new IllegalArgumentException("Email đã tồn tại trong hệ thống.");
            }
            
            // Lấy thông tin user hiện tại
            User user = userDAO.getUserById(userId);
            if (user == null) {
                throw new IllegalArgumentException("Không tìm thấy thông tin người dùng.");
            }
            
            // Cập nhật thông tin
            user.setUserName(userName);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            user.setGender(gender);
            
            // Chuyển đổi ngày sinh
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date dateOfBirth = new Date(sdf.parse(dateOfBirthStr).getTime());
                user.setDateOfBirth(dateOfBirth);
            }
            
            // Cập nhật database
            boolean success = userDAO.updateUser(user);
            
            if (success) {
                // Cập nhật session
                HttpSession session = request.getSession();
                session.setAttribute("userName", userName);
                session.setAttribute("userEmail", email);
                
                request.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("errorMessage", "Không thể cập nhật thông tin. Vui lòng thử lại.");
            }
            
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
        }
        
        doGet(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        
        try {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            
            // Validation
            if (currentPassword == null || currentPassword.trim().isEmpty() ||
                newPassword == null || newPassword.trim().isEmpty() ||
                confirmPassword == null || confirmPassword.trim().isEmpty()) {
                throw new IllegalArgumentException("Tất cả các trường mật khẩu không được để trống.");
            }
            
            if (!newPassword.equals(confirmPassword)) {
                throw new IllegalArgumentException("Mật khẩu mới và xác nhận mật khẩu không khớp.");
            }
            
            if (newPassword.length() < 6) {
                throw new IllegalArgumentException("Mật khẩu mới phải có ít nhất 6 ký tự.");
            }
            
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserById(userId);
            
            // Kiểm tra mật khẩu hiện tại
            if (!currentPassword.equals(user.getPassword())) {
                throw new IllegalArgumentException("Mật khẩu hiện tại không đúng.");
            }
            
            // Cập nhật mật khẩu mới
            boolean success = userDAO.changePassword(userId, newPassword);
            
            if (success) {
                request.setAttribute("successMessage", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("errorMessage", "Không thể đổi mật khẩu. Vui lòng thử lại.");
            }
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
        }
        
        doGet(request, response);
    }
}
