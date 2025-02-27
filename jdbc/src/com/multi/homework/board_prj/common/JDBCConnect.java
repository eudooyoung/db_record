package com.multi.homework.board_prj.common;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCConnect {
    private static Connection conn = null;

    public static Connection getConnection() {
        Properties prop = new Properties();

        try {
            if (conn == null || conn.isClosed()) {
                prop.load(new FileReader("resources/driver.properties"));
                Class.forName(prop.getProperty("driver"));
                System.out.println("드라이버 등록 성공");

                String url = prop.getProperty("url");

                conn = DriverManager.getConnection(url, prop);
                System.out.println("conn=" + conn);

                conn.setAutoCommit(false);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        return conn;
    }

    public static void close(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.commit();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void commit(Connection con) {
        try {
            if(con != null && !con.isClosed()) {
                con.commit();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void rollback(Connection con) {
        try {
            if(con != null && !con.isClosed()) {
                con.rollback();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
