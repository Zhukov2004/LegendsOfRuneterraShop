/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import java.sql.ResultSet;
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
@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            PreparedStatement checkEmail = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet rs = checkEmail.executeQuery();

            if (!rs.next()) {
                request.setAttribute("error", "⚠️ Email không tồn tại!");
                request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
                conn.close();
                return;
            }

            String otp = String.valueOf((int)(Math.random() * 900000) + 100000);
            HttpSession session = request.getSession();
            session.setAttribute("resetEmail", email);
            session.setAttribute("resetOtp", otp);

            System.out.println("📧 Mã xác thực gửi đến " + email + ": " + otp);

            conn.close();
            request.getRequestDispatcher("verify-reset.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi hệ thống!");
            request.getRequestDispatcher("forgot-password.jsp").forward(request, response);
        }
    }
}

