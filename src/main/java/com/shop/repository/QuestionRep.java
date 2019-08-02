package com.shop.repository;

import java.util.ArrayList;
import java.util.List;

import com.shop.vo.Question;
import com.shop.vo.QuestionFile;
import com.shop.vo.QuestionComment;
import com.shop.vo.Question;

public interface QuestionRep {

	
	void insertQuestionFile(QuestionFile file);

	List<Question> selectQuestions();

	Question selectQuestion(int questionNo);

	ArrayList<QuestionFile> selectQuestionFile(int questionNo);

	QuestionFile selectQuestionFileByQuestionFileNo(int fileNo);

	ArrayList<QuestionFile> selectQuestionFilesByQuestionNo(int questionNo);

	Question selectQuestionByQuestionNo(int questionNo);

	void deleteQuestion(int questionNo);

	void deleteQuestionFile(int fileNo);

	void updateQuestion(Question question);

	int insertQuestion(Question question);

	void updateCount(int questionNo);
	
	/* ==================================================== */
	
	void insertComment(QuestionComment comment);
	
	void updateComment(QuestionComment comment);

	void deleteComment(int commentNo);

	ArrayList<QuestionComment> selectCommentsByQuestionNo(int questionNo);
	
	QuestionComment selectCommentByCommentNo(int commentNo);
	
	void updateCommentStep(QuestionComment comment);
	
	void insertRecomment(QuestionComment comment);
	
	List<Question> selectQuestionlist(String category);


}