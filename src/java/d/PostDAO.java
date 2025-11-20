package d;

import model.Post;
import java.sql.*;
import java.util.*;

public class PostDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/runeterra_shop?useUnicode=true&characterEncoding=UTF-8";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    public static List<Post> getAllPosts() {
        List<Post> posts = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "SELECT p.*, c.name AS category_name FROM Post p JOIN Category c ON p.category_id = c.id ORDER BY p.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setCategoryId(rs.getInt("category_id"));
                post.setCategoryName(rs.getString("category_name"));
                post.setAuthor(rs.getString("author"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setDescription(rs.getString("description"));
                post.setVideoUrl(rs.getString("videoUrl"));

                posts.add(post);
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return posts;
    }

    public static Post getPostById(int id) {
        Post post = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "SELECT p.*, c.name AS category_name FROM Post p JOIN Category c ON p.category_id = c.id WHERE p.id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setCategoryId(rs.getInt("category_id"));
                post.setCategoryName(rs.getString("category_name"));
                post.setAuthor(rs.getString("author"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                post.setUpdatedAt(rs.getTimestamp("updated_at"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setDescription(rs.getString("description"));
                post.setVideoUrl(rs.getString("videoUrl"));

            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

    public static boolean insertPost(Post post) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "INSERT INTO Post (title, content, category_id, author, thumbnail, description, videoUrl) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getCategoryId());
            ps.setString(4, post.getAuthor());
            ps.setString(5, post.getThumbnail());
            ps.setString(6, post.getDescription());
            ps.setString(7, post.getVideoUrl());
            int rows = ps.executeUpdate();

            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean updatePost(Post post) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "UPDATE Post SET title=?, content=?, category_id=?, author=?, thumbnail=?, description=?, videoUrl=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, post.getTitle());
            ps.setString(2, post.getContent());
            ps.setInt(3, post.getCategoryId());
            ps.setString(4, post.getAuthor());
            ps.setString(5, post.getThumbnail());
            ps.setString(6, post.getDescription());
            ps.setString(7, post.getVideoUrl());
            ps.setInt(8, post.getId());
            int rows = ps.executeUpdate();

            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static boolean deletePost(int id) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "DELETE FROM Post WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            int rows = ps.executeUpdate();

            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public static List<Post> getRandomPosts(int limit) {
        List<Post> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "SELECT * FROM Post ORDER BY RAND() LIMIT ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Post p = new Post();
                p.setId(rs.getInt("id"));
                p.setTitle(rs.getString("title"));
                p.setCreatedAt(rs.getTimestamp("created_at"));
                p.setThumbnail(rs.getString("thumbnail"));
                p.setDescription(rs.getString("description"));
                p.setVideoUrl(rs.getString("videoUrl"));

                list.add(p);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public static List<Post> getPostsByCategory(int categoryId) {
    List<Post> posts = new ArrayList<>();
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
        String sql = "SELECT p.*, c.name AS category_name FROM Post p JOIN Category c ON p.category_id = c.id WHERE p.category_id = ? ORDER BY p.created_at DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, categoryId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Post post = new Post();
            post.setId(rs.getInt("id"));
            post.setTitle(rs.getString("title"));
            post.setContent(rs.getString("content"));
            post.setCategoryId(rs.getInt("category_id"));
            post.setCategoryName(rs.getString("category_name"));
            post.setAuthor(rs.getString("author"));
            post.setCreatedAt(rs.getTimestamp("created_at"));
            post.setUpdatedAt(rs.getTimestamp("updated_at"));
            post.setThumbnail(rs.getString("thumbnail"));
            post.setDescription(rs.getString("description"));
            post.setVideoUrl(rs.getString("videoUrl"));
            posts.add(post);
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return posts;
}
// ✅ Tìm kiếm bài viết theo từ khóa (title, description, content)
public static List<Post> searchByKeyword(String keyword) {
    List<Post> posts = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
             PreparedStatement stmt = conn.prepareStatement(
                 "SELECT p.*, c.name AS category_name " +
                 "FROM Post p JOIN Category c ON p.category_id = c.id " +
                 "WHERE p.title LIKE ? OR p.description LIKE ? OR p.content LIKE ? " +
                 "ORDER BY p.created_at DESC")) {

            String pattern = "%" + keyword + "%";
            stmt.setString(1, pattern);
            stmt.setString(2, pattern);
            stmt.setString(3, pattern);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setCategoryId(rs.getInt("category_id"));
                    post.setCategoryName(rs.getString("category_name"));
                    post.setAuthor(rs.getString("author"));
                    post.setCreatedAt(rs.getTimestamp("created_at"));
                    post.setUpdatedAt(rs.getTimestamp("updated_at"));
                    post.setThumbnail(rs.getString("thumbnail"));
                    post.setDescription(rs.getString("description"));
                    post.setVideoUrl(rs.getString("videoUrl"));
                    posts.add(post);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return posts;
}

}
