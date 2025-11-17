<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.CardBack, d.CardBackDAO" %>
<%
  String code = request.getParameter("code");

  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
  CardBackDAO dao = new CardBackDAO(conn);
  CardBack cb = dao.getByCode(code);
  conn.close();

  if (cb == null) {
    response.sendRedirect("cardbacks.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Sửa lưng bài</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/style.css" rel="stylesheet" type="text/css"/>
  <style>
      .glass-select {
  background: rgba(255, 255, 255, 0.15);
  border: 1px solid rgba(255, 255, 255, 0.3);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-radius: 12px;
  color: #fff;
  font-weight: bold;
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.glass-select option {
  background: rgba(0, 0, 0, 0.6);
  color: #fff;
}

  </style>
</head>
<body>
  <div class="container mt-4">
    <h2>🎴 Sửa thông tin lưng bài</h2>
    <form method="post" action="editCardBack">
      <!-- Mã lưng bài (không sửa được) -->
      <input type="hidden" name="code" value="<%= cb.getCode() %>">
      <div class="mb-3">
        <label>Mã lưng bài</label>
        <input type="text" class="form-control" value="<%= cb.getCode() %>" readonly>
      </div>

      <!-- Link ảnh -->
      <div class="mb-3">
        <label>Link ảnh</label>
        <input type="text" name="image" class="form-control" value="<%= cb.getImage() %>" required>
      </div>

      <!-- Độ hiếm -->
      <div class="mb-3">
  <label>Độ hiếm</label>
  <select name="rarity" class="form-select glass-select">
    <option value="Common" <%= cb.getRarity().equals("Common") ? "selected" : "" %>>Common</option>
    <option value="Rare" <%= cb.getRarity().equals("Rare") ? "selected" : "" %>>Rare</option>
    <option value="Epic" <%= cb.getRarity().equals("Epic") ? "selected" : "" %>>Epic</option>n>
  </select>
</div>


      <!-- Mô tả -->
      <div class="mb-3">
        <label>Mô tả</label>
        <textarea name="description" class="form-control" rows="3"><%= cb.getDescription() %></textarea>
      </div>

      <!-- Giá -->
      <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="price" class="form-control" value="<%= cb.getPrice() %>">
      </div>

      <!-- Nút lưu -->
      <button type="submit" class="btn btn-primary">💾 Lưu thay đổi</button>
      <a href="CardBackController" class="btn btn-secondary">⬅️ Quay lại</a>
    </form>
  </div>
</body>
</html>
