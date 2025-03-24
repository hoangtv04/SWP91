package controller;

import dal.VoucherDAO;
import model.Voucher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;

@WebServlet("/applyVoucher")
public class ApplyVoucherServlet extends HttpServlet {
    private VoucherDAO voucherDAO = new VoucherDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String voucherCode = request.getParameter("voucherCode");
        BigDecimal totalPrice = new BigDecimal(request.getParameter("totalPrice"));

        try {
            Voucher voucher = voucherDAO.getVoucherByCode(voucherCode);
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            if (voucher != null && voucher.getExpiryDate().after(new java.util.Date())) {
                BigDecimal discountAmount = voucher.getDiscountAmount();
                BigDecimal finalPrice = totalPrice.subtract(discountAmount);

                out.print("{\"success\": true, \"discountAmount\": " + discountAmount + ", \"finalPrice\": " + finalPrice + "}");
            } else {
                out.print("{\"success\": false}");
            }
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the voucher.");
        }
    }
}