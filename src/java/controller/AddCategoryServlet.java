package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Category;
import d.CategoryDAO;

@WebServlet("/addCategory")
public class AddCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String slug = request.getParameter("slug");
        String description = request.getParameter("description");
        if (CategoryDAO.isSlugExists(slug, null)) {
    request.setAttribute("error", "Slug đã tồn tại. Vui lòng chọn slug khác.");
    request.getRequestDispatcher("addCategory.jsp").forward(request, response);
    return;
}
if (slug == null || slug.trim().isEmpty()) {
    request.setAttribute("error", "⚠️ Slug không được để trống.");
    
}

        Category cat = new Category();
        cat.setName(name);
        cat.setSlug(slug);
        cat.setDescription(description);

        CategoryDAO.insertCategory(cat);
        response.sendRedirect("categories.jsp");
    }
}
