package com.multi;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class Test {

    public static void main(String[] args) {

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

}
