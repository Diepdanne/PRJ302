package controller;

import dao.UserDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet(name = "EmployeeListServlet", urlPatterns = {"/employee-list"})
public class EmployeeListServlet extends HttpServlet {

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
            // Lấy tham số search và filter
            String searchTerm = request.getParameter("search");
            String roleFilter = request.getParameter("roleFilter");
            String divisionFilter = request.getParameter("divisionFilter");
            
            UserDAO userDAO = new UserDAO();
            List<User> employees = userDAO.getAllUsers(searchTerm, roleFilter, divisionFilter);
            List<String> divisions = userDAO.getAllDivisions();
            
            request.setAttribute("employees", employees);
            request.setAttribute("divisions", divisions);
            request.setAttribute("searchTerm", searchTerm);
            request.setAttribute("roleFilter", roleFilter);
            request.setAttribute("divisionFilter", divisionFilter);
            
            request.getRequestDispatcher("employee_list.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh sách nhân viên.");
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
