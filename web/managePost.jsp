<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.Post, d.PostDAO" %>
<%
    List<Post> posts = PostDAO.getAllPosts();
    String role = (String) session.getAttribute("role");
    boolean isAdmin = "admin".equals(role);
    if (!isAdmin) {
        response.sendRedirect("index.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý bài viết</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .table
        {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-runeterra">
    <div class="container">
      <a class="navbar-brand" href="index.jsp">
        <img src="images/images/logo.png" alt="Runeterra" style="height: 32px;">
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="index.jsp">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="topup.jsp">Nạp tiền</a></li>
          <li class="nav-item"><a class="nav-link" href="history">Lịch sử mua</a></li>
          <li class="nav-item"><a class="nav-link" href="topup-history.jsp">Lịch sử nạp</a></li>
          <li class="nav-item"><a class="nav-link" href="cart.jsp">Giỏ hàng</a></li>
          <%
  Integer balance = (Integer) session.getAttribute("balance");
%>
<% if (username != null) { %>
  <li class="nav-item">
    <a class="nav-link text-warning">
      Xin chào, <strong><%= username %></strong> | 💰 <strong><%= String.format("%,d", balance) %> Xu</strong>
    </a>
  </li>
  <li class="nav-item"><a class="nav-link" href="?logout=true">Đăng xuất</a></li>
<% } else { %>

            <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
            <li class="nav-item"><a class="nav-link" href="register.jsp">Đăng ký</a></li>
          <% } %>
            <% if ("admin".equals(username) || isAdmin) { %>
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle text-danger" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
      🛠 Quản trị nội dung
    </a>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="categories.jsp">📁 Chỉnh sửa danh mục</a></li>
      <li><a class="dropdown-item" href="managePost.jsp">📝 Chỉnh sửa bài viết</a></li>
    </ul>
  </li>
<% } %>

        </ul>
      </div>
    </div>
  </nav>
<div class="container mt-5">
    <h2>🛠 Quản lý bài viết</h2>
    <div class="mb-3 text-end">
    <a href="addPost.jsp" class="btn btn-success">
        ➕ Thêm bài viết mới
    </a>
</div>

    <table class="table table-bordered table-hover mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tiêu đề</th>
                <th>Danh mục</th>
                <th>Tác giả</th>
                <th>Ngày tạo</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <% for (Post p : posts) { %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getTitle() %></td>
                <td><%= p.getCategoryName() %></td>
                <td><%= p.getAuthor() %></td>
                <td><%= p.getCreatedAt() %></td>
                <td>
                    <a href="editPost.jsp?id=<%= p.getId() %>" class="btn btn-warning btn-sm">✏️ Sửa</a>
                    <a href="deletePost?id=<%= p.getId() %>" class="btn btn-danger btn-sm"
                       onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')">🗑 Xóa</a>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
