package com.future.my.fish.vo;

public class FishVO {
	private String title; // 상품 설명
	private String img;   // 상품 이미지
	private String price; // 상품 가격
	
	public FishVO() {
	}
	
	@Override
	public String toString() {
		return "FishVO [title=" + title + ", img=" + img + ", price=" + price + "]";
	}

	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	
	
	
	
}
