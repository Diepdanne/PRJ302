package controller;

import dao.LeaveTypeDAO;
import dao.LeaveRequestDAO;
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
import model.LeaveRequest;
import model.LeaveType;

@WebServlet(name = "CreateLeaveRequestServlet", urlPatterns = {"/create-leave-request"})
public class CreateLeaveRequestServlet extends HttpServlet {

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
            LeaveTypeDAO leaveTypeDAO = new LeaveTypeDAO();
            List<LeaveType> leaveTypes = leaveTypeDAO.getAllLeaveTypes();
            request.setAttribute("leaveTypes", leaveTypes);
            request.getRequestDispatcher("create_leave_request.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Đã xảy ra lỗi khi tải trang. Vui lòng thử lại sau.");
            request.getRequestDispatcher("staff_dashboard.jsp").forward(request, response);
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
        
        try {
            // Lấy dữ liệu từ form
            int leaveTypeId = Integer.parseInt(request.getParameter("leaveTypeId"));
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String reason = request.getParameter("reason");
            String proofFile = request.getParameter("proofFile"); // Tạm thời để trống, sẽ xử lý upload file sau
            
            // Validation
            if (fromDateStr == null || fromDateStr.trim().isEmpty() ||
                toDateStr == null || toDateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Ngày bắt đầu và ngày kết thúc không được để trống.");
            }
            
            // Chuyển đổi string thành Date
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date fromDate = new Date(sdf.parse(fromDateStr).getTime());
            Date toDate = new Date(sdf.parse(toDateStr).getTime());
            
            // Kiểm tra logic ngày
            if (fromDate.after(toDate)) {
                throw new IllegalArgumentException("Ngày bắt đầu không thể sau ngày kết thúc.");
            }
            
            // Kiểm tra ngày không được trong quá khứ
            Date today = new Date(System.currentTimeMillis());
            if (fromDate.before(today)) {
                throw new IllegalArgumentException("Ngày bắt đầu không thể trong quá khứ.");
            }
            
            // Tạo đối tượng LeaveRequest
            LeaveRequest leaveRequest = new LeaveRequest();
            leaveRequest.setUserId(userId);
            leaveRequest.setLeaveTypeId(leaveTypeId);
            leaveRequest.setFromDate(fromDate);
            leaveRequest.setToDate(toDate);
            leaveRequest.setReason(reason);
            leaveRequest.setStatus("Inprogress");
            leaveRequest.setProofFile(proofFile);
            
            // Lưu vào database
            LeaveRequestDAO leaveRequestDAO = new LeaveRequestDAO();
            boolean success = leaveRequestDAO.createLeaveRequest(leaveRequest);
            
            if (success) {
                request.setAttribute("successMessage", "Đơn nghỉ phép đã được tạo thành công!");
                response.sendRedirect("my-leave-requests");
            } else {
                request.setAttribute("errorMessage", "Không thể tạo đơn nghỉ phép. Vui lòng thử lại.");
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
