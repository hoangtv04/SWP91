/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.VoucherDAO;
import model.Voucher;
import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author tovie
 */
@WebServlet(name="ApplyVoucherController", urlPatterns={"/applyvoucher"})
public class ApplyVoucherController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String voucherCode = request.getParameter("voucherCode");
        VoucherDAO voucherDAO = new VoucherDAO();
        
        try {
            Voucher voucher = voucherDAO.getVoucherByCode(voucherCode);
            if (voucher != null) {
                // Apply the voucher (e.g., update the total price)
                BigDecimal discountAmount = voucher.getDiscountAmount();
                double totalPrice = (double) request.getAttribute("totalPrice");
                totalPrice -= discountAmount.doubleValue();
                request.setAttribute("totalPrice", totalPrice);
                request.setAttribute("voucherApplied", true);
                request.setAttribute("voucherCode", voucherCode);
            } else {
                request.setAttribute("voucherApplied", false);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("voucherApplied", false);
        }
        
        request.getRequestDispatcher("confirmBooking.jsp").forward(request, response);
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
