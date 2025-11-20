package controller;

import d.CardBackDAO;
import model.CardBack;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import model.CartItem;

@WebServlet("/purchase-cardback")
public class PurchaseCardBackController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String confirm = request.getParameter("confirm");
        String cardBackCode = request.getParameter("cardBackCode");
        String showSuccess = request.getParameter("showSuccess");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            CardBackDAO dao = new CardBackDAO(conn);
            CardBack cb = dao.getByCode(cardBackCode);

            if (cb == null) {
                conn.close();
                response.sendRedirect("CardBackController?error=notfound");
                return;
            }

            // Lấy số dư
            PreparedStatement userStmt = conn.prepareStatement(
                "SELECT balance FROM users WHERE username = ?");
            userStmt.setString(1, username);
            ResultSet userRs = userStmt.executeQuery();

            if (!userRs.next()) {
                conn.close();
                response.sendRedirect("CardBackController?error=usernotfound");
                return;
            }

            int balance = userRs.getInt("balance");

            if (balance < cb.getPrice()) {
                conn.close();
                response.sendRedirect("CardBackController?error=notenough");
                return;
            }

            // Nếu chưa xác nhận
            if (!"true".equals(confirm)) {
                conn.close();
                response.sendRedirect("CardBackController?action=confirm&code=" + cardBackCode);
                return;
            }

            // Trừ tiền
            PreparedStatement updateStmt = conn.prepareStatement(
                "UPDATE users SET balance = balance - ? WHERE username = ?");
            updateStmt.setInt(1, cb.getPrice());
            updateStmt.setString(2, username);
            updateStmt.executeUpdate();

            // Lưu lịch sử mua
            PreparedStatement historyStmt = conn.prepareStatement(
                "INSERT INTO card_back_purchase_history (username, cardBackCode, cardBackName, price, time) VALUES (?, ?, ?, ?, NOW())");
            historyStmt.setString(1, username);
            historyStmt.setString(2, cb.getCode());
            historyStmt.setString(3, cb.getDescription());
            historyStmt.setInt(4, cb.getPrice());
            historyStmt.executeUpdate();

            // Cập nhật số dư trong session
            request.getSession().setAttribute("balance", balance - cb.getPrice());

            conn.close();

            // Redirect về trang danh sách + hiện modal
            String redirectURL = "CardBackController";
            if ("true".equals(showSuccess)) {
                redirectURL += "?showSuccess=true";
            }

            response.sendRedirect(redirectURL);
            // sau khi ghi lịch sử mua
List<CartItem> cart = (List<CartItem>) request.getSession().getAttribute("cart");
if (cart != null) {
    cart.removeIf(ci -> ci.getItemCode().equals(cardBackCode));
    request.getSession().setAttribute("cart", cart);
}

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("CardBackController?error=exception");
        }
    }
}
