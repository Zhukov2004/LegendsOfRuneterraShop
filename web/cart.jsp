<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    int total = 0;
    int itemCount = 0;
%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
  String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Giỏ hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
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
  <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
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
<div class="container py-5">
  <h2 class="text-center mb-4">🛒 Giỏ hàng của bạn</h2>

  <div class="table-responsive mx-auto" style="max-width: 900px;">
    <table class="table table-dark table-striped text-center align-middle">
      <thead>
        <tr>
          <th>Tên vật phẩm</th>
          <th>Giá</th>
          <th>Số lượng</th>
          <th>Tổng</th>
          <th>Thao tác</th>
        </tr>
      </thead>
      <tbody>
        <% if (cart != null && !cart.isEmpty()) {
            for (CartItem item : cart) {
                int itemTotal = item.getPrice() * item.getQuantity();
                total += itemTotal;
                itemCount += item.getQuantity();
        %>
        <tr>
          <td>
  <img src="<%= item.getImagePath() %>" alt="<%= item.getItemName() %>" 
       style="width:100px; height:140px; object-fit:cover; margin-right:8px;">
  <%= item.getItemName() %>
</td>

          <td><%= String.format("%,d", item.getPrice()) %> Xu</td>
          <td><%= item.getQuantity() %></td>
          <td><%= String.format("%,d", itemTotal) %> Xu</td>
          <td>
            <form method="POST" action="remove-cart">
              <input type="hidden" name="itemCode" value="<%= item.getItemCode() %>">
              <button type="submit" class="btn btn-sm btn-danger">🗑️</button>
            </form>
              <!-- Nút mua ngay -->
  <form method="POST" action="purchase" style="display:inline-block; margin-left:5px;">
    <input type="hidden" name="itemCode" value="<%= item.getItemCode() %>">
    <input type="hidden" name="itemName" value="<%= item.getItemName() %>">
    <input type="hidden" name="price" value="<%= item.getPrice() %>">
    <input type="hidden" name="quantity" value="<%= item.getQuantity() %>">
    <input type="hidden" name="itemType" value="<%= item.getItemType() %>">
    <button type="submit" class="btn btn-sm btn-success">🛒 Mua ngay</button>
  </form>
          </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5">Giỏ hàng trống.</td></tr>
        <% } %>
      </tbody>
    </table>
  </div>

  <% if (cart != null && !cart.isEmpty()) { %>
    <h4 class="text-center mt-4">
      Tổng cộng: <%= String.format("%,d", total) %> Xu (<%= itemCount %> vật phẩm)
    </h4>
    <div class="d-flex justify-content-center mt-3">
      <form method="POST" action="checkout">
  <button type="submit" class="btn btn-success px-4">✅ Thanh toán</button>
</form>

    </div>
  <% } %>
</div>
</body>
</html>
