package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet("/register-step2")
public class RegisterStep2Controller extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String otpInput = request.getParameter("otpInput");
        String otpStored = (String) session.getAttribute("otp");

        String username = (String) session.getAttribute("pendingUsername");
        String email = (String) session.getAttribute("pendingEmail");
        String hashedPassword = (String) session.getAttribute("pendingPassword");

        // ✅ Kiểm tra session có tồn tại (chống bypass)
        if (username == null || email == null || hashedPassword == null || otpStored == null) {
            request.setAttribute("error", "⚠️ Phiên đăng ký không hợp lệ. Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // ✅ Kiểm tra mã OTP
        if (!otpStored.equals(otpInput)) {
            request.setAttribute("error", "⚠️ Mã xác thực không đúng!");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            // ✅ Kiểm tra email trùng
            PreparedStatement checkEmail = conn.prepareStatement("SELECT * FROM users WHERE email = ?");
            checkEmail.setString(1, email);
            ResultSet rsEmail = checkEmail.executeQuery();

            if (rsEmail.next()) {
                request.setAttribute("error", "⚠️ Email đã được sử dụng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                conn.close();
                return;
            }

            // ✅ Lưu tài khoản vào DB
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (username, password, email) VALUES (?, ?, ?)");
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            stmt.setString(3, email);
            stmt.executeUpdate();

            conn.close();

            // ✅ Xóa session tạm
            session.removeAttribute("otp");
            session.removeAttribute("pendingUsername");
            session.removeAttribute("pendingEmail");
            session.removeAttribute("pendingPassword");

            // ✅ Thông báo thành công
            request.setAttribute("success", "🎉 Đăng ký thành công! Bạn có thể đăng nhập ngay.");
            request.getRequestDispatcher("register.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "❌ Lỗi khi lưu tài khoản!");
            request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
        }
    }
}
