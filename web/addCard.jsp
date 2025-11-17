<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Card" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Thêm thẻ bài</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
</head>
<body>
  <div class="container mt-4">
    <h2>🃏 Thêm thẻ bài mới</h2>
    <form method="post" action="addCard">
      <div class="mb-3">
        <label>Mã thẻ bài</label>
        <input type="text" name="cardCode" class="form-control" required>
      </div>

      <div class="mb-3">
        <label>Tên thẻ bài</label>
        <input type="text" name="name" class="form-control" required>
      </div>

      <div class="mb-3">
        <label>Mô tả</label>
        <textarea name="descriptionRaw" class="form-control" rows="3"></textarea>
      </div>

      <div class="mb-3">
        <label>Độ hiếm</label>
        <input type="text" name="rarityRef" class="form-control">
      </div>

      <div class="mb-3">
        <label>Khu vực</label>
        <input type="text" name="regionRefs" class="form-control">
      </div>

      <div class="mb-3">
        <label>Mana</label>
        <input type="number" name="cost" class="form-control">
      </div>

      <div class="mb-3">
        <label>Loại bài</label>
        <input type="text" name="type" class="form-control">
      </div>

      <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="price" class="form-control">
      </div>

      <button type="submit" class="btn btn-success">➕ Thêm thẻ bài</button>
      <a href="<%= request.getContextPath() %>/cards" class="btn btn-secondary">⬅️ Quay lại</a>
    </form>
  </div>
</body>
</html>
