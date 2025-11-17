package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.List;
import model.CartItem;
import model.CardBack;
@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/runeterra_shop?useUnicode=true&characterEncoding=UTF-8";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        Integer balance = (Integer) session.getAttribute("balance");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (username == null || cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        int totalCost = 0;
        for (CartItem item : cart) {
            totalCost += item.getPrice() * item.getQuantity();
        }

        if (balance < totalCost) {
            request.setAttribute("error", "⚠️ Số dư không đủ để thanh toán.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            return;
        }

        Connection conn = null;
        PreparedStatement psBalance = null;
        PreparedStatement psCard = null;
        PreparedStatement psRelic = null;
        PreparedStatement psCardBack = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            conn.setAutoCommit(false);

            // 1. Trừ số dư
            String sqlBalance = "UPDATE Users SET balance = balance - ? WHERE username = ?";
            psBalance = conn.prepareStatement(sqlBalance);
            psBalance.setInt(1, totalCost);
            psBalance.setString(2, username);
            psBalance.executeUpdate();

            // 2. Chuẩn bị các câu lệnh insert
            String sqlCard = "INSERT INTO purchase_history (username, cardCode, cardName, price, time) VALUES (?, ?, ?, ?, NOW())";
            String sqlRelic = "INSERT INTO relic_purchase_history (username, relicCode, relicName, price, time) VALUES (?, ?, ?, ?, NOW())";
            String sqlCardBack = "INSERT INTO card_back_purchase_history (username, cardBackCode,cardBackName, price, time) VALUES (?,?, ?, ?, NOW())";

            psCard = conn.prepareStatement(sqlCard);
            psRelic = conn.prepareStatement(sqlRelic);
            psCardBack = conn.prepareStatement(sqlCardBack);

            // 3. Phân loại theo itemCode
            for (CartItem item : cart) {
    String type = item.getItemType();

    switch (type) {
        case "card":
            psCard.setString(1, username);
            psCard.setString(2, item.getItemCode());
            psCard.setString(3, item.getItemName());
            psCard.setInt(4, item.getPrice());
            psCard.addBatch();
            break;

        case "relic":
            psRelic.setString(1, username);
            psRelic.setString(2, item.getItemCode());
            psRelic.setString(3, item.getItemName());
            psRelic.setInt(4, item.getPrice());
            psRelic.addBatch();
            break;

        case "cardback":
            psCardBack.setString(1, username);
            psCardBack.setString(2, item.getItemCode());
            psCardBack.setString(3, item.getItemName());
            psCardBack.setInt(4, item.getPrice());
            psCardBack.addBatch();
            break;
    }
}


            // 4. Thực thi batch
            psCard.executeBatch();
            psRelic.executeBatch();
            psCardBack.executeBatch();

            conn.commit();

            // 5. Xóa giỏ hàng và cập nhật số dư
            session.removeAttribute("cart");
            session.setAttribute("balance", balance - totalCost);

            response.sendRedirect("cart.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            request.setAttribute("error", "❌ Có lỗi xảy ra khi thanh toán.");
            request.getRequestDispatcher("cart.jsp").forward(request, response);
        } finally {
            try {
                if (psBalance != null) psBalance.close();
                if (psCard != null) psCard.close();
                if (psRelic != null) psRelic.close();
                if (psCardBack != null) psCardBack.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}

