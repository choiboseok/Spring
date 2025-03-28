package com.future.my.member.vo;
/**
 * Class Name  : MemberVO
 * Author      : Boseok
 * Created Date: 2025. 3. 19.
 * Version	   : 1.0
 * Purpose	   : members table VO or DTO
 * Description : 회원 정보 관리 빈
 */
public class MemberVO {
	private String memId;         /* 회원 아이디  */
	private String memPw;         /* 회원 비밀번호 */
	private String memNm;         /* 회원 이름  */
	private String profileImg;    /* 회원 프로필사진 경로 */
	private String memAddr;       /* 회우너 주소  */
	
	public MemberVO() {
	}

	@Override
	public String toString() {
		return "MemberVO [memId=" + memId + ", memPw=" + memPw + ", memNm=" + memNm + ", profileImg=" + profileImg
				+ ", memAddr=" + memAddr + "]";
	}
	
	public String getMemId() {return memId;}
	public void setMemId(String memId) {this.memId = memId;}
	
	public String getMemPw() {return memPw;}
	public void setMemPw(String memPw) {this.memPw = memPw;}
	
	public String getMemNm() {return memNm;}
	public void setMemNm(String memNm) {this.memNm = memNm;}

	public String getProfileImg() {return profileImg;}
	public void setProfileImg(String profileImg) {this.profileImg = profileImg;}

	public String getMemAddr() {return memAddr;}
	public void setMemAddr(String memAddr) {this.memAddr = memAddr;}
}
