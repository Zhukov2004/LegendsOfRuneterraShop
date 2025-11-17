<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Card Back</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container mt-4">
    <h2>🃏 Thêm Card Back mới</h2>
    <form method="post" action="addCardBack">
        <div class="mb-3">
            <label for="code" class="form-label">Mã Card Back</label>
            <input type="text" class="form-control" name="code" id="code" required>
        </div>

        <div class="mb-3">
            <label for="image" class="form-label">Link ảnh</label>
            <input type="text" class="form-control" name="image" id="image" required>
        </div>

        <div class="mb-3">
            <label for="rarity" class="form-label">Độ hiếm</label>
            <select class="form-select" name="rarity" id="rarity">
                <option value="Common">Common</option>
                <option value="Rare">Rare</option>
                <option value="Epic">Epic</option>
                <option value="Legendary">Legendary</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="description" class="form-label">Mô tả</label>
            <textarea class="form-control" name="description" id="description" rows="3"></textarea>
        </div>

        <div class="mb-3">
            <label for="price" class="form-label">Giá</label>
            <input type="number" class="form-control" name="price" id="price" required>
        </div>

        <button type="submit" class="btn btn-success">➕ Thêm Card Back</button>
        <a href="cardbacks" class="btn btn-secondary">⬅️ Quay lại danh sách</a>
    </form>
</div>
</body>
</html>
