package com.shop.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Review {
	private int reviewNo;
	private String content;
	private Date regDate;
	private float star;
	private String memberId;
	private int groupNo;
	private int step;
	private int depth;
	private int productNo;
}
