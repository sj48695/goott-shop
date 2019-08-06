package com.shop.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Member {
	
	private String memberId;
	private String pwd;
	private String name;
	private String phone;
	private String postCode;
	private String roadAddr;
	private String jibunAddr;
	private String detailAddr;
	private String extraAddr;
	private Date regDate;
	
}
