<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    int total = 0;
    int itemCount = 0;
%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
  String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Giỏ hàng</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  
  <link rel="stylesheet" href="assets/style.css">
</head>
<body class="bg-dark text-white">
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
<div class="container py-5">
  <h2 class="text-center mb-4">🛒 Giỏ hàng của bạn</h2>

  <div class="table-responsive mx-auto" style="max-width: 900px;">
    <table class="table table-dark table-striped text-center align-middle">
      <thead>
        <tr>
          <th>Tên vật phẩm</th>
          <th>Giá</th>
          <th>Số lượng</th>
          <th>Tổng</th>
          <th>Thao tác</th>
        </tr>
      </thead>
      <tbody>
        <% if (cart != null && !cart.isEmpty()) {
            for (CartItem item : cart) {
                int itemTotal = item.getPrice() * item.getQuantity();
                total += itemTotal;
                itemCount += item.getQuantity();
        %>
        <tr>
          <td>
  <img src="<%= item.getImagePath() %>" alt="<%= item.getItemName() %>" 
       style="width:100px; height:140px; object-fit:cover; margin-right:8px;">
  <%= item.getItemName() %>
</td>

          <td><%= String.format("%,d", item.getPrice()) %> Xu</td>
          <td><%= item.getQuantity() %></td>
          <td><%= String.format("%,d", itemTotal) %> Xu</td>
          <td>
            <form method="POST" action="remove-cart">
              <input type="hidden" name="itemCode" value="<%= item.getItemCode() %>">
              <button type="submit" class="btn btn-sm btn-danger">🗑️</button>
            </form>
              <!-- Nút mua ngay -->
  <form method="POST" action="purchase" style="display:inline-block; margin-left:5px;">
    <input type="hidden" name="itemCode" value="<%= item.getItemCode() %>">
    <input type="hidden" name="itemName" value="<%= item.getItemName() %>">
    <input type="hidden" name="price" value="<%= item.getPrice() %>">
    <input type="hidden" name="quantity" value="<%= item.getQuantity() %>">
    <input type="hidden" name="itemType" value="<%= item.getItemType() %>">
    <button type="button" class="btn btn-sm btn-success"
        onclick="openConfirmModal('<%= item.getItemCode() %>', '<%= item.getItemType() %>')">
  🛒 Mua ngay
</button>
  </form>
          </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5">Giỏ hàng trống.</td></tr>
        <% } %>
      </tbody>
    </table>
  </div>

  <% if (cart != null && !cart.isEmpty()) { %>
    <h4 class="text-center mt-4">
      Tổng cộng: <%= String.format("%,d", total) %> Xu (<%= itemCount %> vật phẩm)
    </h4>
    <div class="d-flex justify-content-center mt-3">
      <form method="POST" action="checkout">
  <button type="submit" class="btn btn-success px-4">✅ Thanh toán</button>
</form>

    </div>
  <% } %>
</div>
<div class="modal fade" id="confirmModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content bg-dark text-white">
      <div class="modal-header">
        <h5 class="modal-title">Xác nhận mua</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <p>Bạn có chắc muốn mua vật phẩm này?</p>
      </div>
      <div class="modal-footer">
        <form method="post" id="modalForm" class="w-100">
  <input type="hidden" id="modalItemCode"> <!-- chỉ có id, name sẽ set bằng JS -->
  <input type="hidden" name="confirm" value="true">
  <input type="hidden" name="returnPage" value="cart.jsp">
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
        <p>Hãy kiểm tra mục <strong>Lịch sử mua</strong> để xem chi tiết giao dịch.</p>
      </div>
    </div>
  </div>
</div>

<script>
    function openConfirmModal(itemCode, itemType) {
  const form = document.getElementById("modalForm");
  const hiddenInput = document.getElementById("modalItemCode");

  hiddenInput.value = itemCode;

  if (itemType === "card") {
    form.action = "purchase";
    hiddenInput.name = "cardCode";       // servlet đọc cardCode
  } else if (itemType === "relic") {
    form.action = "purchase-relic";
    hiddenInput.name = "relicCode";      // servlet đọc relicCode
  } else if (itemType === "cardback") {
    form.action = "purchase-cardback";
    hiddenInput.name = "cardBackCode";   // servlet đọc cardBackCode
  }

  const modal = new bootstrap.Modal(document.getElementById("confirmModal"));
  modal.show();
}

</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<% if (request.getAttribute("showSuccessModal") != null) { %>
<script>
document.addEventListener("DOMContentLoaded", function() {
  const successModal = new bootstrap.Modal(document.getElementById("successModal"));
  successModal.show();
});
</script>
<% } %>

</body>
</html>
