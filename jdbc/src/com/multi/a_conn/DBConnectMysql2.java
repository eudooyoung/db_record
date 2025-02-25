package com.multi.a_conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnectMysql2 {
    public static void main(String[] args) {

//        Connection 인터페이스로 con이라는 객체 생성
        Connection con = null;

//        PreparedStatement 인터페이스 사용: sql 안에 여러가지 패러미터를 넘겨줘야 함
//        sql객체
        PreparedStatement ps = null;

        try {
            // 리플렉션
            Class.forName("com.multi.cj.jdbc.Driver");
            System.out.println("드라이버 로드 성공");

            String user = "scott"; // dbeaver에 저장된 user 와 맞춰서 기입
            String password = "tiger";
            String url = "jdbc:mysql://localhost:3306/jdbc?"; // 현재 로컬 호스트 url 확인

            // url, user, password 대로 디비버 로컬 호스트와 연결
            con = DriverManager.getConnection(url, user, password);

            System.out.println("db 연결 성공");

//            Connection 인터페이스 메소드
            con.setAutoCommit(false);
            System.out.println("오토커밋 비활성화");

//            실행될 sql 코드 그대로 삽입
            String sql = "insert into member values (null, 'user01', 'user01', '오둥이', '010', current_timestamp())";

//            Connection 인터페이스의 메소드: sql의 값을 sql에서 쓸 수 있는 문장으로 바꿔줌?

            ps = con.prepareStatement(sql);

            System.out.println("sql 객체 생성 성공");

            // ps가 실행한 row 수 반환
//            esecuteUpdate()가 호출될때 sql 실행됨
            int result = ps.executeUpdate();

            String sql1 = "insert into member values (1, 'user01', 'user01', '오둥이', '010', current_timestamp())";
            ps = con.prepareStatement(sql1);
            int result1 = ps.executeUpdate();

            System.out.println("sql 실행 성공 결과 =>" + result);
            System.out.println("sql1 실행 성공 결과 =>" + result1);

//            sql 과 sql1이 전부 실행 됐을 경우에만 커밋
//            : 트랜잭션 구현
            if(result >= 1 && result1 >= 1) {
                System.out.println("데이터 입력 완교");
                con.commit();
                System.out.println("6. 트랜잭션 커밋 완료.");
            } else {
                System.out.println("데이터 입력 실패");
                con.rollback();
            }

//            예외처리가 많으면 or로 묶어서 한번에 처리
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
//            getConnection() 으로 반환 받는 값이 null이 아니면
            if(con != null) {
                    try {
                        con.rollback();
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                System.out.println("트랜잭션 롤백.");
            }
        }  finally {
//            끝날때 객체 닫기
            try {
//                마지막에 열린거 먼저
                ps.close();
                con.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
