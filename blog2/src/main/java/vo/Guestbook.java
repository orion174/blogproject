package vo;

public class Guestbook {
	public Guestbook() {} // 생성자 메서드
	
	public int guestbookNo; // DB 기본키
	public String guestbookContent; // 방명록 글 내용
	public String guestbookPw; // 방명록 비밀번호
	public String writer; // 방명록 글쓴이
	public String createDate; // 생성날짜
	public String updateDate; // 최종 수정날짜
}
