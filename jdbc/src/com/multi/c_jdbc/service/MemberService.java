package com.multi.c_jdbc.service;

import com.multi.c_jdbc.model.dao.MemberDAO;
import com.multi.c_jdbc.model.dto.Member;

import java.sql.Connection;
import java.util.ArrayList;

import static com.multi.c_jdbc.common.JDBCConnect.*;
import static com.multi.c_jdbc.common.JDBCConnect.getConnection;

public class MemberService {
    private final MemberDAO memberDAO;

    public MemberService() {
        memberDAO = new MemberDAO();
    }

    public ArrayList<Member> selectAll () {
        Connection conn = getConnection();
        ArrayList<Member> list = memberDAO.selectAll(conn);
        close(conn);

        return list;
    }

    public Member selectOne(String memberId) {
        Connection conn = getConnection();
        Member m = memberDAO.selectOne(conn, memberId);
        close(conn);
        return m;
    }

    public Member selectByName(String memberName) {
        Connection conn = getConnection();
        Member m = memberDAO.selectByName(conn, memberName);
        close(conn);
        return m;
    }

    public int insertMember(Member member) {
        Connection conn = getConnection();
        int result = memberDAO.insertMember(conn, member);
        if(result > 0) commit(conn);
        else rollback(conn);
        close(conn);

        return result;
    }

    public int updateMember(Member member) {
        Connection conn = getConnection();
        int result = memberDAO.updateMember(conn, member);
        if(result > 0) commit(conn);
        else rollback(conn);
        close(conn);

        return result;
    }

    public int deleteMember(String memberId) {
        Connection conn = getConnection();
        int result = memberDAO.deleteMember(conn, memberId);
        if(result > 0) commit(conn);
        else rollback(conn);
        close(conn);

        return result;
    }

    public ArrayList<Member> selectAllDeleteMember() {
        Connection conn = getConnection();
        ArrayList<Member> list = memberDAO.selectAllDeleteMember(conn);
        close(conn);

        return list;
    }
}
