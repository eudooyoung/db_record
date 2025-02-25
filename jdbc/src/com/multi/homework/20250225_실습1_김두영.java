//package com.multi.homework;
//
//import com.multi.c_jdbc.view.MemberMenu;
//
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//
//public class homework {
//    public void selectByName(String memberName) {
//        MemberMenu memberMenu = new MemberMenu();
//        Member member = memberService.selectByName(memberName);
//
//        if(member != null) {
//            memberMenu.displayMember(member);
//        } else {
//            memberMenu.displayNoData();
//        }
//    }
//
//    public Member selectByName(String memberName) {
//        Connection conn = getConnection();
//        Member m = memberDAO.selectByName(conn, memberName);
//        close(conn);
//        return m;
//    }
//
//    public Member selectByName(Connection conn, String memberName) {
//        Member m = null;
//        PreparedStatement pstmt = null;
//        ResultSet rs = null;
//
//        String sql = prop.getProperty("selectByName");
//
//        try {
//            pstmt = conn.prepareStatement(sql);
//
//            //SELECT * FROM STUDENT WHERE USERNAME LIKE ?
//            pstmt.setString(1, "%" + memberName + "%");
//
//            rs = pstmt.executeQuery();
//
//            if(rs.next()) {
//                m = new Member();
//
//                m.setUserNo(rs.getString("userno"));
//
//                m.setUserId(rs.getString("USERID"));
//                m.setPassword(rs.getString("PASSWORD"));
//                m.setUserName(rs.getString("USERNAME"));
//                m.setGender(rs.getString("GENDER"));
//                m.setAge(rs.getInt("AGE"));
//                m.setEmail(rs.getString("EMAIL"));
//                m.setPhone(rs.getString("PHONE"));
//                m.setAddress(rs.getString("ADDRESS"));
//                m.setHobby(rs.getString("HOBBY"));
//                m.setEnrollDate(rs.getTimestamp("ENROLLDATE").toLocalDateTime());
//            }
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//        finally {
//            close(rs);
//            close(pstmt);
//        }
//
//        return m;
//    }
//}
