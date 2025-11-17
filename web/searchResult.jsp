<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="d.PostDAO"%>
<%@page import="model.Post"%>
<%@page import="d.CardBackDAO"%>
<%@page import="d.RelicDAO"%>
<%@page import="d.CardDAO"%>
<%@page import="model.CardBack"%>
<%@page import="model.Relic"%>
<%@page import="model.Card"%>
<%@page import="java.util.List"%>
<%@ page import="model.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Card, model.Relic, model.CardBack, model.Post" %>
<%
    String username = (String) session.getAttribute("username");
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }
%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
%>
<html>
<head>
    <title>Kết quả tìm kiếm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
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
<div class="container mt-4">
<h2>Kết quả tìm kiếm cho: "<%= request.getAttribute("keyword") %>"</h2>
<% List<Card> cards = (List<Card>) request.getAttribute("cards"); %>
<% List<Relic> relics = (List<Relic>) request.getAttribute("relics"); %>
<% List<CardBack> cardbacks = (List<CardBack>) request.getAttribute("cardbacks"); %>
<% List<Post> posts = (List<Post>) request.getAttribute("posts"); %>

<h3>🃏 Lá bài</h3>
<div class="row">
    <% for(Card c : cards){ %>
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <img src="images/anh/<%= c.getCardCode() %>.png" class="card-img-top" alt="<%= c.getName() %>">
            <div class="card-body text-center">
                <h5 class="card-title"><%= c.getName() %></h5>
                <p class="card-text text-danger"><strong><%= c.getPrice() %> Xu</strong></p>
                <a href="CardDetail?code=<%= c.getCardCode() %>" class="btn btn-info btn-sm">Xem chi tiết</a>
                <a href="AddToCart?type=card&code=<%= c.getCardCode() %>" class="btn btn-success btn-sm">Mua</a>
            </div>
        </div>
    </div>
    <% } %>
</div>

<h3>🔮 Relic</h3>
<div class="row">
    <% for(Relic r : relics){ %>
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <img src="images/relics/<%= r.getRelicCode() %>.png" class="card-img-top" alt="<%= r.getName() %>">
            <div class="card-body text-center">
                <h5 class="card-title"><%= r.getName() %></h5>
                <p class="card-text text-danger"><strong><%= r.getPrice() %> Xu</strong></p>
                <a href="RelicDetail?code=<%= r.getRelicCode() %>" class="btn btn-info btn-sm">Xem chi tiết</a>
                <a href="AddToCart?type=relic&code=<%= r.getRelicCode() %>" class="btn btn-success btn-sm">Mua</a>
            </div>
        </div>
    </div>
    <% } %>
</div>

<h3>🎴 Lưng bài</h3>
<div class="row">
    <% for(CardBack cb : cardbacks){ %>
    <div class="col-md-3 mb-4">
        <div class="card h-100">
            <img src="images/cardback/<%= cb.getCode() %>.png" class="card-img-top" alt="<%= cb.getCode() %>">
            <div class="card-body text-center">
                <h5 class="card-title"><%= cb.getCode() %></h5>
                <p class="card-text text-danger"><strong><%= cb.getPrice() %> Xu</strong></p>
                <a href="CardBackDetail?code=<%= cb.getCode() %>" class="btn btn-info btn-sm">Xem chi tiết</a>
                <a href="AddToCart?type=cardback&code=<%= cb.getCode() %>" class="btn btn-success btn-sm">Mua</a>
            </div>
        </div>
    </div>
    <% } %>
</div>


<h3>📝 Bài viết</h3>
<div class="row">
<% for(Post p : posts){ %>
    <div class="col-md-4 mb-4">
        <div class="card h-100">
            <!-- Ảnh thumbnail -->
            <img src="<%= p.getThumbnail() %>" class="card-img-top" alt="<%= p.getTitle() %>">
            
            <div class="card-body">
                <!-- Tiêu đề -->
                <h5 class="card-title"><%= p.getTitle() %></h5>
                <!-- Mô tả ngắn -->
                <p class="card-text"><%= p.getDescription() %></p>
                <!-- Ngày tạo -->
                <p class="text-muted"><i class="fa fa-calendar"></i> <%= p.getCreatedAt() %></p>
                <!-- Nút xem chi tiết -->
                <a href="viewPost.jsp?id=<%= p.getId() %>" class="btn btn-info btn-sm">Xem chi tiết</a>
            </div>
        </div>
    </div>
<% } %>
</div>
<a href="index.jsp" class="btn btn-secondary mt-3">⬅ Quay lại trang chủ</a>

</div>
</body>
</html>
