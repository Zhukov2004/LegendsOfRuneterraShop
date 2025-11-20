<%@ page import="d.PostDAO"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Category" %>
<%@ page import="d.CategoryDAO" %>
<%@ page import="model.Post" %>
<%
    List<Category> categories = CategoryDAO.getAllCategories();

    String categoryParam = request.getParameter("category");
    List<Post> posts;
    if (categoryParam != null) {
        int categoryId = Integer.parseInt(categoryParam);
        posts = PostDAO.getPostsByCategory(categoryId);
    } else {
        posts = PostDAO.getAllPosts();
    }

    String role = (String) session.getAttribute("role");
    boolean isAdmin = "admin".equals(role);
    String username = (String) session.getAttribute("username");
%>
<%
    if ("true".equals(request.getParameter("logout"))) {
        session.invalidate();
        response.sendRedirect("blog.jsp");
        return;
    }
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
    <title>Legends Of Runeterra | Blog</title>

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
    <link href="assets/style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="css/style.css" type="text/css">
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
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Blog</h2>
                        <div class="breadcrumb__option">
                            <a href="./index.jsp">Home</a>
                            <span>Blog</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Blog Section Begin -->
    <section class="blog spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-5">
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
                <div class="col-lg-8 col-md-7">
                    <div class="row">
  <% for (Post post : posts) { %>
    <div class="col-lg-6 col-md-6 col-sm-6">
      <div class="blog__item">
        <div class="blog__item__pic">
          <img src="<%= post.getThumbnail() %>" alt="" class="img-fluid" style="height: 250px; object-fit: cover;">
        </div>
        <div class="blog__item__text">
          <ul class="mb-2">
            <li><i class="fa fa-calendar-o"></i> <%= post.getCreatedAt() %></li>
            <li><i class="fa fa-user"></i> <%= post.getAuthor() %></li>
          </ul>
          <h5 class="mb-2">
            <a href="viewPost.jsp?id=<%= post.getId() %>"><%= post.getTitle() %></a>
          </h5>
          <p class="mb-3 flex-grow-1">
            <%= post.getDescription().length() > 100 ? post.getDescription().substring(0, 100) + "..." : post.getDescription() %>
          </p>
          <a href="viewPost.jsp?id=<%= post.getId() %>" class="blog__btn">XEM THÊM <span class="arrow_right"></span></a>
        </div>
      </div>
    </div>
  <% } %>
</div>


                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->
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