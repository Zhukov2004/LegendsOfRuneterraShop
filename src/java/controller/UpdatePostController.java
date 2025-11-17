/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import d.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Post;

/**
 *
 * @author Admin
 */
@WebServlet("/updatePost")
public class UpdatePostController extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String description = req.getParameter("description");
        String author = req.getParameter("author");
        int categoryId = Integer.parseInt(req.getParameter("category_id"));

        Post post = new Post();
        post.setId(id);
        post.setTitle(title);
        post.setContent(content);
        post.setDescription(description);
        post.setAuthor(author);
        post.setCategoryId(categoryId);

        PostDAO.updatePost(post);
        res.sendRedirect("managePost.jsp");
    }
}

