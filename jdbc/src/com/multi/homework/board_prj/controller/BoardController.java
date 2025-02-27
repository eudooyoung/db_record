package com.multi.homework.board_prj.controller;


import com.multi.homework.board_prj.model.dto.Board;
import com.multi.homework.board_prj.service.BoardService;
import com.multi.homework.board_prj.view.BoardMenu;

import java.util.ArrayList;

public class BoardController {

    private BoardService boardService = new BoardService();

    public void selectAll() {
        BoardMenu boardMenu = new BoardMenu();

        try{
            ArrayList<Board> list = boardService.selectAll();
            if(!list.isEmpty()) {
                boardMenu.displayBoardList(list);
            } else {
                boardMenu.displayNodata();
            }
        } catch (Exception e) {
            e.printStackTrace();
            boardMenu.displayError("게시글 조회 실패, 관리자게에 문의 하세요.");
        }
    }

    public void insertPost(Board board) {
        int result = 0;
        try {
            result = boardService.insertBoard(board);
            if (result > 0) {
                new BoardMenu().displaySuccess("글 등록 성공");
            }
        } catch (Exception e) {
            e.printStackTrace();
            new BoardMenu().displayError("글 등록 실패, 관리자에게 문의하세요");
        }
    }

    public void selectOne(long no) {
        BoardMenu boardMenu = new BoardMenu();
        Board board = boardService.selectOne(no);

        if(board != null) {
            boardMenu.displayPost(board);
        } else {
            boardMenu.displayNodata();
        }
    }

    public void updatePost(Board board) {
        int result = 0;
        try {
            result = boardService.updatePost(board);
            if (result > 0) {
                new BoardMenu().displaySuccess("글 수정 성공");
            }
        } catch (Exception e) {
            e.printStackTrace();
            new BoardMenu().displayError("글 수정 실패, 관리자에게 문의하세요");
        }
    }

    public void deletePost(long no) {
        int result = 0;
        try{
            result = boardService.deletePost(no);
            if(result > 0 ) {
                new BoardMenu().displaySuccess("글 삭제 성공");
            } else {
                new BoardMenu().displayNodata();
            }
        } catch (Exception e) {
            e.printStackTrace();
            new BoardMenu().displayError("글 삭제 실패, 관리자에게 문의하세요");
        }
    }

    public void exitProgram() {
        boardService.exitProgram();
        System.out.println("프로그램을 종료합니다.");
    }
}
