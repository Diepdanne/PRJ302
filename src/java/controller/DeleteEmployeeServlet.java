package controller;

import dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "DeleteEmployeeServlet", urlPatterns = {"/delete-employee"})
public class DeleteEmployeeServlet extends HttpServlet {

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
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.deleteUser(userId);
            
            if (success) {
                session.setAttribute("successMessage", "Xóa nhân viên thành công!");
            } else {
                session.setAttribute("errorMessage", "Không thể xóa nhân viên. Vui lòng thử lại.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMessage", "Đã xảy ra lỗi khi xóa nhân viên.");
        }
        
        response.sendRedirect("employee-list");
    }
}
