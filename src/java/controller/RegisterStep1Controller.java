package controller;

import Helper.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register-step1")
public class RegisterStep1Controller extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String hashedPassword = PasswordUtil.hashPassword(password);
        String otp = String.valueOf((int)(Math.random() * 900000) + 100000); // mã 6 chữ số

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            // Kiểm tra trùng tên đăng nhập
            PreparedStatement checkUsername = conn.prepareStatement("SELECT * FROM users WHERE username = ?");
            checkUsername.setString(1, username);
            ResultSet rs1 = checkUsername.executeQuery();

            if (rs1.next()) {
                request.setAttribute("error", "⚠️ Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                conn.close();
                return;
            }

            // Kiểm tra trùng email
            PreparedStatement checkEmail = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet rs2 = checkEmail.executeQuery();

            if (rs2.next()) {
                request.setAttribute("error", "⚠️ Email đã được sử dụng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                conn.close();
                return;
            }

            // Nếu không trùng → tiếp tục tạo OTP
            HttpSession session = request.getSession();
            session.setAttribute("pendingUsername", username);
            session.setAttribute("pendingEmail", email);
            session.setAttribute("pendingPassword", hashedPassword);
            session.setAttribute("otp", otp);

            System.out.println("📧 Mã xác thực gửi đến " + email + ": " + otp);

            conn.close();
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi kết nối CSDL!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
