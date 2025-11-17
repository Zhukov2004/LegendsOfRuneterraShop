package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Category;
import d.CategoryDAO;

@WebServlet("/editCategory")
public class EditCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
Category cat = new Category();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String slug = request.getParameter("slug");
        String description = request.getParameter("description");
        if (CategoryDAO.isSlugExists(slug, id)) {
    request.setAttribute("error", "Slug đã tồn tại. Vui lòng chọn slug khác.");
    request.setAttribute("category", cat);
    request.getRequestDispatcher("editCategory.jsp").forward(request, response);
    return;
}
if (slug == null || slug.trim().isEmpty()) {
    request.setAttribute("error", "⚠️ Slug không được để trống.");
    request.setAttribute("category", cat);
    request.getRequestDispatcher("editCategory.jsp").forward(request, response);
}

        
        cat.setId(id);
        cat.setName(name);
        cat.setSlug(slug);
        cat.setDescription(description);

        CategoryDAO.updateCategory(cat);
        response.sendRedirect("categories.jsp");
    }
}
