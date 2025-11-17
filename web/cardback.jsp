<%@ page import="java.util.*, java.io.*, model.CardBack" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CartItem" %>
<%
    List<CardBack> allCards = (List<CardBack>) request.getAttribute("allCardBacks");
    if (allCards == null) {
    allCards = new ArrayList<>();
}
    String username = (String) session.getAttribute("username");
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("cardback.jsp");
        return;
        
    }
%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
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
  String message = (String) session.getAttribute("message");
  if (message != null) {
%>
  <div class="alert alert-info"><%= message %></div>
<%
    session.removeAttribute("message");
  }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lưng thẻ bài</title>
    <!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Select2 -->
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="assets/style.css">
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
        <li class="nav-item"><a class="nav-link" href="#">Lịch sử nạp</a></li>
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
  <li class="nav-item"><a class="nav-link" href="logout">Đăng xuất</a></li>
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
<!-- Bộ lọc thẻ bài -->
<div class="container mb-4">
    <div class="glass-filter p-3">
  <div class="row justify-content-center text-center g-3">
    

    <!-- Độ hiếm -->
    <div class="col-6 col-md-3">
  <select id="filter-rarity" class="glass-select" style="width:100%">
    <option value="">-- Độ hiếm --</option>
    <option value="Common" data-image="images/dohiem/Common.png">Thường</option>
    <option value="Rare" data-image="images/dohiem/Rare.png">Hiếm</option>
    <option value="Epic" data-image="images/dohiem/Epic.png">Sử thi</option>
  </select>
</div>

<% if (isAdmin) { %>
  <!-- Nút thêm + ô tìm kiếm -->
  <div class="col-12 col-md-6 d-flex align-items-center gap-2">
    <a href="addCardBack" class="btn btn-success flex-shrink-0">➕ Thêm lưng bài</a>
    <input type="text" id="filter-name" class="form-control" placeholder="🔍 Tìm theo tên lưng bài...">
  </div>
<% } else { %>
  <!-- Chỉ ô tìm kiếm nếu không phải admin -->
  <div class="col-12 col-md-6">
    <input type="text" id="filter-name" class="form-control" placeholder="🔍 Tìm theo tên lưng bài...">
  </div>
<% } %>

  </div>
</div>
</div>
    <div class="container py-5">
        <h2 id="card-count" class="text-center text-light mb-4">Tổng số lưng bài: <%= allCards.size() %></h2>

        <div class="row justify-content-center g-4">
            <% for (CardBack card : allCards) {
                String code = card.getCode();
    String imagePath = card.getImage();
    String rarity = card.getRarity() != null ? card.getRarity().trim() : "None";
    String description = card.getDescription();
    int price = card.getPrice();

            %>
            <div class="col-md-6 col-lg-4 col-xl-3 card-item"
     data-rarity="<%= rarity.toLowerCase() %>"
     data-name="<%= code.toLowerCase() %>">

                <div class="glass-card h-100 text-center">
                    <img src="<%= imagePath %>" alt="<%= code %>" class="img-fluid card-img">
                    <h5 class="card-title"><%= code %></h5>
                    <p class="price">Giá: <%= String.format("%,d", price) %> Xu</p>
                    
                    <div class="d-flex flex-wrap justify-content-center gap-2 mt-2 button-row">

<% if (username != null) { 
     if (!card.isPurchased()) { %>
       <!-- Nếu chưa mua: hiện nút mua và giỏ -->
       <form method="post" class="button-wrapper"
             onsubmit="event.preventDefault(); checkBalanceBeforeConfirm('<%= code %>', <%= price %>, <%= balance != null ? balance : 0 %>)">
         <button type="submit" class="btn btn-success">🛒 Mua ngay</button>
       </form>
       <form method="POST" action="cart" class="button-wrapper w-100">
         <input type="hidden" name="itemCode" value="<%= code %>">
         <input type="hidden" name="itemName" value="<%= code %>">
         <input type="hidden" name="price" value="<%= card.getPrice() %>">
         <input type="hidden" name="itemType" value="cardback">
         <button type="submit" class="btn btn-sm btn-outline-light w-100">➕ Thêm vào giỏ</button>
       </form>
     <% } else { %>
       <!-- Nếu đã mua: hiện thông báo -->
       <div class="alert alert-info w-100 text-center">✅ Bạn đã mua lưng bài này rồi.</div>
     <% } 
   } else { %>
     <!-- Chưa đăng nhập: hiện nút đăng nhập -->
     <form method="get" action="login.jsp" class="button-wrapper">
       <input type="hidden" name="redirect" value="checkout.jsp?cardCode=<%= code %>">
       <button type="submit" class="btn btn-warning">Đăng nhập để mua</button>
     </form>
<% } %>




  <form method="get" action="CardBackDetailController" class="button-wrapper">
  <input type="hidden" name="cardBackCode" value="<%= code %>">
  <button type="submit" class="btn btn-info">Chi tiết</button>
</form>


  <% if (isAdmin) { %>
    <form method="get" action="editCardBack" class="button-wrapper">
      <input type="hidden" name="code" value="<%= code %>">
      <button type="submit" class="btn btn-warning">Sửa</button>
    </form>

    <form method="get" action="deleteCardBack" class="button-wrapper"
          onsubmit="return confirm('Bạn có chắc muốn xóa thẻ bài này không?')">
      <input type="hidden" name="code" value="<%= code %>">
      <button type="submit" class="btn btn-danger">Xóa</button>
    </form>
  <% } %>
</div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
<script>
$(document).ready(function () {
  function formatOption(option) {
    if (!option.id) return option.text;
    const img = $(option.element).data('image');
    if (!img) return option.text;
    return $('<span><img src="' + img + '" style="height:20px; margin-right:8px;">' + option.text + '</span>');
  }

  $('#filter-rarity' ).select2({
    templateResult: formatOption,
    templateSelection: formatOption,
    minimumResultsForSearch: Infinity
  });

  

  const filters = {
    rarity: document.getElementById("filter-rarity"),
    name: document.getElementById("filter-name")
  };

  const cards = document.querySelectorAll(".card-item");

  function applyFilters() {
  const rarity = filters.rarity.value.toLowerCase();
  const name = filters.name.value.toLowerCase();

  let visibleCount = 0;

  cards.forEach(card => {
    const matchRarity = !rarity || card.dataset.rarity.includes(rarity);
    const matchName = !name || card.dataset.name.includes(name);

    const isVisible = matchRarity && matchName;
    card.style.display = isVisible ? "block" : "none";

    if (isVisible) visibleCount++;
  });

  document.getElementById("card-count").textContent = "Tổng số lưng bài: " + visibleCount;
}



  Object.values(filters).forEach(input => {
    input.addEventListener("input", applyFilters);
    input.addEventListener("change", applyFilters);
  });

  $('#filter-region, #filter-rarity, #filter-mana, #filter-type').on('change', applyFilters);
});
</script>
<!-- Modal xác nhận -->
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
        <form method="post" action="purchase-cardback" class="w-100">
          <input type="hidden" name="cardBackCode" id="modalCardCode">
          <input type="hidden" name="confirm" value="true">
          <input type="hidden" name="returnPage" value="detail-cardback.jsp">
          <input type="hidden" name="showSuccess" value="true">
          <button type="submit" class="btn btn-success w-100">✅ Đồng ý mua</button>
        </form>
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

<script>
function showConfirmModal(cardCode, name, description, price) {
  document.getElementById("modalBody").innerHTML = `
    <p>Bạn có chắc muốn mua vật phẩm này ?</p>
    <p><em>${description}</em></p>
  `;
  document.getElementById("modalCardCode").value = cardCode;
  const modal = new bootstrap.Modal(document.getElementById("confirmModal"));
  modal.show();
}
</script>
<script>
function openConfirmModal(cardCode) {
  document.getElementById("modalCardCode").value = cardCode;
  const modal = new bootstrap.Modal(document.getElementById("confirmModal"));
  modal.show();
}
</script>
<script>
function closeSuccessAlert() {
  const alertBox = document.getElementById("successAlert");
  if (alertBox) alertBox.style.display = "none";
}
</script>
<script>
function checkBalanceBeforeConfirm(cardCode, price, balance) {
  if (balance < price) {
    const modal = new bootstrap.Modal(document.getElementById("insufficientModal"));
    modal.show();
    return;
  }
  openConfirmModal(cardCode);
}
</script>
</body>
</html>
