package com.shop.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.shop.repository.QuestionRep;
import com.shop.vo.Question;
import com.shop.vo.QuestionComment;
import com.shop.vo.QuestionFile;

public class QuestionServiceImpl implements QuestionService {
	
	private QuestionRep questionRep;
	
	public QuestionRep getQuestionRep() {
		return questionRep;
	}

	
	public void setQuestionRep(QuestionRep questionRep) {
		this.questionRep = questionRep;
	}

	@Override
	public ArrayList<Question> findQuestions(String category){
		
		List<Question> questions = questionRep.selectQuestions(category);
		return (ArrayList<Question>)questions;
	}
	
//
//	@Override
//	public List<Question> findQuestionlist(String category) {
//		List<Question> questions = questionRep.selectQuestionlist(category);
//		return questions;
//	}

	@Override
	public int registerQuestion(Question question) {
		int newQuestionNo = questionRep.insertQuestion(question);
//		for(QuestionFile file : question.getFiles()) {
//			file.setQuestionNo(newQuestionNo);
//			questionRep.insertQuestionFile(file);
//			System.out.println(file);System.out.println(newQuestionNo);
//		}
		return newQuestionNo;
	}

	@Override
	public void registerQuestionFile(QuestionFile questionFile) {
		questionRep.insertQuestionFile(questionFile);
		
	}


	@Override
	public Question findQuestionByQuestionNo(int questionNo) {
		Question question = questionRep.selectQuestionByQuestionNo(questionNo);
		return question;
	}


	@Override
	public List<QuestionFile> findQuestionFilesByQuestionNo(int questionNo) {
		List<QuestionFile> files = questionRep.selectQuestionFilesByQuestionNo(questionNo);
		return files;
	}
	
	@Override
	public QuestionFile findQuestionFileByQuestionFileNo(int questionFileNo) {
		QuestionFile file = questionRep.selectQuestionFileByQuestionFileNo(questionFileNo);
		return file;
	}


	@Override
	public void deleteQuestion(int questionNo) {
		
		questionRep.deleteQuestion(questionNo);
		
	}

	@Override
	public void deleteQuestionFile(int fileNo) {
		
		questionRep.deleteQuestionFile(fileNo);	
		
	}


	@Override
	public void updateQuestion(Question question) {
		
		questionRep.updateQuestion(question);
		
	}


	@Override
	public void readCount(int questionNo) {
		questionRep.updateCount(questionNo);
	}
	
/* ==================================================== */
	
	@Override
	public void writeComment(QuestionComment comment) {
		
		questionRep.insertComment(comment);
		
	}
	
	@Override
	public void deleteComment(int commentNo) {
		questionRep.deleteComment(commentNo);
	}

	@Override
	public void updateComment(QuestionComment comment) {
		questionRep.updateComment(comment);		
	}

	@Override
	public List<QuestionComment> findCommentListByQuestionNo(int questionNo) {
		List<QuestionComment> comments = questionRep.selectCommentsByQuestionNo(questionNo);
		return comments;
	}
	
	@Override
	public void writeRecomment(QuestionComment comment) {		
		
		QuestionComment parent = questionRep.selectCommentByCommentNo(comment.getCommentNo());
		questionRep.updateCommentStep(parent);
		
		comment.setGroupNo(parent.getGroupNo());
		comment.setDepth(parent.getDepth() + 1);
		comment.setStep(parent.getStep() + 1);		
		
		questionRep.insertRecomment(comment);
	}
	


	@Override
	public String findPwdByQuestionNo(int questionNo) {
		
		String pwd = questionRep.selectPwdByQuestionNo(questionNo);
		return pwd;
	}


	@Override
	public List<Question> findMyQuestionList(String memberId) {
		List<Question> questions = questionRep.findMyQuestionList(memberId);
		return questions;
	}
	
	
	
	/**/
	
	@Override
	public List<QuestionComment> findCommentListByQuestionNoWithPaging(HashMap<String, Object> params) {

		List<QuestionComment> comments =
				questionRep.selectQuestionByQuestionNoWithPaging(params);
		
		return comments;
	}
	@Override
	public int findCommentsCountByQuestionNo(int questionNo) {
		int commentsCount = 
				questionRep.selectCommentsCountByQuestionNo(questionNo);
		return commentsCount;
	}

}
