package com.shop.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Product {

	private int productNo;
	private String title;
	private int price;
	private int count;
	private String content;
	private String category;
	private String productName;
	private String color;
	private String size;
	private Date regDate;
	private String managerId;
	
}
