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

@WebServlet(name = "PendingRequestsServlet", urlPatterns = {"/pending-requests"})
public class PendingRequestsServlet extends HttpServlet {

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
        
        // Chỉ Manager và Admin mới có quyền truy cập
        if (!"Manager".equals(userRole) && !"Admin".equals(userRole)) {
            response.sendRedirect("staff_dashboard.jsp");
            return;
        }
        
        try {
            LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
            List<LeaveRequest> pendingRequests;
            
            if ("Manager".equals(userRole)) {
                // Manager chỉ thấy đơn của nhân viên trong bộ phận
                pendingRequests = leaveRequestDAO.getPendingRequestsForManager(userId);
                request.setAttribute("pageTitle", "Đơn chờ duyệt - Nhân viên");
            } else {
                // Admin thấy đơn của Manager chờ duyệt
                pendingRequests = leaveRequestDAO.getPendingManagerRequestsForAdmin();
                request.setAttribute("pageTitle", "Đơn chờ duyệt - Manager");
            }
            
            request.setAttribute("pendingRequests", pendingRequests);
            request.getRequestDispatcher("pending_requests.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh sách đơn chờ duyệt.");
            
            if ("Manager".equals(userRole)) {
                request.getRequestDispatcher("manager_dashboard.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
            }
        }
    }
}
