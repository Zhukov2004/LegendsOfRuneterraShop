<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="d.RevenueDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/runeterra_shop", "root", "");

    RevenueDAO revenueDAO = new RevenueDAO(conn);

    // Lấy doanh thu theo loại sản phẩm
    Map<String, Integer> revenues = revenueDAO.getRevenueAll();

    // Lấy doanh thu theo tháng
    Map<String, Integer> monthlyRevenue = revenueDAO.getRevenueByMonth();

    // Lấy tổng doanh thu
    int totalRevenue = revenueDAO.getTotalRevenue();

    conn.close();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Báo cáo doanh thu</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link href="assets/style.css" rel="stylesheet" type="text/css"/>
  <style>
    body { background-color: #f8f9fa; }
    .report-card {
  position: relative;
  background: rgba(255, 255, 255, 0.08); /* nền trong suốt nhẹ */
  border-radius: 20px;
  backdrop-filter: blur(12px);            /* hiệu ứng kính */
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.25);
  box-shadow: 0 4px 15px rgba(0,0,0,0.4);
  padding: 20px;
  margin-bottom: 20px;
  transition: transform 0.35s ease, box-shadow 0.35s ease;
}

.report-card:hover {
  transform: translateY(-5px) scale(1.02);
  box-shadow: 0 20px 35px rgba(0,0,0,0.6);
  border-color: rgba(255, 255, 255, 0.4);
}
.glass-table {
  background: rgba(255, 255, 255, 0.08); /* nền trong suốt */
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255, 255, 255, 0.25);
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 15px rgba(0,0,0,0.4);
}

.glass-table thead {
  background: rgba(255, 255, 255, 0.15);
  color: #ffc107; /* vàng nổi bật cho header */
}
.glass-table th, .glass-table td {
  padding: 12px;
  text-align: center;
  border-bottom: 1px solid rgba(255,255,255,0.2);
}

.glass-table tbody tr {
  color: #fff;
}

.glass-table tbody tr:hover {
  background: rgba(255, 255, 255, 0.12);
  transform: scale(1.01);
  transition: 0.3s ease;
}
.glass-table {
  width: 100%; /* bảng chiếm toàn bộ chiều rộng card */
}
    h2 { color: #ffffff; }
  </style>
</head>
<body class="container py-5">

  <h2 class="mb-4 text-center">📊 Báo cáo doanh thu</h2>

  <!-- Tổng doanh thu -->
  <div class="report-card text-center">
    <h4>Tổng doanh thu</h4>
    <p style="font-size:1.5rem; font-weight:bold; color:#28a745;">
      <%= totalRevenue %> Xu
    </p>
  </div>

  <!-- Doanh thu theo loại sản phẩm -->
  <div class="report-card">
    <h4>Doanh thu theo loại sản phẩm</h4>
    <table class="glass-table">
      <thead>
  <tr>
    <th>Loại sản phẩm</th>
    <th>Doanh thu</th>
  </tr>
</thead>

      <tbody>
        <% for (Map.Entry<String, Integer> entry : revenues.entrySet()) { %>
          <tr>
            <td><%= entry.getKey() %></td>
            <td><%= entry.getValue() %> Xu</td>
          </tr>
        <% } %>
      </tbody>
    </table>
  </div>

  <!-- Biểu đồ doanh thu theo tháng -->
  <div class="report-card">
    <h4>Doanh thu theo tháng</h4>
    <canvas id="revenueChart"></canvas>
  </div>

  <script>
    const ctx = document.getElementById('revenueChart');
    const chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: [<% for (String month : monthlyRevenue.keySet()) { %>"<%= month %>", <% } %>],
        datasets: [{
          label: 'Doanh thu (Xu)',
          data: [<% for (int value : monthlyRevenue.values()) { %><%= value %>, <% } %>],
          borderColor: 'rgba(255, 193, 7, 1)',
          backgroundColor: 'rgba(255, 193, 7, 0.2)',
          fill: true,
          tension: 0.3
        }]
      }
    });
  </script>

</body>
</html>
