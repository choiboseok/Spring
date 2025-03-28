package com.future.my.fish.vo;

public class FishVO {
	private String Title; // 상품 설명
	private String Img;   // 상품 이미지
	
	public FishVO() {
	}
	
	@Override
	public String toString() {
		return "FishVO [Title=" + Title + ", Img=" + Img + "]";
	}
	
	public String getTitle() {return Title;}
	public void setTitle(String title) {Title = title;}
	
	public String getImg() {return Img;}
	public void setImg(String img) {Img = img;}
}
