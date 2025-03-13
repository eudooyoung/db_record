package com.multi.homework.board_prj.model.dto;

import java.sql.Timestamp;

public class Board {

    private long no;
    private int categoryCode;
    private String title;
    private String content;
    private long writer;
    private Timestamp createdDate;
    private Timestamp modifiedDate;
    private String status;
    private int count;

    public Board() {
    }

    public Board(long no, int categoryCode, String title, String content, long writer, int count, Timestamp createdDate, Timestamp modifiedDate, String status) {
        this.no = no;
        this.categoryCode = categoryCode;
        this.title = title;
        this.content = content;
        this.writer = writer;
        this.count = count;
        this.createdDate = createdDate;
        this.modifiedDate = modifiedDate;
        this.status = status;
    }

    public long getNo() {
        return no;
    }

    public void setNo(long no) {
        this.no = no;
    }

    public int getCategoryCode() {
        return categoryCode;
    }

    public void setCategoryCode(int categoryCode) {
        this.categoryCode = categoryCode;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getWriter() {
        return writer;
    }

    public void setWriter(long writer) {
        this.writer = writer;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    public Timestamp getModifiedDate() {
        return modifiedDate;
    }

    public void setModifiedDate(Timestamp modifiedDate) {
        this.modifiedDate = modifiedDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Board{" +
                "no='" + no + '\'' +
                ", categoryCode=" + categoryCode +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", writer=" + writer +
                ", count=" + count +
                ", createdDate=" + createdDate +
                ", modifiedDate=" + modifiedDate +
                ", status=" + status +
                '}';
    }
}
