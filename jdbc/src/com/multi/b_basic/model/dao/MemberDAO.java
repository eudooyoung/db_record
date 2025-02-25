package com.multi.b_basic.model.dao;

import com.multi.b_basic.model.dto.MemberDTO;

import java.sql.*;
import java.util.ArrayList;

public class MemberDAO {

    public int insert(String id, String pw, String name, String tel) {

        int result = 0;

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");

            String sql = "insert into MEMBER values (null, ?, ?, ?, ?, now())";

            ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, pw);
            ps.setString(3, name);
            ps.setString(4, tel);

            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }

    public int delete(String id) {
        int result = 0;

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");

            String sql = "delete from member where id = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, id);

            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }

    public int insert(MemberDTO memberDTO) {

        int result = 0;

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");

            String sql = "insert into MEMBER values (null, ?, ?, ?, ?, now())";

            ps = con.prepareStatement(sql);
            ps.setString(1, memberDTO.getId());
            ps.setString(2, memberDTO.getPw());
            ps.setString(3, memberDTO.getName());
            ps.setString(4, memberDTO.getTel());

            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }

    public MemberDTO selectOne(String id) {

        MemberDTO memberDTO = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");


            String sql = "select * from member where id = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, id);


            rs = ps.executeQuery();

            if(rs.next()){
                System.out.println("검색 결과 있음");
                String id2 = rs.getString("id");
                String pw = rs.getString("pw");
                String name = rs.getString(4);
                String tel = rs.getString("tel");

                // 생성자로 해보기
                memberDTO = new MemberDTO();
                memberDTO.setId(id2);
                memberDTO.setPw(pw);
                memberDTO.setName(name);
                memberDTO.setTel(tel);

            }


        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return memberDTO;

    }

    public MemberDTO login(String id, String pw) {
        MemberDTO memberDTO = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");


            String sql = "select * from member where id = ? and pw = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, pw);

//            ps.setString(1, memberDTO.getId());
//            ps.setString(2, memberDTO.getPw());


            rs = ps.executeQuery();

            //  * 6.list 에 객체 하나씩 담기
            if(rs.next()){
                System.out.println("로그인 성공");
                String id2 = rs.getString("id");
                String pw2 = rs.getString("pw");
                String name = rs.getString(4);
                String tel = rs.getString("tel");

                // 생성자로 해보기
                memberDTO = new MemberDTO();
                memberDTO.setId(id2);
                memberDTO.setPw(pw2);
                memberDTO.setName(name);
                memberDTO.setTel(tel);

            } else {
                System.out.println("로그인 실패");
            }


        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return memberDTO; //memberDTO 이름 바꿔서 확인
    }


    public int update(MemberDTO memberDTO) {

        int result = 0;

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");

            String sql = "update MEMBER set tel = ? where id =  ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, memberDTO.getTel());
            ps.setString(2, memberDTO.getId());

            result = ps.executeUpdate();

            if (result > 0) {
                con.commit();
            } else {
                con.rollback();
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return result;
    }

    public ArrayList<MemberDTO> selectALL() {
//        MemberDTO memberDTO = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<MemberDTO> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");

            String sql = "select * from member";

            ps = con.prepareStatement(sql);


            rs = ps.executeQuery();

            //  * 6.list 에 객체 하나씩 담기
            while(rs.next()){
                System.out.println("검색 결과 있음");
                String id2 = rs.getString("id");
                String pw2 = rs.getString("pw");
                String name = rs.getString(4);
                String tel = rs.getString("tel");

                // 생성자로 해보기
                MemberDTO memberDTO = new MemberDTO();
                memberDTO.setId(id2);
                memberDTO.setPw(pw2);
                memberDTO.setName(name);
                memberDTO.setTel(tel);

                list.add(memberDTO);
            }
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return list;
    }

    public MemberDTO login(MemberDTO memberDTO) {
        MemberDTO memberDTO2 = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            // static 메소드 getConnection
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);

            System.out.println("오토커밋 비활성화");


            String sql = "select * from member where id = ? and pw = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, memberDTO.getId());
            ps.setString(2, memberDTO.getPw());

//            ps.setString(1, memberDTO.getId());
//            ps.setString(2, memberDTO.getPw());


            rs = ps.executeQuery();

            if(rs.next()){
                System.out.println("검색 결과 있음");
                String id2 = rs.getString("id");
                String pw2 = rs.getString("pw");
                String name = rs.getString(4);
                String tel = rs.getString("tel");

                // 생성자로 해보기
                memberDTO2 = new MemberDTO();
                memberDTO2.setId(id2);
                memberDTO2.setPw(pw2);
                memberDTO2.setName(name);
                memberDTO2.setTel(tel);

                System.out.println((memberDTO2));

            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            try {
                rs.close();
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return memberDTO2; //memberDTO 이름 바꿔서 확인
    }
}
