package d;

import model.Board;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private Connection conn;

    public BoardDAO(Connection conn) {
        this.conn = conn;
    }

    // ===== Lấy tất cả bàn đấu để hiển thị =====
    public List<Board> getAllBoards() throws SQLException {
        List<Board> boards = new ArrayList<>();
        String sql = "SELECT * FROM boards";
        try (Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Board board = new Board();
                board.setId(rs.getInt("id"));
                board.setName(rs.getString("name"));
                board.setIcon(rs.getString("icon"));
                board.setDisplay(rs.getString("display"));
                board.setLoadingScreen(rs.getString("loadingScreen"));
                board.setRarity(rs.getString("rarity"));
                board.setDescription(rs.getString("description"));
                board.setPrice(rs.getInt("price"));
                boards.add(board);
            }
        }
        return boards;
    }
    public List<Board> getRandom10() throws SQLException {
    List<Board> list = new ArrayList<>();
    String sql = "SELECT * FROM boards ORDER BY RAND() LIMIT 10";
    PreparedStatement stmt = conn.prepareStatement(sql);
    ResultSet rs = stmt.executeQuery();
    while (rs.next()) {
        Board b = new Board(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("icon"),
            rs.getString("display"),
            rs.getString("loadingScreen"),   // đúng vị trí thứ 5
            rs.getString("rarity"),          // đúng vị trí thứ 6
            rs.getString("description"),     // đúng vị trí thứ 7
            rs.getInt("price")               // đúng vị trí cuối
        );
        list.add(b);
    }
    return list;
}

}
