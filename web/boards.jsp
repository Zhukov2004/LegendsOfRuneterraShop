<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="model.Board" %>
<%@ page import="d.BoardDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
    BoardDAO dao = new BoardDAO(conn);
    List<Board> boards = dao.getAllBoards();
    conn.close();
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Bàn đấu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/style.css" rel="stylesheet" type="text/css"/>
<style>
    .board-card {
      position: relative;
      background: rgba(255, 255, 255, 0.08);
      border-radius: 20px;
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border: 1px solid rgba(255, 255, 255, 0.25);
      box-shadow: 0 4px 15px rgba(0,0,0,0.4);
      transition: transform 0.35s ease, box-shadow 0.35s ease;
      overflow: hidden;
    }
    .board-card:hover {
      transform: translateY(-12px) scale(1.05);
      box-shadow: 0 20px 35px rgba(0,0,0,0.6);
      border-color: rgba(255, 255, 255, 0.4);
    }
    .board-card img {
      border-top-left-radius: 20px;
      border-top-right-radius: 20px;
      transition: transform 0.4s ease;
    }
    .board-card:hover img {
      transform: scale(1.1);
    }
    .board-card .card-body {
      padding: 1.2rem;
    }
    .board-card .card-title {
      font-weight: 700;
      font-size: 1.2rem;
      margin-bottom: 0.5rem;
    }
    .board-card p {
      font-size: 0.95rem;
      margin-bottom: 0.4rem;
    }
    .board-card .badge {
      font-size: 0.85rem;
      padding: 0.5em 0.8em;
      border-radius: 12px;
      background: linear-gradient(135deg, #ffc107, #ff9800);
      color: #000;
      font-weight: 600;
      box-shadow: 0 2px 6px rgba(0,0,0,0.3);
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
      animation: fadeIn 1.2s ease-out, glowPulse 3s infinite;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    @keyframes glowPulse {
      0% { box-shadow: 0 0 10px rgba(0,123,255,0.6); }
      50% { box-shadow: 0 0 25px rgba(0,123,255,0.9); }
      100% { box-shadow: 0 0 10px rgba(0,123,255,0.6); }
    }
</style>
</head>

<div class="announcement-banner mb-4 text-center">
  <div class="announcement-content">
    <h4>🏟️ Bàn đấu sắp mở bán</h4>
    <p>⚠️ Bàn đấu này chỉ mở bán một lần duy nhất – sau đó sẽ khóa vĩnh viễn!</p>
  </div>
</div>

<body class="bg-dark text-white">
<div class="container py-5">
  <h2 class="text-center mb-4">🏟️ Bộ sưu tập Bàn Đấu</h2>
  <div class="row">
    <% for (Board b : boards) { %>
      <div class="col-md-4 mb-4">
  <div class="board-card text-white h-100 text-center">
    <!-- Icon -->
    <img src="<%= b.getIcon() %>" class="card-img-top" alt="<%= b.getName() %>" 
         style="height:120px; object-fit:contain;">

    <!-- Ảnh bàn đấu trong trận -->
    <img src="<%= b.getDisplay() %>" class="img-fluid mt-2" alt="Board Display" 
         style="height:200px; object-fit:cover; border-radius:10px;">

    <!-- Ảnh loading sau trận -->
    <img src="<%= b.getLoadingScreen() %>" class="img-fluid mt-2" alt="Loading Screen" 
         style="height:200px; object-fit:cover; border-radius:10px;">

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
</body>
</html>
