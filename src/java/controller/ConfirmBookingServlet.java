/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.SeatDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Seat;


@WebServlet(name="ConfirmBookingServlet", urlPatterns={"/confirmBooking"})
public class ConfirmBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String movieName = request.getParameter("movieName");
            String cinemaName = request.getParameter("cinemaName");
            String screenName = request.getParameter("screenName");
            String[] seatIds = request.getParameterValues("seatIds");

            SeatDAO seatDAO = new SeatDAO();
            List<Seat> selectedSeats = new ArrayList<>();
            if (seatIds != null) {
                selectedSeats = seatDAO.getSeatsByIds(seatIds);
            }

            request.setAttribute("movieName", movieName);
            request.setAttribute("cinemaName", cinemaName);
            request.setAttribute("screenName", screenName);
            request.setAttribute("selectedSeats", selectedSeats);

            request.getRequestDispatcher("/confirmBooking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
        }
    }
}
