package com.shop.vo;

import java.sql.Date;
import java.util.ArrayList;

import lombok.Data;

@Data
public class Buy {

	private int buyNo;
	private int productNo;
	private int count;
	private int price;
	private String productName;
	private String color;
	private String size;
	private String name;
	private String phone;
	private String address;
	private Date buyDate;
	private String orderMsg;
	private String memberId;

	private ProductFile file;
	private ArrayList<ProductFile> files;
	private String title;
	private int cnt;
	
}
