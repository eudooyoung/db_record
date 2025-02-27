package com.multi.homework.board_prj.service;

import com.multi.homework.board_prj.common.exception.BoardException;
import com.multi.homework.board_prj.model.dao.BoardDAO;
import com.multi.homework.board_prj.model.dto.Board;

import java.sql.Connection;
import java.util.ArrayList;

import static com.multi.homework.board_prj.common.JDBCConnect.*;
import static com.multi.homework.board_prj.common.JDBCConnect.close;

public class BoardService {
    private final BoardDAO boardDAO;
    Connection conn = null;

    //    서비스 클래스의 생성자
    public BoardService() {
        boardDAO = new BoardDAO();
    }

    public ArrayList<Board> selectAll() {
        ArrayList<Board> list;

        try {
            conn = getConnection();
            list = boardDAO.selectAll(conn);
        } catch (BoardException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) close(conn);
        }

        return list;
    }

    public int insertBoard(Board board) {
        int result = 0;
        try {
            conn = getConnection();
            result = boardDAO.insertPost(conn, board);
            if (result > 0) commit(conn);
            else rollback(conn);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) close(conn);
        }
        return result;
    }


    public Board selectOne(long no) {
        Board board;
        try {
            conn = getConnection();
            board = boardDAO.selectOne(conn, no);
            if (board != null) commit(conn);
            else rollback(conn);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) close(conn);
        }
        return board;


    }

    public int updatePost(Board board) {
        int result = 0;
        try {
            conn = getConnection();
            result = boardDAO.updatePost(conn, board);
            if (result > 0) commit(conn);
            else rollback(conn);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) close(conn);
        }
        return result;
    }

    public int deletePost(long no) {
        int result = 0;
        try{
            conn = getConnection();
            result = boardDAO.deletePost(conn, no);
            if (result > 0) commit(conn);
            else rollback(conn);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (conn != null) close(conn);
        }
        return result;

    }

    public void exitProgram() {
        close(conn);
    }
}
