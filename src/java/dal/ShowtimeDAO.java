package dal;

import model.Showtime;
import model.Cinema;
import model.Screen;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Admin;
import model.Movie;

public class ShowtimeDAO extends DBContext {

    public List<Showtime> getShowtimesByMovieId(int movieID) {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT s.*, sc.*, c.*, a.* FROM Showtime s "
                + "JOIN Screen sc ON s.ScreenID = sc.ScreenID "
                + "JOIN Cinema c ON sc.CinemaID = c.CinemaID "
                + "JOIN Admin a ON s.AdminID = a.AdminID "
                + "WHERE s.MovieID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Showtime showtime = new Showtime();
                    showtime.setShowtimeID(rs.getInt("ShowtimeID"));
                    showtime.setStartTime(rs.getTimestamp("StartTime"));
                    showtime.setEndTime(rs.getTimestamp("EndTime"));

                    Screen screen = new Screen();
                    screen.setScreenID(rs.getInt("ScreenID"));
                    screen.setScreenName(rs.getString("ScreenName"));
                    screen.setTotalSeat(rs.getInt("TotalSeat"));

                    Cinema cinema = new Cinema();
                    cinema.setCinemaID(rs.getInt("CinemaID"));
                    cinema.setCinemaName(rs.getString("CinemaName"));
                    cinema.setLocation(rs.getString("Location"));
                    cinema.setNumberOfScreen(rs.getInt("NumberOfScreen"));

                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("AdminID"));
                    admin.setName(rs.getString("Name"));
                    admin.setEmail(rs.getString("Email"));
                    admin.setPassword(rs.getString("Password"));

                    screen.setCinemaID(cinema);
                    showtime.setScreenID(screen);
                    showtime.setAdminID(admin);

                    showtimes.add(showtime);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    public List<Screen> getScreensByCinemaAndMovie(int cinemaId, int movieId) {
        List<Screen> screens = new ArrayList<>();
        String sql = "SELECT DISTINCT sc.ScreenID, sc.ScreenName, sc.TotalSeat "
                + "FROM Screen sc "
                + "JOIN Showtime s ON sc.ScreenID = s.ScreenID "
                + "WHERE sc.CinemaID = ? AND s.MovieID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cinemaId);
            ps.setInt(2, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Screen screen = new Screen();
                    screen.setScreenID(rs.getInt("ScreenID"));
                    screen.setScreenName(rs.getString("ScreenName"));
                    screen.setTotalSeat(rs.getInt("TotalSeat"));
                    screens.add(screen);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return screens;
    }

    public List<Showtime> getAllShowtimes() {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT s.ShowtimeID, m.MovieID, m.Title AS MovieTitle, sc.ScreenID, sc.ScreenName, s.StartTime, s.EndTime, a.AdminID "
                + "FROM Showtime s "
                + "JOIN Movie m ON s.MovieID = m.MovieID "
                + "JOIN Screen sc ON s.ScreenID = sc.ScreenID "
                + "JOIN Admin a ON s.AdminID = a.AdminID";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Showtime showtime = new Showtime();
                showtime.setShowtimeID(rs.getInt("ShowtimeID"));
                showtime.setStartTime(rs.getTimestamp("StartTime"));
                showtime.setEndTime(rs.getTimestamp("EndTime"));

                // Gán thông tin Movie
                Movie movie = new Movie();
                movie.setMovieID(rs.getInt("MovieID"));
                movie.setTitle(rs.getString("MovieTitle"));
                showtime.setMovieID(movie);

                // Gán thông tin Screen
                Screen screen = new Screen();
                screen.setScreenID(rs.getInt("ScreenID"));
                screen.setScreenName(rs.getString("ScreenName"));
                showtime.setScreenID(screen);

                // Gán thông tin Admin
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt("AdminID"));
                showtime.setAdminID(admin);

                showtimes.add(showtime);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return showtimes;
    }

    public List<Showtime> getShowtimesByCinemaScreenAndMovie(int cinemaId, int screenId, int movieId) {
        List<Showtime> showtimes = new ArrayList<>();
        String sql = "SELECT s.* FROM Showtime s "
                + "JOIN Screen sc ON s.ScreenID = sc.ScreenID "
                + "WHERE sc.CinemaID = ? AND sc.ScreenID = ? AND s.MovieID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cinemaId);
            ps.setInt(2, screenId);
            ps.setInt(3, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Showtime showtime = new Showtime();
                    showtime.setShowtimeID(rs.getInt("ShowtimeID"));
                    showtime.setStartTime(rs.getTimestamp("StartTime"));
                    showtime.setEndTime(rs.getTimestamp("EndTime"));
                    showtimes.add(showtime);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    public List<Cinema> getAllCinemas() {
        List<Cinema> cinemas = new ArrayList<>();
        String sql = "SELECT * FROM Cinema";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cinema cinema = new Cinema();
                cinema.setCinemaID(rs.getInt("CinemaID"));
                cinema.setCinemaName(rs.getString("CinemaName"));
                cinema.setLocation(rs.getString("Location"));
                cinema.setNumberOfScreen(rs.getInt("NumberOfScreen"));
                cinemas.add(cinema);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cinemas;
    }

    public List<Screen> getAllScreens() {
        List<Screen> screens = new ArrayList<>();
        String sql = "SELECT * FROM Screen";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Screen screen = new Screen();
                screen.setScreenID(rs.getInt("ScreenID"));
                screen.setScreenName(rs.getString("ScreenName"));
                screen.setTotalSeat(rs.getInt("TotalSeat"));
                screens.add(screen);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return screens;
    }

    public Showtime getShowtimeById(int showtimeId) {
        Showtime showtime = null;
        String sql = "SELECT s.*, sc.*, c.*, a.*, m.* FROM Showtime s "
                + "JOIN Screen sc ON s.ScreenID = sc.ScreenID "
                + "JOIN Cinema c ON sc.CinemaID = c.CinemaID "
                + "JOIN Admin a ON s.AdminID = a.AdminID "
                + "JOIN Movie m ON s.MovieID = m.MovieID "
                + "WHERE s.ShowtimeID = ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showtimeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    showtime = new Showtime();
                    showtime.setShowtimeID(rs.getInt("ShowtimeID"));
                    showtime.setStartTime(rs.getTimestamp("StartTime"));
                    showtime.setEndTime(rs.getTimestamp("EndTime"));

                    Screen screen = new Screen();
                    screen.setScreenID(rs.getInt("ScreenID"));
                    screen.setScreenName(rs.getString("ScreenName"));
                    screen.setTotalSeat(rs.getInt("TotalSeat"));

                    Cinema cinema = new Cinema();
                    cinema.setCinemaID(rs.getInt("CinemaID"));
                    cinema.setCinemaName(rs.getString("CinemaName"));
                    cinema.setLocation(rs.getString("Location"));
                    cinema.setNumberOfScreen(rs.getInt("NumberOfScreen"));

                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt("AdminID"));
                    admin.setName(rs.getString("Name"));
                    admin.setEmail(rs.getString("Email"));
                    admin.setPassword(rs.getString("Password"));

                    Movie movie = new Movie();
                    movie.setMovieID(rs.getInt("MovieID"));
                    movie.setTitle(rs.getString("Title"));
                    movie.setGenre(rs.getString("Genre"));
                    movie.setDuration(rs.getInt("Duration"));
                    movie.setReleaseDate(rs.getDate("ReleaseDate"));
                    movie.setDescription(rs.getString("Description"));

                    screen.setCinemaID(cinema);
                    showtime.setScreenID(screen);
                    showtime.setAdminID(admin);
                    showtime.setMovieID(movie);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return showtime;
    }

    public void addShowtime(Showtime showtime) {
        String sql = "INSERT INTO Showtime (MovieID, ScreenID, StartTime, EndTime, AdminID) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showtime.getMovieID().getMovieID());
            ps.setInt(2, showtime.getScreenID().getScreenID());
            ps.setTimestamp(3, new Timestamp(showtime.getStartTime().getTime()));
            ps.setTimestamp(4, new Timestamp(showtime.getEndTime().getTime()));
            ps.setInt(5, showtime.getAdminID().getAdminId());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean deleteShowtime(int showtimeID) {
        String sql = "DELETE FROM Showtime WHERE showtimeID = ?";

        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showtimeID);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
