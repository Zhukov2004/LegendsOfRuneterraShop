<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Đặt lại mật khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/style.css">
    <style>
    .password-wrapper {
      position: relative;
    }
    .password-wrapper input {
      padding-right: 40px;
    }
    .toggle-eye {
      position: absolute;
      top: 50%;
      right: 10px;
      transform: translateY(-50%);
      cursor: pointer;
      font-size: 18px;
      color: #888;
      user-select: none;
    }
  </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Đặt lại mật khẩu</h2>

    <% String error = (String) request.getAttribute("error"); %>
    <% if (error != null) { %>
        <div class="alert alert-danger text-center"><%= error %></div>
    <% } %>
<% String success = (String) request.getAttribute("success"); %>
<% if (success != null) { %>
  <div class="alert alert-success text-center"><%= success %></div>
<% } %>

    <form action="reset-password" method="POST" class="mx-auto" style="max-width: 400px;">
        <div class="mb-3">
            <label for="newPassword" class="form-label">Mật khẩu mới</label>
            <div class="password-wrapper">
  <input type="password" id="password" name="newPassword" class="form-control" placeholder="Mật khẩu" required>
  <span class="toggle-eye" onclick="togglePassword('password', this)">🔓</span>

</div>
        </div>
        <div class="mb-3">
  <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
  <div class="password-wrapper">
    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
    <span class="toggle-eye" onclick="togglePassword('confirmPassword', this)">🔓️</span>
  </div>
</div>

        <button type="submit" class="btn btn-warning w-100">Cập nhật mật khẩu</button>
    </form>
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
document.querySelector("form").addEventListener("submit", function(e) {
  const pw = document.getElementById("password").value;
  const confirm = document.getElementById("confirmPassword").value;
  if (pw !== confirm) {
    e.preventDefault();
    alert("⚠️ Mật khẩu không khớp. Vui lòng kiểm tra lại.");
  }
});
</script>
</body>
</html>
