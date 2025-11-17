package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import Helper.PasswordUtil;
@WebServlet("/register")
public class RegisterController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String hashedPassword = PasswordUtil.hashPassword(password);
        String success = null;
        String error = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            // Kiểm tra trùng tên
            PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                error = "Tên đăng nhập đã tồn tại!";
            } else {
                PreparedStatement insertStmt = conn.prepareStatement(
                    "INSERT INTO users (username, password, email) VALUES (?, ?, ?)");
                insertStmt.setString(1, username);
                insertStmt.setString(2, hashedPassword);
                insertStmt.setString(3, email);

                int rows = insertStmt.executeUpdate();
                if (rows > 0) {
                    success = "🎉 Đăng ký thành công! Bạn có thể đăng nhập ngay.";
                } else {
                    error = "Lỗi khi đăng ký!";
                }
            }

            conn.close();
        } catch (Exception e) {
            error = "Lỗi kết nối CSDL!";
            e.printStackTrace();
        }

        request.setAttribute("success", success);
        request.setAttribute("error", error);
        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        rd.forward(request, response);
    }
}
