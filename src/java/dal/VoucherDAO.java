package dal;

import model.Voucher;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VoucherDAO extends DBContext {
    
    public List<Voucher> getAllVouchers() throws Exception {
        List<Voucher> vouchers = new ArrayList<>();
        String query = "SELECT * FROM Voucher";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                vouchers.add(new Voucher(
                    rs.getInt("VoucherID"),
                    rs.getString("Code"),
                    rs.getBigDecimal("DiscountAmount"),
                    rs.getDate("ExpiryDate"),
                    rs.getInt("AdminID")
                ));
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(VoucherDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vouchers;
    }
    
    public boolean addVoucher(Voucher voucher) throws Exception {
        String query = "INSERT INTO Voucher (Code, DiscountAmount, ExpiryDate, AdminID) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, voucher.getCode());
            stmt.setBigDecimal(2, voucher.getDiscountAmount());
            stmt.setDate(3, new java.sql.Date(voucher.getExpiryDate().getTime()));
            stmt.setObject(4, voucher.getAdminID(), Types.INTEGER);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean updateVoucher(Voucher voucher) throws Exception {
        String query = "UPDATE Voucher SET Code = ?, DiscountAmount = ?, ExpiryDate = ?, AdminID = ? WHERE VoucherID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, voucher.getCode());
            stmt.setBigDecimal(2, voucher.getDiscountAmount());
            stmt.setDate(3, new java.sql.Date(voucher.getExpiryDate().getTime()));
            stmt.setObject(4, voucher.getAdminID(), Types.INTEGER);
            stmt.setInt(5, voucher.getVoucherID());
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean deleteVoucher(int voucherID) throws Exception {
        String query = "DELETE FROM Voucher WHERE VoucherID = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, voucherID);
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean isCodeExists(String code) throws Exception {
        String query = "SELECT COUNT(*) FROM Voucher WHERE Code = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        }
    }

    public Voucher getVoucherByCode(String code) throws Exception {
        String query = "SELECT * FROM Voucher WHERE Code = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, code);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Voucher(
                    rs.getInt("VoucherID"),
                    rs.getString("Code"),
                    rs.getBigDecimal("DiscountAmount"),
                    rs.getDate("ExpiryDate"),
                    rs.getInt("AdminID")
                );
            }
        }
        return null;
    }
}
