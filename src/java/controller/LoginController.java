package controller;

import Helper.PasswordUtil;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String hashedInput = PasswordUtil.hashPassword(password);
        String error = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPass = rs.getString("password");

                if (hashedInput.equals(storedPass)) {
                    HttpSession session = request.getSession();
                    int balance = rs.getInt("balance");
                    String role = rs.getString("role");

                    session.setAttribute("username", username);
                    session.setAttribute("balance", balance);
                    session.setAttribute("role", role);

                    response.sendRedirect("index.jsp");
                    return;
                } else {
                    error = "⚠️ Sai mật khẩu!";
                }
            } else {
                error = "⚠️ Tài khoản không tồn tại!";
            }

            conn.close();
        } catch (Exception e) {
            error = "⚠️ Lỗi kết nối CSDL!";
            e.printStackTrace();
        }

        request.setAttribute("error", error);
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        rd.forward(request, response);
    }
}
