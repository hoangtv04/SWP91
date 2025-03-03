package controller;

import dal.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.UUID;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SendResetLinkServlet", urlPatterns = {"/sendResetLink"})
public class SendResetLinkServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            String sql = "SELECT * FROM Customer WHERE Email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Redirect to reset password form with email
                response.sendRedirect("resetPassword.jsp?email=" + email);
            } else {
                request.setAttribute("message", "Email not found.");
                request.setAttribute("messageType", "error-message");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "An error occurred. Please try again.");
            request.setAttribute("messageType", "error-message");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}