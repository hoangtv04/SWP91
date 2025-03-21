package dal;

import java.sql.Connection;
import java.sql.DriverManager;

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
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true";
        } else {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true";
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