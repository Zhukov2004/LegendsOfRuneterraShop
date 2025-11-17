package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import d.RelicDAO;

@WebServlet("/deleteRelic")
public class DeleteRelicController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String relicCode = request.getParameter("code");

        if (relicCode == null || relicCode.isEmpty()) {
            response.getWriter().println("❌ Thiếu mã cổ vật để xóa.");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            boolean success = RelicDAO.deleteRelic(relicCode);
            conn.close();

            if (success) {
                response.sendRedirect("relics"); // hoặc trang danh sách cổ vật
            } else {
                response.getWriter().println("❌ Xóa cổ vật thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Lỗi kết nối hoặc xử lý dữ liệu.");
        }
    }
}
