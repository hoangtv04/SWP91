/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author tovie
 */
public class DBContext {
    private final String serverName = "localhost\\SQLEXPRESS";
    private final String dbName = "MovieTicketBooking";
    private final String portNumber = "1433";
    private final String instance = ""; 
    private final String userID = "hoangtv";
    private final String password = "vh692004";
    public Connection getConnection() throws Exception {
        String url;
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://NTQ-COMPUTER\\QUY:1433;databaseName=MovieTicketBooking;TrustServerCertificate=true;";
        } else {
            url = "jdbc:sqlserver://NTQ-COMPUTER\\QUY:1433;databaseName=MovieTicketBooking;TrustServerCertificate=true;";
        }

        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    public static void main(String[] args) {
        try {
            Connection conn = new DBContext().getConnection();
            if (conn != null) {
                System.out.println("Kết nối SQL thành công!");
            } else {
                System.out.println("Kết nối SQL thất bại!");
            }
        } catch (Exception e) {
            System.out.println("Lỗi kết nối SQL: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
