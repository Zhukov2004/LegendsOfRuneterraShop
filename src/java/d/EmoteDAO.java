package d;

import model.Emote;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmoteDAO {
    private Connection conn;

    public EmoteDAO(Connection conn) {
        this.conn = conn;
    }

    // Lấy tất cả emotes từ bảng
    public List<Emote> getAll() {
        List<Emote> emotes = new ArrayList<>();
        String sql = "SELECT id, name, icon, rarity, description, price FROM emotes";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Emote e = new Emote();
                e.setId(rs.getInt("id"));
                e.setName(rs.getString("name"));
                e.setIcon(rs.getString("icon"));
                e.setRarity(rs.getString("rarity"));
                e.setDescription(rs.getString("description"));
                e.setPrice(rs.getInt("price"));
                emotes.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return emotes;
    }
}
