package d;

import model.Guardian;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GuardianDAO {
    private Connection conn;

    public GuardianDAO(Connection conn) {
        this.conn = conn;
    }

    public List<Guardian> getAll() throws SQLException {
    List<Guardian> list = new ArrayList<>();
    String sql = "SELECT * FROM guardians";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
    while (rs.next()) {
        Guardian g = new Guardian(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("rarity"),
            rs.getString("description"),
            rs.getInt("price")
        );
        list.add(g);
    }
    return list;
}

public Guardian getById(int id) throws SQLException {
    String sql = "SELECT * FROM guardians WHERE id = ?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        return new Guardian(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("rarity"),
            rs.getString("description"),
            rs.getInt("price")
        );
    }
    return null;
}

}
