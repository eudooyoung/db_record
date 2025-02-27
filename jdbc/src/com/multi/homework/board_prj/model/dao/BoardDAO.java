package com.multi.homework.board_prj.model.dao;

import com.multi.homework.board_prj.common.exception.BoardException;
import com.multi.homework.board_prj.model.dto.Board;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;

public class BoardDAO {
    private Properties prop = null;

    //    DAO 생성자
    public BoardDAO() {

        prop = new Properties();
        try {
            prop.loadFromXML(new FileInputStream("resources/query_b.xml"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Board> selectAll(Connection conn) {
        ArrayList<Board> list = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectAll");

        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Board board = new Board();

                board.setNo(rs.getLong("no"));
                board.setCategoryCode(rs.getInt("category_code"));
                board.setTitle(rs.getString("title"));
                board.setContent(rs.getString("content"));
                board.setWriter(rs.getLong("writer"));
                board.setCount(rs.getInt("count"));
                board.setCreatedDate(rs.getTimestamp("created_date"));
                board.setModifiedDate(rs.getTimestamp("modified_date"));
                board.setStatus(rs.getString("status"));

                list.add(board);
            }
        } catch (SQLException e) {
            throw new BoardException(e);
        } finally {
            try {
                rs.close();
                stmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return list;
    }

    public Board selectOne(Connection conn, long no) {
        Board b = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectOne");

        try {
            pstmt = conn.prepareStatement(sql);

            pstmt.setLong(1, no);

            rs = pstmt.executeQuery();

            if (rs.next()) {
                b = new Board();

                b.setNo(rs.getLong("no"));
                b.setCategoryCode(rs.getInt("category_code"));
                b.setContent(rs.getString("content"));
                b.setTitle(rs.getString("title"));
                b.setWriter(rs.getLong("writer"));
                b.setCount(rs.getInt("count"));
                b.setCreatedDate(rs.getTimestamp("created_date"));
                b.setModifiedDate(rs.getTimestamp("modified_date"));
                b.setStatus(rs.getString("status"));
            }
        }  catch (SQLException e) {
            throw new BoardException(e);
        } finally {
            try {
                rs.close();
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return b;

    }

    public int insertPost(Connection conn, Board board) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql = prop.getProperty("insertPost");

        try {
            pstmt = conn.prepareStatement(sql);

            // 순서 확인!
            pstmt.setInt(1, board.getCategoryCode());
            pstmt.setString(2, board.getTitle());
            pstmt.setString(3, board.getContent());
            pstmt.setLong(4, board.getWriter());
            pstmt.setInt(5, board.getCount());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new BoardException(e);
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }

    public int updatePost(Connection conn, Board board) {
        int result = 0;
        PreparedStatement pstmt = null;

        String sql = prop.getProperty("updatePost");

        try {
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, board.getCategoryCode());
            pstmt.setString(2, board.getTitle());
            pstmt.setString(3, board.getContent());
            pstmt.setLong(4, board.getNo());

            result = pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new BoardException(e);
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }

    public int deletePost(Connection conn, long no) {
        int result = 0;
        PreparedStatement pstmt = null;

        String sql = prop.getProperty("deletePost");

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, no);

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new BoardException(e);
        } finally {
            try {
                pstmt.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }
}
