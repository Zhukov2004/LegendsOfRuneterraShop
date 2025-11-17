package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.CartItem;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String itemCode = request.getParameter("itemCode");
        String itemName = request.getParameter("itemName");
        int price = Integer.parseInt(request.getParameter("price"));
        String itemType = request.getParameter("itemType"); // "card", "relic", "cardback"

        // ✅ Xác định đường dẫn ảnh dựa trên loại vật phẩm
        String imagePath = "";
        switch (itemType) {
            case "card":
                imagePath = "images/anh/" + itemCode + ".png";
                break;
            case "relic":
                imagePath = "images/relics/" + itemCode + ".png";
                break;
            case "cardback":
                imagePath = "images/cardback/" + itemCode + ".png";
                break;
            default:
                imagePath = "images/default.png";
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        boolean found = false;
        for (CartItem item : cart) {
            if (item.getItemCode().equals(itemCode)) {
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }

        if (!found) {
            // ✅ Truyền thêm imagePath vào constructor
            cart.add(new CartItem(itemCode, itemName, price, 1, itemType, imagePath));
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("cart.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET không được hỗ trợ");
    }
}
