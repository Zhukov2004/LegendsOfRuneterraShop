package d;

import model.Relic;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RelicDAO {

    // Lấy toàn bộ relics
    public static List<Relic> getAllRelics() {
        List<Relic> relics = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            String sql = "SELECT * FROM relics";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Relic relic = new Relic();
                relic.setRelicCode(rs.getString("relicCode"));
                relic.setName(rs.getString("name"));
                relic.setRarity(rs.getString("rarity"));
                relic.setDescriptionRaw(rs.getString("descriptionRaw"));
                relic.setPrice(rs.getInt("price"));
                relics.add(relic);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return relics;
    }

    // Tìm relic theo mã
    public static Relic getRelicByCode(String relicCode) {
        Relic relic = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            String sql = "SELECT * FROM relics WHERE relicCode = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, relicCode);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                relic = new Relic();
                relic.setRelicCode(rs.getString("relicCode"));
                relic.setName(rs.getString("name"));
                relic.setRarity(rs.getString("rarity"));
                relic.setDescriptionRaw(rs.getString("descriptionRaw"));
                relic.setPrice(rs.getInt("price"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return relic;
    }

    // Thêm relic mới
    public static boolean insertRelic(Relic relic) {
        boolean success = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            String sql = "INSERT INTO relics (relicCode, name, rarity, descriptionRaw, price) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, relic.getRelicCode());
            stmt.setString(2, relic.getName());
            stmt.setString(3, relic.getRarity());
            stmt.setString(4, relic.getDescriptionRaw());
            stmt.setInt(5, relic.getPrice());

            success = stmt.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Sửa relic
    public static boolean updateRelic(Relic relic) {
        boolean success = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            String sql = "UPDATE relics SET name = ?, rarity = ?, descriptionRaw = ?, price = ? WHERE relicCode = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, relic.getName());
            stmt.setString(2, relic.getRarity());
            stmt.setString(3, relic.getDescriptionRaw());
            stmt.setInt(4, relic.getPrice());
            stmt.setString(5, relic.getRelicCode());

            success = stmt.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    // Xóa relic
    public static boolean deleteRelic(String relicCode) {
        boolean success = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            String sql = "DELETE FROM relics WHERE relicCode = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, relicCode);

            success = stmt.executeUpdate() > 0;
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    public static List<Relic> getRandomRelics(int limit) {
    List<Relic> relics = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

        String sql = "SELECT * FROM relics ORDER BY RAND() LIMIT ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, limit);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Relic relic = new Relic();
            relic.setRelicCode(rs.getString("relicCode"));
            relic.setName(rs.getString("name"));
            relic.setRarity(rs.getString("rarity"));
            relic.setDescriptionRaw(rs.getString("descriptionRaw"));
            relic.setPrice(rs.getInt("price"));
            relics.add(relic);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return relics;
}
    // Lấy danh sách relics và đánh dấu đã mua cho user
public static List<Relic> getAllRelicsForUser(String username) {
    List<Relic> relics = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
             PreparedStatement stmt = conn.prepareStatement(
    "SELECT r.*, EXISTS(SELECT 1 FROM relic_purchase_history ph WHERE ph.username=? AND ph.relicCode=r.relicCode) AS purchased " +
    "FROM relics r"
);
) {

            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Relic relic = new Relic();
                    relic.setRelicCode(rs.getString("relicCode"));
                    relic.setName(rs.getString("name"));
                    relic.setRarity(rs.getString("rarity"));
                    relic.setDescriptionRaw(rs.getString("descriptionRaw"));
                    relic.setPrice(rs.getInt("price"));
                    relic.setPurchased(rs.getBoolean("purchased")); // ✅ đánh dấu đã mua
                    relics.add(relic);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return relics;
}

// Lấy chi tiết relic và check purchased cho user
public static Relic getRelicByCode(String relicCode, String username) {
    Relic relic = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
             PreparedStatement ps = conn.prepareStatement(
    "SELECT r.*, EXISTS(SELECT 1 FROM relic_purchase_history ph WHERE ph.username=? AND ph.relicCode=r.relicCode) AS purchased " +
    "FROM relics r WHERE r.relicCode=?"
)) {

            ps.setString(1, username);
            ps.setString(2, relicCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    relic = new Relic();
                    relic.setRelicCode(rs.getString("relicCode"));
                    relic.setName(rs.getString("name"));
                    relic.setRarity(rs.getString("rarity"));
                    relic.setDescriptionRaw(rs.getString("descriptionRaw"));
                    relic.setPrice(rs.getInt("price"));
                    relic.setPurchased(rs.getBoolean("purchased"));
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return relic;
}
// ✅ Tìm kiếm relic theo từ khóa (relicCode, name, descriptionRaw)
public static List<Relic> searchByKeyword(String keyword) {
    List<Relic> relics = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT * FROM relics WHERE relicCode LIKE ? OR name LIKE ? OR descriptionRaw LIKE ?")) {

            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            stmt.setString(3, pattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Relic relic = new Relic();
                    relic.setRelicCode(rs.getString("relicCode"));
                    relic.setName(rs.getString("name"));
                    relic.setRarity(rs.getString("rarity"));
                    relic.setDescriptionRaw(rs.getString("descriptionRaw"));
                    relic.setPrice(rs.getInt("price"));
                    relic.setPurchased(false); // mặc định chưa mua
                    relics.add(relic);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return relics;
}


}
