<%@ page import="java.util.*, java.io.*, model.Card" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.CartItem" %>
<%
    List<Card> allCards = (List<Card>) request.getAttribute("allCards");
    if (allCards == null) {
    allCards = new ArrayList<>();
}
    String username = (String) session.getAttribute("username");
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("cards.jsp");
        return;
        
    }
%>
<%
    // Nhận tham số page từ URL, mặc định là 1
    String pageParam = request.getParameter("page");
    int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
    int pageSize = 12; // số lá bài mỗi trang

    // Tính tổng số trang
    int totalItems = allCards.size();
    int totalPages = (int) Math.ceil((double) totalItems / pageSize);

    // Lấy danh sách card cho trang hiện tại
    int start = (currentPage - 1) * pageSize;
    int end = Math.min(start + pageSize, totalItems);
    List<Card> pageCards = allCards.subList(start, end);
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
    <title>Danh sách thẻ bài</title>
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
    
    <!-- Khu vực -->
    <div class="col-6 col-md-3">
      <select id="filter-region" class="glass-select" style="width:100%">
  <option value="">Tất cả khu vực</option>
  <option value="Demacia" data-image="images/vung/Demacia.png">Demacia</option>
  <option value="Bilgewater" data-image="images/vung/Bilgewater.png">Bilgewater</option>
  <option value="Freljord" data-image="images/vung/Freljord.png">Freljord</option>
  <option value="Ionia" data-image="images/vung/Ionia.png">Ionia</option>
  <option value="Noxus" data-image="images/vung/Noxus.png">Noxus</option>
  <option value="PiltoverZaun" data-image="images/vung/Piltover_Zaun.png">Piltover & Zaun</option>
  <option value="Runeterra" data-image="images/vung/Runeterra.png">Runeterra</option>
  <option value="ShadowIsles" data-image="images/vung/Shadow_Isles.png">Quần đảo bóng đêm</option>
  <option value="Shurima" data-image="images/vung/Shurima.png">Shurima</option>
  <option value="Targon" data-image="images/vung/Targon.png">Targon</option>
  <option value="BandleCity" data-image="images/vung/Bandle_City.png">Thành phố Bandle</option>
  <option value="SpiritBlossom" data-image="images/vung/SpiritBlossom.png">Hoa Linh Lục Địa</option>
</select>

    </div>

    <!-- Độ hiếm -->
    <div class="col-6 col-md-3">
  <select id="filter-rarity" class="glass-select" style="width:100%">
    <option value="">-- Độ hiếm --</option>
    <option value="Common" data-image="images/dohiem/Common.png">Thường</option>
    <option value="Rare" data-image="images/dohiem/Rare.png">Hiếm</option>
    <option value="Epic" data-image="images/dohiem/Epic.png">Sử thi</option>
    <option value="Champion" data-image="images/dohiem/Champion.png">Tướng</option>
    <option value="None">Không rõ</option>
  </select>
</div>


    <!-- Mana -->
    <div class="col-6 col-md-3">
      <select id="filter-mana" class="form-select">
        <option value="">-- Mana --</option>
        <option value="0">0</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
        <option value="6">6</option>
        <option value="7">7</option>
        <option value="8">8</option>
        <option value="9+">9+</option>
      </select>
    </div>

    <!-- Loại bài -->
    <div class="col-6 col-md-3">
      <select id="filter-type" class="glass-select" style="width:100%">
        <option value="">-- Loại bài --</option>
        <option value="Bài quân" data-image="images/images/Unit.png">Bài quân</option>
        <option value="Bài phép" data-image="images/images/Spell.png">Bài phép</option>
        <option value="Địa Danh" data-image="images/images/Landmark.png">Địa danh</option>
        <option value="Trang Bị" data-image="images/images/Equipment.png">Trang bị</option>
      </select>
    </div>
<% if (isAdmin) { %>
  <!-- Nút thêm + ô tìm kiếm -->
  <div class="col-12 col-md-6 d-flex align-items-center gap-2">
  <a href="addCard" class="btn btn-success flex-shrink-0">➕ Thêm lá bài</a>
  <input type="text" id="filter-name" class="form-control" placeholder="🔍 Tìm theo tên lá bài...">
</div>

<% } else { %>
  <!-- Chỉ ô tìm kiếm nếu không phải admin -->
  <div class="col-12 col-md-6">
    <input type="text" id="filter-name" class="form-control" placeholder="🔍 Tìm theo tên lá bài...">
  </div>
<% } %>

  </div>
</div>
</div>
    <div class="container py-5">
        <h2 id="card-count" class="text-center text-light mb-4">Tổng số lá bài: <%= allCards.size() %></h2>

        <div class="row justify-content-center g-4">
            <% for (Card card : allCards) {
                String name = card.getName();
                String descriptionRaw = card.getDescriptionRaw();
                String rarity = card.getRarityRef() != null ? card.getRarityRef().trim() : "None";
                String regionRaw = card.getRegionRefs();
                String regionDisplay = (regionRaw != null && !regionRaw.isEmpty())
    ? regionRaw.replace("[", "").replace("]", "").replace("'", "").trim()
    : "Không rõ";

                int price = card.getPrice();
                String cardCode = card.getCardCode();
                String imagePath = "images/anh/" + cardCode + ".png";
            %>
            <div class="col-md-6 col-lg-4 col-xl-3 card-item"
     data-region="<%= regionDisplay.toLowerCase() %>"
     data-rarity="<%= rarity.toLowerCase() %>"
     data-mana="<%= card.getCost() %>"
     data-type="<%= card.getType().toLowerCase() %>"
     data-name="<%= name.toLowerCase() %>">

                <div class="glass-card h-100 text-center">
                    <img src="<%= imagePath %>" alt="<%= name %>" class="img-fluid card-img">
                    <h5 class="card-title"><%= name %></h5>
                    <!--
                    <p class="card-text"><%= descriptionRaw %></p>
                    <p class="rarity">Độ hiếm: <%= rarity %></p>
                    <p class="region">Khu vực: <%= regionDisplay %></p>
                    -->
                    <p class="price">Giá: <%= String.format("%,d", price) %> Xu</p>
                    
                    <div class="d-flex flex-wrap justify-content-center gap-2 mt-2 button-row">
  <% 
  boolean purchased = false;
  if (card != null) {
    purchased = card.isPurchased();
  }
%>

<% if (username != null) { %>
  <% if (!purchased) { %>
    <form method="post" class="button-wrapper"
          onsubmit="event.preventDefault(); checkBalanceBeforeConfirm('<%= card.getCardCode() %>', <%= card.getPrice() %>, <%= balance != null ? balance : 0 %>)">
      <button type="submit" class="btn btn-success">🛒 Mua ngay</button>
    </form>
    <form method="POST" action="cart" class="button-wrapper w-100">
      <input type="hidden" name="itemCode" value="<%= card.getCardCode() %>">
      <input type="hidden" name="itemName" value="<%= card.getName() %>">
      <input type="hidden" name="price" value="<%= card.getPrice() %>">
      <input type="hidden" name="itemType" value="card"> <!-- ✅ card / relic / cardback -->
      <button type="submit" class="btn btn-sm btn-outline-light w-100">➕ Thêm vào giỏ</button>
    </form>
  <% } else { %>
    <div class="alert alert-info w-100 text-center">✅ Bạn đã mua lá bài này rồi.</div>
  <% } %>
<% } else { %>
  <form method="get" action="login.jsp" class="button-wrapper">
    <input type="hidden" name="redirect" value="checkout.jsp?cardCode=<%= card.getCardCode() %>">
    <button type="submit" class="btn btn-warning">Đăng nhập để mua</button>
  </form>
<% } %>



  <form method="get" action="<%= request.getContextPath() %>/cards" class="button-wrapper">
    <input type="hidden" name="cardCode" value="<%= cardCode %>">
    <button type="submit" class="btn btn-info">Chi tiết</button>
  </form>

  <% if (isAdmin) { %>
    <form method="get" action="editCard.jsp" class="button-wrapper">
      <input type="hidden" name="code" value="<%= cardCode %>">
      <button type="submit" class="btn btn-warning">Sửa</button>
    </form>

    <form method="get" action="deleteCard" class="button-wrapper"
          onsubmit="return confirm('Bạn có chắc muốn xóa thẻ bài này không?')">
      <input type="hidden" name="code" value="<%= cardCode %>">
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

  $('#filter-region, #filter-rarity, #filter-type' ).select2({
    templateResult: formatOption,
    templateSelection: formatOption,
    minimumResultsForSearch: Infinity
  });

  $('#filter-mana, #filter-type').select2({
    minimumResultsForSearch: Infinity
  });

  const filters = {
    region: document.getElementById("filter-region"),
    rarity: document.getElementById("filter-rarity"),
    mana: document.getElementById("filter-mana"),
    type: document.getElementById("filter-type"),
    name: document.getElementById("filter-name")
  };

  const cards = document.querySelectorAll(".card-item");

  function applyFilters() {
    const region = filters.region.value.toLowerCase();
    const rarity = filters.rarity.value.toLowerCase();
    const mana = filters.mana.value;
    const type = filters.type.value.toLowerCase();
    const name = filters.name.value.toLowerCase();

    let visibleCount = 0;

    cards.forEach(card => {
      const matchRegion = !region || card.dataset.region.includes(region);
      const matchRarity = !rarity || card.dataset.rarity.includes(rarity);
      const matchMana = !mana || (mana === "9+" ? parseInt(card.dataset.mana) >= 9 : card.dataset.mana === mana);
      const matchType = !type || card.dataset.type.includes(type);
      const matchName = !name || card.dataset.name.includes(name);

      const isVisible = matchRegion && matchRarity && matchMana && matchType && matchName;
      card.style.display = isVisible ? "block" : "none";

      if (isVisible) visibleCount++;
    });

    document.getElementById("card-count").textContent = "Tổng số lá bài: " + visibleCount;
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
        <form method="post" action="purchase" class="w-100">
          <input type="hidden" name="cardCode" id="modalCardCode">
          <input type="hidden" name="confirm" value="true">
          <input type="hidden" name="returnPage" value="cards.jsp">
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
