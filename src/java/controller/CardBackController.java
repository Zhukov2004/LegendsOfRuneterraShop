/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import d.CardBackDAO;
import java.util.List;
import model.CardBack;
import java.sql.*;
/**
 *
 * @author Admin
 */
@WebServlet(name = "CardBackController", urlPatterns = {"/CardBackController"})
public class CardBackController extends HttpServlet {

    private CardBackDAO dao;

    @Override
    public void init() throws ServletException {
        try {
            // Kết nối CSDL
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/runeterra_shop", "root", ""
            );
            dao = new CardBackDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Không thể kết nối CSDL", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        String action = req.getParameter("action");
        String code = req.getParameter("code");
        String keyword = req.getParameter("keyword");
        String error = req.getParameter("error");
if (error != null) {
    switch (error) {
        case "notfound":
            req.setAttribute("error", "⚠️ Không tìm thấy lưng bài.");
            break;
        case "notenough":
            req.setAttribute("error", "⚠️ Không đủ Xu để mua lưng bài này.");
            break;
        case "usernotfound":
            req.setAttribute("error", "⚠️ Không tìm thấy người dùng.");
            break;
        default:
            req.setAttribute("error", "⚠️ Đã xảy ra lỗi.");
    }
}

String showSuccess = req.getParameter("showSuccess");
if ("true".equals(showSuccess)) {
    req.setAttribute("showSuccessModal", Boolean.TRUE);
}


        try {
            if ("detail".equals(action) && code != null) {
    String username = (String) req.getSession().getAttribute("username");
    CardBack card;
    if (username != null) {
        card = CardBackDAO.getCardBackByCode(code, username); // ✅ có purchased flag
    } else {
        card = dao.getByCode(code); // fallback nếu chưa login
    }
    req.setAttribute("card", card);
    req.getRequestDispatcher("/card_back_detail.jsp").forward(req, resp);
}
 else if ("search".equals(action) && keyword != null) {
                List<CardBack> results = dao.searchByKeyword(keyword);
                req.setAttribute("cards", results);
                req.getRequestDispatcher("/card_back_list.jsp").forward(req, resp);

            } else {
    String username = (String) req.getSession().getAttribute("username");
    List<CardBack> list;
    if (username != null) {
        list = CardBackDAO.getAllCardBacksForUser(username); // ✅ có purchased flag
    } else {
        list = dao.getAll();
    }
    req.setAttribute("allCardBacks", list);
    req.getRequestDispatcher("/cardback.jsp").forward(req, resp);
}

        } catch (Exception e) {
            throw new ServletException("Lỗi xử lý GET", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
        throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            if ("add".equals(action)) {
                CardBack card = extractCard(req);
                dao.insert(card);
                resp.sendRedirect("CardBackController");

            } else if ("update".equals(action)) {
                CardBack card = extractCard(req);
                dao.update(card);
                resp.sendRedirect("CardBackController?action=detail&code=" + card.getCode());

            } else if ("delete".equals(action)) {
                String code = req.getParameter("code");
                dao.delete(code);
                resp.sendRedirect("CardBackController");
            }
        } catch (Exception e) {
            throw new ServletException("Lỗi xử lý POST", e);
        }
    }

    private CardBack extractCard(HttpServletRequest req) {
        String code = req.getParameter("code");
        String image = req.getParameter("image");
        String rarity = req.getParameter("rarity");
        String description = req.getParameter("description");
        int price = Integer.parseInt(req.getParameter("price"));
        return new CardBack(code, image, rarity, description, price);
    }
    
}
