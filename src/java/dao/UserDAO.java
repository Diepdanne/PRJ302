package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO {

    /**
     * Checks user credentials against the database.
     */
    public User checkLogin(String email, String password) throws Exception {
        String sql = "SELECT u.UserID, u.UserName, u.Email, u.Role, u.Division, u.ManagerID, m.UserName as ManagerName " +
                    "FROM Users u " +
                    "LEFT JOIN Users m ON u.ManagerID = m.UserID " +
                    "WHERE u.Email = ? AND u.Password = ?";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUserName(rs.getString("UserName"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getString("Role"));
                    user.setDivision(rs.getString("Division"));
                    user.setManagerId(rs.getInt("ManagerID"));
                    user.setManagerName(rs.getString("ManagerName"));
                    return user;
                }
            }
        }
        return null;
    }
    
    /**
     * Lấy thông tin user theo ID với đầy đủ thông tin
     */
    public User getUserById(int userId) throws Exception {
        String sql = "SELECT u.*, m.UserName as ManagerName " +
                    "FROM Users u " +
                    "LEFT JOIN Users m ON u.ManagerID = m.UserID " +
                    "WHERE u.UserID = ?";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        }
        return null;
    }
    
    /**
     * Lấy tất cả nhân viên với search và filter
     */
    public List<User> getAllUsers(String searchTerm, String roleFilter, String divisionFilter) throws Exception {
        List<User> users = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT u.*, m.UserName as ManagerName " +
            "FROM Users u " +
            "LEFT JOIN Users m ON u.ManagerID = m.UserID " +
            "WHERE 1=1 "
        );
        
        List<Object> params = new ArrayList<>();
        
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            sql.append("AND (u.UserName LIKE ? OR u.Email LIKE ? OR u.PhoneNumber LIKE ?) ");
            String searchPattern = "%" + searchTerm.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }
        
        if (roleFilter != null && !roleFilter.trim().isEmpty() && !"all".equals(roleFilter)) {
            sql.append("AND u.Role = ? ");
            params.add(roleFilter);
        }
        
        if (divisionFilter != null && !divisionFilter.trim().isEmpty() && !"all".equals(divisionFilter)) {
            sql.append("AND u.Division = ? ");
            params.add(divisionFilter);
        }
        
        sql.append("ORDER BY u.UserName");
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapResultSetToUser(rs));
                }
            }
        }
        return users;
    }
    
    /**
     * Thêm nhân viên mới
     */
    public boolean addUser(User user) throws Exception {
        String sql = "INSERT INTO Users (UserName, Password, Email, Role, Division, DateOfBirth, " +
                    "Gender, PhoneNumber, Address, HireDate, JobTitle, ManagerID) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getDivision());
            ps.setDate(6, user.getDateOfBirth());
            ps.setString(7, user.getGender());
            ps.setString(8, user.getPhoneNumber());
            ps.setString(9, user.getAddress());
            ps.setDate(10, user.getHireDate());
            ps.setString(11, user.getDepartment());
            ps.setInt(12, user.getManagerId() == 0 ? null : user.getManagerId());
            
            int result = ps.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * Cập nhật thông tin nhân viên
     */
    public boolean updateUser(User user) throws Exception {
        String sql = "UPDATE Users SET UserName = ?, Email = ?, Role = ?, Division = ?, " +
                    "DateOfBirth = ?, Gender = ?, PhoneNumber = ?, Address = ?, " +
                    "HireDate = ?, JobTitle = ?, ManagerID = ? WHERE UserID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRole());
            ps.setString(4, user.getDivision());
            ps.setDate(5, user.getDateOfBirth());
            ps.setString(6, user.getGender());
            ps.setString(7, user.getPhoneNumber());
            ps.setString(8, user.getAddress());
            ps.setDate(9, user.getHireDate());
            ps.setString(10, user.getDepartment());
            ps.setInt(11, user.getManagerId() == 0 ? null : user.getManagerId());
            ps.setInt(12, user.getUserId());
            
            int result = ps.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * Xóa nhân viên
     */
    public boolean deleteUser(int userId) throws Exception {
        String sql = "DELETE FROM Users WHERE UserID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            int result = ps.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * Đổi mật khẩu
     */
    public boolean changePassword(int userId, String newPassword) throws Exception {
        String sql = "UPDATE Users SET Password = ? WHERE UserID = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            
            int result = ps.executeUpdate();
            return result > 0;
        }
    }
    
    /**
     * Kiểm tra email đã tồn tại
     */
    public boolean isEmailExists(String email, int excludeUserId) throws Exception {
        String sql = "SELECT COUNT(*) FROM Users WHERE Email = ? AND UserID != ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setInt(2, excludeUserId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }
    
    /**
     * Lấy danh sách manager để chọn
     */
    public List<User> getManagers() throws Exception {
        List<User> managers = new ArrayList<>();
        String sql = "SELECT UserID, UserName, Division FROM Users WHERE Role IN ('Manager', 'Admin') ORDER BY UserName";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                User manager = new User();
                manager.setUserId(rs.getInt("UserID"));
                manager.setUserName(rs.getString("UserName"));
                manager.setDivision(rs.getString("Division"));
                managers.add(manager);
            }
        }
        return managers;
    }
    
    /**
     * Lấy danh sách division duy nhất
     */
    public List<String> getAllDivisions() throws Exception {
        List<String> divisions = new ArrayList<>();
        String sql = "SELECT DISTINCT Division FROM Users WHERE Division IS NOT NULL ORDER BY Division";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                divisions.add(rs.getString("Division"));
            }
        }
        return divisions;
    }
    
    /**
     * Helper method để map ResultSet thành User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setUserName(rs.getString("UserName"));
        user.setPassword(rs.getString("Password"));
        user.setEmail(rs.getString("Email"));
        user.setRole(rs.getString("Role"));
        user.setDivision(rs.getString("Division"));
        user.setDateOfBirth(rs.getDate("DateOfBirth"));
        user.setGender(rs.getString("Gender"));
        user.setPhoneNumber(rs.getString("PhoneNumber"));
        user.setAddress(rs.getString("Address"));
        user.setHireDate(rs.getDate("HireDate"));
        user.setDepartment(rs.getString("JobTitle")); // Mapping JobTitle to Department
        user.setManagerId(rs.getInt("ManagerID"));
        user.setManagerName(rs.getString("ManagerName"));
        return user;
    }
}
