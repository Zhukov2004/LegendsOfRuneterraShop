package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import model.Card;
import d.CardDAO;

@WebServlet("/addCard")
public class AddCardController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String cardCode = request.getParameter("cardCode");
        String name = request.getParameter("name");
        String descriptionRaw = request.getParameter("descriptionRaw");
        String rarityRef = request.getParameter("rarityRef");
        String regionRefs = request.getParameter("regionRefs");
        int cost = Integer.parseInt(request.getParameter("cost"));
        String type = request.getParameter("type");
        int price = Integer.parseInt(request.getParameter("price"));

        Card card = new Card();
        card.setCardCode(cardCode);
        card.setName(name);
        card.setDescriptionRaw(descriptionRaw);
        card.setRarityRef(rarityRef);
        card.setRegionRefs(regionRefs);
        card.setCost(cost);
        card.setType(type);
        card.setPrice(price);
        card.setPurchased(false);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
            boolean success = CardDAO.addCard(card);
            conn.close();

            if (success) {
                response.sendRedirect("cards"); // hoặc trang danh sách thẻ bài
            } else {
                response.getWriter().println("❌ Thêm thẻ bài thất bại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("❌ Lỗi kết nối hoặc xử lý dữ liệu.");
        }
    }
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    request.getRequestDispatcher("addCard.jsp").forward(request, response);
}

}
