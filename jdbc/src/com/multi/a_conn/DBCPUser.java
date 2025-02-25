package com.multi.a_conn;

public class DBCPUser {
    public static void main(String[] args) {
        // 싱글톤
        DBCP dbcp = DBCP.getInstance();

        System.out.println(dbcp);

        DBCP dbcp2 = DBCP.getInstance();

        System.out.println(dbcp2);
        // dbcp, dbcp2가 같은 객체를 참조함
    }
}
