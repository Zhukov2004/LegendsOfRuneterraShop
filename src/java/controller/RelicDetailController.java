package controller;

import d.RelicDAO;
import model.Relic;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/detail-relic")
public class RelicDetailController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String relicCode = request.getParameter("relicCode");
        if (relicCode == null || relicCode.isEmpty()) {
            response.sendRedirect("relics");
            return;
        }

        String username = (String) request.getSession().getAttribute("username");
        Relic relic;
        if (username != null) {
            relic = RelicDAO.getRelicByCode(relicCode, username); // ✅ có purchased flag
        } else {
            relic = RelicDAO.getRelicByCode(relicCode); // fallback nếu chưa login
        }

        if (relic == null) {
            request.setAttribute("error", "⚠️ Không tìm thấy cổ vật.");
            RequestDispatcher rd = request.getRequestDispatcher("relics.jsp");
            rd.forward(request, response);
            return;
        }

        request.setAttribute("relic", relic);
        RequestDispatcher rd = request.getRequestDispatcher("detail-relic.jsp");
        rd.forward(request, response);
    }
}

