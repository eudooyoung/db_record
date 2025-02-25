package com.multi.a_conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnectMysql {
    /* 1.Connection 객체연결하기
     * 2.Statement 객체 생성하기
     * 3.ResultSet 객체 생성하기
     * 4.Sql작성하기
     * 5.ResultSet  결과담기
     * 6.list 에 객체 하나씩 담기
     * 7.close 하기 (자원반납 - 생성의 역순)
     */
    public static void main(String[] args) {

        Connection con = null; // mysql 라이브러리 객체
        PreparedStatement ps = null; // 초기값 null

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("드라이버 로드 성공");

            String user = "scott";
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?";

            con = DriverManager.getConnection(url, user, password); // static 메소드 getConnection

            System.out.println("db 연결성공");

            // 오토 커밋 해제
            con.setAutoCommit(false);
            System.out.println("오토커밋 비활성화");

            // 데이터 삽입
            String sql = "insert into MEMBER values (null,'user01', 'user01', '오둥이', '010', CURRENT_TIMESTAMP())";
            ps = con.prepareStatement(sql);

            System.out.println("sql 객체 생성 성공");

            // result에 실행된 row수 반환
            int result = ps.executeUpdate();

            String sql1 = "insert into MEMBER values (null,'user01', 'user01', '오둥이', '010', CURRENT_TIMESTAMP())";
            ps = con.prepareStatement(sql1);

            System.out.println("sql 객체 생성 성공");

            int result1 = ps.executeUpdate();

            System.out.println("sql 실행 성공 결과 =>" + result1);



            // 트랜잭션 커밋
            if (result >= 1 && result1 >= 1) {
                System.out.println("데이터 입력 완료");
                con.commit();
                System.out.println("6. 트랜잭션 커밋 완료.");
            }
            // Query가 제대로 실행되지 않은 경우

            else {
                System.out.println("데이터 입력 실패");
                con.rollback();
            }


        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback(); // 예외 발생 시 롤백
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
                System.out.println("트랜잭션 롤백.");
            }
        } finally {
            try {
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
