package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import model.CardBack;
import d.CardBackDAO;

@WebServlet("/editCardBack")
public class EditCardBackController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String code = request.getParameter("code");
        String image = request.getParameter("image");
        String rarity = request.getParameter("rarity");
        String description = request.getParameter("description");
        int price = Integer.parseInt(request.getParameter("price"));

        CardBack card = new CardBack(code, image, rarity, description, price);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            CardBackDAO dao = new CardBackDAO(conn);

            boolean success = dao.update(card);

            if (success) {
                response.sendRedirect("CardBackController");

            } else {
                response.getWriter().println("❌ Cập nhật thất bại. Kiểm tra lại dữ liệu.");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Lỗi kết nối hoặc xử lý dữ liệu.");
        }
    }
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    request.setCharacterEncoding("UTF-8");
    String code = request.getParameter("code");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        CardBackDAO dao = new CardBackDAO(conn);

        CardBack cb = dao.getByCode(code);
        conn.close();

        if (cb != null) {
            request.setAttribute("cardback", cb);
            request.getRequestDispatcher("editCardBack.jsp").forward(request, response);
        } else {
            response.sendRedirect("CardBackController");
        }

    } catch (Exception e) {
        e.printStackTrace();
        response.getWriter().println("❌ Lỗi khi tải dữ liệu lưng bài.");
    }
}

    
}
