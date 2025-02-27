package com.multi.d_dbcp.model.dao;

import com.multi.d_dbcp.common.DBConnectionMgr;
import com.multi.d_dbcp.common.exception.MemberException;
import com.multi.d_dbcp.model.dto.Member;

import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Properties;
/* 1.Connection 객체연결하기
 * 2.Statement 객체 생성하기
 * 3.ResultSet 객체 생성하기
 * 4.Sql작성하기
 * 5.ResultSet  결과담기
 * 6.list 에 객체 하나씩 담기
 * 7.close 하기 (자원반납 - 생성의 역순)
 */

public class MemberDAO {
    private Properties prop = null;


    public MemberDAO() {

        try {
            prop = new Properties();
            prop.load(new FileReader("resources/query.properties"));
            //prop.loadFromXML(new FileInputStream("mapper/query_m.xml"));
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public ArrayList<Member> selectAll(Connection conn) {

        ArrayList<Member> list = new ArrayList<>();
        Statement stmt = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectAll");

        try {
            stmt = conn.createStatement();

            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Member m = new Member();

                // https://www.tutorialspoint.com/jdbc/jdbc-data-types.htm
                m.setUserNo(rs.getString("userno"));

                m.setUserId(rs.getString("USERID"));
                m.setPassword(rs.getString("PASSWORD"));
                m.setUserName(rs.getString("USERNAME"));
                m.setGender(rs.getString("GENDER"));
                m.setAge(rs.getInt("AGE"));
                m.setEmail(rs.getString("EMAIL"));
                m.setPhone(rs.getString("PHONE"));
                m.setAddress(rs.getString("ADDRESS"));
                m.setHobby(rs.getString("HOBBY"));
                m.setEnrollDate(rs.getTimestamp("ENROLLDATE").toLocalDateTime());

                list.add(m);
            }
        } catch (SQLException e) {
            throw new MemberException(e);
        } finally {
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, stmt, rs);
        }

        return list;
    }

    public Member selectOne(Connection conn, String memberId) {
        Member m = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectOne");

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);

            rs = pstmt.executeQuery();

            if(rs.next()) {
                m = new Member();

                m.setUserNo(rs.getString("userno"));

                m.setUserId(rs.getString("USERID"));
                m.setPassword(rs.getString("PASSWORD"));
                m.setUserName(rs.getString("USERNAME"));
                m.setGender(rs.getString("GENDER"));
                m.setAge(rs.getInt("AGE"));
                m.setEmail(rs.getString("EMAIL"));
                m.setPhone(rs.getString("PHONE"));
                m.setAddress(rs.getString("ADDRESS"));
                m.setHobby(rs.getString("HOBBY"));
                m.setEnrollDate(rs.getTimestamp("ENROLLDATE").toLocalDateTime());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, pstmt, rs);
        }

        return m;
    }

    public Member selectByName(Connection conn, String memberName) {
        Member m = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectByName");

        try {
            pstmt = conn.prepareStatement(sql);

            //SELECT * FROM STUDENT WHERE USERNAME LIKE ?
            pstmt.setString(1, "%" + memberName + "%");

            rs = pstmt.executeQuery();

            if(rs.next()) {
                m = new Member();

                m.setUserNo(rs.getString("userno"));

                m.setUserId(rs.getString("USERID"));
                m.setPassword(rs.getString("PASSWORD"));
                m.setUserName(rs.getString("USERNAME"));
                m.setGender(rs.getString("GENDER"));
                m.setAge(rs.getInt("AGE"));
                m.setEmail(rs.getString("EMAIL"));
                m.setPhone(rs.getString("PHONE"));
                m.setAddress(rs.getString("ADDRESS"));
                m.setHobby(rs.getString("HOBBY"));
                m.setEnrollDate(rs.getTimestamp("ENROLLDATE").toLocalDateTime());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, pstmt, rs);
        }

        return m;
    }

    public int insertMember(Connection conn, Member member) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql = prop.getProperty("insertMember");

        try {
            pstmt = conn.prepareStatement(sql);

            // 순서 확인!
            pstmt.setString(1, member.getUserId() );
            pstmt.setString(2, member.getPassword() );
            pstmt.setString(3, member.getUserName() );
            pstmt.setString(4, member.getGender() );
            pstmt.setInt(5, member.getAge() );
            pstmt.setString(6, member.getEmail() );
            pstmt.setString(7, member.getPhone() );
            pstmt.setString(8, member.getAddress() );
            pstmt.setString(9, member.getHobby() );

            result = pstmt.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, pstmt);
        }

        return result;
    }

    public int updateMember(Connection conn, Member member) {
        int result = 0;
        PreparedStatement pstmt = null;

        String sql = prop.getProperty("updateMember");

        try {
            pstmt = conn.prepareStatement(sql);

            // 순서 확인!
            pstmt.setString(1, member.getPassword() );
            pstmt.setString(2, member.getEmail() );
            pstmt.setString(3, member.getPhone() );
            pstmt.setString(4, member.getAddress() );
            pstmt.setString(5, member.getUserId());

            result = pstmt.executeUpdate();


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally{
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, pstmt);
        }

        return result;
    }

    public int deleteMember(Connection conn, String memberId) {
        int result = 0;
        PreparedStatement pstmt = null;
        String sql = prop.getProperty("deleteMember");

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memberId);

            result =  pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, pstmt);
        }

        return result;
    }

    public ArrayList<Member> selectAllDeleteMember(Connection conn) {

        ArrayList<Member> list = new ArrayList<>();

        Statement stmt = null;
        ResultSet rs = null;

        String sql = prop.getProperty("selectAllDeleteMember");

        try {
            stmt = conn.createStatement();

            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Member m = new Member();

                // https://www.tutorialspoint.com/jdbc/jdbc-data-types.htm
                m.setUserNo(rs.getString("userno"));

                m.setUserId(rs.getString("USERID"));
                m.setPassword(rs.getString("PASSWORD"));
                m.setUserName(rs.getString("USERNAME"));
                m.setGender(rs.getString("GENDER"));
                m.setAge(rs.getInt("AGE"));
                m.setEmail(rs.getString("EMAIL"));
                m.setPhone(rs.getString("PHONE"));
                m.setAddress(rs.getString("ADDRESS"));
                m.setHobby(rs.getString("HOBBY"));
                m.setEnrollDate(rs.getTimestamp("ENROLLDATE").toLocalDateTime());

                list.add(m);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            DBConnectionMgr dbcp = new DBConnectionMgr();
            dbcp.freeConnection(conn, stmt, rs);
        }

        return list;
    }
}
