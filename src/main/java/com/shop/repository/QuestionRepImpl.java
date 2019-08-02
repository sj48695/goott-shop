package com.shop.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.xml.stream.events.Namespace;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.jdbc.core.JdbcTemplate;

import com.shop.mapper.QuestionMapper;
import com.shop.vo.Question;
import com.shop.vo.QuestionFile;
import com.shop.vo.Question;
import com.shop.vo.QuestionComment;


public class QuestionRepImpl implements QuestionRep {
	
	private SqlSessionTemplate sessionTemplate;
	
	
	public SqlSessionTemplate getSessionTemplate() {
		return sessionTemplate;
	}

	public void setSessionTemplate(SqlSessionTemplate sessionTemplate) {
		this.sessionTemplate = sessionTemplate;
	}
	
	private QuestionMapper questionMapper;	

	public QuestionMapper getQuestionMapper() {
		return questionMapper;
	}

	public void setQuestionMapper(QuestionMapper questionMapper) {
		this.questionMapper = questionMapper;
	}
	

	//JDBC의 구조 코드를 단순하게 만드는 스프링의 클래스 
	private JdbcTemplate jdbcTemplate;

	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	@Override
	public int insertQuestion(Question question) {

		questionMapper.insertQuestion(question);
		return question.getQuestionNo();
		
	}
	
	@Override
	public void insertQuestionFile(QuestionFile file) {
		System.out.println(file);
		questionMapper.insertQuestionFile(file);
	
	}
		
	@Override
	public ArrayList<Question> selectQuestions() {

		List<Question> question = questionMapper.selectQuestions();

		return (ArrayList<Question>) question; // 호출한 곳으로 조회한 데이터를 반환

	}
	
	@Override
	public Question selectQuestion(int questionNo) {
			
		Question question = questionMapper.selectQuestion(questionNo);
			
		return question;
	}

@Override
public ArrayList<QuestionFile> selectQuestionFile(int questionNo) {
	
	List<QuestionFile> files = questionMapper.selectQuestionFilesByQuestionNo(questionNo);
	
	return (ArrayList<QuestionFile>)files;
	}
	
	@Override
	public QuestionFile selectQuestionFileByQuestionFileNo(int fileNo) {
		QuestionFile file = //sessionTemplate.selectOne(
	//			"com.springdemoweb.mapper.questionMapper.selectUploadFileByUploadFileNo",fileNo);
				questionMapper.selectQuestionFileByQuestionFileNo(fileNo);
		return file; //호출한 곳으로 조회한 데이터를 반환
	}
	
	
	@Override
	public ArrayList<QuestionFile> selectQuestionFilesByQuestionNo(int questionNo) {
	//	List<UploadFile> files = sessionTemplate.selectList(
	//			"com.springdemoweb.mapper.questionMapper.selectUploadFilesByUploadNo",uploadno);
		List<QuestionFile> files = questionMapper.selectQuestionFilesByQuestionNo(questionNo);
		
	    return (ArrayList<QuestionFile>)files;  //호출한 곳으로 조회한 데이터를 반환
	 }
	
	@Override
	public Question selectQuestionByQuestionNo(int questionNo) {
	//	Upload upload = sessionTemplate.selectOne(
	//			"com.springdemoweb.mapper.questionMapper.selectUploadByUploadNo",uploadNo);
		Question question = questionMapper.selectQuestionByQuestionNo(questionNo);
	    return question; //호출한 곳으로 조회한 데이터를 반환
	 }
	
	@Override
	public void deleteQuestion(int questionNo) {
		
		//sessionTemplate.delete("com.springdemoweb.mapper.questionMapper.deleteUpload", uploadNo);
		
		questionMapper.deleteQuestion(questionNo);
		
	}

	@Override
	public void deleteQuestionFile(int fileNo) {
	
		//sessionTemplate.delete(
		//		"com.springdemoweb.mapper.questionMapper.deleteUploadFile", fileNo);
		questionMapper.deleteQuestionFile(fileNo);
		
	}

	@Override
	public void updateQuestion(Question question) {
		sessionTemplate.update(
				"com.shop.mapper.QuestionMapper.updateQuestion", question);
		//questionMapper.updateUpload(upload);
	}

	@Override
	public void updateCount(int questionNo) {
		questionMapper.updateCount(questionNo);
	}
	
/* ==================================================== */
	
	@Override
	public void insertComment(QuestionComment comment) {

		//sessionTemplate.insert(
		//	"com.springdemoweb.mapper.questionMapper.insertComment", comment);
		questionMapper.insertComment(comment);
	}
	
	@Override
	public void updateComment(QuestionComment comment) {
		
		//sessionTemplate.update(
		//	"com.springdemoweb.mapper.questionMapper.updateComment", comment);
		questionMapper.updateComment(comment);
	}
	
	@Override
	public void deleteComment(int commentNo) {
				
		//sessionTemplate.delete(
		//	"com.springdemoweb.mapper.questionMapper.deleteComment", commentNo);
		questionMapper.deleteComment(commentNo);
	}

	@Override
	public ArrayList<QuestionComment> selectCommentsByQuestionNo(int questionNo) {
		List<QuestionComment> comments =
//			sessionTemplate.select(
//				"com.springdemoweb.mapper.questionMapper.selectCommentsByUploadNo", uploadNo);
			questionMapper.selectCommentsByQuestionNo(questionNo);
		return (ArrayList<QuestionComment>)comments;
	}
	
	@Override
	public QuestionComment selectCommentByCommentNo(int commentNo) {
		QuestionComment comment =
//			sessionTemplate.select(
//				"com.springdemoweb.mapper.questionMapper.selectCommentByCommentNo", commentNo);
			questionMapper.selectCommentByCommentNo(commentNo);
		return comment;
	}
	
	@Override
	public void updateCommentStep(QuestionComment comment) {
//		sessionTemplate.update(
//			"com.springdemoweb.mapper.questionMapper.updateCommentStep", params);
		questionMapper.updateCommentStep(comment);
	}
	
	@Override
	public void insertRecomment(QuestionComment comment) {

		//sessionTemplate.insert(
		//	"com.springdemoweb.mapper.questionMapper.insertComment", comment);
		questionMapper.insertRecomment(comment);
	}
	
	@Override
	public ArrayList<Question> selectQuestionlist(String category) {
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("category", category);
		//List<Question> Questions = QuestionMapper.selectQuestionlist(category);
		List<Question> Questions = questionMapper.selectQuestionlist(params);
		
		return (ArrayList<Question>) Questions;
	}

	
	

	
}


