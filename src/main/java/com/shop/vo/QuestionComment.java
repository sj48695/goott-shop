package com.shop.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class QuestionComment {

	private int commentNo;
	private int questionNo;
	private String writer;
	private String content;
	private Date regDate;
	private int groupNo;
	private int step;
	private int depth;
	
}
