/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;
import d.CardDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
/**
 *
 * @author Admin
 */
@WebServlet("/deleteCard")
public class DeleteCardController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cardCode = request.getParameter("code");

        if (cardCode != null && !cardCode.isEmpty()) {
            boolean success = CardDAO.deleteCard(cardCode);
            if (success) {
                System.out.println("Xóa thành công: " + cardCode);
            } else {
                System.out.println("Xóa thất bại: " + cardCode);
            }
        }

        response.sendRedirect(request.getContextPath() + "/cards");
    }
}
