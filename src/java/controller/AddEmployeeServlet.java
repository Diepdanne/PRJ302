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

@WebServlet(name = "AddEmployeeServlet", urlPatterns = {"/add-employee"})
public class AddEmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"Admin".equals(userRole)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            List<User> managers = userDAO.getManagers();
            List<String> divisions = userDAO.getAllDivisions();
            
            request.setAttribute("managers", managers);
            request.setAttribute("divisions", divisions);
            request.getRequestDispatcher("add_employee.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải trang.");
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        String userRole = (String) session.getAttribute("userRole");
        
        if (!"Admin".equals(userRole)) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Lấy dữ liệu từ form
            String userName = request.getParameter("userName");
            String password = request.getParameter("password");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            String division = request.getParameter("division");
            String dateOfBirthStr = request.getParameter("dateOfBirth");
            String gender = request.getParameter("gender");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String hireDateStr = request.getParameter("hireDate");
            String department = request.getParameter("department");
            String managerIdStr = request.getParameter("managerId");
            
            // Validation
            if (userName == null || userName.trim().isEmpty() ||
                password == null || password.trim().isEmpty() ||
                email == null || email.trim().isEmpty()) {
                throw new IllegalArgumentException("Tên, mật khẩu và email không được để trống.");
            }
            
            // Kiểm tra email đã tồn tại
            UserDAO userDAO = new UserDAO();
            if (userDAO.isEmailExists(email, 0)) {
                throw new IllegalArgumentException("Email đã tồn tại trong hệ thống.");
            }
            
            // Chuyển đổi ngày
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date dateOfBirth = null;
            Date hireDate = null;
            
            if (dateOfBirthStr != null && !dateOfBirthStr.trim().isEmpty()) {
                dateOfBirth = new Date(sdf.parse(dateOfBirthStr).getTime());
            }
            
            if (hireDateStr != null && !hireDateStr.trim().isEmpty()) {
                hireDate = new Date(sdf.parse(hireDateStr).getTime());
            }
            
            int managerId = 0;
            if (managerIdStr != null && !managerIdStr.trim().isEmpty() && !"0".equals(managerIdStr)) {
                managerId = Integer.parseInt(managerIdStr);
            }
            
            // Tạo đối tượng User
            User newUser = new User(userName, password, email, role, division, 
                                  dateOfBirth, gender, phoneNumber, address, 
                                  hireDate, department, managerId);
            
            // Lưu vào database
            boolean success = userDAO.addUser(newUser);
            
            if (success) {
                request.setAttribute("successMessage", "Thêm nhân viên thành công!");
                response.sendRedirect("employee-list");
            } else {
                request.setAttribute("errorMessage", "Không thể thêm nhân viên. Vui lòng thử lại.");
                doGet(request, response);
            }
            
        } catch (ParseException e) {
            request.setAttribute("errorMessage", "Định dạng ngày không hợp lệ.");
            doGet(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi hệ thống. Vui lòng thử lại sau.");
            doGet(request, response);
        }
    }
}
