package model;

import java.math.BigDecimal;
import java.sql.Date;

public class Voucher {
    private int voucherID;
    private String code;
    private BigDecimal discountAmount;
    private Date expiryDate;
    private Integer adminID;

    public Voucher() {}

    public Voucher(int voucherID, String code, BigDecimal discountAmount, Date expiryDate, Integer adminID) {
        this.voucherID = voucherID;
        this.code = code;
        this.discountAmount = discountAmount;
        this.expiryDate = expiryDate;
        this.adminID = adminID;
    }

    public int getVoucherID() {
        return voucherID;
    }

    public void setVoucherID(int voucherID) {
        this.voucherID = voucherID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Integer getAdminID() {
        return adminID;
    }

    public void setAdminID(Integer adminID) {
        this.adminID = adminID;
    }
}