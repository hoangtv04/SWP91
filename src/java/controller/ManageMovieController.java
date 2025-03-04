package controller;

import dal.MovieDAO;
import model.Movie;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageMovieController", urlPatterns = {"/Movie"})
public class ManageMovieController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MovieDAO movieDAO = new MovieDAO();
        List<Movie> movies = movieDAO.getAllMovies();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("manageMovies.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MovieDAO movieDAO = new MovieDAO();

        String action = request.getParameter("action");
        if ("add".equals(action)) {
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            int duration = Integer.parseInt(request.getParameter("duration"));
            java.sql.Date releaseDate = java.sql.Date.valueOf(request.getParameter("releaseDate"));
            String description = request.getParameter("description");
            
            Movie movie = new Movie(0, title, genre, duration, releaseDate, description);
            movieDAO.addMovie(movie);
        } else if ("update".equals(action)) {
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            String title = request.getParameter("title");
            String genre = request.getParameter("genre");
            int duration = Integer.parseInt(request.getParameter("duration"));
            java.sql.Date releaseDate = java.sql.Date.valueOf(request.getParameter("releaseDate"));
            String description = request.getParameter("description");
            
            Movie movie = new Movie(movieID, title, genre, duration, releaseDate, description);
            movieDAO.updateMovie(movie);
        } else if ("delete".equals(action)) {
            int movieID = Integer.parseInt(request.getParameter("movieID"));
            movieDAO.deleteMovie(movieID);
        }

        response.sendRedirect(request.getContextPath() + "/Movie");
    }

    @Override
    public String getServletInfo() {
        return "Manage Movie Controller";
    }
}
