package com.shop.mapper;


import java.util.HashMap;
import java.util.List;

import com.shop.vo.Question;
import com.shop.vo.QuestionFile;
import com.shop.vo.QuestionComment;

//이 인터페이스의 패키지와 인터페이스 이름은 member-mapper.xml 파일의 namespace와 일치
public interface QuestionMapper {
	
	Question selectQuestion(int questionNo);
	List<Question> selectQuestions();
	
	Question selectQuestionByQuestionNo(int questionNo);
	
	List<QuestionFile> selectQuestionFilesByQuestionNo(int questionNo);
	
	QuestionFile selectQuestionFileByQuestionFileNo(int questionFileNo);
	
	void deleteQuestion(int questionNo);
	
	void insertQuestion(Question question);
	
	void insertQuestion2(Question question);
	
	void insertQuestionFile(QuestionFile file);

	void deleteQuestionFile(int questionFileNo);
	
	void updateQuestion(Question question);
	
	void updateCount(int questionNo);
	
	/* ==================================================== */

	void insertComment(QuestionComment comment);
	
	void updateComment(QuestionComment comment);

	void deleteComment(int commentNo);

	List<QuestionComment> selectCommentsByQuestionNo(int questionNo);
	
	void updateCommentStep(QuestionComment comment);
	
	void insertRecomment(QuestionComment comment);
	QuestionComment selectCommentByCommentNo(int commentNo);	
	
	List<Question> selectQuestionlist(HashMap<String, Object> params);

}
	
