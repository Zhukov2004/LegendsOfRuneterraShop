package controller;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.List;
import model.CartItem;

@WebServlet("/remove-cart")
public class RemoveCartServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String itemCode = request.getParameter("itemCode");

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart != null && itemCode != null) {
            cart.removeIf(item -> itemCode.equals(item.getItemCode()));
        }

        response.sendRedirect("cart.jsp");
    }
}
