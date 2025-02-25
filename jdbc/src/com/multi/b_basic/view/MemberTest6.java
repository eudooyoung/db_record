package com.multi.b_basic.view;

import com.multi.b_basic.model.dao.MemberDAO;
import com.multi.b_basic.model.dto.MemberDTO;

import javax.swing.*;

public class MemberTest6 {
    public static void main(String[] args) {
//      아이디 가져와서 전화번호 수정

        String id = JOptionPane.showInputDialog("아이디 입력");
        String tel = JOptionPane.showInputDialog("전화번호 입력");

        MemberDAO dao = new MemberDAO();

        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setId(id);
        memberDTO.setTel(tel);

        int result = dao.update(memberDTO);
        if(result > 0) {
            System.out.println("업데이트 성공");
        } else {
            System.out.println("실패");
        }
    }
}
