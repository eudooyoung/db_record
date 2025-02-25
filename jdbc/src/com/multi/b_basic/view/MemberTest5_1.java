package com.multi.b_basic.view;

import com.multi.b_basic.model.dao.MemberDAO;
import com.multi.b_basic.model.dto.MemberDTO;

import javax.swing.*;

public class MemberTest5_1 {
    public static void main(String[] args) {
        // 아이디, 비밀번호 입력받아서 로그인 하기
        // 선생님 방식으로 다시 짜보기
        String id = JOptionPane.showInputDialog("아이디 입력");
        String pw = JOptionPane.showInputDialog("패스워드 입력");


        MemberDAO dao = new MemberDAO();

        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setId(id);
        memberDTO.setPw(pw);

        MemberDTO resultDto = dao.login(memberDTO);
        if(resultDto != null) {
            System.out.println("로그인 성공");
        } else {
            System.out.println("로그인 실패");
        }

    }
}
