package controller;

import dao.LeaveRequestDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.LeaveRequest;

@WebServlet(name = "AllRequestsServlet", urlPatterns = {"/all-requests"})
public class AllRequestsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userID");
        String userRole = (String) session.getAttribute("userRole");
        
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Chỉ Admin mới có quyền truy cập
        if (!"Admin".equals(userRole)) {
            response.sendRedirect("staff_dashboard.jsp");
            return;
        }
        
        try {
            LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
            List<LeaveRequest> allRequests = leaveRequestDAO.getAllLeaveRequests();
            
            request.setAttribute("allRequests", allRequests);
            request.setAttribute("pageTitle", "Tất cả đơn nghỉ phép");
            request.getRequestDispatcher("all_requests.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh sách đơn nghỉ phép.");
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }
}
