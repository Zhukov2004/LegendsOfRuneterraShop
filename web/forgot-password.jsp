<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Quên mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/style.css">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Quên mật khẩu</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>

    <form action="forgot-password" method="POST" class="mx-auto" style="max-width: 400px;">
        <div class="mb-3">
            <label for="email" class="form-label">Nhập email của bạn</label>
            <input type="email" class="form-control" name="email" id="email" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Gửi mã xác thực</button>
    </form>
</div>
</body>
</html>
