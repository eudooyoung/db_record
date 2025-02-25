package com.multi.b_basic.view;

import com.multi.b_basic.model.dao.MemberDAO;
import com.multi.b_basic.model.dto.MemberDTO;

import javax.swing.*;

public class MemberTest4 {
    public static void main(String[] args) {
//        아이디로 row 정보 출력

        String id = JOptionPane.showInputDialog("아이디 입력");

        MemberDAO dao = new MemberDAO();


        MemberDTO memberDTO = dao.selectOne(id);

        System.out.println(memberDTO);
    }
}
