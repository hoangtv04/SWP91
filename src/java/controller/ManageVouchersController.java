package controller;

import dal.VoucherDAO;
import model.Voucher;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "VoucherController", urlPatterns = {"/voucher"})
public class ManageVouchersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            VoucherDAO dao = new VoucherDAO();
            List<Voucher> vouchers = dao.getAllVouchers();
            request.setAttribute("vouchers", vouchers);
            request.getRequestDispatcher("manageVouchers.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ManageVouchersController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        VoucherDAO dao = new VoucherDAO();

        try {
            if ("add".equals(action)) {
                String code = request.getParameter("code");
                BigDecimal discount = new BigDecimal(request.getParameter("discount"));
                Date expiry = Date.valueOf(request.getParameter("expiry"));
                Integer adminID = request.getParameter("admin").isEmpty() ? null : Integer.parseInt(request.getParameter("admin"));
                
                if (dao.isCodeExists(code)) {
                    request.setAttribute("error", "Mã voucher đã tồn tại.");
                } else {
                    dao.addVoucher(new Voucher(0, code, discount, expiry, adminID));
                    response.sendRedirect("voucher");
                    return;
                }
            } else if ("update".equals(action)) {
                int voucherID = Integer.parseInt(request.getParameter("voucherID"));
                String code = request.getParameter("code");
                BigDecimal discount = new BigDecimal(request.getParameter("discount"));
                Date expiry = Date.valueOf(request.getParameter("expiry"));
                Integer adminID = request.getParameter("admin").isEmpty() ? null : Integer.parseInt(request.getParameter("admin"));
                
                dao.updateVoucher(new Voucher(voucherID, code, discount, expiry, adminID));
                response.sendRedirect("voucher");
                return;
            } else if ("delete".equals(action)) {
                int voucherID = Integer.parseInt(request.getParameter("voucherID"));
                dao.deleteVoucher(voucherID);
                response.sendRedirect("voucher");
                return;
            }
        } catch (Exception ex) {
            Logger.getLogger(ManageVouchersController.class.getName()).log(Level.SEVERE, null, ex);
        }

        doGet(request, response);
    }
}