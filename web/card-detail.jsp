<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Card" %>
<%
    Card card = (Card) request.getAttribute("card");
    String username = (String) session.getAttribute("username");
    
%>
<% Boolean showSuccessModal = (Boolean) request.getAttribute("showSuccessModal"); %>
<% if (showSuccessModal != null && showSuccessModal) { %>
  <script>
    window.addEventListener("DOMContentLoaded", function() {
      const modal = new bootstrap.Modal(document.getElementById("successModal"));
      modal.show();
    });
  </script>
<% } %>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
%>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Chi tiết lá bài - <%= card.getName() %></title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
  <style>
    
    .card-detail {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(12px);
      border-radius: 20px;
      border: 1px solid rgba(255, 255, 255, 0.3);
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
      padding: 30px;
      color: #fff;
      min-height: 500px;
    }

    .info-box p {
      font-size: 1.1rem;
      margin-bottom: 0.75rem;
    }
    .btn-back {
      margin-top: 20px;
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container">
    <a class="navbar-brand" href="index.jsp">
      <img src="images/images/logo.png" alt="Runeterra" style="height: 40px;">
    </a>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="index.jsp">Trang chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="topup.jsp">Nạp tiền</a></li>
        <li class="nav-item"><a class="nav-link" href="history">Lịch sử mua</a></li>
        <li class="nav-item"><a class="nav-link" href="cart.jsp">Giỏ hàng</a></li>
        <%
  Integer balance = (Integer) session.getAttribute("balance");
%>
<% if (username != null) { %>
  <li class="nav-item">
    <a class="nav-link text-warning">
      Xin chào, <strong><%= username %></strong> | 💰 <strong><%= String.format("%,d", balance) %> Xu</strong>
    </a>
  </li>
  <a class="nav-link" href="?logout=true&redirect=card-detail.jsp?cardCode=<%= card.getCardCode() %>">Đăng xuất</a>
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

<!-- Chi tiết lá bài -->
<div class="container my-5">
  <div class="row justify-content-center align-items-center">
    <div class="col-lg-10 card-detail">
      <div class="row">
        <!-- Ảnh lá bài -->
    <div class="col-lg-6 text-center">
      <img src="images/anh/<%= card.getCardCode() %>.png" alt="Ảnh lá bài" class="card-img">
    </div>

        <!-- Thông tin -->
        <div class="col-lg-6 info-box">
          <h2 class="text-center"><%= card.getName() %></h2>
          <p><strong>Mô tả:</strong> <%= card.getDescriptionRaw() %></p>
          <p><strong>Vùng:</strong> <%= card.getRegionRefs().toString().replaceAll("[\\[\\]']", "") %></p>
          <p><strong>Độ hiếm:</strong> <%= card.getRarityRef() %></p>
          <p><strong>Loại bài:</strong> <%= card.getType() %></p>
          <p><strong>Mana:</strong> <%= card.getCost() %></p>
          <p><strong>Giá:</strong> <%= String.format("%,d", card.getPrice()) %> Xu</p>
          <div class="d-flex justify-content-center gap-2 mt-3">
  <% if (username != null) { 
     if (!card.isPurchased()) { %>
       <!-- Nếu chưa mua: hiển thị nút mua và thêm giỏ -->
       <form method="post" class="flex-grow-1"
             onsubmit="event.preventDefault(); checkBalanceBeforeConfirm('<%= card.getCardCode() %>', <%= card.getPrice() %>, <%= balance != null ? balance : 0 %>)">
         <button type="submit" class="btn btn-success w-100">🛒 Mua ngay</button>
       </form>
       <form method="post" action="cart" class="flex-grow-1">
         <input type="hidden" name="itemCode" value="<%= card.getCardCode() %>">
         <input type="hidden" name="itemName" value="<%= card.getName() %>">
         <input type="hidden" name="price" value="<%= card.getPrice() %>">
         <button type="submit" class="btn btn-outline-light w-100">➕ Thêm vào giỏ</button>
       </form>
     <% } else { %>
       <!-- Nếu đã mua: hiển thị thông báo -->
       <div class="alert alert-info w-100 text-center">✅ Bạn đã mua lá bài này rồi.</div>
     <% } 
   } else { %>
     <!-- Chưa đăng nhập: hiển thị nút đăng nhập -->
     <form method="get" action="login.jsp" class="flex-grow-1">
       <input type="hidden" name="redirect" value="card-detail.jsp?cardCode=<%= card.getCardCode() %>">
       <button type="submit" class="btn btn-warning w-100">🔐 Đăng nhập để mua</button>
     </form>
<% } %>


  <!-- Nút quay lại -->
  <form method="get" action="cards" class="flex-grow-1">
    <button type="submit" class="btn btn-info w-100">⬅ Quay lại</button>
  </form>
</div>

        </div>
      </div>
    </div>
  </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<div class="modal fade" id="confirmModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content bg-dark text-white">
      <div class="modal-header">
        <h5 class="modal-title">Xác nhận mua vật phẩm</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <p>Bạn có chắc muốn mua vật phẩm này?</p>
      </div>
      <div class="modal-footer">
        <form method="post" action="purchase" class="w-100">
          <input type="hidden" name="cardCode" id="modalCardCode">
          <input type="hidden" name="confirm" value="true">
          <input type="hidden" name="returnPage" value="card-detail.jsp">
          <input type="hidden" name="showSuccess" value="true">
          <button type="submit" class="btn btn-success w-100">✅ Đồng ý mua</button>
        </form>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="successModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content bg-success text-white">
      <div class="modal-header">
        <h5 class="modal-title">🎉 Mua thành công!</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <p>Bạn đã mua vật phẩm thành công.</p>
        <p>Hãy kiểm tra mục <strong>Lịch sử mua</strong> để xem chi tiết giao dịch của bạn.</p>
      </div>
    </div>
  </div>
</div>
<div class="modal fade" id="insufficientModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content bg-danger text-white">
      <div class="modal-header">
        <h5 class="modal-title">⚠️ Không đủ Xu</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <p>Bạn không đủ Xu để mua vật phẩm này.</p>
        <p>Vui lòng nạp thêm hoặc chọn vật phẩm khác.</p>
      </div>
      <div class="modal-footer justify-content-center">
        <a href="topup.jsp" class="btn btn-light">💳 Nạp tiền ngay</a>
        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Đóng</button>
      </div>
    </div>
  </div>
</div>

<script>
function checkBalanceBeforeConfirm(cardCode, price, balance) {
  if (balance < price) {
    const modal = new bootstrap.Modal(document.getElementById("insufficientModal"));
    modal.show();
    return;
  }
  document.getElementById("modalCardCode").value = cardCode;
  const modal = new bootstrap.Modal(document.getElementById("confirmModal"));
  modal.show();
}
</script>


</body>

</html>
