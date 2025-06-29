package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.LeaveRequest;

public class LeaveRequestDAO {
    
    /**
     * Tạo đơn nghỉ phép mới
     */
    public boolean createLeaveRequest(LeaveRequest leaveRequest) throws Exception {
        String sql = "INSERT INTO LeaveRequests (UserID, LeaveTypeID, FromDate, ToDate, Reason, Status, ProofFile) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, leaveRequest.getUserId());
            ps.setInt(2, leaveRequest.getLeaveTypeId());
            ps.setDate(3, leaveRequest.getFromDate());
            ps.setDate(4, leaveRequest.getToDate());
            ps.setString(5, leaveRequest.getReason());
            ps.setString(6, leaveRequest.getStatus());
            ps.setString(7, leaveRequest.getProofFile());
            
            int result = ps.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * Lấy danh sách đơn nghỉ phép của một user
     */
    public List<LeaveRequest> getLeaveRequestsByUserId(int userId) throws Exception {
        List<LeaveRequest> requests = new ArrayList<>();
        String sql = "SELECT lr.RequestID, lr.UserID, lr.LeaveTypeID, lr.FromDate, lr.ToDate, " +
                    "lr.Reason, lr.Status, lr.ManagerNote, lr.ProofFile, lr.CreatedAt, " +
                    "lt.Name as LeaveTypeName, u.UserName " +
                    "FROM LeaveRequests lr " +
                    "JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID " +
                    "JOIN Users u ON lr.UserID = u.UserID " +
                    "WHERE lr.UserID = ? " +
                    "ORDER BY lr.CreatedAt DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LeaveRequest request = mapResultSetToLeaveRequest(rs);
                    requests.add(request);
                }
            }
        }
        return requests;
    }
    
    /**
     * Lấy danh sách đơn chờ duyệt cho manager (theo bộ phận)
     */
    public List<LeaveRequest> getPendingRequestsForManager(int managerId) throws Exception {
        List<LeaveRequest> requests = new ArrayList<>();
        String sql = "SELECT lr.RequestID, lr.UserID, lr.LeaveTypeID, lr.FromDate, lr.ToDate, " +
                    "lr.Reason, lr.Status, lr.ManagerNote, lr.ProofFile, lr.CreatedAt, " +
                    "lt.Name as LeaveTypeName, u.UserName, u.Division " +
                    "FROM LeaveRequests lr " +
                    "JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID " +
                    "JOIN Users u ON lr.UserID = u.UserID " +
                    "WHERE u.ManagerID = ? AND lr.Status = 'Inprogress' " +
                    "ORDER BY lr.CreatedAt ASC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, managerId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LeaveRequest request = mapResultSetToLeaveRequest(rs);
                    requests.add(request);
                }
            }
        }
        return requests;
    }
    
    /**
     * Lấy danh sách đơn của manager chờ admin duyệt
     */
    public List<LeaveRequest> getPendingManagerRequestsForAdmin() throws Exception {
        List<LeaveRequest> requests = new ArrayList<>();
        String sql = "SELECT lr.RequestID, lr.UserID, lr.LeaveTypeID, lr.FromDate, lr.ToDate, " +
                    "lr.Reason, lr.Status, lr.ManagerNote, lr.ProofFile, lr.CreatedAt, " +
                    "lt.Name as LeaveTypeName, u.UserName, u.Division, u.Role " +
                    "FROM LeaveRequests lr " +
                    "JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID " +
                    "JOIN Users u ON lr.UserID = u.UserID " +
                    "WHERE u.Role = 'Manager' AND lr.Status = 'Inprogress' " +
                    "ORDER BY lr.CreatedAt ASC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                LeaveRequest request = mapResultSetToLeaveRequest(rs);
                requests.add(request);
            }
        }
        return requests;
    }
    
    /**
     * Lấy tất cả đơn nghỉ phép (cho admin)
     */
    public List<LeaveRequest> getAllLeaveRequests() throws Exception {
        List<LeaveRequest> requests = new ArrayList<>();
        String sql = "SELECT lr.RequestID, lr.UserID, lr.LeaveTypeID, lr.FromDate, lr.ToDate, " +
                    "lr.Reason, lr.Status, lr.ManagerNote, lr.ProofFile, lr.CreatedAt, " +
                    "lt.Name as LeaveTypeName, u.UserName, u.Division, u.Role, m.UserName as ManagerName " +
                    "FROM LeaveRequests lr " +
                    "JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID " +
                    "JOIN Users u ON lr.UserID = u.UserID " +
                    "LEFT JOIN Users m ON u.ManagerID = m.UserID " +
                    "ORDER BY lr.CreatedAt DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                LeaveRequest request = mapResultSetToLeaveRequest(rs);
                request.setManagerName(rs.getString("ManagerName"));
                requests.add(request);
            }
        }
        return requests;
    }
    
    /**
     * Lấy danh sách đơn theo bộ phận (cho manager xem tất cả đơn trong bộ phận)
     */
    public List<LeaveRequest> getRequestsByDivision(String division) throws Exception {
        List<LeaveRequest> requests = new ArrayList<>();
        String sql = "SELECT lr.RequestID, lr.UserID, lr.LeaveTypeID, lr.FromDate, lr.ToDate, " +
                    "lr.Reason, lr.Status, lr.ManagerNote, lr.ProofFile, lr.CreatedAt, " +
                    "lt.Name as LeaveTypeName, u.UserName, u.Division, u.Role " +
                    "FROM LeaveRequests lr " +
                    "JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID " +
                    "JOIN Users u ON lr.UserID = u.UserID " +
                    "WHERE u.Division = ? " +
                    "ORDER BY lr.CreatedAt DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, division);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LeaveRequest request = mapResultSetToLeaveRequest(rs);
                    requests.add(request);
                }
            }
        }
        return requests;
    }
    
    /**
     * Cập nhật trạng thái đơn nghỉ phép
     */
    public boolean updateRequestStatus(int requestId, String status, String managerNote) throws Exception {
        String sql = "UPDATE LeaveRequests SET Status = ?, ManagerNote = ? WHERE RequestID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setString(2, managerNote);
            ps.setInt(3, requestId);
            
            int result = ps.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * Lấy thông tin đơn nghỉ phép theo ID
     */
    public LeaveRequest getLeaveRequestById(int requestId) throws Exception {
        String sql = "SELECT lr.RequestID, lr.UserID, lr.LeaveTypeID, lr.FromDate, lr.ToDate, " +
                    "lr.Reason, lr.Status, lr.ManagerNote, lr.ProofFile, lr.CreatedAt, " +
                    "lt.Name as LeaveTypeName, u.UserName, u.Division, u.Role " +
                    "FROM LeaveRequests lr " +
                    "JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID " +
                    "JOIN Users u ON lr.UserID = u.UserID " +
                    "WHERE lr.RequestID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, requestId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToLeaveRequest(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Helper method để map ResultSet thành LeaveRequest object
     */
    private LeaveRequest mapResultSetToLeaveRequest(ResultSet rs) throws SQLException {
        LeaveRequest request = new LeaveRequest();
        request.setRequestId(rs.getInt("RequestID"));
        request.setUserId(rs.getInt("UserID"));
        request.setLeaveTypeId(rs.getInt("LeaveTypeID"));
        request.setFromDate(rs.getDate("FromDate"));
        request.setToDate(rs.getDate("ToDate"));
        request.setReason(rs.getString("Reason"));
        request.setStatus(rs.getString("Status"));
        request.setManagerNote(rs.getString("ManagerNote"));
        request.setProofFile(rs.getString("ProofFile"));
        request.setCreatedAt(rs.getTimestamp("CreatedAt"));
        request.setLeaveTypeName(rs.getString("LeaveTypeName"));
        request.setUserName(rs.getString("UserName"));
        return request;
    }
}