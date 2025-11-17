/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import d.CardBackDAO;
import d.CardDAO;
import d.PostDAO;
import d.RelicDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Card;
import model.CardBack;
import model.Post;
import model.Relic;

/**
 *
 * @author Admin
 */
@WebServlet("/search")
public class SearchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        if (keyword == null || keyword.trim().isEmpty()) {
            resp.sendRedirect("index.jsp");
            return;
        }

        try {
            List<Card> cards = CardDAO.searchByKeyword(keyword);
            List<Relic> relics = RelicDAO.searchByKeyword(keyword);
            List<CardBack> cardbacks = CardBackDAO.searchByKeyword(keyword);
            List<Post> posts = PostDAO.searchByKeyword(keyword);

            req.setAttribute("cards", cards);
            req.setAttribute("relics", relics);
            req.setAttribute("cardbacks", cardbacks);
            req.setAttribute("posts", posts);
            req.setAttribute("keyword", keyword);

            req.getRequestDispatcher("searchResult.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "⚠️ Lỗi khi tìm kiếm.");
            req.getRequestDispatcher("index.jsp").forward(req, resp);
        }
    }
}





