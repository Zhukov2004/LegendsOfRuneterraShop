<%@page import="d.CategoryDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@ page import="model.Post" %>
<%@ page import="d.PostDAO" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Post post = PostDAO.getPostById(id);
    String username = (String) session.getAttribute("username");
    List<Category> categories = CategoryDAO.getAllCategories();
    List<Post> randomPosts = PostDAO.getRandomPosts(3);
%>
<%
  String role = (String) session.getAttribute("role");
  boolean isAdmin = "admin".equals(role);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Ogani Template">
    <meta name="keywords" content="Ogani, unica, creative, html">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Chi tiết bài viết</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="css/style.css" type="text/css">
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
    <style>
        @media (min-width: 992px) {
  .navbar-expand-lg {
    justify-content: space-between !important;
  }
  .navbar-nav.ms-auto {
    margin-left: auto !important;
  }
}

    </style>
</head>

<body>
    <!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>
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
    <!-- Blog Details Hero Begin -->
    <section class="blog-details-hero set-bg" data-setbg="<%= post.getThumbnail() != null ? post.getThumbnail() : "img/blog/details/details-hero.jpg" %>">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="blog__details__hero__text">
                        <h2><%= post.getTitle() %></h2>
                        <ul>
                            <li><%= post.getAuthor() %></li>
                            <li><%= post.getCreatedAt() %></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Details Hero End -->

    <!-- Blog Details Section Begin -->
    <section class="blog-details spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-5 order-md-1 order-2">
                    <div class="blog__sidebar">
                        <div class="blog__sidebar__search">
                            <form action="#">
                                <input type="text" placeholder="Search...">
                                <button type="submit"><span class="icon_search"></span></button>
                            </form>
                        </div>
                        <div class="blog__sidebar__item">
                            <h4>Categories</h4>
                            <ul>
        <% for (Category cat : categories) { %>
            <li>
                <a href="blog.jsp?category=<%= cat.getId() %>">
                    <%= cat.getName() %> (<%= cat.getPostCount() %>)
                </a>
            </li>
        <% } %>
    </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8 col-md-7 order-md-1 order-1">
                    <div class="blog__details__text">
<%
    if (post.getVideoUrl() != null && !post.getVideoUrl().isEmpty()) {
        // Chuẩn hóa link YouTube: watch?v=..., youtu.be/..., shorts/...
        String videoUrl = post.getVideoUrl();
        videoUrl = videoUrl.replaceAll("https://www.youtube.com/watch\\?v=([a-zA-Z0-9_-]+)", 
                                       "https://www.youtube.com/embed/$1");
        videoUrl = videoUrl.replaceAll("https://youtu.be/([a-zA-Z0-9_-]+)", 
                                       "https://www.youtube.com/embed/$1");
        videoUrl = videoUrl.replaceAll("https://www.youtube.com/shorts/([a-zA-Z0-9_-]+)", 
                                       "https://www.youtube.com/embed/$1");
%>
        <!-- Nhúng video trực tiếp -->
        <div class="ratio ratio-16x9 mb-3">
            <iframe src="<%= videoUrl %>" 
                    style="width:100%; height:400px;" 
                    frameborder="0" allowfullscreen></iframe>
        </div>
<%
    } else {
        // Nếu không có videoUrl thì hiển thị content như bình thường
        String html = post.getContent().replaceAll("\\[img\\](.*?)\\[/img\\]", "<img src=\"$1\" style='max-width:100%; margin:20px 0;'>");
%>
        <div style="white-space: pre-line;"><%= html %></div>
<%
    } // <-- thêm dấu đóng này
%>
</div>


                    <div class="blog__details__content">
    <div class="row">
        <!-- Tác giả -->
        <div class="col-lg-6">
            <div class="blog__details__author">
                <div class="blog__details__author__pic">
                    <img src="img/blog/details/details-author.png" alt="">
                </div>
                <div class="blog__details__author__text">
                    <h6><%= post.getAuthor() %></h6>
                    <span>Tác giả</span>
                </div>
            </div>
        </div>

        <!-- Chuyên mục + mạng xã hội -->
        <div class="col-lg-6">
            <div class="blog__details__widget">
                <ul>
                    <li><span>Chuyên mục:</span> <%= post.getCategoryName() %></li>
                </ul>
                <div class="blog__details__social">
                    <a href="#"><i class="fa fa-facebook"></i></a>
                    <a href="#"><i class="fa fa-twitter"></i></a>
                    <a href="#"><i class="fa fa-google-plus"></i></a>
                    <a href="#"><i class="fa fa-linkedin"></i></a>
                    <a href="#"><i class="fa fa-envelope"></i></a>
                </div>
            </div>
        </div>
    </div>
</div>
            </div>
        </div>
    </section>
    <!-- Blog Details Section End -->

    <!-- Related Blog Section Begin -->
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
    <!-- Related Blog Section End -->

    <!-- Js Plugins -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/main.js"></script>



</body>

</html>