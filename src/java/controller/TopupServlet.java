package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.Arrays;
import java.util.List;

@WebServlet("/topup")
public class TopupServlet extends HttpServlet {
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setCharacterEncoding("UTF-8");
    response.setContentType("text/html;charset=UTF-8");

    HttpSession session = request.getSession();
    String username = (String) session.getAttribute("username");

    if (username == null) {
      request.setAttribute("message", "❌ Bạn chưa đăng nhập.");
      request.getRequestDispatcher("topup-result.jsp").forward(request, response);
      return;
    }

    String method = request.getParameter("method");
    String code = request.getParameter("code");
    String amountStr = request.getParameter("amount");

    int amount = 0;
    try {
      amount = Integer.parseInt(amountStr);
    } catch (NumberFormatException e) {
      request.setAttribute("message", "❌ Mệnh giá không hợp lệ.");
      request.getRequestDispatcher("topup-result.jsp").forward(request, response);
      return;
    }

    List<Integer> allowedAmounts = Arrays.asList(10000, 20000, 50000, 100000, 200000, 500000);
    if (!allowedAmounts.contains(amount)) {
      request.setAttribute("message", "❌ Mệnh giá không nằm trong danh sách cho phép.");
      request.getRequestDispatcher("topup-result.jsp").forward(request, response);
      return;
    }

    if (code == null || code.trim().isEmpty()) {
      request.setAttribute("message", "❌ Vui lòng nhập mã giao dịch hoặc mã thẻ.");
      request.getRequestDispatcher("topup-result.jsp").forward(request, response);
      return;
    }

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

      PreparedStatement check = conn.prepareStatement("SELECT id FROM topup_log WHERE code = ?");
      check.setString(1, code);
      ResultSet rs = check.executeQuery();
      if (rs.next()) {
        rs.close();
        check.close();
        conn.close();
        request.setAttribute("message", "❌ Mã giao dịch này đã được sử dụng.");
        request.getRequestDispatcher("topup-result.jsp").forward(request, response);
        return;
      }
      rs.close();
      check.close();

      PreparedStatement update = conn.prepareStatement("UPDATE users SET balance = balance + ? WHERE username = ?");
      update.setInt(1, amount);
      update.setString(2, username);
      boolean success = update.executeUpdate() > 0;
      update.close();

      PreparedStatement log = conn.prepareStatement(
        "INSERT INTO topup_log (username, method, amount, code, status) VALUES (?, ?, ?, ?, ?)"
      );
      log.setString(1, username);
      log.setString(2, method);
      log.setInt(3, amount);
      log.setString(4, code);
      log.setString(5, success ? "success" : "failed");
      log.executeUpdate();
      log.close();

      conn.close();

      String msg = success
        ? "✅ Nạp thành công. Đã cộng " + amount + " xu vào tài khoản."
        : "❌ Không thể cập nhật số dư.";

      request.setAttribute("message", msg);
      request.getRequestDispatcher("topup-result.jsp").forward(request, response);

    } catch (Exception e) {
      e.printStackTrace();
      request.setAttribute("message", "❌ Lỗi hệ thống: " + e.getMessage());
      request.getRequestDispatcher("topup-result.jsp").forward(request, response);
    }
  }
}
