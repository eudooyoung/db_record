package com.multi.homework.board_prj.view;

import com.multi.homework.board_prj.controller.BoardController;
import com.multi.homework.board_prj.model.dto.Board;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;

//    Board 테이블로 crud 완성 해보기
//    전체조회, 1건 조회, 추가 , 수정 , 삭제 , 예외처리  까지 ,
//    view , controller ,service, dao 로 구분해서 만들어주세요
//    20250226_실습1_이름.zip
public class BoardMenu {

    //    메뉴 입력받기 위한 스캐너 생성
    private static Scanner sc = new Scanner(System.in);

    //    메뉴 클래스 내에서 사용할 컨트롤러 객체 생성
    private BoardController boardController = new BoardController();

    public void mainMenu() {
        int choice = 0; // 메뉴를 입력받기 위한 변수 선언 및 초기화

        do {
            try {
                System.out.println("\n-----게시판 관리 프로그램-----");
                System.out.println("1. 전체 글 조회");
                System.out.println("2. 글 번호 검색");
                System.out.println("3. 새글 등록");
                System.out.println("4. 게시글 수정");
                System.out.println("5. 게시글 삭제");
                System.out.println("9. 프로그램 종료");

                choice = sc.nextInt();
                sc.nextLine();
                switch (choice) {
                    case 1 -> boardController.selectAll();
                    case 2 -> boardController.selectOne(inputNo());
                    case 3 -> boardController.insertPost(inputPost());
                    case 4 -> boardController.updatePost(updatePost());
                    case 5 -> boardController.deletePost(inputNo());
                    case 9 -> {
                        System.out.println("정말로 끝내시겠습니까??(y/n)");
                        if ('y' == sc.next().toLowerCase().charAt(0)) {
                            boardController.exitProgram();
                            return;
                        }
                    }
                }
            } catch (InputMismatchException e) {
                System.out.println("유효한 숫자를 입력해 주세요.");
                sc.nextLine();
            }
        } while (true);

    }

    private Board updatePost() {
        Board board = new Board();
        System.out.println("수정할 글의 번호를 입력하세요.");
        board.setNo(inputNo());
        System.out.println("카테고리(공통: 10, 운동: 20, 요리: 30, 기타: 70): ");
        board.setCategoryCode(sc.nextInt());
        sc.nextLine();
        System.out.println("제목: ");
        board.setTitle(sc.nextLine());
        System.out.println("내용: ");
        board.setContent(sc.nextLine());

        return board;
    }

    private long inputNo() {
        System.out.println("글 번호 입력: ");

        return sc.nextLong();
    }

    private Board inputPost() {

        Board board = new Board();
        System.out.println("새로운 글의 정보를 입력하세요 >>");
        System.out.println("카테고리(공통: 10, 운동: 20, 요리: 30, 기타: 70): ");
        board.setCategoryCode(sc.nextInt());
        sc.nextLine();
        System.out.println("제목: ");
        board.setTitle(sc.nextLine());
        System.out.println("내용: ");
        board.setContent(sc.nextLine());
        System.out.println("작성자(멤버 번호를 정확하게 입력하세요): ");
        board.setWriter(sc.nextInt());
        sc.nextLine();//입력버퍼의 enter 키 제거

        return board;
    }

    public void displayBoardList(ArrayList<Board> list) {
        System.out.println("\n조회된 게시글 정보는 다음과 같습니다.");
        System.out.println("\n글번호\t카테고리\t제목\t내용\t작성자\t조회수\t생성일\t수정일\t상태");
        System.out.println("----------------------------------------------------------");

        for(Board m: list) {
            System.out.println(m);
        }
    }

    public void displayNodata() {
        System.out.println("조회된 결과가 없습니다.");
    }

    public void displayError(String message) {
        System.out.println("서비스 요청 처리 실패: " + message);
    }

    public void displaySuccess(String message) {
        System.out.println("서비스 요청 결과: " + message);
    }

    public void displayPost(Board board) {
        System.out.println("\n조회된 게시글 정보는 다음과 같습니다.");
        System.out.println("\n글번호\t카테고리\t제목\t내용\t작성자\t조회수\t생성일\t수정일\t상태");
        System.out.println("----------------------------------------------------------");

        System.out.println(board);
    }
}
