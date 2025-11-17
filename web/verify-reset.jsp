<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Xác thực mã OTP</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
  <style>
    .otp-input {
      width: 40px;
      height: 50px;
      text-align: center;
      font-size: 24px;
      margin: 0 5px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    .otp-group {
      display: flex;
      justify-content: center;
      gap: 5px;
    }
  </style>
</head>
<body>
<div class="container mt-5">
  <h2 class="text-center mb-4">Xác thực mã OTP</h2>

  <% if (error != null) { %>
    <div class="alert alert-danger text-center"><%= error %></div>
  <% } %>

  <form action="verify-reset" method="POST" class="mx-auto" style="max-width: 400px;" onsubmit="combineOTP()">
    <div class="mb-3 text-center">
      <label class="form-label mb-2">Nhập mã xác thực gồm 6 chữ số</label>
      <div class="otp-group">
        <input type="text" maxlength="1" class="otp-input" id="otp1" required>
        <input type="text" maxlength="1" class="otp-input" id="otp2" required>
        <input type="text" maxlength="1" class="otp-input" id="otp3" required>
        <input type="text" maxlength="1" class="otp-input" id="otp4" required>
        <input type="text" maxlength="1" class="otp-input" id="otp5" required>
        <input type="text" maxlength="1" class="otp-input" id="otp6" required>
      </div>
    </div>
    <input type="hidden" name="otpInput" id="otpInput">
    <button type="submit" class="btn btn-success w-100">Xác nhận</button>
  </form>
</div>

<script>
  const inputs = document.querySelectorAll('.otp-input');
  inputs.forEach((input, index) => {
    input.addEventListener('input', () => {
      if (input.value.length === 1 && index < inputs.length - 1) {
        inputs[index + 1].focus();
      }
    });
    input.addEventListener('keydown', (e) => {
      if (e.key === "Backspace" && input.value === "" && index > 0) {
        inputs[index - 1].focus();
      }
    });
  });

  function combineOTP() {
    const otp = Array.from(inputs).map(i => i.value).join('');
    document.getElementById('otpInput').value = otp;
  }
</script>
</body>
</html>
