<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Category" %>
<%@ page import="d.CategoryDAO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Category cat = CategoryDAO.getCategoryById(id);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa chuyên mục</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container mt-4">
    <h2>✏️ Sửa chuyên mục</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
<% } %>

    <form method="post" action="editCategory">
        <input type="hidden" name="id" value="<%= cat.getId() %>">
        <div class="mb-3">
            <label>Tên chuyên mục</label>
            <input type="text" name="name" class="form-control" value="<%= cat.getName() %>" required>
        </div>
        <div class="mb-3">
            <label>Slug</label>
            <input type="text" name="slug" class="form-control" value="<%= cat.getSlug() %>" required>
        </div>
        <div class="mb-3">
            <label>Mô tả</label>
            <textarea name="description" class="form-control" rows="3"><%= cat.getDescription() %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">💾 Cập nhật</button>
        <a href="categories.jsp" class="btn btn-secondary">⬅️ Quay lại</a>
    </form>
</div>
</body>
</html>
