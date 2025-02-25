package com.multi.b_basic.view;

import com.multi.b_basic.model.dao.MemberDAO;
import com.multi.b_basic.model.dto.MemberDTO;

import javax.swing.*;

public class MemberTest3 {
    public static void main(String[] args) {
//        입력받은 정보를 dto로 넘겨서 row 생성

        String id = JOptionPane.showInputDialog("아이디 입력");
        String pw = JOptionPane.showInputDialog("패스워드 입력");
        String name = JOptionPane.showInputDialog("이름 입력");
        String tel = JOptionPane.showInputDialog("전화번호 입력");

        MemberDAO dao = new MemberDAO();

        // 생성자로 해보기
        // MemberDTO에 객체를 만들어서 정보를 넘겨줌

        MemberDTO memberDTO = new MemberDTO();
        memberDTO.setId(id);
        memberDTO.setPw(pw);
        memberDTO.setName(name);
        memberDTO.setTel(tel);

        int result = dao.insert(memberDTO);

        System.out.println(result);
    }
}
