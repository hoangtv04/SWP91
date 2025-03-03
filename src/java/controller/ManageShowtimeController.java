package controller;

import dal.ShowtimeDAO;
import model.Showtime;
import java.io.IOException;
import dal.MovieDAO;
import model.Movie;
import dal.ScreenDAO;
import model.Screen;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "ManageShowtimeController", urlPatterns = {"/Showtime"})
public class ManageShowtimeController extends HttpServlet {

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    ShowtimeDAO showtimeDAO = new ShowtimeDAO();
    List<Showtime> showtimes = showtimeDAO.getAllShowtimes();

    MovieDAO movieDAO = new MovieDAO();
    List<Movie> movies = movieDAO.getAllMovies();

    ScreenDAO screenDAO = new ScreenDAO();
    List<Screen> screens = screenDAO.getAllScreens();

    // Kiểm tra dữ liệu có null không
    System.out.println("Movies size: " + (movies == null ? "NULL" : movies.size()));
    System.out.println("Screens size: " + (screens == null ? "NULL" : screens.size()));

    request.setAttribute("showtimes", showtimes);
    request.setAttribute("movies", movies);
    request.setAttribute("screens", screens);

    request.getRequestDispatcher("showtime.jsp").forward(request, response);
}


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ShowtimeDAO showtimeDAO = new ShowtimeDAO();

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            int screenID = Integer.parseInt(request.getParameter("screenID"));

            String startTimeStr = request.getParameter("startTime").replace("T", " ") + ":00";
            String endTimeStr = request.getParameter("endTime").replace("T", " ") + ":00";

            Timestamp startTime = Timestamp.valueOf(startTimeStr);
            Timestamp endTime = Timestamp.valueOf(endTimeStr);
            int adminID = Integer.parseInt(request.getParameter("adminID"));

            Showtime showtime = new Showtime(0, movieID, screenID, startTime, endTime, adminID);
            showtimeDAO.addShowtime(showtime);
        } else if ("delete".equals(action)) {
            int showtimeID = Integer.parseInt(request.getParameter("showtimeID"));
            showtimeDAO.deleteShowtime(showtimeID);
        }

        response.sendRedirect(request.getContextPath() + "/Showtime");
    }

    @Override
    public String getServletInfo() {
        return "Manage Showtime Controller";
    }
}
