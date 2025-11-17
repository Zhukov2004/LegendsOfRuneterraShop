<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String message = (String) request.getAttribute("message");
  if (message == null) message = "❌ Không có thông báo.";
%>
<!DOCTYPE html>
<html>
<head>
  <title>Kết quả nạp xu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/style.css" rel="stylesheet" type="text/css"/>
  <style>
    
    body {
  background-color: #0f0f0f;
  color: #f1f1f1;
  font-family: 'Segoe UI', sans-serif;
}
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.result-box {
  animation: fadeIn 0.6s ease-out;
}

.result-box {
  max-width: 500px;
  margin: 100px auto;
  padding: 30px;
  background-color: #1c1c1c; /* nền tối */
  box-shadow: 0 0 30px rgba(0, 255, 255, 0.2); /* bóng đổ xanh lam nhẹ */
  border-radius: 12px;
  text-align: center;
  border: 1px solid rgba(255,255,255,0.05);
  transition: transform 0.3s ease;
  color: #fff;
}

.result-box:hover {
  transform: scale(1.02);
  box-shadow: 0 0 40px rgba(0, 255, 255, 0.3);
}

.result-box h3 {
  margin-bottom: 20px;
  color: #fff; /* chữ xanh lam nổi bật */
}

.btn-primary {
  background-color: #007bff;
  border: none;
}

.btn-outline-secondary {
  border-color: #aaa;
  color: #ddd;
}

.btn-outline-secondary:hover {
  background-color: #333;
  color: #fff;
}

  </style>
</head>
<body>
  <div class="result-box">
    <h3><%= message %></h3>
    <div class="d-grid gap-2">
      <a href="index.jsp" class="btn btn-primary">🏠 Về trang chủ</a>
      <a href="topup.jsp" class="btn btn-outline-secondary">🔄 Quay lại trang nạp</a>
    </div>
  </div>
</body>
</html>
