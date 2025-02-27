package com.multi.d_dbcp.controller;

import com.multi.d_dbcp.model.dto.Member;
import com.multi.d_dbcp.service.MemberService;
import com.multi.d_dbcp.view.MemberMenu;

import java.util.ArrayList;

public class MemberController {
    /* 컨트롤러가 하는 역할은 뷰에서 사용자가 입력한 정보를 파라미터 형태로 전달받으면
     * 전달받은 값들을 검증하거나 추가적인 정보가 필요한 경우 가공을 한 뒤
     * 서비스쪽으로 전달하기 위한 인스턴스에 담고 서비스의 비즈니스 로직을 담당하는 메소드를 호출한다.
     * 또한 호출한 수행 결과를 반환받아 어떠한 뷰를 다시 사용자에게 보여줄 것인지를 결정하는 역할을 한다.
     * */
    //view 와 service를 연결해주는 객체
    // view <-> controller <->service <->dao <-> db

    private MemberService memberService = new MemberService();

    public void selectAll() {
        MemberMenu memberMenu = new MemberMenu();

        try {
            ArrayList<Member> list = memberService.selectAll();
            if (!list.isEmpty()) {
                memberMenu.displayMemberList(list);
            } else {
                memberMenu.displayNoData();
            }
        } catch (Exception e) {
            e.printStackTrace();
            memberMenu.displayError("회원 전체 조회 실패, 관리자에게 문의하세요");
        }
    }

    public void selectOne(String memberId) {
        MemberMenu memberMenu = new MemberMenu();

        try {
            Member member = memberService.selectOne(memberId);
            if (member != null) {
                memberMenu.displayMember(member);
            } else {
                memberMenu.displayNoData();
            }
        } catch (Exception e) {
            e.printStackTrace();
            memberMenu.displayError("회원 조회 실패, 관리자에게 문의하세요");
        }
    }

    public void selectByName(String memberName) {
        MemberMenu memberMenu = new MemberMenu();

        try {
            Member member = memberService.selectByName(memberName);
            if (member != null) {
                memberMenu.displayMember(member);
            } else {
                memberMenu.displayNoData();
            }
        } catch (Exception e) {
            e.printStackTrace();
            memberMenu.displayError("회원 조회 실패, 관리자에게 문의하세요");
        }
    }

    public void insertMember(Member member) {
        try {
            int result = memberService.insertMember(member);
            if (result > 0) {
                new MemberMenu().displaySuccess("회원가입 성공");
            }
        } catch (Exception e) {
            e.printStackTrace();
            new MemberMenu().displayError("회원 가입 실패, 관리자에게 문의하세요");
        }
    }

    public void updateMember(Member member) {
        try {
            int result = memberService.updateMember(member);
            if (result > 0) {
                new MemberMenu().displaySuccess("회원수정 성공");
            }
        } catch (Exception e) {
            e.printStackTrace();
            new MemberMenu().displayError("정보 수정 실패, 관리자에게 문의하세요");
        }
    }

    public void deleteMember(String memberId) {
        MemberMenu memberMenu = new MemberMenu();
        try {
            int result = memberService.deleteMember(memberId);
            if (result > 0) {
                memberMenu.displayDelete(memberId);
            } else {
                memberMenu.displayNoData();
            }
        } catch (Exception e) {
            e.printStackTrace();
            new MemberMenu().displayError("회원 삭제 실패, 관리자에게 문의하세요");
        }
    }

    public void selectAllDeleteMember() {
        MemberMenu memberMenu = new MemberMenu();
        try {
            ArrayList<Member> list = memberService.selectAllDeleteMember();

            if (!list.isEmpty()) {
                memberMenu.displayMemberList(list);
            } else {
                memberMenu.displayNoData();
            }
        } catch (Exception e) {
            e.printStackTrace();
            new MemberMenu().displayError("회원 삭제 실패, 관리자에게 문의하세요");
        }
    }

    public void exitProgram() {
        memberService.exitProgram();
        System.out.println("프로그램을 종료합니다.");
    }
}
