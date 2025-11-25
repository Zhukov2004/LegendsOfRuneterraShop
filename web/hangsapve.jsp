<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="model.Guardian" %>
<%@ page import="d.GuardianDAO" %>
<%@ page import="model.Board" %>
<%@ page import="d.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

    GuardianDAO guardianDAO = new GuardianDAO(conn);
    List<Guardian> guardians = guardianDAO.getAll();

    BoardDAO boardDAO = new BoardDAO(conn);
    List<Board> boards = boardDAO.getAllBoards();

    conn.close();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Hàng sắp mở bán</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/style.css" rel="stylesheet" type="text/css"/>
  <style>
      .glass-card {
  position: relative;
  background: rgba(255, 255, 255, 0.08); /* nền trong suốt nhẹ */
  border-radius: 20px;
  backdrop-filter: blur(12px);            /* hiệu ứng kính */
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.25);
  box-shadow: 0 4px 15px rgba(0,0,0,0.4);
  transition: transform 0.35s ease, box-shadow 0.35s ease;
  overflow: hidden;
}

.glass-card:hover {
  transform: translateY(-10px) scale(1.03);
  box-shadow: 0 20px 35px rgba(0,0,0,0.6);
  border-color: rgba(255, 255, 255, 0.4);
}

.glass-card img {
  border-top-left-radius: 20px;
  border-top-right-radius: 20px;
  transition: transform 0.4s ease;
}

.glass-card:hover img {
  transform: scale(1.05);
}
.glass-tab {
  background: rgba(255, 255, 255, 0.08);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.25);
  border-radius: 12px;
  margin: 0 8px;
  color: #fff;
  transition: all 0.3s ease;
  padding: 12px 24px;   /* tăng chiều cao button */
  position: relative;
  top: -4px;            /* đẩy button lên che border trắng */
}


.glass-tab.active {
  background: rgba(255, 255, 255, 0.2);
  border-color: rgba(255, 255, 255, 0.4);
  color: #ffc107; /* màu nổi bật khi active */
}

.glass-tab:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(0,0,0,0.4);
}
.announcement-banner {
  background: linear-gradient(135deg, rgba(0,123,255,0.2), rgba(255,255,255,0.1));
  border: 1px solid rgba(255,255,255,0.25);
  border-radius: 15px;
  padding: 20px;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  box-shadow: 0 4px 15px rgba(0,0,0,0.4);
  color: #fff;
}

.announcement-banner h4 {
  font-weight: 700;
  margin-bottom: 8px;
  font-size: 1.4rem;
  text-transform: uppercase;
  letter-spacing: 1px;
}

.announcement-banner p {
  margin: 0;
  font-size: 1rem;
  opacity: 0.9;
}
.announcement-banner {
  animation: fadeIn 1.2s ease-out, glowPulse 3s infinite;
}
.gradient-border {
  border: 3px solid;
  border-image: linear-gradient(45deg, #ff00ff, #00ffff, #ffff00) 1;
  animation: gradientShift 5s linear infinite;
  border-radius: 20px; /* bo góc giống card */
}

@keyframes gradientShift {
  0%   { border-image-source: linear-gradient(45deg, #ff00ff, #00ffff, #ffff00); }
  50%  { border-image-source: linear-gradient(135deg, #ffff00, #ff00ff, #00ffff); }
  100% { border-image-source: linear-gradient(225deg, #00ffff, #ffff00, #ff00ff); }
}
#demo {
  font-size: 2rem;
  font-weight: bold;
  color: #ffffff;
}

  </style>
</head>
<body class="bg-dark text-white">

<!-- Banner chung -->
<div class="announcement-banner mb-4 text-center">
  <div class="announcement-content">
    <h4>🚀 Hàng sắp mở bán</h4>
    <p>Trang này chỉ là bản xem trước demo – hãy đón chờ ngày ra mắt chính thức!</p>
    <p id="demo"></p>
  </div>
</div>

<div class="container py-5">
  <!-- Tab menu -->
  <ul class="nav nav-tabs justify-content-center" id="shopTabs" role="tablist">
  <li class="nav-item">
    <button class="nav-link glass-tab active" id="guardians-tab" data-bs-toggle="tab" data-bs-target="#guardians" type="button" role="tab">🦊 Linh Thú</button>
  </li>
  <li class="nav-item">
    <button class="nav-link glass-tab" id="boards-tab" data-bs-toggle="tab" data-bs-target="#boards" type="button" role="tab">🏟️ Bàn Đấu</button>
  </li>
</ul>
  <!-- Nội dung tab -->
  <div class="tab-content mt-4">
    <!-- Tab Linh Thú -->
    <div class="tab-pane fade show active" id="guardians" role="tabpanel">
      <div class="row">
        <% for (Guardian g : guardians) { %>
          <div class="col-md-4 mb-4">
            <div class="glass-card gradient-border text-white h-100 text-center">
              <img src="<%= g.getImagePath() %>" class="card-img-top" alt="<%= g.getName() %>" style="height:200px; object-fit:contain;">
              <div class="card-body">
                <h5 class="card-title"><%= g.getName() %></h5>
                <p><strong>Độ hiếm:</strong> <%= g.getRarity() %></p>
                <p style="white-space:pre-line;"><%= g.getDescription() %></p>
                <p><strong>Giá dự kiến:</strong> <%= g.getPrice() %> Xu</p>
                <span class="badge bg-info text-dark">Sắp mở bán</span>
              </div>
            </div>
          </div>
        <% } %>
      </div>
    </div>

    <!-- Tab Bàn Đấu -->
    <div class="tab-pane fade" id="boards" role="tabpanel">
      <div class="row">
        <% for (Board b : boards) { %>
          <div class="col-md-4 mb-4">
            <div class="glass-card gradient-border text-white h-100 text-center">
              <!-- 3 ảnh: icon, display, loading -->
              <img src="<%= b.getIcon() %>" class="card-img-top" alt="<%= b.getName() %>" style="height:120px; object-fit:contain;">
              <img src="<%= b.getDisplay() %>" class="img-fluid mt-2" alt="Board Display" style="height:150px; object-fit:cover; border-radius:10px;">
              <img src="<%= b.getLoadingScreen() %>" class="img-fluid mt-2" alt="Loading Screen" style="height:150px; object-fit:cover; border-radius:10px;">
              <div class="card-body">
                <h5 class="card-title"><%= b.getName() %></h5>
                <p><strong>Độ hiếm:</strong> <%= b.getRarity() %></p>
                <p style="white-space:pre-line;"><%= b.getDescription() %></p>
                <p><strong>Giá dự kiến:</strong> <%= b.getPrice() %> Xu</p>
                <span class="badge bg-warning text-dark">Sắp mở bán – chỉ bán 1 lần duy nhất</span>
              </div>
            </div>
          </div>
        <% } %>
      </div>
    </div>
  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
// Set the date we're counting down to
var countDownDate = new Date("Jan 9, 2026 00:00:00").getTime();

// Update the count down every 1 second
var x = setInterval(function() {

  // Get today's date and time
  var now = new Date().getTime();
    
  // Find the distance between now and the count down date
  var distance = countDownDate - now;
    
  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);
    
  // Output the result in an element with id="demo"
  document.getElementById("demo").innerHTML = "Mở bán sau " + days + " ngày " + hours + " giờ "
  + minutes + " phút " + seconds + " giây ";
    
  // If the count down is over, write some text 
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("demo").innerHTML = "Đã hết hạn";
  }
}, 1000);
</script>
</body>
</html>
