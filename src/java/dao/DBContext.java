package dao; // Thay đổi package cho phù hợp với cấu trúc dự án của bạn

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=LeaveManagement";
    private static final String USER = "sa"; 
    private static final String PASS = "sa"; 

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            // Đăng ký Driver JDBC
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Mở kết nối
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Kết nối cơ sở dữ liệu thành công!");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Không tìm thấy Driver JDBC SQL Server: " + ex.getMessage());
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            System.err.println("Lỗi kết nối cơ sở dữ liệu: " + ex.getMessage());
        }
        return conn;
    }
}

