<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập - Runeterra Shop</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
  <style>
.password-wrapper {
  position: relative;
}

.password-wrapper input {
  padding-right: 40px; /* chừa chỗ cho icon */
}

.toggle-eye {
  position: absolute;
  top: 50%;
  right: 10px;
  transform: translateY(-50%);
  cursor: pointer;
  font-size: 18px;
  color: #888;
}
</style>

</head>
<body>
  <div class="wrapper d-flex justify-content-center align-items-center min-vh-100">
    <div class="login-box p-4 rounded shadow" style="width: 100%; max-width: 500px;">
      <h2 class="text-center mb-4">Đăng nhập</h2>

      <% if (error != null) { %>
        <div class="alert alert-danger text-center"><%= error %></div>
      <% } %>

      <form action="login" method="POST">
        <div class="mb-3">
          <label for="username" class="form-label">Tên đăng nhập</label>
          <input type="text" class="form-control" id="username" name="username" required>
        </div>
        <div class="mb-3">
          <label for="password" class="form-label">Mật khẩu</label>
<div class="password-wrapper">
  <input type="password" id="password" name="password" class="form-control" placeholder="Mật khẩu" required>
  <span class="toggle-eye" onclick="togglePassword('password', this)">🔓</span>

</div>


        </div>
        <button type="submit" class="btn btn-glow w-100 mt-3">Đăng nhập</button>
      </form>

      <p class="text-center mt-4 mb-0">
        Chưa có tài khoản? <a href="register.jsp" class="text-warning">Đăng ký ngay</a>
      </p>
      <p class="text-center mt-2">
    <a href="forgot-password.jsp" class="text-danger">Quên mật khẩu?</a>
</p>

    </div>
  </div>
<script>
function togglePassword(id, icon) {
  const input = document.getElementById(id);
  if (input.type === "password") {
    input.type = "text";
    icon.textContent = "🔒";
  } else {
    input.type = "password";
    icon.textContent = "🔓️";
  }
}
</script>




</body>
</html>
