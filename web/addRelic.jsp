<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Thêm cổ vật</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
</head>
<body>
  <div class="container mt-4">
    <h2>🔮 Thêm cổ vật mới</h2>
    <form method="post" action="addRelic">
      <div class="mb-3">
        <label>Mã cổ vật</label>
        <input type="text" name="relicCode" class="form-control" required>
      </div>

      <div class="mb-3">
        <label>Tên cổ vật</label>
        <input type="text" name="name" class="form-control" required>
      </div>

      <div class="mb-3">
        <label>Mô tả</label>
        <textarea name="descriptionRaw" class="form-control" rows="3"></textarea>
      </div>

      <div class="mb-3">
        <label>Độ hiếm</label>
        <input type="text" name="rarity" class="form-control">
      </div>

      <div class="mb-3">
        <label>Giá</label>
        <input type="number" name="price" class="form-control">
      </div>

      <button type="submit" class="btn btn-success">➕ Thêm cổ vật</button>
      <a href="relics" class="btn btn-secondary">⬅️ Quay lại</a>
    </form>
  </div>
</body>
</html>
