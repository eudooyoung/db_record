package com.multi.homework.board_prj.common.exception;

public class BoardException extends RuntimeException {

    public BoardException(String message) {
      super(message);
    }

    public BoardException(Exception e) {
    }
}
