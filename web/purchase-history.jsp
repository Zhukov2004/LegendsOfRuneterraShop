<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Purchase" %>
<%@ page import="java.util.List" %>
<%
    String username = (String) session.getAttribute("username");
  String role = (String) session.getAttribute("role");
    List<Purchase> cardPurchases = (List<Purchase>) request.getAttribute("cardPurchases");
    List<Purchase> relicPurchases = (List<Purchase>) request.getAttribute("relicPurchases");
    List<Purchase> cardBackPurchases = (List<Purchase>) request.getAttribute("cardBackPurchases");
%>
<%
  boolean isAdmin = "admin".equals(role);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lịch sử mua</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
</head>
<body class="bg-dark text-white">
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
<div class="container my-5">
    <h2 class="text-center mb-4">📜
        Lịch sử mua lá bài</h2>
    <!-- 🔍 Form tìm kiếm -->
<form method="GET" action="history" class="row g-3 mb-4 align-items-end">
    <% if ("admin".equals(role)) { %>
        <div class="col-md-3">
            <label class="form-label text-white">Người mua</label>
            <input type="text" name="username" class="form-control" placeholder="Tìm theo người mua">
        </div>
    <% } %>
    <div class="col-md-3">
        <label class="form-label text-white">Từ ngày</label>
        <input type="date" name="fromDate" class="form-control">
    </div>
    <div class="col-md-3">
        <label class="form-label text-white">Đến ngày</label>
        <input type="date" name="toDate" class="form-control">
    </div>
    <div class="col-md-3">
        <button type="submit" class="btn btn-warning w-100">🔍 Tìm kiếm</button>
    </div>
</form>


    <table class="table table-dark table-striped">
        <thead>
            <tr>
                <% if ("admin".equals(role)) { %><th>Người mua</th><% } %>
                <th>Tên lá bài</th>
                <th>Giá</th>
                <th>Thời gian</th>
                
            </tr>
        </thead>
        <tbody>
            <% if (cardPurchases != null && !cardPurchases.isEmpty()) {
                for (Purchase p : cardPurchases) { %>
                <tr>
                    <% if ("admin".equals(role)) { %><td><%= p.getUsername() %></td><% } %>
                    <td><%= p.getItemName() %></td>
                    <td><%= String.format("%,d", p.getPrice()) %> Xu</td>
                    <td><%= p.getTime() %></td>
                </tr>
            <% }} else { %>
                <tr><td colspan="4">Không có lịch sử mua lá bài.</td></tr>
            <% } %>
        </tbody>
    </table>

    <h2 class="text-center my-4">📜 Lịch sử mua cổ vật</h2>
    <table class="table table-dark table-striped">
        <thead>
            <tr>
                <% if ("admin".equals(role)) { %><th>Người mua</th><% } %>
                <th>Tên cổ vật</th>
                <th>Giá</th>
                <th>Thời gian</th>
            </tr>
        </thead>
        <tbody>
            <% if (relicPurchases != null && !relicPurchases.isEmpty()) {
                for (Purchase p : relicPurchases) { %>
                <tr>
                    <% if ("admin".equals(role)) { %><td><%= p.getUsername() %></td><% } %>
                    <td><%= p.getItemName() %></td>
                    <td><%= String.format("%,d", p.getPrice()) %> Xu</td>
                    <td><%= p.getTime() %></td>
                </tr>
            <% }} else { %>
                <tr><td colspan="4">Không có lịch sử mua cổ vật.</td></tr>
            <% } %>
        </tbody>
    </table>

        <h2 class="text-center my-4">📜 Lịch sử mua lưng bài</h2>
<table class="table table-dark table-striped">
    <thead>
        <tr>
            <% if ("admin".equals(role)) { %><th>Người mua</th><% } %>
            <th>Tên lưng bài</th>
            <th>Giá</th>
            <th>Thời gian</th>
        </tr>
    </thead>
    <tbody>
        <% if (cardBackPurchases != null && !cardBackPurchases.isEmpty()) {
            for (Purchase p : cardBackPurchases) { %>
            <tr>
                <% if ("admin".equals(role)) { %><td><%= p.getUsername() %></td><% } %>
                <td><%= p.getItemName() %></td>
                <td><%= String.format("%,d", p.getPrice()) %> Xu</td>
                <td><%= p.getTime() %></td>
            </tr>
        <% }} else { %>
            <tr><td colspan="4">Không có lịch sử mua lưng bài.</td></tr>
        <% } %>
    </tbody>
</table>

    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-light">⬅ Quay về trang chủ</a>
    </div>
</div>
</body>
</html>
