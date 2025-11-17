<%@page import="model.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="model.Post, d.PostDAO, d.CategoryDAO, java.util.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Post post = PostDAO.getPostById(id);
    List<Category> categories = CategoryDAO.getAllCategories();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Sửa bài viết</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container mt-5">
    <h2>✏️ Sửa bài viết</h2>
    <form method="post" action="updatePost">
        <input type="hidden" name="id" value="<%= post.getId() %>">
        <div class="mb-3">
            <label>Tiêu đề</label>
            <input type="text" name="title" class="form-control" value="<%= post.getTitle() %>">
        </div>
        <div class="mb-3">
            <label>Danh mục</label>
            <select name="category_id" class="form-select">
                <% for (Category c : categories) { %>
                    <option value="<%= c.getId() %>" <%= c.getId() == post.getCategoryId() ? "selected" : "" %>>
                        <%= c.getName() %>
                    </option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label>Tác giả</label>
            <input type="text" name="author" class="form-control" value="<%= post.getAuthor() %>">
        </div>
        <div class="mb-3">
            <label>Mô tả</label>
            <textarea name="description" class="form-control"><%= post.getDescription() %></textarea>
        </div>
        <div class="mb-3">
            <label>Nội dung</label>
            <textarea name="content" class="form-control" rows="10"><%= post.getContent() %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">💾 Lưu thay đổi</button>
    </form>
</div>
</body>
</html>
