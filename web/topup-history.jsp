<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String username = (String) session.getAttribute("username");
  String role = (String) session.getAttribute("role");

  if (username == null) {
%>
  <div class="alert alert-danger text-center mt-5">
    ❌ Bạn chưa đăng nhập. Vui lòng <a href="login.jsp">đăng nhập</a>.
  </div>
<% return; } %>
<%
  boolean isAdmin = "admin".equals(role);
%>
<!DOCTYPE html>
<html>
<head>
  <title>Lịch sử nạp xu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
          <li class="nav-item"><a class="nav-link" href="#">Lịch sử nạp</a></li>
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
<div class="container py-4">
  <h2 class="text-center mb-4">📜 Lịch sử nạp xu</h2>
  <table class="table table-bordered table-striped table-dark">
    <thead>
      <tr>
        <th>#</th>
        <th>Người dùng</th>
        <th>Phương thức</th>
        <th>Mệnh giá</th>
        <th>Mã giao dịch</th>
        <th>Trạng thái</th>
        <th>Thời gian</th>
      </tr>
    </thead>
    <tbody>
<%
  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

    String sql = "SELECT * FROM topup_log";
    if (!"admin".equals(role)) {
      sql += " WHERE username = ?";
    }
    sql += " ORDER BY created_at DESC";

    PreparedStatement stmt = conn.prepareStatement(sql);
    if (!"admin".equals(role)) {
      stmt.setString(1, username);
    }

    ResultSet rs = stmt.executeQuery();
    int count = 1;
    while (rs.next()) {
%>
      <tr>
        <td><%= count++ %></td>
        <td><%= rs.getString("username") %></td>
        <td><%= rs.getString("method") %></td>
        <td><%= String.format("%,d", rs.getInt("amount")) %> VNĐ</td>
        <td><%= rs.getString("code") %></td>
        <td><%= rs.getString("status") %></td>
        <td><%= rs.getTimestamp("created_at") %></td>
      </tr>
<%
    }
    rs.close();
    stmt.close();
    conn.close();
  } catch (Exception e) {
%>
    <tr><td colspan="7">❌ Lỗi: <%= e.getMessage() %></td></tr>
<%
  }
%>
    </tbody>
  </table>
</div>
</body>
</html>
