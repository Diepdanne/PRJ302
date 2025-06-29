package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.LeaveType;

public class LeaveTypeDAO {
    
    /**
     * Lấy tất cả loại nghỉ phép
     * @return List<LeaveType>
     * @throws Exception 
     */
    public List<LeaveType> getAllLeaveTypes() throws Exception {
        List<LeaveType> leaveTypes = new ArrayList<>();
        String sql = "SELECT LeaveTypeID, Name, Description FROM LeaveTypes ORDER BY Name";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                LeaveType leaveType = new LeaveType();
                leaveType.setLeaveTypeId(rs.getInt("LeaveTypeID"));
                leaveType.setName(rs.getString("Name"));
                leaveType.setDescription(rs.getString("Description"));
                leaveTypes.add(leaveType);
            }
        }
        return leaveTypes;
    }
    
    /**
     * Lấy thông tin loại nghỉ phép theo ID
     * @param leaveTypeId
     * @return LeaveType
     * @throws Exception 
     */
    public LeaveType getLeaveTypeById(int leaveTypeId) throws Exception {
        String sql = "SELECT LeaveTypeID, Name, Description FROM LeaveTypes WHERE LeaveTypeID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, leaveTypeId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    LeaveType leaveType = new LeaveType();
                    leaveType.setLeaveTypeId(rs.getInt("LeaveTypeID"));
                    leaveType.setName(rs.getString("Name"));
                    leaveType.setDescription(rs.getString("Description"));
                    return leaveType;
                }
            }
        }
        return null;
    }
}
