package dal;

import model.Seat;
import model.Screen;
import model.Cinema;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SeatDAO extends DBContext {

    public List<Seat> getSeatsByMovieCinemaScreen(int movieId, int cinemaId, int screenId) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT DISTINCT s.SeatID, s.SeatNumber, s.SeatType, s.Price, " +
                     "sc.ScreenID, sc.ScreenName, " +
                     "c.CinemaID, c.CinemaName " +
                     "FROM Seat s " +
                     "JOIN Screen sc ON s.ScreenID = sc.ScreenID " +
                     "JOIN Cinema c ON sc.CinemaID = c.CinemaID " +
                     "JOIN Showtime sh ON sc.ScreenID = sh.ScreenID " +
                     "WHERE c.CinemaID = ? AND sc.ScreenID = ? AND sh.MovieID = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cinemaId);
            ps.setInt(2, screenId);
            ps.setInt(3, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Seat seat = new Seat();
                    seat.setSeatID(rs.getInt("SeatID"));
                    seat.setSeatNumber(rs.getString("SeatNumber"));
                    seat.setSeatType(rs.getString("SeatType"));
                    seat.setPrice(rs.getDouble("Price"));

                    Screen screen = new Screen();
                    screen.setScreenID(rs.getInt("ScreenID"));
                    screen.setScreenName(rs.getString("ScreenName"));

                    Cinema cinema = new Cinema();
                    cinema.setCinemaID(rs.getInt("CinemaID"));
                    cinema.setCinemaName(rs.getString("CinemaName"));

                    seat.setScreen(screen);

                    seats.add(seat);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return seats;
    }

    public List<Seat> getSeatsByIds(String[] seatIds) {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT * FROM Seat WHERE seatID IN (";
        for (int i = 0; i < seatIds.length; i++) {
            sql += "?";
            if (i < seatIds.length - 1) {
                sql += ",";
            }
        }
        sql += ")";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < seatIds.length; i++) {
                ps.setString(i + 1, seatIds[i]);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat();
                seat.setSeatID(rs.getInt("seatID"));
                seat.setSeatNumber(rs.getString("seatNumber"));
                seat.setSeatType(rs.getString("seatType"));
                seat.setPrice(rs.getDouble("price"));
                seats.add(seat);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return seats;
    }
}