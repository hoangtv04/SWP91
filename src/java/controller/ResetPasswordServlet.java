package controller;

import dal.DBContext;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/resetPassword"})
public class ResetPasswordServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");

        try {
            DBContext dbContext = new DBContext();
            Connection conn = dbContext.getConnection();
            String sql = "SELECT * FROM Customer WHERE Email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                sql = "UPDATE Customer SET Password = ? WHERE Email = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, newPassword);
                stmt.setString(2, email);
                stmt.executeUpdate();

                request.setAttribute("message", "Password reset successful! Please log in.");
                request.setAttribute("messageType", "success-message");
            } else {
                request.setAttribute("message", "Invalid email.");
                request.setAttribute("messageType", "error-message");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("messageType", "error-message");
        }

        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
