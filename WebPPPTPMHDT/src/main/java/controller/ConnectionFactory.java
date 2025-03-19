package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionFactory {
   
    public static Connection getConnection() throws ClassNotFoundException {
        Connection con = null;
        try {
            // Đăng ký driver MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Tạo kết nối với cơ sở dữ liệu MySQL
            con = DriverManager.getConnection("jdbc:mysql://localhost/quanlydangky", "root", "");
        } catch (SQLException e) {
            // Ném ngoại lệ RuntimeException nếu có lỗi SQL
            throw new RuntimeException("Lỗi kết nối cơ sở dữ liệu: " + e.getMessage(), e);
        }
        return con;
    }
    
    public static void main(String[] args) {
        try {
            Connection conn = getConnection();
            System.out.println("Kết nối thành công");
            conn.close(); // Đóng kết nối sau khi kiểm tra
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Lỗi");
        }
    }
}