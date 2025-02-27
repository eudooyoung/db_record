package com.multi.d_dbcp.common.exception;

public class MemberException extends RuntimeException {
    public MemberException(String message) {
        super(message);
    }

    public MemberException(Exception e) {

    }
}
