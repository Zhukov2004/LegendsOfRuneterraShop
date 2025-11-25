<%@page import="d.IconDAO"%>
<%@page import="model.Icon"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="model.Guardian" %>
<%@ page import="d.GuardianDAO" %>
<%@ page import="model.Board" %>
<%@ page import="d.BoardDAO" %>
<%@ page import="model.Emote" %>
<%@ page import="d.EmoteDAO" %>
<%@ page import="model.Emote" %>
<%@ page import="d.EmoteDAO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

    GuardianDAO guardianDAO = new GuardianDAO(conn);
    List<Guardian> guardians = guardianDAO.getAll();

    BoardDAO boardDAO = new BoardDAO(conn);
    List<Board> boards = boardDAO.getAllBoards();

    EmoteDAO emoteDAO = new EmoteDAO(conn);
    List<Emote> emotes = emoteDAO.getAll();
    IconDAO iconDAO = new IconDAO(conn);
    List<Icon> icons = iconDAO.getAll();
    conn.close();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Sản phẩm đã ngừng kinh doanh</title>
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
.alert-banner {
  background: linear-gradient(135deg, rgba(255,0,0,0.3), rgba(255,255,255,0.1));
  border: 1px solid rgba(255,0,0,0.5);
  border-radius: 15px;
  padding: 20px;
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  box-shadow: 0 4px 15px rgba(255,0,0,0.6);
  color: #fff;
  animation: fadeIn 1.2s ease-out, glowPulseRed 3s infinite;
}

.alert-banner h4 {
  font-weight: 700;
  margin-bottom: 8px;
  font-size: 1.4rem;
  text-transform: uppercase;
  letter-spacing: 1px;
  color: #ff4d4d; /* đỏ nổi bật */
}

.alert-banner p {
  margin: 0;
  font-size: 1rem;
  opacity: 0.9;
}

@keyframes glowPulseRed {
  0%   { box-shadow: 0 0 10px rgba(255,0,0,0.6); }
  50%  { box-shadow: 0 0 25px rgba(255,0,0,0.9); }
  100% { box-shadow: 0 0 10px rgba(255,0,0,0.6); }
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

  </style>
</head>
<body class="bg-dark text-white">

<!-- Banner chung -->
<div class="alert-banner mb-4 text-center">
  <div class="announcement-content">
    <h4>⛔ Hàng đã ngừng bán</h4>
    <p>Sản phẩm đã ngừng bán, nhưng hành trình chưa kết thúc. Hãy chuẩn bị cho những phiên bản đặc biệt sắp xuất hiện!</p>
  </div>
</div>


<div class="container py-5">
  <!-- Tab menu -->
  <ul class="nav nav-tabs justify-content-center" id="shopTabs" role="tablist">
  <li class="nav-item">
  <button class="nav-link glass-tab active" id="emotes-tab" data-bs-toggle="tab" data-bs-target="#emotes" type="button" role="tab">😊 Emotes</button>
</li>
  <li class="nav-item">
    <button class="nav-link glass-tab" id="icons-tab" data-bs-toggle="tab" data-bs-target="#icons" type="button" role="tab">🖼️ Logo người dùng</button>
  </li>
</ul>
  <!-- Nội dung tab -->
  <div class="tab-content mt-4">
    <!-- Tab Emotes -->
<div class="tab-pane fade show active" id="emotes" role="tabpanel">
  <div class="row">
    <% for (Emote e : emotes) { %>
      <div class="col-md-4 mb-4">
        <div class="glass-card gradient-border text-white h-100 text-center">
          <img src="<%= e.getIcon() %>" class="card-img-top" alt="<%= e.getName() %>" style="height:120px; object-fit:contain;">
          <div class="card-body">
            <h5 class="card-title"><%= e.getName() %></h5>
            <p><strong>Độ hiếm:</strong> <%= e.getRarity() %></p>
            <p style="white-space:pre-line;"><%= e.getDescription() %></p>
            <p><strong>Giá:</strong> <%= e.getPrice() %> Xu</p>
            <span class="badge bg-danger text-white">Đã ngừng bán</span>
          </div>
        </div>
      </div>
    <% } %>
  </div>
</div>


    <!-- Tab Logo người dùng -->
    <div class="tab-pane fade" id="icons" role="tabpanel">
  <div class="row">
    <% for (Icon icon : icons) { %>
      <div class="col-md-4 mb-4">
        <div class="glass-card gradient-border text-white h-100 text-center">
          <!-- Ảnh icon -->
          <img src="<%= icon.getImage() %>" class="card-img-top" alt="<%= icon.getName() %>" style="height:120px; object-fit:contain;">
          <div class="card-body">
            <h5 class="card-title"><%= icon.getName() %></h5>
            <p><strong>Độ hiếm:</strong> <%= icon.getRarity() %></p>
            <p><strong>Giá:</strong> <%= icon.getPrice() %> Xu</p>
            <span class="badge bg-danger text-white">Đã ngừng bán</span>
          </div>
        </div>
      </div>
    <% } %>
  </div>
</div>

  </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
