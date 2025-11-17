package controller;

import d.PurchaseDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Purchase;
import java.io.IOException;
import java.util.List;

@WebServlet("/history")
public class PurchaseHistoryController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String sessionUsername = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        if (sessionUsername == null || role == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // ✅ Lấy dữ liệu tìm kiếm từ form
        String searchUsername = request.getParameter("username");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        PurchaseDAO dao = new PurchaseDAO();
        List<Purchase> cardPurchases;
        List<Purchase> relicPurchases;
        List<Purchase> cardBackPurchases;
        if ("admin".equals(role)) {
            // ✅ Admin có thể tìm theo người mua và khoảng thời gian
            cardPurchases = dao.searchCardPurchases(searchUsername, fromDate, toDate);
            relicPurchases = dao.searchRelicPurchases(searchUsername, fromDate, toDate);
            cardBackPurchases = dao.searchCardBackPurchases(searchUsername, fromDate, toDate);
        } else {
            // ✅ Người dùng thường chỉ tìm theo khoảng thời gian, username là của chính họ
            cardPurchases = dao.searchCardPurchases(sessionUsername, fromDate, toDate);
            relicPurchases = dao.searchRelicPurchases(sessionUsername, fromDate, toDate);
            cardBackPurchases = dao.searchCardBackPurchases(sessionUsername, fromDate, toDate);
        }

        request.setAttribute("cardPurchases", cardPurchases);
        request.setAttribute("relicPurchases", relicPurchases);
        request.setAttribute("cardBackPurchases", cardBackPurchases);
        request.getRequestDispatcher("purchase-history.jsp").forward(request, response);
    }
}
