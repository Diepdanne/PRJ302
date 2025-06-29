package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
        String sql = "SELECT UserID, UserName, Role FROM Users WHERE Email = ? AND Password = ?";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt("UserID"), rs.getString("UserName"), email, rs.getString("Role"));
                }
            }
        }
        return null; // Login failed
    }
}