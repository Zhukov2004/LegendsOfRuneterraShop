/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;
import d.RelicDAO;
import jakarta.servlet.RequestDispatcher;
import model.Relic;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet("/relics")
public class RelicListController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = (String) request.getSession().getAttribute("username");

        List<Relic> relics;
        if (username != null) {
            relics = RelicDAO.getAllRelicsForUser(username); // ✅ check purchased
        } else {
            relics = RelicDAO.getAllRelics(); // fallback nếu chưa login
        }
        request.setAttribute("relics", relics);

        RequestDispatcher rd = request.getRequestDispatcher("relic.jsp");
        rd.forward(request, response);
    }
}

