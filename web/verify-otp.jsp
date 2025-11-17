<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
    String email = (String) session.getAttribute("pendingEmail");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác thực email</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/style.css">
    <style>
  .otp-input {
    width: 40px;
    height: 50px;
    font-size: 24px;
    text-align: center;
    border: 2px solid #ccc;
    border-radius: 6px;
  }
</style>

</head>
<body>
    <div class="wrapper d-flex justify-content-center align-items-center min-vh-100">
        <div class="login-box p-4 rounded shadow">
            <h2 class="text-center mb-4">🔐 Xác thực email</h2>

            <% if (error != null) { %>
                <div class="alert alert-danger text-center"><%= error %></div>
            <% } %>

            <p class="text-center">Mã xác thực đã gửi đến email: <strong><%= email %></strong></p>

            <form action="register-step2" method="post" class="d-flex justify-content-center gap-2">
  <input type="text" maxlength="1" class="otp-input" name="otp1" required>
  <input type="text" maxlength="1" class="otp-input" name="otp2" required>
  <input type="text" maxlength="1" class="otp-input" name="otp3" required>
  <input type="text" maxlength="1" class="otp-input" name="otp4" required>
  <input type="text" maxlength="1" class="otp-input" name="otp5" required>
  <input type="text" maxlength="1" class="otp-input" name="otp6" required>

  <input type="hidden" name="otpInput" id="otpInput">
  <button type="submit" class="btn btn-glow ms-3">Xác nhận</button>
</form>

        </div>
    </div>
</body>
<script>
  const inputs = document.querySelectorAll(".otp-input");
  const hiddenInput = document.getElementById("otpInput");

  inputs.forEach((input, index) => {
    input.addEventListener("input", () => {
      if (input.value.length === 1 && index < inputs.length - 1) {
        inputs[index + 1].focus();
      }
      updateHiddenInput();
    });

    input.addEventListener("keydown", (e) => {
      if (e.key === "Backspace" && input.value === "" && index > 0) {
        inputs[index - 1].focus();
      }
    });
  });

  function updateHiddenInput() {
    hiddenInput.value = Array.from(inputs).map(i => i.value).join("");
  }
</script>

</html>
