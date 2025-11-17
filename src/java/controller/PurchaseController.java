package controller;

import model.Card;
import d.CardDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/purchase")
public class PurchaseController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String confirm = request.getParameter("confirm"); // "true" hoặc "false"
        String itemType = request.getParameter("itemType"); // "card" hoặc "relic"
        String username = (String) request.getSession().getAttribute("username");
        String cardCode = request.getParameter("cardCode");
        String returnPage = request.getParameter("returnPage");
        String showSuccess = request.getParameter("showSuccess");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (returnPage == null || returnPage.isEmpty()) {
            returnPage = "index.jsp";
        }

        Connection conn = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            // 🔒 Kiểm tra đã mua lá bài chưa
            PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT COUNT(*) FROM purchase_history WHERE username = ? AND cardCode = ?");
            checkStmt.setString(1, username);
            checkStmt.setString(2, cardCode);
            ResultSet checkRs = checkStmt.executeQuery();
            boolean alreadyPurchased = false;
            if (checkRs.next()) {
                alreadyPurchased = checkRs.getInt(1) > 0;
            }

            if (alreadyPurchased) {
    request.setAttribute("showLimitModal", true); // ✅ flag để JSP bật modal
    RequestDispatcher rd = request.getRequestDispatcher(returnPage);
    rd.forward(request, response);
    return;
}


            // 📦 Lấy thông tin lá bài
            PreparedStatement cardStmt = conn.prepareStatement(
                    "SELECT name, price FROM cards WHERE cardCode = ?");
            cardStmt.setString(1, cardCode);
            ResultSet cardRs = cardStmt.executeQuery();

            if (!cardRs.next()) {
                request.setAttribute("error", "⚠️ Không tìm thấy lá bài.");
                RequestDispatcher rd = request.getRequestDispatcher(returnPage);
                rd.forward(request, response);
                return;
            }

            String cardName = cardRs.getString("name");
            int price = cardRs.getInt("price");

            // 💰 Lấy số dư người dùng
            PreparedStatement userStmt = conn.prepareStatement(
                    "SELECT balance FROM users WHERE username = ?");
            userStmt.setString(1, username);
            ResultSet userRs = userStmt.executeQuery();
            userRs.next();
            int balance = userRs.getInt("balance");

            if (balance < price) {
                request.setAttribute("error", "⚠️ Không đủ Xu để mua lá bài này.");
                Card card = CardDAO.getCardByCode(cardCode,username);
                request.setAttribute("card", card);
                RequestDispatcher rd = request.getRequestDispatcher(returnPage);
                rd.forward(request, response);
                return;
            }

            // ✅ Nếu chưa xác nhận thì hiển thị trang xác nhận
            if (!"true".equals(confirm)) {
                Card card = new Card();
                card.setCardCode(cardCode);
                card.setName(cardName);
                card.setPrice(price);
                request.setAttribute("card", card);
                request.setAttribute("returnPage", returnPage);
                RequestDispatcher rd = request.getRequestDispatcher("confirm.jsp");
                rd.forward(request, response);
                return;
            }

            // 💸 Trừ tiền
            PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE users SET balance = balance - ? WHERE username = ?");
            updateStmt.setInt(1, price);
            updateStmt.setString(2, username);
            updateStmt.executeUpdate();

            // 📝 Lưu lịch sử mua
            PreparedStatement historyStmt = conn.prepareStatement(
                    "INSERT INTO purchase_history (username, cardCode, cardName, price, time) VALUES (?, ?, ?, ?, NOW())");
            historyStmt.setString(1, username);
            historyStmt.setString(2, cardCode);
            historyStmt.setString(3, cardName);
            historyStmt.setInt(4, price);
            historyStmt.executeUpdate();

            // 🔄 Cập nhật lại số dư trong session
            request.getSession().setAttribute("balance", balance - price);

            // ✅ Đánh dấu đã mua để JSP ẩn nút
            request.setAttribute("alreadyPurchased", true);

            // ✅ Hiển thị thông báo thành công nếu cần
            if ("true".equals(showSuccess)) {
                request.setAttribute("showSuccessModal", true);
            }

           // 📦 Luôn load lại danh sách lá bài cho người dùng
if ("cards.jsp".equals(returnPage)) {
    List<Card> allCards = CardDAO.getAllCardsForUser(username); // lấy từ DB
    request.setAttribute("allCards", allCards);
}

// Nếu quay về trang chi tiết thì load thêm card cụ thể
if ("card-detail.jsp".equals(returnPage)) {
    Card card = CardDAO.getCardByCode(cardCode,username);
    request.setAttribute("card", card);
}

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠️ Lỗi khi xử lý mua hàng.");
        }

        RequestDispatcher rd = request.getRequestDispatcher(returnPage);
        rd.forward(request, response);
    }
}
