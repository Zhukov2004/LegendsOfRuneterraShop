package d;

import model.Icon;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class IconDAO {
    private Connection conn;

    public IconDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Icon> getAll() throws SQLException {
        List<Icon> list = new ArrayList<>();
        String sql = "SELECT * FROM summoner_icons";
        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Icon icon = new Icon(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("image"),
                rs.getString("rarity"),
                rs.getInt("price")
            );
            list.add(icon);
        }

        return list;
    }
}
