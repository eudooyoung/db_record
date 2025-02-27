package com.multi.d_dbcp.service;

import com.multi.d_dbcp.common.DBConnectionMgr;
import com.multi.d_dbcp.common.exception.MemberException;
import com.multi.d_dbcp.model.dao.MemberDAO;
import com.multi.d_dbcp.model.dto.Member;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberService {
    private final MemberDAO memberDAO;
    Connection con = null;
    DBConnectionMgr dbcp;

    public MemberService() {
        dbcp = DBConnectionMgr.getInstance();

        if (dbcp.getConnectionCount() == 0) {
            try {
                dbcp.setInitOpenConnections(10);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

        memberDAO = new MemberDAO();
    }

    public ArrayList<Member> selectAll() {
        ArrayList<Member> list;
        try {
            con = dbcp.getConnection();
            list = memberDAO.selectAll(con);
        } catch (MemberException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }

        return list;
    }

    public Member selectOne(String memberId) {
        Member member;

        try {
            con = dbcp.getConnection();
            member = memberDAO.selectOne(con, memberId);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }

        return member;
    }

    public Member selectByName(String memberName) {
        Member member;

        try {
            con = dbcp.getConnection();
            member = memberDAO.selectByName(con, memberName);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }

        return member;

    }

    public int insertMember(Member member) {
        int result = 0;

        try {
            con = dbcp.getConnection();
            con.setAutoCommit(false);
            result = memberDAO.insertMember(con, member);

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }

        return result;
    }

    public int updateMember(Member member) {
        int result = 0;

        try {
            con = dbcp.getConnection();
            con.setAutoCommit(false);
            result = memberDAO.updateMember(con, member);

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }
        return result;
    }

    public int deleteMember(String memberId) {
        int result = 0;

        try {
            con = dbcp.getConnection();
            result = memberDAO.deleteMember(con, memberId);
            con.setAutoCommit(false);

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }

        return result;
    }

    public ArrayList<Member> selectAllDeleteMember() {
        ArrayList<Member> list;
        try {
            con = dbcp.getConnection();
            list = memberDAO.selectAllDeleteMember(con);
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) dbcp.freeConnection(con);
        }

        return list;
    }

    public void exitProgram() {
        dbcp.freeConnection(con);
    }
}
