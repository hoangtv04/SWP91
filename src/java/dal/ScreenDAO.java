package dal;

import model.Screen;
import model.Cinema;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ScreenDAO {
    private Connection conn;
    
    public ScreenDAO() {
        try {
            conn = new DBContext().getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Screen> getAllScreens() {
        List<Screen> screens = new ArrayList<>();
        String sql = "SELECT screenID, cinemaID, screenName, totalSeat FROM Screen";
        
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Screen screen = new Screen();
                screen.setScreenID(rs.getInt("screenID"));
                
                Cinema cinema = new Cinema();
                cinema.setCinemaID(rs.getInt("cinemaID")); // Giả định có phương thức này
                screen.setCinemaID(cinema);
                
                screen.setScreenName(rs.getString("screenName"));
                screen.setTotalSeat(rs.getInt("totalSeat"));
                
                screens.add(screen);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return screens;
    }
}