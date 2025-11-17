package d;

import model.Purchase;
import java.sql.*;
import java.util.*;

public class PurchaseDAO {
    private Connection conn;

    public PurchaseDAO() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Purchase> getAllCardPurchases() {
        String sql = "SELECT * FROM purchase_history ORDER BY time DESC";
        return queryPurchases(sql, null, null, null, "card");
    }

    public List<Purchase> getAllRelicPurchases() {
        String sql = "SELECT * FROM relic_purchase_history ORDER BY time DESC";
        return queryPurchases(sql, null, null, null, "relic");
    }

    public List<Purchase> getCardPurchasesByUsername(String username) {
        String sql = "SELECT * FROM purchase_history WHERE username = ? ORDER BY time DESC";
        return queryPurchases(sql, username, null, null, "card");
    }

    public List<Purchase> getRelicPurchasesByUsername(String username) {
        String sql = "SELECT * FROM relic_purchase_history WHERE username = ? ORDER BY time DESC";
        return queryPurchases(sql, username, null, null, "relic");
    }

    public List<Purchase> getAllCardBackPurchases() {
    String sql = "SELECT * FROM card_back_purchase_history ORDER BY time DESC";
    return queryPurchases(sql, null, null, null, "cardback");
}
    public List<Purchase> getCardBackPurchasesByUsername(String username) {
    String sql = "SELECT * FROM card_back_purchase_history WHERE username = ? ORDER BY time DESC";
    return queryPurchases(sql, username, null, null, "cardback");
}

    // ✅ Tìm kiếm theo khoảng thời gian
    public List<Purchase> searchCardPurchases(String username, String fromDate, String toDate) {
        StringBuilder sql = new StringBuilder("SELECT * FROM purchase_history WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (username != null && !username.isEmpty()) {
            sql.append(" AND username LIKE ?");
            params.add("%" + username + "%");
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND DATE(time) >= ?");
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND DATE(time) <= ?");
            params.add(toDate);
        }

        sql.append(" ORDER BY time DESC");
        return queryPurchases(sql.toString(), params, "card");
    }

    public List<Purchase> searchRelicPurchases(String username, String fromDate, String toDate) {
        StringBuilder sql = new StringBuilder("SELECT * FROM relic_purchase_history WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (username != null && !username.isEmpty()) {
            sql.append(" AND username LIKE ?");
            params.add("%" + username + "%");
        }
        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND DATE(time) >= ?");
            params.add(fromDate);
        }
        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND DATE(time) <= ?");
            params.add(toDate);
        }

        sql.append(" ORDER BY time DESC");
        return queryPurchases(sql.toString(), params, "relic");
    }
    public List<Purchase> searchCardBackPurchases(String username, String fromDate, String toDate) {
    StringBuilder sql = new StringBuilder("SELECT * FROM card_back_purchase_history WHERE 1=1");
    List<Object> params = new ArrayList<>();

    if (username != null && !username.isEmpty()) {
        sql.append(" AND username LIKE ?");
        params.add("%" + username + "%");
    }
    if (fromDate != null && !fromDate.isEmpty()) {
        sql.append(" AND DATE(time) >= ?");
        params.add(fromDate);
    }
    if (toDate != null && !toDate.isEmpty()) {
        sql.append(" AND DATE(time) <= ?");
        params.add(toDate);
    }

    sql.append(" ORDER BY time DESC");
    return queryPurchases(sql.toString(), params, "cardback");
}

    // ✅ Overload cho truy vấn linh hoạt
    private List<Purchase> queryPurchases(String sql, String username, String fromDate, String toDate, String type) {
        List<Object> params = new ArrayList<>();
        if (username != null) params.add(username);
        if (fromDate != null) params.add(fromDate);
        if (toDate != null) params.add(toDate);
        return queryPurchases(sql, params, type);
    }

    private List<Purchase> queryPurchases(String sql, List<Object> params, String type) {
        List<Purchase> list = new ArrayList<>();
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Purchase p = new Purchase();
                    p.setUsername(rs.getString("username"));
                    if ("card".equals(type)) {
                        p.setItemName(rs.getString("cardName"));
                    } else if ("relic".equals(type)) {
                        p.setItemName(rs.getString("relicName"));
                    }
                    else if ("cardback".equals(type)) {
    p.setItemName(rs.getString("cardBackCode"));
}
                    p.setPrice(rs.getInt("price"));
                    p.setTime(rs.getTimestamp("time"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
}
