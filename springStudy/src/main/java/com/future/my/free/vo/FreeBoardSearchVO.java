package com.future.my.free.vo;

import com.future.my.common.vo.PagingVO;

// PagingVO를 상속 받아서 부모의 변수와 메서드를 사용 가능.
public class FreeBoardSearchVO extends PagingVO{
	
	private String searchWord;		/* 검색 키워드 */
	private String searchType;		/* 검색 조건 타입(T:제목, W:작성자, C:내용)*/
//	private String searchCategory;	/* 게시판 카테고리 */
	
	private String searchCategory;
	public FreeBoardSearchVO() {
	}
	
	@Override
	public String toString() {
		return "FreeSearchVO [searchWord=" + searchWord + ", searchType=" + searchType + ", searchCategory="
				+ searchCategory + "]";
	}

	public String getSearchWord() {return searchWord;}
	public void setSearchWord(String searchWord) {this.searchWord = searchWord;}
	
	public String getSearchType() {return searchType;}
	public void setSearchType(String searchType) {this.searchType = searchType;}

	public String getSearchCategory() {
		return searchCategory;
	}

	public void setSearchCategory(String searchCategory) {
		this.searchCategory = searchCategory;
	}
	

}
