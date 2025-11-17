package controller;

import d.CardDAO;
import model.Card;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/editCard")
public class EditCardController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
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

            boolean success = CardDAO.updateCard(card);

            HttpSession session = request.getSession();
            if (success) {
                session.setAttribute("message", "✅ Cập nhật thành công!");
            } else {
                session.setAttribute("message", "❌ Cập nhật thất bại!");
            }

            response.sendRedirect(request.getContextPath() + "/cards");

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "❌ Có lỗi xảy ra khi cập nhật!");
            response.sendRedirect(request.getContextPath() + "/cards");
        }
    }
}
