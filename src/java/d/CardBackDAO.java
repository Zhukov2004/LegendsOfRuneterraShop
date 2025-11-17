package d;

import model.CardBack;
import java.sql.*;
import java.util.*;

public class CardBackDAO {
    private Connection conn;

    public CardBackDAO(Connection conn) {
        this.conn = conn;
    }

    public List<CardBack> getAll() throws SQLException {
        List<CardBack> list = new ArrayList<>();
        String sql = "SELECT * FROM card_backs";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new CardBack(
                    rs.getString("code"),
                    rs.getString("image"),
                    rs.getString("rarity"),
                    rs.getString("description"),
                    rs.getInt("price")
                ));
            }
        }
        return list;
    }

    public CardBack getByCode(String code) throws SQLException {
        String sql = "SELECT * FROM card_backs WHERE code = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new CardBack(
                        rs.getString("code"),
                        rs.getString("image"),
                        rs.getString("rarity"),
                        rs.getString("description"),
                        rs.getInt("price")
                    );
                }
            }
        }
        return null;
    }

    public static List<CardBack> searchByKeyword(String keyword) {
    List<CardBack> list = new ArrayList<>();
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
         PreparedStatement stmt = conn.prepareStatement("SELECT * FROM card_backs WHERE code LIKE ? OR description LIKE ?")) {
        String pattern = "%" + keyword + "%";
        stmt.setString(1, pattern);
        stmt.setString(2, pattern);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(new CardBack(
                    rs.getString("code"),
                    rs.getString("image"),
                    rs.getString("rarity"),
                    rs.getString("description"),
                    rs.getInt("price")
                ));
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public boolean insert(CardBack card) throws SQLException {
        String sql = "INSERT INTO card_backs (code, image, rarity, description, price) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, card.getCode());
            stmt.setString(2, card.getImage());
            stmt.setString(3, card.getRarity());
            stmt.setString(4, card.getDescription());
            stmt.setInt(5, card.getPrice());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean update(CardBack card) throws SQLException {
        String sql = "UPDATE card_backs SET image = ?, rarity = ?, description = ?, price = ? WHERE code = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, card.getImage());
            stmt.setString(2, card.getRarity());
            stmt.setString(3, card.getDescription());
            stmt.setInt(4, card.getPrice());
            stmt.setString(5, card.getCode());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean delete(String code) throws SQLException {
        String sql = "DELETE FROM card_backs WHERE code = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, code);
            return stmt.executeUpdate() > 0;
        }
    }
    public static List<CardBack> getRandomCardBacks(int limit) {
    List<CardBack> list = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

        String sql = "SELECT * FROM card_backs ORDER BY RAND() LIMIT ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, limit);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            list.add(new CardBack(
                rs.getString("code"),
                rs.getString("image"),
                rs.getString("rarity"),
                rs.getString("description"),
                rs.getInt("price")
            ));
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
// Lấy tất cả cardback và đánh dấu đã mua cho user
public static List<CardBack> getAllCardBacksForUser(String username) {
    List<CardBack> list = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

        String sql = "SELECT cb.*, EXISTS(SELECT 1 FROM card_back_purchase_history ph WHERE ph.username=? AND ph.cardBackCode=cb.code) AS purchased " +
                     "FROM card_backs cb";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            CardBack cb = new CardBack(
                rs.getString("code"),
                rs.getString("image"),
                rs.getString("rarity"),
                rs.getString("description"),
                rs.getInt("price")
            );
            cb.setPurchased(rs.getBoolean("purchased")); // ✅ đánh dấu đã mua
            list.add(cb);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}

// Lấy chi tiết cardback và check purchased cho user
public static CardBack getCardBackByCode(String code, String username) {
    CardBack cb = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

        String sql = "SELECT cb.*, EXISTS(SELECT 1 FROM card_back_purchase_history ph WHERE ph.username=? AND ph.cardBackCode=cb.code) AS purchased " +
                     "FROM card_backs cb WHERE cb.code=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, code);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            cb = new CardBack(
                rs.getString("code"),
                rs.getString("image"),
                rs.getString("rarity"),
                rs.getString("description"),
                rs.getInt("price")
            );
            cb.setPurchased(rs.getBoolean("purchased"));
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return cb;
}


}
