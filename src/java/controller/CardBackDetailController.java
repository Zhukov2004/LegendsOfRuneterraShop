package controller;

import d.CardBackDAO;
import model.CardBack;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;

@WebServlet("/CardBackDetailController")
public class CardBackDetailController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code = request.getParameter("cardBackCode");

        if (code == null || code.isEmpty()) {
            request.setAttribute("error", "⚠️ Không có mã lưng bài.");
            request.getRequestDispatcher("cardback.jsp").forward(request, response);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            String username = (String) request.getSession().getAttribute("username");
            CardBack cb;
            if (username != null) {
                cb = CardBackDAO.getCardBackByCode(code, username); // ✅ có purchased flag
            } else {
                CardBackDAO dao = new CardBackDAO(conn);
                cb = dao.getByCode(code); // fallback nếu chưa login
            }

            if (cb == null) {
                request.setAttribute("error", "⚠️ Không tìm thấy lưng bài.");
                conn.close();
                request.getRequestDispatcher("cardback.jsp").forward(request, response);
                return;
            }

            request.setAttribute("cardBack", cb);
            conn.close();
            request.getRequestDispatcher("detail-cardback.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "⚠️ Lỗi khi tải chi tiết lưng bài.");
            request.getRequestDispatcher("cardback.jsp").forward(request, response);
        }
    }
}

