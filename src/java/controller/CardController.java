/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Card;
import d.CardDAO;
import jakarta.servlet.annotation.WebServlet;
@WebServlet("/cards")
public class CardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cardCode = request.getParameter("cardCode");
        String username = (String) request.getSession().getAttribute("username"); // ✅ lấy username từ session

        try {
            if (cardCode != null && !cardCode.trim().isEmpty()) {
                // Nếu có cardCode → hiển thị chi tiết lá bài
                Card card;
                if (username != null) {
                    card = CardDAO.getCardByCode(cardCode, username); // ✅ check purchased
                } else {
                    card = CardDAO.getCardByCode(cardCode,username); // fallback nếu chưa login
                }

                if (card != null) {
                    request.setAttribute("card", card);
                    RequestDispatcher rd = request.getRequestDispatcher("card-detail.jsp");
                    rd.forward(request, response);
                } else {
                    response.setContentType("text/html;charset=UTF-8");
                    response.getWriter().println("<h3 style='color:red;text-align:center;'>Không tìm thấy lá bài có mã: " + cardCode + "</h3>");
                }

            } else {
                // Nếu không có cardCode → hiển thị danh sách
                List<Card> allCards;
                if (username != null) {
                    allCards = CardDAO.getAllCardsForUser(username); // ✅ check purchased
                } else {
                    allCards = CardDAO.getAllCards(); // fallback nếu chưa login
                }
                request.setAttribute("allCards", allCards);
                RequestDispatcher rd = request.getRequestDispatcher("cards.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<h3 style='color:red;text-align:center;'>Lỗi khi xử lý dữ liệu lá bài.</h3>");
            response.getWriter().println("<pre style='color:red; padding:10px; background:#fdd; border:1px solid red;'>");
            e.printStackTrace(response.getWriter()); // In lỗi ra trình duyệt
            response.getWriter().println("</pre>");
        }
    }
}

