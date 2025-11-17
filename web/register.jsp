<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String success = (String) request.getAttribute("success");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng ký</title>
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
  <div class="wrapper d-flex justify-content-center align-items-center min-vh-100">
    <div class="login-box p-4 rounded shadow" style="width: 100%; max-width: 500px;">
      <h2 class="text-center mb-4">Tạo tài khoản mới</h2>

      <% if (success != null) { %>
        <div class="alert alert-success text-center"><%= success %></div>
      <% } else if (error != null) { %>
        <div class="alert alert-danger text-center"><%= error %></div>
      <% } %>

      <form action="register-step1" method="POST">
        <div class="mb-3">
          <label for="username" class="form-label">Tên đăng nhập</label>
          <input type="text" class="form-control" id="username" name="username" placeholder="Tên đăng nhập" required>
        </div>
        <div class="mb-3">
          <label for="email" class="form-label">Email</label>
          <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
        </div>
        <div class="mb-3">
          <label for="password" class="form-label">Mật khẩu</label>
          <div class="password-wrapper">
            <input type="password" id="password" name="password" class="form-control" placeholder="Mật khẩu" required>
            <span class="toggle-eye" onclick="togglePassword('password', this)">🔓️</span>
          </div>
        </div>
          <div class="mb-3">
  <label for="confirmPassword" class="form-label">Xác nhận mật khẩu</label>
  <div class="password-wrapper">
    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu" required>
    <span class="toggle-eye" onclick="togglePassword('confirmPassword', this)">🔓️</span>
  </div>
</div>

        <button type="submit" class="btn btn-glow w-100 mt-3">Đăng ký</button>
      </form>

      <p class="text-center mt-4 mb-0">
        Đã có tài khoản? <a href="login.jsp" class="text-warning">Đăng nhập ngay</a>
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
