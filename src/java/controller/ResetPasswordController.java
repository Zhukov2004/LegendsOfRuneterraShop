/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import Helper.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 *
 * @author Admin
 */
@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            request.setAttribute("error", "⚠️ Phiên đặt lại mật khẩu không hợp lệ!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
            return;
        }

        if (newPassword == null || confirmPassword == null || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "⚠️ Vui lòng nhập đầy đủ mật khẩu!");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "⚠️ Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        String hashedPassword;
        try {
            hashedPassword = PasswordUtil.hashPassword(newPassword);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi mã hóa mật khẩu!");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            PreparedStatement stmt = conn.prepareStatement("UPDATE users SET password = ? WHERE email = ?");
            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);
            stmt.executeUpdate();

            conn.close();
            session.removeAttribute("resetEmail");
            session.removeAttribute("resetOtp");

            request.setAttribute("success", "✅ Mật khẩu đã được cập nhật!");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi khi cập nhật mật khẩu!");
            request.getRequestDispatcher("reset-password.jsp").forward(request, response);
        }
    }
}


