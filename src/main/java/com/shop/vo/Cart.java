package com.shop.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Cart {

	private int cartNo;
	private int productNo;
	private int count;
	private int price;
	private String productName;
	private String color;
	private String size;
	private Date regDate;
	private String memberId;
	
	
	private String title;
	
}
