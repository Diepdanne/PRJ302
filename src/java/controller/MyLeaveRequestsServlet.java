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

@WebServlet(name = "MyLeaveRequestsServlet", urlPatterns = {"/my-leave-requests"})
public class MyLeaveRequestsServlet extends HttpServlet {

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
        
        try {
            LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
            List<LeaveRequest> myRequests = leaveRequestDAO.getLeaveRequestsByUserId(userId);
            
            request.setAttribute("leaveRequests", myRequests);
            request.setAttribute("pageTitle", "Đơn nghỉ phép của tôi");
            
            // Chuyển hướng đến trang phù hợp theo role
            if ("Staff".equals(userRole)) {
                request.getRequestDispatcher("my_leave_requests.jsp").forward(request, response);
            } else if ("Manager".equals(userRole)) {
                request.getRequestDispatcher("manager_my_requests.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("my_leave_requests.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải danh sách đơn nghỉ phép.");
            request.getRequestDispatcher("staff_dashboard.jsp").forward(request, response);
        }
    }
}
