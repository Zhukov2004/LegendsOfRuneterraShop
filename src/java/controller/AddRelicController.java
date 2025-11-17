package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import model.Relic;
import d.RelicDAO;

@WebServlet("/addRelic")
public class AddRelicController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addRelic.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String relicCode = request.getParameter("relicCode");
        String name = request.getParameter("name");
        String descriptionRaw = request.getParameter("descriptionRaw");
        String rarity = request.getParameter("rarity");
        int price = Integer.parseInt(request.getParameter("price"));

        Relic relic = new Relic();
        relic.setRelicCode(relicCode);
        relic.setName(name);
        relic.setDescriptionRaw(descriptionRaw);
        relic.setRarity(rarity);
        relic.setPrice(price);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

            boolean success = RelicDAO.insertRelic(relic);
            conn.close();

            if (success) {
                response.sendRedirect("relics"); // hoặc trang danh sách cổ vật
            } else {
                response.getWriter().println("❌ Thêm cổ vật thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Lỗi kết nối hoặc xử lý dữ liệu.");
        }
    }
}
