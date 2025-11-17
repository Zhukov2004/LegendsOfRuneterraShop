<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Relic, d.RelicDAO" %>
<%
  String code = request.getParameter("code");
  Relic relic = RelicDAO.getRelicByCode(code);
  if (relic == null) {
    response.sendRedirect("relics.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Sửa cổ vật</title>
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
    <h2>🔮 Sửa thông tin cổ vật</h2>
    <form method="post" action="editRelic">
      <!-- Mã cổ vật: hiển thị nhưng không cho sửa -->
      <input type="hidden" name="relicCode" value="<%= relic.getRelicCode() %>">
      <div class="mb-3">
        <label>Mã cổ vật</label>
        <input type="text" class="form-control" value="<%= relic.getRelicCode() %>" readonly>
      </div>

      <div class="mb-3">
        <label>Tên cổ vật</label>
        <input type="text" name="name" class="form-control" value="<%= relic.getName() %>" required>
      </div>

      <div class="mb-3">
        <label>Mô tả</label>
        <textarea name="descriptionRaw" class="form-control" rows="3"><%= relic.getDescriptionRaw() %></textarea>
      </div>

      <div class="mb-3">
  <label>Độ hiếm</label>
  <select name="rarity" class="form-select glass-select">
    <option value="Common" <%= relic.getRarity().equals("Common") ? "selected" : "" %>>Common</option>
    <option value="Rare" <%= relic.getRarity().equals("Rare") ? "selected" : "" %>>Rare</option>
    <option value="Epic" <%= relic.getRarity().equals("Epic") ? "selected" : "" %>>Epic</option>
  </select>
</div>

      <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="price" class="form-control" value="<%= relic.getPrice() %>">
      </div>

      <button type="submit" class="btn btn-primary">💾 Lưu thay đổi</button>
      <a href="<%= request.getContextPath() %>/relics" class="btn btn-secondary">⬅️ Quay lại</a>
    </form>
  </div>
</body>
</html>
