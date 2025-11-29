package d;

import java.sql.*;
import java.util.*;

public class RevenueDAO {
    private Connection conn;

    public RevenueDAO(Connection conn) {
        this.conn = conn;
    }

    // Lấy doanh thu tổng hợp từ 3 bảng
    public Map<String, Integer> getRevenueAll() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();

        String sql =
            "SELECT 'Lưng bài' AS type, SUM(price) AS revenue FROM card_back_purchase_history " +
            "UNION ALL " +
            "SELECT 'Lá bài', SUM(price) FROM purchase_history " +
            "UNION ALL " +
            "SELECT 'Cổ vật', SUM(price) FROM relic_purchase_history";

        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            map.put(rs.getString("type"), rs.getInt("revenue"));
        }

        return map;
    }

    // Lấy tổng doanh thu tất cả bảng
    public int getTotalRevenue() throws SQLException {
        int total = 0;

        String sql1 = "SELECT SUM(price) AS revenue FROM card_back_purchase_history";
        String sql2 = "SELECT SUM(price) AS revenue FROM purchase_history";
        String sql3 = "SELECT SUM(price) AS revenue FROM relic_purchase_history";

        PreparedStatement stmt1 = conn.prepareStatement(sql1);
        ResultSet rs1 = stmt1.executeQuery();
        if (rs1.next()) total += rs1.getInt("revenue");

        PreparedStatement stmt2 = conn.prepareStatement(sql2);
        ResultSet rs2 = stmt2.executeQuery();
        if (rs2.next()) total += rs2.getInt("revenue");

        PreparedStatement stmt3 = conn.prepareStatement(sql3);
        ResultSet rs3 = stmt3.executeQuery();
        if (rs3.next()) total += rs3.getInt("revenue");

        return total;
    }
    public Map<String, Integer> getRevenueByMonth() throws SQLException {
        Map<String, Integer> map = new LinkedHashMap<>();

        String sql =
            "SELECT DATE_FORMAT(time, '%Y-%m') AS month, SUM(price) AS revenue " +
            "FROM (" +
            "   SELECT time, price FROM card_back_purchase_history " +
            "   UNION ALL " +
            "   SELECT time, price FROM purchase_history " +
            "   UNION ALL " +
            "   SELECT time, price FROM relic_purchase_history " +
            ") AS all_history " +
            "GROUP BY month ORDER BY month";

        PreparedStatement stmt = conn.prepareStatement(sql);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            map.put(rs.getString("month"), rs.getInt("revenue"));
        }

        return map;
    }
}
