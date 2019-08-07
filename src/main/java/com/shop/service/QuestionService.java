package com.shop.service;

import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Question;
import com.shop.vo.QuestionFile;
import com.shop.vo.Question;
import com.shop.vo.QuestionComment;

public interface QuestionService  {

	int registerQuestion(Question question);
	void registerQuestionFile(QuestionFile questionFile);
	ArrayList<Question> findQuestions(String category);
	Question findQuestionByQuestionNo(int questionNo);
	List<QuestionFile> findQuestionFilesByQuestionNo(int questionNo);
	QuestionFile findQuestionFileByQuestionFileNo(int questionFileNo);
	
	void deleteQuestion (int questionNo);
	void deleteQuestionFile(int fileNo);
	
	void updateQuestion(Question question);
	void readCount(int questionNo);
	
	/* ==================================================== */

	void writeComment(QuestionComment comment);
	
	void deleteComment(int commentNo);

	void updateComment(QuestionComment comment);

	List<QuestionComment> findCommentListByQuestionNo(int questionNo);
	
	void writeRecomment(QuestionComment comment);
	
	//List<Question> findQuestionlist(String category);
	
	String findPwdByQuestionNo(int questionNo);

	
	
}


