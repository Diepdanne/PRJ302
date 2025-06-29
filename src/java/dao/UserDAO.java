package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO {

    /**
     * Checks user credentials against the database.
     *
     * @param email The user's email.
     * @param password The user's plain text password.
     * @return A User object if login is successful, null otherwise.
     * @throws Exception
     *
     * SECURITY NOTE: Storing and comparing plain text passwords is a major
     * security risk. In a real-world application, you should use a strong
     * hashing algorithm like BCrypt to hash passwords before storing them.
     * The check would then involve hashing the input password and comparing it
     * with the stored hash.
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
        return null; // Login failed
    }
    
    /**
     * Lấy thông tin user theo ID
     */
    public User getUserById(int userId) throws Exception {
        String sql = "SELECT u.UserID, u.UserName, u.Email, u.Role, u.Division, u.ManagerID, m.UserName as ManagerName " +
                    "FROM Users u " +
                    "LEFT JOIN Users m ON u.ManagerID = m.UserID " +
                    "WHERE u.UserID = ?";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

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
     * Lấy danh sách nhân viên theo manager
     */
    public List<User> getEmployeesByManager(int managerId) throws Exception {
        List<User> employees = new ArrayList<>();
        String sql = "SELECT UserID, UserName, Email, Role, Division, ManagerID " +
                    "FROM Users WHERE ManagerID = ? ORDER BY UserName";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, managerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("UserID"));
                    user.setUserName(rs.getString("UserName"));
                    user.setEmail(rs.getString("Email"));
                    user.setRole(rs.getString("Role"));
                    user.setDivision(rs.getString("Division"));
                    user.setManagerId(rs.getInt("ManagerID"));
                    employees.add(user);
                }
            }
        }
        return employees;
    }
}