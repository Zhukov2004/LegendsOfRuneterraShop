package d;

import model.Category;
import java.sql.*;
import java.util.*;

public class CategoryDAO {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/runeterra_shop?useUnicode=true&characterEncoding=UTF-8";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "";

    public static List<Category> getAllCategories() {
    List<Category> list = new ArrayList<>();
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
        String sql = "SELECT c.id, c.name, COUNT(p.id) AS post_count " +
                     "FROM Category c LEFT JOIN Post p ON c.id = p.category_id " +
                     "GROUP BY c.id, c.name";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Category cat = new Category();
            cat.setId(rs.getInt("id"));
            cat.setName(rs.getString("name"));
            cat.setPostCount(rs.getInt("post_count"));
            list.add(cat);
        }
        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}


    public static boolean insertCategory(Category cat) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);
            String sql = "INSERT INTO Category (name, slug, description) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, cat.getName());
            ps.setString(2, cat.getSlug());
            ps.setString(3, cat.getDescription());
            int rows = ps.executeUpdate();

            ps.close();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public static List<Category> getCategoriesWithPostCount() {
    List<Category> list = new ArrayList<>();
    String sql = """
        SELECT c.id, c.name, c.slug, c.description, COUNT(p.id) AS post_count
        FROM Category c
        LEFT JOIN Post p ON c.id = p.category_id
        GROUP BY c.id, c.name, c.slug, c.description
        ORDER BY c.name ASC
    """;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Category cat = new Category();
            cat.setId(rs.getInt("id"));
            cat.setName(rs.getString("name"));
            cat.setSlug(rs.getString("slug"));
            cat.setDescription(rs.getString("description"));
            cat.setPostCount(rs.getInt("post_count")); // thêm thuộc tính này
            list.add(cat);
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list;
}
    public static boolean deleteCategory(int id) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        String sql = "DELETE FROM Category WHERE id=?";
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
public static boolean updateCategory(Category cat) {
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        String sql = "UPDATE Category SET name=?, slug=?, description=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, cat.getName());
        ps.setString(2, cat.getSlug());
        ps.setString(3, cat.getDescription());
        ps.setInt(4, cat.getId());
        int rows = ps.executeUpdate();
        ps.close();
        conn.close();
        return rows > 0;
    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}
public static Category getCategoryById(int id) {
    Category cat = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        String sql = "SELECT * FROM Category WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            cat = new Category();
            cat.setId(rs.getInt("id"));
            cat.setName(rs.getString("name"));
            cat.setSlug(rs.getString("slug"));
            cat.setDescription(rs.getString("description"));
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return cat;
}
public static boolean isSlugExists(String slug, Integer excludeId) {
    boolean exists = false;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/runeterra_shop", "root", "");
        String sql = "SELECT COUNT(*) FROM Category WHERE slug = ?";
        if (excludeId != null) {
            sql += " AND id <> ?";
        }
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, slug);
        if (excludeId != null) {
            ps.setInt(2, excludeId);
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next() && rs.getInt(1) > 0) {
            exists = true;
        }
        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
    return exists;
}


}
