package com.multi.c_jdbc.view;

import com.multi.c_jdbc.controller.MemberController;
import com.multi.c_jdbc.model.dto.Member;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;

public class MemberMenu {
    private static Scanner sc = new Scanner(System.in);
    private MemberController memberController = new MemberController();

    public void mainMenu() {
        int choice = 0;

        do {
            try {
                System.out.println("\n*******학생관리프로그램********");
                System.out.println("1.학생 전체 조회");// SELECT
                System.out.println("2.학생 아이디 조회");// SELECT
                System.out.println("3.학생 이름 조회");// SELECT _ 과제
                System.out.println("4.학생 가입");// INSERT
                System.out.println("5.학생 정보 변경");// UPDATE
                System.out.println("6.학생 탈퇴");// DELETE
                System.out.println("9.프로그램 끝내기");// 종료
                System.out.print("번호선택 : ");

                choice = sc.nextInt();  // 사용자로부터 입력 받기

                switch (choice) {
                    case 1:
                        memberController.selectAll();
                        break;
                    case 2:
                        memberController.selectOne(inputMemberId());
                        break;
                    case 3:
                         memberController.selectByName(inputMemberName());  // pstmt.setString(1, "%"+memberName+"%");
                        break;
                    case 4:
                         memberController.insertMember(inputMember());
                        break;
                    case 5:
                        //memberController.updateMember(updateMember());
                        break;
                    case 6:
                        //memberController.deleteMember(inputMemberId());
                        break;
                    case 7:
                        // memberController.selectAllDeleteMember();
                        break;
                    case 9:
                        System.out.println("정말로 끝내시겠습니까??(y/n)");
                        if ('y' == sc.next().toLowerCase().charAt(0)) {
                            //memberController.exitProgram();
                            return;  // 프로그램 종료
                        }
                        break;
                    default:
                        System.out.println("번호를 잘못입력하였습니다.");
                        break;
                }

            } catch (InputMismatchException e) {
                // 숫자가 아닌 값이 입력되었을 때 예외 처리
                System.out.println("유효한 숫자를 입력해 주세요.");
                sc.nextLine();  // 잘못된 입력을 버퍼에서 제거
            }
        } while (true);  // 무한 루프
    }

    private Member inputMember() {

        Member m = new Member();
        System.out.println("새로운 회원정보를 입력하세요 >>");
        System.out.println("아이디 : ");
        m.setUserId(sc.next());
        System.out.println("암호 : ");
        m.setPassword(sc.next());
        System.out.println("이름 : ");
        m.setUserName(sc.next());
        System.out.println("나이 : ");
        m.setAge(sc.nextInt());
        System.out.println("성별(M/F) : ");
        m.setGender(sc.next().toUpperCase());
        System.out.println("이메일 : ");
        m.setEmail(sc.next());
        System.out.println("전화번호(-빼고입력) : ");
        m.setPhone(sc.next());
        System.out.println("주소 : ");
        sc.nextLine();//입력버퍼의 enter 키 제거
        m.setAddress(sc.nextLine());
        System.out.println("취미 : ");
        m.setHobby(sc.next());

        return m;
    }

    private String inputMemberName() {
        System.out.println("이름 입력: ");

        return sc.next();
    }

    private String inputMemberId() {
            System.out.println("아이디입력 : ");

            return sc.next();
        }


    public void displayMemberList(ArrayList<Member> list) {
        System.out.println("\n조회된 전체 회원정보는 다음과 같습니다.");
        System.out.println("\n아이디\t이름\t성별\t나이\t이메일\t전화번호\t주소\t취미\t가입일");
        System.out.println("----------------------------------------------------------");

        for(Member m: list) {
            System.out.println(m);
        }
    }

    public void displayNoData() {
        System.out.println("조회된 결과가 없습니다.");
    }


    public void displayMember(Member member) {
        System.out.println("\n조회된  회원정보는 다음과 같습니다.");
        System.out.println("\n아이디\t이름\t성별\t나이\t이메일\t전화번호\t주소\t취미\t가입일");
        System.out.println("----------------------------------------------------------");

        System.out.println(member);
    }

    public void displaySuccess(String message) {
        System.out.println("서비스 요청결과: " + message);
    }
}

