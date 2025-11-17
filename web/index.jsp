<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="d.PostDAO"%>
<%@page import="model.Post"%>
<%@page import="d.CardBackDAO"%>
<%@page import="d.RelicDAO"%>
<%@page import="d.CardDAO"%>
<%@page import="model.CardBack"%>
<%@page import="model.Relic"%>
<%@page import="model.Card"%>
<%@page import="java.util.List"%>
<%@ page import="model.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }
%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
%>
  <%
  List<Card> cards = CardDAO.getRandomCards(6);
  List<Relic> relics = RelicDAO.getRandomRelics(6);
  List<CardBack> cardbacks = CardBackDAO.getRandomCardBacks(6);
  List<Post> randomPosts = PostDAO.getRandomPosts(3);
%>
<%
    List<Item> allItems = new ArrayList<>();

    for (Card c : cards) {
        allItems.add(new Item(c.getName(), "images/anh/" + c.getCardCode() + ".png", c.getPrice(), "oranges"));
    }

    for (Relic r : relics) {
        allItems.add(new Item(r.getName(), "images/relics/" + r.getRelicCode() + ".png", r.getPrice(), "fresh-meat"));
    }

    for (CardBack cb : cardbacks) {
        String encoded = cb.getCode().replace(" ", "%20");
        allItems.add(new Item(cb.getCode(), "images/cardback/" + encoded + ".png", cb.getPrice(), "cardback"));
    }

    Collections.shuffle(allItems); // 🔀 Xáo trộn danh sách
%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Runeterra Shop</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="assets/style.css">
  <link href="css/style.css" rel="stylesheet" type="text/css"/>
  <style>
@keyframes fadeLeft {
  from { opacity: 0; transform: translateX(-50px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes fadeRight {
  from { opacity: 0; transform: translateX(50px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(50px); }
  to { opacity: 1; transform: translateY(0); }
}

.fade-left {
  animation: fadeLeft 0.8s ease-out forwards;
}

.fade-right {
  animation: fadeRight 0.8s ease-out forwards;
}

.fade-up {
  animation: fadeUp 0.8s ease-out forwards;
}
.product-slider-section {
  padding: 60px 0;
  background: linear-gradient(to bottom, rgba(255,255,255,0.03), rgba(255,255,255,0.03));
}

.slider-title {
  font-weight: 600;
  font-size: 22px;
  margin-bottom: 20px;
  text-align: center;
  color: #f0f0f0;
}

.product-card {
  width: 250px;
  height: 400px; /* ✅ cố định chiều cao */
  margin: 0 auto;
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(6px);
  border-radius: 12px;
  padding: 15px;
  text-align: center;

  display: flex;
  flex-direction: column;
  justify-content: center; /* ✅ căn giữa theo chiều dọc */
  align-items: center;
  box-sizing: border-box;
}


.product-card img {
  max-height: 320px;
  width: auto;
  object-fit: contain;
  margin-bottom: 10px;
  border-radius: 8px;
}


.product-card h6,
.product-card span {
  margin: 0;
  padding: 4px 0;
}
.glass-list {
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255, 255, 255, 0.2);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-radius: 12px;
  padding: 15px 20px;
  list-style: none;
  margin-top: 10px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
  
}
.glass-list li {
  margin-bottom: 8px;
  width: 100%;
}

.glass-list li a {
  display: block;
  border-radius: 6px;
  color: #fff;
  font-weight: 500;
  text-decoration: none;
  .glass-list li {
  margin-bottom: 8px;
}

.glass-list li a {
  display: block;
  padding: 10px 15px;
  border-radius: 8px;
  color: #fff;
  font-weight: 500;
  text-decoration: none;
  transition: background 0.3s;
  width: fit-content;
}

.glass-list li a:hover {
  background-color: rgba(255, 255, 255, 0.15);
}

}

.glass-list li a:hover {
  background-color: rgba(255, 255, 255, 0.15);
  width: 100%;
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
  Integer balance = (Integer) session.getAttribute("balance");
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

  <!-- Banner -->
  <div class="container text-center my-3">
    <h1 class="display-5">Chào mừng đến với Runeterra Shop</h1>
    <p class="lead">Mua bán vật phẩm Legends of Runeterra – nhanh, tiện, uy tín!</p>
  </div>
  <section class="hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="hero__categories">
                        <div class="hero__categories__all">
                            <i class="fa fa-bars"></i>
                            <span>Danh mục</span>
                        </div>
                        <ul class="glass-list">
                            <li><a href="cards">Thẻ bài</a></li>
                            <li><a href="relics">Cổ vật</a></li>
                            <li><a href="CardBackController">Lưng bài</a></li>
                            <li><a href="#">Sàn đấu</a></li>
                            <li><a href="blog.jsp">Bài viết</a></li>
                            <li><a href="#">Butter & Eggs</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="hero__search">
                        <div class="hero__search__form">
                            <form action="search" method="get">
  <div class="hero__search__categories">
    Tìm kiếm
    <span class="arrow_carrot-down"></span>
  </div>
  <input type="text" name="keyword" placeholder="Bạn cần tìm gì?">
  <button type="submit" class="site-btn">SEARCH</button>
</form>

                        </div>
                        <div class="hero__search__phone">
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h5>0948104769</h5>
                                <span>Hỗ trợ 24/7</span>
                            </div>
                        </div>
                    </div>
                    <div class="hero__item set-bg" data-setbg="img/hero/banner.jpg">
                        
                    </div>
                </div>
            </div>
        </div>
    </section>
  <!-- Danh mục sản phẩm -->
  <div class="container my-5">
    <h2 class="text-center mb-3">Chọn vật phẩm bạn muốn mua</h2>
    <div class="row justify-content-center text-center">
  <div class="col-md-4 mb-4 fade-left">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <img src="images/images/card.png" alt="Thẻ bài" class="mb-3" width="200">
        <h5 class="card-title">🃏 Mua lá bài</h5>
        <p class="card-text">Các lá bài Legends of Runeterra theo vùng, độ hiếm và kỹ năng.</p>
        <a href="cards" class="btn btn-primary">Xem lá bài</a>
      </div>
    </div>
  </div>

  <div class="col-md-4 mb-4 fade-up">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <img src="images/images/relic.png" alt="Cổ vật" width="200">
        <h5 class="card-title">🔮 Mua cổ vật</h5>
        <p class="card-text">Trang bị đặc biệt giúp tăng sức mạnh cho bộ bài của bạn.</p>
        <a href="relics" class="btn btn-primary">Xem cổ vật</a>
      </div>
    </div>
  </div>
          <div class="col-md-4 mb-4 fade-right">
    <div class="card h-100 shadow-sm">
      <div class="card-body">
        <img src="images/images/back.png" alt="Lưng bài" width="200">
        <h5 class="card-title">🎴 Mua lưng bài</h5>
        <p class="card-text">Thiết kế lưng bài độc quyền theo từng vùng Runeterra.</p>
        <a href="CardBackController" class="btn btn-primary">Xem lưng bài</a>
      </div>
    </div>
  </div>
</div>
  </div>
  <section class="featured spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h2>Sản phẩm nổi bật</h2>
                    </div>
                    <div class="featured__controls">
                        <ul>
                            <li class="active" data-filter="*">All</li>
                            <li data-filter=".oranges">Lá bài</li>
                            <li data-filter=".fresh-meat">Cổ vật</li>
                            <li data-filter=".cardback">Lưng bài</li>
                            <li data-filter=".board">Sàn đấu</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row featured__filter">
  <% for (Item item : allItems) { %>
    <div class="col-lg-3 col-md-4 col-sm-6 mix <%= item.getType() %>">
      <div class="featured__item">
        <div class="featured__item__pic set-bg" data-setbg="<%= item.getImagePath() %>">
          <ul class="featured__item__pic__hover">
            <li><a href="#"><i class="fa fa-heart"></i></a></li>
            <li><a href="#"><i class="fa fa-retweet"></i></a></li>
            <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
          </ul>
        </div>
        <div class="featured__item__text">
          <h6><%= item.getName() %></h6>
          <h5><%= item.getPrice() %> Xu</h5>
        </div>
      </div>
    </div>
  <% } %>
</div>



        </div>
    </section>


<section class="product-slider-section">
  <div class="container">
      <h2 class="text-center text-light mb-5">🎁 Bộ sưu tập vật phẩm</h2>
    <div class="row text-center">

      <!-- Cards -->
      <div class="col-lg-4 col-md-6 mb-4">
        <h4 class="slider-title">🃏 Lá bài</h4>
        <div class="product-card" id="card-box">
          <img id="card-img" src="images/anh/<%= cards.get(0).getCardCode() %>.png" alt="">
          <h6 id="card-name"><%= cards.get(0).getName() %></h6>
          <span id="card-price"><%= cards.get(0).getPrice() %> Xu</span>
        </div>
      </div>

      <!-- Relics -->
      <div class="col-lg-4 col-md-6 mb-4">
        <h4 class="slider-title">🔮 Cổ vật</h4>
        <div class="product-card" id="relic-box">
          <img id="relic-img" src="images/relics/<%= relics.get(0).getRelicCode() %>.png" alt="">
          <h6 id="relic-name"><%= relics.get(0).getName() %></h6>
          <span id="relic-price"><%= relics.get(0).getPrice() %> Xu</span>
        </div>
      </div>

      <!-- Cardbacks -->
      <div class="col-lg-4 col-md-6 mb-4">
        <h4 class="slider-title">🎴 Lưng bài</h4>
        <div class="product-card" id="cardback-box">
          <img id="cardback-img" src="images/cardback/<%= cardbacks.get(0).getCode() %>.png" alt="">
          <h6 id="cardback-name"><%= cardbacks.get(0).getCode() %></h6>
          <span id="cardback-price"><%= cardbacks.get(0).getPrice() %> Xu</span>
        </div>
      </div>

    </div>
  </div>
</section>
<section class="from-blog spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title from-blog__title">
                        <h2>Bài viết mới</h2>
                    </div>
                </div>
            </div>
<div class="row">
    
    <% for (Post p : randomPosts) { %>
    <div class="col-lg-4 col-md-4 col-sm-6">
        <div class="blog__item">
            <div class="blog__item__pic">
                <img src="<%= p.getThumbnail() %>" alt="">
            </div>
            <div class="blog__item__text">
                <ul>
                    <li><i class="fa fa-calendar-o"></i> <%= p.getCreatedAt() %></li>
                </ul>
                <h5><a href="viewPost.jsp?id=<%= p.getId() %>"><%= p.getTitle() %></a></h5>
                <p><%= p.getDescription() %></p>
            </div>
        </div>
    </div>
    <% } %>
</div>
        </div>
</section>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const cards = [
      <% for (Card c : cards) { %>
        { img: "images/anh/<%= c.getCardCode() %>.png", name: "<%= c.getName() %>", price: "<%= c.getPrice() %> Xu" },
      <% } %>
    ];

    const relics = [
      <% for (Relic r : relics) { %>
        { img: "images/relics/<%= r.getRelicCode() %>.png", name: "<%= r.getName() %>", price: "<%= r.getPrice() %> Xu" },
      <% } %>
    ];

    const cardbacks = [
      <% for (CardBack cb : cardbacks) { %>
        { img: "images/cardback/<%= cb.getCode() %>.png", name: "<%= cb.getCode() %>", price: "<%= cb.getPrice() %> Xu" },
      <% } %>
    ];

    let i = 0;
    setInterval(() => {
      i = (i + 1) % cards.length;

      document.getElementById("card-img").src = cards[i].img;
      document.getElementById("card-name").innerText = cards[i].name;
      document.getElementById("card-price").innerText = cards[i].price;

      document.getElementById("relic-img").src = relics[i].img;
      document.getElementById("relic-name").innerText = relics[i].name;
      document.getElementById("relic-price").innerText = relics[i].price;

      document.getElementById("cardback-img").src = cardbacks[i].img;
      document.getElementById("cardback-name").innerText = cardbacks[i].name;
      document.getElementById("cardback-price").innerText = cardbacks[i].price;
    }, 4000);
  });
</script>
  <footer class="footer spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="footer__about">
                        <div class="footer__about__logo">
                            <a href="./index.jsp"><img src="images/images/legends-of-runeterra-logo.png" alt=""></a>
                        </div>
                        <ul>
                            <li>Address: Thành Phố Nam Định</li>
                            <li>Phone: 0948104769</li>
                            <li>Email: buihaidang13062004@gmail.com</li>
                            <li>Donate: 9378513062004 Bui Hai Dang</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 col-sm-6 offset-lg-1">
                    <div class="footer__widget">
                        <h6>Useful Links</h6>
                        <ul>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">About Our Shop</a></li>
                            <li><a href="#">Secure Shopping</a></li>
                            <li><a href="#">Delivery infomation</a></li>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Our Sitemap</a></li>
                        </ul>
                        <ul>
                            <li><a href="#">Who We Are</a></li>
                            <li><a href="#">Our Services</a></li>
                            <li><a href="#">Projects</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">Innovation</a></li>
                            <li><a href="#">Testimonials</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-12">
                    <div class="footer__widget">
                        <h6>Join Our Newsletter Now</h6>
                        <p>Get E-mail updates about our latest shop and special offers.</p>
                        <form action="#">
                            <input type="text" placeholder="Enter your mail">
                            <button type="submit" class="site-btn">Subscribe</button>
                        </form>
                        <div class="footer__widget__social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-pinterest"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="footer__copyright">
                        <div class="footer__copyright__text"><p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p></div>
                        <div class="footer__copyright__payment"><img src="img/payment-item.png" alt=""></div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
        

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="js/jquery-3.3.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
  <script src="js/owl.carousel.min.js"></script>
    
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/mixitup.min.js"></script>

    <script src="js/main.js"></script>

</body>
</html>
