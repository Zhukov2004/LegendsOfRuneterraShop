package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import d.CategoryDAO;

@WebServlet("/deleteCategory")
public class DeleteCategoryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            CategoryDAO.deleteCategory(id);
        }
        response.sendRedirect("categories.jsp");
    }
}
