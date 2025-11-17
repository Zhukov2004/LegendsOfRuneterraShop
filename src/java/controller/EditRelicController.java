package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Relic;
import d.RelicDAO;

@WebServlet("/editRelic")
public class EditRelicController extends HttpServlet {
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

        boolean success = RelicDAO.updateRelic(relic);

        if (success) {
            response.sendRedirect("relics"); // hoặc trang danh sách cổ vật
        } else {
            response.getWriter().println("❌ Cập nhật thất bại. Kiểm tra lại dữ liệu.");
        }
    }
}
