package controller;

import model.Relic;
import d.RelicDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.List;
import model.CartItem;

@WebServlet("/purchase-relic")
public class PurchaseRelicController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String confirm = request.getParameter("confirm"); // "true" hoặc "false"
        String relicCode = request.getParameter("relicCode");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            // 🔒 Kiểm tra đã mua relic chưa
    PreparedStatement checkStmt = conn.prepareStatement(
        "SELECT COUNT(*) FROM relic_purchase_history WHERE username = ? AND relicCode = ?");
    checkStmt.setString(1, username);
    checkStmt.setString(2, relicCode);
    ResultSet checkRs = checkStmt.executeQuery();
    boolean alreadyPurchased = false;
    if (checkRs.next()) {
        alreadyPurchased = checkRs.getInt(1) > 0;
    }
    if (alreadyPurchased) {
        request.setAttribute("showLimitModal", true);
        RequestDispatcher rd = request.getRequestDispatcher("relic.jsp");
        rd.forward(request, response);
        return;
    }
            // Lấy thông tin cổ vật
            PreparedStatement relicStmt = conn.prepareStatement(
                "SELECT name, price FROM relics WHERE relicCode = ?");
            relicStmt.setString(1, relicCode);
            ResultSet relicRs = relicStmt.executeQuery();

            if (!relicRs.next()) {
                request.setAttribute("error", "⚠️ Không tìm thấy cổ vật.");
                List<Relic> relics = RelicDAO.getAllRelics();
                request.setAttribute("relic", relics);
                request.getRequestDispatcher("relic.jsp").forward(request, response);
                return;
            }

            String relicName = relicRs.getString("name");
            int price = relicRs.getInt("price");

            // Lấy số dư người dùng
            PreparedStatement userStmt = conn.prepareStatement(
                "SELECT balance FROM users WHERE username = ?");
            userStmt.setString(1, username);
            ResultSet userRs = userStmt.executeQuery();
            userRs.next();
            int balance = userRs.getInt("balance");

            if (balance < price) {
                request.setAttribute("error", "⚠️ Không đủ Xu để mua cổ vật này.");
                List<Relic> relics = RelicDAO.getAllRelics();
                request.setAttribute("relic", relics);
                request.getRequestDispatcher("relic.jsp").forward(request, response);
                return;
            }

            // Nếu chưa xác nhận thì hiển thị trang xác nhận
            if (!"true".equals(confirm)) {
                Relic relic = new Relic();
                relic.setRelicCode(relicCode);
                relic.setName(relicName);
                relic.setPrice(price);
                request.setAttribute("relic", relic);
                request.getRequestDispatcher("confirm.jsp").forward(request, response);
                return;
            }

            // Trừ tiền
            PreparedStatement updateStmt = conn.prepareStatement(
                "UPDATE users SET balance = balance - ? WHERE username = ?");
            updateStmt.setInt(1, price);
            updateStmt.setString(2, username);
            updateStmt.executeUpdate();

            // Lưu lịch sử mua
            PreparedStatement historyStmt = conn.prepareStatement(
  "INSERT INTO relic_purchase_history (username, relicCode, relicName, price, time) VALUES (?, ?, ?, ?, NOW())");
historyStmt.setString(1, username);
historyStmt.setString(2, relicCode);
historyStmt.setString(3, relicName);
historyStmt.setInt(4, price);
historyStmt.executeUpdate();


            // Cập nhật lại số dư trong session
            request.getSession().setAttribute("balance", balance - price);

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠️ Lỗi khi xử lý mua cổ vật.");
            List<Relic> relics = RelicDAO.getAllRelics();
            request.setAttribute("relic", relics);
            request.getRequestDispatcher("relic.jsp").forward(request, response);
            return;
        }
        
        // Hiển thị modal thành công nếu có
        String showSuccess = request.getParameter("showSuccess");
        if ("true".equals(showSuccess)) {
            request.setAttribute("showSuccessModal", Boolean.TRUE);
        }

       String returnPage = request.getParameter("returnPage");
if (returnPage == null || returnPage.isEmpty()) {
    returnPage = "relic.jsp";
}

if ("relic.jsp".equals(returnPage)) {
    List<Relic> relics;
    if (username != null) {
        relics = RelicDAO.getAllRelicsForUser(username); // có purchased flag
    } else {
        relics = RelicDAO.getAllRelics();
    }
    request.setAttribute("relics", relics); // ✅ đồng bộ tên attribute
}

if ("detail-relic.jsp".equals(returnPage)) {
    Relic relic;
    if (username != null) {
        relic = RelicDAO.getRelicByCode(relicCode, username); // ✅ có purchased flag
    } else {
        relic = RelicDAO.getRelicByCode(relicCode);
    }
    request.setAttribute("relic", relic);
}

List<CartItem> cart = (List<CartItem>) request.getSession().getAttribute("cart");
if (cart != null) {
    cart.removeIf(ci -> ci.getItemCode().equals(relicCode));
    request.getSession().setAttribute("cart", cart);
}

RequestDispatcher rd = request.getRequestDispatcher(returnPage);
rd.forward(request, response);

    }
}
