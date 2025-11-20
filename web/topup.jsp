<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String username = (session != null) ? (String) session.getAttribute("username") : null;
  Integer balance = (session != null && session.getAttribute("balance") != null)
    ? (Integer) session.getAttribute("balance")
    : 0;

%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Nạp xu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <link href="assets/style.css" rel="stylesheet" type="text/css"/>
  <style>
    body { background-color: #1c1c1c; color: #fff; }
    .topup-box { background-color: #2c2c2c; border-radius: 10px; padding: 30px; }
    .method-card, .amount-card {
      background-color: #333; border-radius: 8px; padding: 15px; cursor: pointer; transition: 0.3s;
      text-align: center;
    }
    .method-card:hover, .amount-card:hover { background-color: #444; }
    .method-card.active, .amount-card.active { border: 2px solid #0d6efd; }
    .price-table th, .price-table td { color: #fff; }
    .d-none { display: none !important; }
    #amountOptions { min-height: 180px; transition: all 0.3s ease; }
    .topup-box {
  background-color: rgba(44, 44, 44, 0.7); /* nền mờ */
  border-radius: 10px;
  padding: 30px;
  box-shadow: 0 0 30px rgba(0, 0, 0, 0.6); /* shadow mềm */
  backdrop-filter: blur(8px); /* hiệu ứng mờ nền sau */
  -webkit-backdrop-filter: blur(8px); /* hỗ trợ Safari */
}

  </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-runeterra">
    <div class="container">
      <a class="navbar-brand" href="index.jsp">
        <img src="images/images/logo.png" alt="Runeterra" style="height: 32px;">
      </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="index.jsp">Trang chủ</a></li>
          <li class="nav-item"><a class="nav-link" href="topup.jsp">Nạp tiền</a></li>
          <li class="nav-item"><a class="nav-link" href="history">Lịch sử mua</a></li>
          <li class="nav-item"><a class="nav-link" href="topup-history.jsp">Lịch sử nạp</a></li>
          <li class="nav-item"><a class="nav-link" href="cart.jsp">Giỏ hàng</a></li>
          <%
%>
<% if (username != null) { %>
  <li class="nav-item">
    <a class="nav-link text-warning">
      Xin chào, <strong><%= username %></strong> | 💰 <strong><%= String.format("%,d", balance) %> Xu</strong>
    </a>
  </li>
  <li class="nav-item"><a class="nav-link" href="?logout=true">Đăng xuất</a></li>
<% } else { %>

            <li class="nav-item"><a class="nav-link" href="login.jsp">Đăng nhập</a></li>
            <li class="nav-item"><a class="nav-link" href="register.jsp">Đăng ký</a></li>
          <% } %>
            <% if ("admin".equals(username) || isAdmin) { %>
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle text-danger" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
      🛠 Quản trị nội dung
    </a>
    <ul class="dropdown-menu">
      <li><a class="dropdown-item" href="categories.jsp">📁 Chỉnh sửa danh mục</a></li>
      <li><a class="dropdown-item" href="managePost.jsp">📝 Chỉnh sửa bài viết</a></li>
    </ul>
  </li>
<% } %>

        </ul>
      </div>
    </div>
  </nav>
<div class="container my-5">
    
  <h2 class="text-center mb-4">💰 Nạp tiền vào tài khoản</h2>

  <div class="topup-box">
    <!-- Chọn phương thức thanh toán -->
    <h5 class="mb-3">📌 Chọn phương thức thanh toán</h5>
    <div class="row g-3 mb-4">
      <div class="col-md-4"><div class="method-card active" data-method="card">💳 Mã thẻ</div></div>
      <div class="col-md-4"><div class="method-card" data-method="qr">📱 QR Ngân hàng</div></div>
      <div class="col-md-4"><div class="method-card" data-method="bank">🏦 Chuyển khoản</div></div>
      <div class="col-md-4"><div class="method-card" data-method="momo">🟣 Ví Momo</div></div>
      <div class="col-md-4"><div class="method-card" data-method="shopeepay">🟠 ShopeePay</div></div>
      <div class="col-md-4"><div class="method-card" data-method="zalopay">🔵 ZaloPay</div></div>
    </div>

    <!-- Bảng giá -->
    <div id="priceTables">
      <div id="price-card" class="mb-4">
        <h6 class="mb-2">? Bảng giá nạp bằng mã thẻ</h6>
        <table class="table table-bordered table-dark text-center price-table">
          <thead><tr><th>Mệnh giá</th><th>Xu nhận</th><th>Ưu đãi</th></tr></thead>
          <tbody>
            <tr><td>10.000 VNĐ</td><td>10.000 Xu</td><td>Không</td></tr>
            <tr><td>20.000 VNĐ</td><td>20.000 Xu</td><td>+5%</td></tr>
            <tr><td>50.000 VNĐ</td><td>50.000 Xu</td><td>+10%</td></tr>
          </tbody>
        </table>
      </div>

      <!-- 📱 QR Ngân hàng -->
  <div id="price-qr" class="mb-4 d-none">
    <h6 class="mb-2">📱 Bảng giá nạp qua QR ngân hàng</h6>
    <div class="row g-3">
      <div class="col-md-4"><div class="amount-card" data-value="50000">50.000 VNĐ<br><small>52.500 Xu – +5%</small></div></div>
      <div class="col-md-4"><div class="amount-card" data-value="100000">100.000 VNĐ<br><small>110.000 Xu – +10%</small></div></div>
      <div class="col-md-4"><div class="amount-card" data-value="200000">200.000 VNĐ<br><small>230.000 Xu – +15%</small></div></div>
    </div>
    <div class="text-center mt-3" id="qr-info">
      <img id="qrImage" src="" style="width: 450px;" class="mx-auto d-block rounded d-none">
<p class="mt-2">Quét mã QR bằng ứng dụng ngân hàng để chuyển khoản.</p>

    </div>
  </div>

  <!-- 🏦 Chuyển khoản -->
  <div id="price-bank" class="mb-4 d-none">
    <h6 class="mb-2">🏦 Bảng giá chuyển khoản ngân hàng</h6>
    <div class="row g-3">
      <div class="col-md-4"><div class="amount-card" data-value="100000">100.000 VNĐ<br><small>120.000 Xu – +20%</small></div></div>
      <div class="col-md-4"><div class="amount-card" data-value="200000">200.000 VNĐ<br><small>250.000 Xu – +25%</small></div></div>
      <div class="col-md-4"><div class="amount-card" data-value="500000">500.000 VNĐ<br><small>650.000 Xu – +30%</small></div></div>
    </div>
    <div class="mt-3" id="bank-info">
      <h6 class="mb-2">🏦 Thông tin chuyển khoản</h6>
      <ul class="list-group list-group-flush">
        <li class="list-group-item bg-dark text-white">Ngân hàng: MB Bank</li>
        <li class="list-group-item bg-dark text-white">Số tài khoản: 9378513062004</li>
        <li class="list-group-item bg-dark text-white">Chủ tài khoản: Bùi Hải Đăng</li>
        <li class="list-group-item bg-dark text-white">Nội dung: <strong>napxu [tên người dùng]</strong></li>
      </ul>
    </div>
  </div>

  <!-- 🟣 Momo -->
  <div id="price-momo" class="mb-4 d-none">
    <h6 class="mb-2">🟣 Nạp qua ví Momo</h6>
    <div class="row g-3">
      <div class="col-md-4"><div class="amount-card" data-value="100000">100.000 VNĐ<br><small>100.000 Xu</small></div></div>
    </div>
    <img src="images/qr/momo-100000.png" style="width: 450px;" class="mx-auto d-block rounded mb-3">
    <p class="mt-2">Quét mã bằng Momo và nhập nội dung: <strong>napxu [tên người dùng]</strong></p>
  </div>

  <!-- 🟠 ShopeePay -->
  <div id="price-shopeepay" class="mb-4 d-none">
    <h6 class="mb-2">🟠 Nạp qua ShopeePay</h6>
    <div class="row g-3">
      <div class="col-md-4"><div class="amount-card" data-value="100000">100.000 VNĐ<br><small>100.000 Xu</small></div></div>
    </div>
    <img src="images/qr/shopeepay-100000.png" style="width: 450px;" class="mx-auto d-block rounded mb-3">
    <p class="mt-2">Quét mã bằng ShopeePay và nhập nội dung: <strong>napxu [tên người dùng]</strong></p>
  </div>

  <!-- 🔵 ZaloPay -->
  <div id="price-zalopay" class="mb-4 d-none">
    <h6 class="mb-2">🔵 Nạp qua ZaloPay</h6>
    <div class="row g-3">
      <div class="col-md-4"><div class="amount-card" data-value="100000">100.000 VNĐ<br><small>100.000 Xu</small></div></div>
    </div>
    <img src="images/qr/zalopay-100000.png" style="width: 450px;" class="mx-auto d-block rounded mb-3">
    <p class="mt-2">Quét mã bằng ZaloPay và nhập nội dung: <strong>napxu [tên người dùng]</strong></p>
  </div>

    </div>

    <!-- Chọn mệnh giá -->
    <h6 class="mb-2">🎯 Chọn mệnh giá</h6>
    <div class="row g-3 mb-4" id="amountOptions"></div>

    <!-- Nhập mã giao dịch -->
    <form method="post" action="topup" >
      <input type="hidden" name="method" id="methodInput" value="card">
      <input type="hidden" name="amount" id="amountInput" value="10000">

      <div class="mb-3">
        <label class="form-label" id="inputLabel">Mã thẻ</label>
        <input type="text" name="code" class="form-control" required>
      </div>

      <button type="submit" class="btn btn-success w-100">✅ Nạp ngay</button>
    </form>
  </div>
</div>
 
<!-- Modal kết quả nạp xu -->
<div class="modal fade" id="topupModal" tabindex="-1" aria-labelledby="topupModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content bg-dark text-white">
      <div class="modal-header">
        <h5 class="modal-title" id="topupModalLabel">Kết quả nạp xu</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Đóng"></button>
      </div>
      <div class="modal-body" id="topupModalBody">
        <!-- Nội dung kết quả sẽ được gán bằng JS -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

</body>
<script>
const methodCards = document.querySelectorAll(".method-card");
const methodInput = document.getElementById("methodInput");
const amountInput = document.getElementById("amountInput");
const inputLabel = document.getElementById("inputLabel");
const amountOptions = document.getElementById("amountOptions");

const priceTables = {
  card: document.getElementById("price-card"),
  qr: document.getElementById("price-qr"),
  bank: document.getElementById("price-bank"),
  momo: document.getElementById("price-momo"),
  shopeepay: document.getElementById("price-shopeepay"),
  zalopay: document.getElementById("price-zalopay")
};

const priceValues = {
  card: [10000, 20000, 50000],
  qr: [50000, 100000, 200000],
  bank: [100000, 200000, 500000],
  momo: [100000],
  shopeepay: [100000],
  zalopay: [100000]
};

function renderAmounts(method) {
  amountOptions.innerHTML = "";
  priceValues[method].forEach((val) => {
    const div = document.createElement("div");
    div.className = "col-md-4";
    const card = document.createElement("div");
    card.className = "amount-card";
    card.setAttribute("data-value", val);
    card.textContent = val.toLocaleString() + " VNĐ";
    card.onclick = () => selectAmount(val);
    div.appendChild(card);
    amountOptions.appendChild(div);
  });
}

function selectAmount(val) {
  amountInput.value = val;

  document.querySelectorAll(".amount-card").forEach(el => el.classList.remove("active"));
  document.querySelectorAll(".amount-card").forEach(el => {
    if (parseInt(el.dataset.value) === val) {
      el.classList.add("active");
    }
  });
}

methodCards.forEach(card => {
  card.addEventListener("click", () => {
    const method = card.dataset.method;
    methodInput.value = method;

    inputLabel.innerText = method === "card"
      ? "Mã thẻ"
      : method === "qr"
      ? "Mã giao dịch QR"
      : "Mã giao dịch ngân hàng";

    methodCards.forEach(c => c.classList.remove("active"));
    card.classList.add("active");

    Object.values(priceTables).forEach(table => table.classList.add("d-none"));
    priceTables[method]?.classList.remove("d-none");

    ["qr-info", "bank-info", "price-momo", "price-shopeepay", "price-zalopay"].forEach(id => {
      const el = document.getElementById(id);
      if (el) el.classList.add("d-none");
    });
    
    if (method === "qr") document.getElementById("qr-info").classList.remove("d-none");
    if (method === "bank") document.getElementById("bank-info").classList.remove("d-none");
    if (method === "momo") document.getElementById("price-momo").classList.remove("d-none");
    if (method === "shopeepay") document.getElementById("price-shopeepay").classList.remove("d-none");
    if (method === "zalopay") document.getElementById("price-zalopay").classList.remove("d-none");

    renderAmounts(method);
  });
});

// Khởi tạo mặc định
document.querySelector('.method-card[data-method="card"]').click();
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("amount-card")) {
    const value = parseInt(e.target.dataset.value);
    amountInput.value = value;

    document.querySelectorAll(".amount-card").forEach(el => el.classList.remove("active"));
    e.target.classList.add("active");
  }
});
document.addEventListener("click", function (e) {
  if (e.target.classList.contains("amount-card")) {
    const value = parseInt(e.target.dataset.value);
    if (!isNaN(value)) {
      amountInput.value = value;

      // Bỏ chọn tất cả
      document.querySelectorAll(".amount-card").forEach(el => el.classList.remove("active"));

      // Chọn duy nhất thẻ vừa click
      e.target.classList.add("active");
    }
  }
});
function selectAmount(val) {
  amountInput.value = val;

  document.querySelectorAll(".amount-card").forEach(el => el.classList.remove("active"));
  document.querySelectorAll(".amount-card").forEach(el => {
    if (parseInt(el.dataset.value) === val) {
      el.classList.add("active");
    }
  });

  // Gắn link QR động
  const username = "<%= username %>";
  const qrImage = document.getElementById("qrImage");
  qrImage.src = `https://img.vietqr.io/image/MB-9378513062004-compact.png?amount=${val}&addInfo=napxu+${username}`;
  
  // Hiện ảnh QR sau khi chọn
  qrImage.classList.remove("d-none");
}


</script>
