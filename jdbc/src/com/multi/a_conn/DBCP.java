package com.multi.a_conn;

public class DBCP {
    private static DBCP instance = null;

    private DBCP(){} // 외부에서 생성 못하게 막아줌

    public static DBCP getInstance(){
        if(instance == null) {
            instance = new DBCP();
        }
        return instance;
    }
}
