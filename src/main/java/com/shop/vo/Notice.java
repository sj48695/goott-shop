package com.shop.vo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class Notice {

	
		private int questionNo;
		private String category;
		private String title;
		private String uploader;
		private String content;
		private int readCount;
		private Date regDate;    
		private boolean deleted;
		private boolean answer;
		private int recnt;
		
		
		//Upload Table과 UploadFile Table 사이의 1:Many 관계를 구현하는 필드
		private ArrayList<QuestionFile> files;
		
		//Upload Table과 UploadComment Table 사이의 1:Many 관계를 구현하는 필드
		private List<QuestionComment> comments;

}
