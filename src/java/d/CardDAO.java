package d;

import model.Card;
import java.sql.*;
import java.util.*;

public class CardDAO {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/runeterra_shop?useUnicode=true&characterEncoding=UTF-8";
private static final String JDBC_USER = "root";
private static final String JDBC_PASS = "";

    // Lấy tất cả lá bài (không check purchased)
    public static List<Card> getAllCards() {
        List<Card> cards = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM cards")) {

                while (rs.next()) {
                    Card card = new Card();
                    card.setCardCode(rs.getString("cardCode"));
                    card.setName(rs.getString("name"));
                    card.setDescriptionRaw(rs.getString("descriptionRaw"));
                    card.setRarityRef(rs.getString("rarityRef"));
                    card.setRegionRefs(rs.getString("regionRefs"));
                    card.setCost(rs.getInt("cost"));
                    card.setType(rs.getString("type"));
                    card.setPrice(rs.getInt("price"));
                    card.setPurchased(false); // mặc định chưa mua
                    cards.add(card);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cards;
    }
    
    // ✅ Lấy danh sách lá bài và đánh dấu đã mua cho user
    public static List<Card> getAllCardsForUser(String username) {
        List<Card> cards = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
                 PreparedStatement stmt = conn.prepareStatement(
                     "SELECT c.cardCode, c.name, c.descriptionRaw, c.rarityRef, c.regionRefs, c.cost, c.type, c.price, " +
                     "       EXISTS(SELECT 1 FROM purchase_history ph WHERE ph.username=? AND ph.cardCode=c.cardCode) AS purchased " +
                     "FROM cards c")) {

                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        Card card = new Card();
                        card.setCardCode(rs.getString("cardCode"));
                        card.setName(rs.getString("name"));
                        card.setDescriptionRaw(rs.getString("descriptionRaw"));
                        card.setRarityRef(rs.getString("rarityRef"));
                        card.setRegionRefs(rs.getString("regionRefs"));
                        card.setCost(rs.getInt("cost"));
                        card.setType(rs.getString("type"));
                        card.setPrice(rs.getInt("price"));
                        card.setPurchased(rs.getBoolean("purchased")); // ✅ đánh dấu đã mua
                        cards.add(card);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cards;
    }

    // ✅ Lấy chi tiết lá bài và check purchased cho user
    public static Card getCardByCode(String cardCode, String username) {
        Card card = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
                 PreparedStatement ps = conn.prepareStatement(
                     "SELECT c.*, EXISTS(SELECT 1 FROM purchase_history ph WHERE ph.username=? AND ph.cardCode=c.cardCode) AS purchased " +
                     "FROM cards c WHERE c.cardCode=?")) {

                ps.setString(1, username);
                ps.setString(2, cardCode);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        card = new Card();
                        card.setCardCode(rs.getString("cardCode"));
                        card.setName(rs.getString("name"));
                        card.setDescriptionRaw(rs.getString("descriptionRaw"));
                        card.setRarityRef(rs.getString("rarityRef"));
                        card.setRegionRefs(rs.getString("regionRefs"));
                        card.setCost(rs.getInt("cost"));
                        card.setType(rs.getString("type"));
                        card.setPrice(rs.getInt("price"));
                        card.setPurchased(rs.getBoolean("purchased"));
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return card;
    }

    public static boolean addCard(Card card) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            String sql = "INSERT INTO cards (cardCode, name, descriptionRaw, rarityRef, regionRefs, cost, type, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, card.getCardCode());
            ps.setString(2, card.getName());
            ps.setString(3, card.getDescriptionRaw());
            ps.setString(4, card.getRarityRef());
            ps.setString(5, card.getRegionRefs());
            ps.setInt(6, card.getCost());
            ps.setString(7, card.getType());
            ps.setInt(8, card.getPrice());
            int rows = ps.executeUpdate();
            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updateCard(Card card) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            String sql = "UPDATE cards SET name=?, descriptionRaw=?, rarityRef=?, regionRefs=?, cost=?, type=?, price=? WHERE cardCode=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, card.getName());
            ps.setString(2, card.getDescriptionRaw());
            ps.setString(3, card.getRarityRef());
            ps.setString(4, card.getRegionRefs());
            ps.setInt(5, card.getCost());
            ps.setString(6, card.getType());
            ps.setInt(7, card.getPrice());
            ps.setString(8, card.getCardCode());
            int rows = ps.executeUpdate();
            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deleteCard(String cardCode) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            String sql = "DELETE FROM cards WHERE cardCode=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cardCode);
            int rows = ps.executeUpdate();
            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static List<Card> getRandomCards(int limit) {
    List<Card> cards = new ArrayList<>();
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        String sql = "SELECT * FROM cards ORDER BY RAND() LIMIT ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Card card = new Card();
            card.setCardCode(rs.getString("cardCode"));
            card.setName(rs.getString("name"));
            card.setDescriptionRaw(rs.getString("descriptionRaw"));
            card.setRarityRef(rs.getString("rarityRef"));
            card.setRegionRefs(rs.getString("regionRefs"));
            card.setCost(rs.getInt("cost"));
            card.setType(rs.getString("type"));
            card.setPrice(rs.getInt("price"));
            card.setPurchased(false); // mặc định chưa mua
            cards.add(card);
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return cards;
}
    // ✅ Lấy chi tiết lá bài (không check purchased)
public static Card getCardByCode(String cardCode) {
    Card card = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM cards WHERE cardCode=?")) {

            ps.setString(1, cardCode);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    card = new Card();
                    card.setCardCode(rs.getString("cardCode"));
                    card.setName(rs.getString("name"));
                    card.setDescriptionRaw(rs.getString("descriptionRaw"));
                    card.setRarityRef(rs.getString("rarityRef"));
                    card.setRegionRefs(rs.getString("regionRefs"));
                    card.setCost(rs.getInt("cost"));
                    card.setType(rs.getString("type"));
                    card.setPrice(rs.getInt("price"));
                    card.setPurchased(false); // mặc định chưa mua
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return card;
}
// ✅ Tìm kiếm lá bài theo từ khóa (cardCode, name, descriptionRaw)
public static List<Card> searchByKeyword(String keyword) {
    List<Card> cards = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT * FROM cards WHERE cardCode LIKE ? OR name LIKE ? OR descriptionRaw LIKE ?")) {

            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            stmt.setString(3, pattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Card card = new Card();
                    card.setCardCode(rs.getString("cardCode"));
                    card.setName(rs.getString("name"));
                    card.setDescriptionRaw(rs.getString("descriptionRaw"));
                    card.setRarityRef(rs.getString("rarityRef"));
                    card.setRegionRefs(rs.getString("regionRefs"));
                    card.setCost(rs.getInt("cost"));
                    card.setType(rs.getString("type"));
                    card.setPrice(rs.getInt("price"));
                    card.setPurchased(false); // mặc định chưa mua
                    cards.add(card);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return cards;
}




}
