<%@page import="d.CardDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Card" %>
<%
  String code = request.getParameter("code");
  Card card = CardDAO.getCardByCode(code);
  if (card == null) {
    response.sendRedirect("card.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Sửa thẻ bài</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
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
    <h2>✏️ Sửa thông tin thẻ bài</h2>
    <form method="post" action="editCard">
      <!-- Mã thẻ bài: hiển thị nhưng không cho sửa -->
      <input type="hidden" name="cardCode" value="<%= card.getCardCode() %>">
      <div class="mb-3">
        <label>Mã thẻ bài</label>
        <input type="text" class="form-control" value="<%= card.getCardCode() %>" readonly>
      </div>

      <div class="mb-3">
        <label>Tên thẻ bài</label>
        <input type="text" name="name" class="form-control" value="<%= card.getName() %>" required>
      </div>

      <div class="mb-3">
        <label>Mô tả</label>
        <textarea name="descriptionRaw" class="form-control" rows="3"><%= card.getDescriptionRaw() %></textarea>
      </div>

      <div class="mb-3">
  <label>Độ hiếm</label>
  <select name="rarity" class="form-select glass-select">
    <option value="Common" <%= card.getRarityRef().equals("Common") ? "selected" : "" %>>Common</option>
    <option value="Rare" <%= card.getRarityRef().equals("Rare") ? "selected" : "" %>>Rare</option>
    <option value="Epic" <%= card.getRarityRef().equals("Epic") ? "selected" : "" %>>Epic</option>
    <option value="Champion" <%= card.getRarityRef().equals("Champion") ? "selected" : "" %>>Champion</option>
  </select>
</div>

      <div class="mb-3">
        <label>Khu vực</label>
        <input type="text" name="regionRefs" class="form-control" value="<%= card.getRegionRefs() %>">
      </div>

      <div class="mb-3">
        <label>Mana</label>
        <input type="number" name="cost" class="form-control" value="<%= card.getCost() %>">
      </div>

      <div class="mb-3">
        <label>Loại bài</label>
        <input type="text" name="type" class="form-control" value="<%= card.getType() %>">
      </div>

      <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="price" class="form-control" value="<%= card.getPrice() %>">
      </div>

      <button type="submit" class="btn btn-primary">💾 Lưu thay đổi</button>
      <a href="<%= request.getContextPath() %>/cards" class="btn btn-secondary">⬅️ Quay lại</a>
    </form>
  </div>
</body>
</html>
