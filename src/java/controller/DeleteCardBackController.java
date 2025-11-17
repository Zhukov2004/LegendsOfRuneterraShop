package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import d.CardBackDAO;

@WebServlet("/deleteCardBack")
public class DeleteCardBackController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.getWriter().println("❌ Thiếu mã card back để xóa.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            CardBackDAO dao = new CardBackDAO(conn);

            boolean success = dao.delete(code);
            conn.close();

            if (success) {
                response.sendRedirect("cardbacks");
            } else {
                response.getWriter().println("❌ Xóa card back thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Lỗi kết nối hoặc xử lý dữ liệu.");
        }
    }
}
