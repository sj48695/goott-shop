package com.shop.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.shop.common.Util;
import com.shop.service.QuestionService;
import com.shop.service.ShopService;
import com.shop.vo.Member;
import com.shop.vo.Product;
import com.shop.vo.Question;
import com.shop.vo.QuestionComment;
import com.shop.vo.QuestionFile;
@Controller
//@RequestMapping(path = "/qna")
public class QuestionController {

	@Autowired
	@Qualifier("questionService")
	private QuestionService questionService;
	
	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;
	
	@RequestMapping(path = "/qa-list", method = RequestMethod.GET)
	public String list(Model model) {
		
		ArrayList<Question> questions = questionService.findQuestions("all");
		ArrayList<Question> notice = questionService.findQuestions("all");
		
		for(Question question : questions) {
			question.setAnswer(false);
			List<QuestionComment> comments = questionService.findCommentListByQuestionNo(question.getQuestionNo());
			for(QuestionComment comment : comments) {
				if(comment.getWriter().equals("manager")) {
					question.setAnswer(true);
				}
			}
		}
		
		model.addAttribute("questions", questions);
		model.addAttribute("notice", notice);
		
		return "question/qa-list"; 
	}
	
	@RequestMapping(path = "/qa-list", method = RequestMethod.POST)
	public String list(String category, Model model) {
		
		ArrayList<Question> questions = questionService.findQuestions(category);
		ArrayList<Question> notice = questionService.findQuestions(category);
		
		for(Question question : questions) {
			question.setAnswer(false);
			List<QuestionComment> comments = questionService.findCommentListByQuestionNo(question.getQuestionNo());
			for(QuestionComment comment : comments) {
				if(comment.getWriter().equals("manager")) {
					question.setAnswer(true);
				}
			}
		}
		
		model.addAttribute("questions", questions);
		model.addAttribute("notice", notice);
		
		return "question/qa-list"; 
	}
	
//	@RequestMapping(path = "/qacategory", method = RequestMethod.POST)
//	public String category(String category, Model model) {
//
//		if(category == null) {
//			category = "all";
//		}
//		
//		List<Question> questions = questionService.findQuestions(category);
//		
//		model.addAttribute("questions", questions);		
//		return "question/qa-list";
//	
//	}
	
	@RequestMapping(path="/qa-write", method = RequestMethod.GET)
	public String writeForm() {
		
		return "question/qa-write"; 
	}
	
	@RequestMapping(path="/qa-write", method = RequestMethod.POST)
	public String write(Question question, Model model, HttpSession session) {
		
		System.out.println(question);
		
		
		Member member = (Member) session.getAttribute("loginuser");
		if (member != null) {
			questionService.registerQuestion(question);
			model.addAttribute("question",question);
			
			//return "redirect:qa-list";  //상대경로
			return "redirect:coding.do";
		}else {
			return "redirect:/";
		}
		
	}
	
	
	@RequestMapping(path="/qa-detail/{questionNo}", method = RequestMethod.GET)
	public String detail(@PathVariable int questionNo, Model model) {
		
	      
	      Question question = questionService.findQuestionByQuestionNo(questionNo);
	      if (question == null) {

	         return "redirect:qa-list";
	      }
	      
	      List<QuestionFile> files = questionService.findQuestionFilesByQuestionNo(questionNo);
	      question.setFiles((ArrayList<QuestionFile>)files); 
	      
	      
	      int pageSize = 2;
		  int currentPage = 1;
		
		  int from = (currentPage - 1) * pageSize + 1;
		  int to = from + pageSize;
		
		  HashMap<String, Object> params = new HashMap<String, Object>();
		  params.put("questionNo", questionNo);
		  params.put("from", from);
		  params.put("to", to);
		  
	      List<QuestionComment> comments = 
	    		  //questionService.findCommentListByQuestionNo(questionNo);
	    		  questionService.findCommentListByQuestionNoWithPaging(params);
	      question.setComments(comments);
	      
	      questionService.readCount(questionNo);
	      
	     model.addAttribute("question", question);
	      
	      int commentsCount = 
					questionService.findCommentsCountByQuestionNo(questionNo);
			
	      model.addAttribute("commentsCount", commentsCount);
		
		return "question/qa-detail"; 
	}
	
	@RequestMapping(path="/productSelect", method = RequestMethod.GET)
	public String productSelectForm(Model model ) {
		
		
		List<Product> products = shopService.findProducts();
		
		model.addAttribute("products", products);
		
		return "question/productSelect"; 
	}
	
//	@RequestMapping(path="/productSelect", method = RequestMethod.POST)
//	public String productSelect(Model model ) {
//		
//		Products products = shopService.findProducts();
//		
//		model.addAttribute("products", products);
//		return null;
//	}
//	
	
	@RequestMapping(path="/pwCheck/{questionNo}", method = RequestMethod.GET)
	public String pwCheckForm(@PathVariable int questionNo, Model model) {
		
		model.addAttribute(questionNo);
		
		return "question/pwCheck"; 
	}
	
	@RequestMapping(path="/pwCheck", method = RequestMethod.POST)
	public String pwCheck( String pwd, int questionNo, Model model ) {
		
		String checkPwd = questionService.findPwdByQuestionNo(questionNo);
		if(pwd.equals(checkPwd)) {
			
			Question question = questionService.findQuestionByQuestionNo(questionNo);
			model.addAttribute(question);
			
			return "redirect:/qa-detail/" + questionNo;
		}else {
			return "redirect:/pwCheck/" + questionNo;
		}
	}


	
	@RequestMapping(path="/delete/{questionNo}", method = RequestMethod.GET)
	public String delete(@PathVariable int questionNo) {
	      
	      questionService.deleteQuestion(questionNo);
	          
	      return "redirect:/qa-list"; 
	    
	}
	
	//@PathVariable : 요청 경로의 {}부분을 데이터로 읽는 annotation
		@RequestMapping(path = "/qa-update/{questionNo}", method = RequestMethod.GET)
		public String updateForm(@PathVariable  int questionNo, Model model) {

			
			
			Question question = questionService.findQuestionByQuestionNo(questionNo);
			if (question == null) { //uploadno가 유효하지 않은 경우 (데이터베이스에 없는 번호인 경우)
				return "redirect:/question/qa-list";
			}		
			List<QuestionFile> files = questionService.findQuestionFilesByQuestionNo(questionNo);
			question.setFiles((ArrayList<QuestionFile>)files); //Upload : UploadFile == 1 : Many
			 
			
			
			//조회 결과를 request 객체에 저장 (JSP에서 사용할 수 있도록)
			model.addAttribute("question", question);

			
			return "question/qa-update";
		}
		
		//@PathVariable : 요청 경로의 {}부분을 데이터로 읽는 annotation
		@RequestMapping(path = "/delete-file/{questionNo}/{fileNo}", method = RequestMethod.GET)
		public String deleteFile(
				@PathVariable int questionNo, @PathVariable int fileNo, Model model) {
			
			QuestionFile file = questionService.findQuestionFileByQuestionFileNo(fileNo);
			
			//파일 삭제
			File f = new File(file.getSavedFileName());
			if (f.exists()) {
				f.delete();
			}		
			//데이터베이스에서 파일 데이터 삭제		
			questionService.deleteQuestionFile(fileNo);

			
			return "redirect:/qa-update/" + questionNo;
		}
		
		@RequestMapping(path = "/qa-update", method = RequestMethod.POST)
		public String update(MultipartHttpServletRequest req, Question question) {

			MultipartFile mf = req.getFile("attach");
			if(mf != null) {
				
				ServletContext application = req.getServletContext();
				String path = application.getRealPath("/resources/files/question-files");
				
				String userFileName = mf.getOriginalFilename();
				if (userFileName.contains("\\")) { 
					userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
				}
				
				String savedFileName = Util.makeUniqueFileName(userFileName);
				
				
				try {
					mf.transferTo(new File(path, savedFileName));
				
					QuestionFile questionFile = new QuestionFile();
					questionFile.setUserFileName(userFileName);
					questionFile.setSavedFileName(savedFileName);
					questionFile.setQuestionNo(question.getQuestionNo());
					questionService.registerQuestionFile(questionFile);
					
					
					questionService.updateQuestion(question);
					
				}catch(Exception ex) {
					ex.printStackTrace();
				}
				
			}

			
			return "redirect:/qa-detail/" + question.getQuestionNo();
		}
		
		/* ================================================================= */
		
		@RequestMapping(path = "/write-comment", 
						method = RequestMethod.POST, 
						produces = "text/plain;charset=utf-8") 
		@ResponseBody 
		public String writeComment(QuestionComment comment) {
			
			questionService.writeComment(comment);
			
			
			return "success"; 
		}
		
		@RequestMapping(path = "/write-recomment", 
				method = RequestMethod.POST, 
				produces = "text/plain;charset=utf-8") 
		@ResponseBody 
		public String writeRecomment(QuestionComment comment) {
		
			questionService.writeRecomment(comment);
			
			return "success"; 
		}
		
		@RequestMapping(value = "/comment-list", method = RequestMethod.POST)
		public String commentList(int questionNo, Model model) {
			
			List<QuestionComment> comments = questionService.findCommentListByQuestionNo(questionNo);
			model.addAttribute("comments", comments);
			
			return "question/comments"; 
		}
		
		@RequestMapping(value = "/delete-comment", method = RequestMethod.GET)
		@ResponseBody
		public String deleteComment(int commentNo) {
			
			questionService.deleteComment(commentNo);
			
			return "success";
		}
		
		@RequestMapping(value = "/update-comment", method = RequestMethod.POST)
		@ResponseBody
		public String updateComment(QuestionComment comment) {
			
			questionService.updateComment(comment);
			
			return "success";
		}
		
		/*----------------------------*/
			
	
		
		
		  @RequestMapping(value = "/coding.do")
		    public String coding() {
		        return "redirect:qa-list";
		    }
		  
		 @RequestMapping(value = "/insertBoard.do", method = RequestMethod.POST)
		    public String insertBoard(String editor) {
		        System.err.println("저장할 내용 : " + editor);
		        return "redirect:/coding.do";
		    }
		 
		 @RequestMapping(value = { "/question/editor-image-upload" }, method = RequestMethod.POST, produces = "text/plain;charset=utf-8")
			@ResponseBody
			public String editorImageUpload(HttpServletRequest req) {
				
				try {
					String sFileInfo = "";
					//파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
					String name = req.getHeader("file-name");
					String ext = name.substring(name.lastIndexOf(".") + 1);
					//파일 기본경로
					String defaultPath = req.getServletContext().getRealPath("/resources/files/question-files/");
					//파일 기본경로 _ 상세경로
					String path = defaultPath + File.separator;
					File file = new File(path);
					if(!file.exists()) {
					    file.mkdirs();
					}
					String realname = UUID.randomUUID().toString() + "." + ext;
					InputStream is = req.getInputStream();
					OutputStream os=new FileOutputStream(path + realname);
					int numRead;
					// 파일쓰기
					byte b[] = new byte[Integer.parseInt(req.getHeader("file-size"))];
					while((numRead = is.read(b,0,b.length)) != -1){
					    os.write(b,0,numRead);
					}
					if(is != null) {
					    is.close();
					}
					os.flush();
					os.close();
					sFileInfo += "&bNewLine=true&sFileName="+ name+"&sFileURL="+"/shop/resources/files/question-files/"+realname;
					
					return sFileInfo;
				} catch (Exception ex) {
					return "error upload file";
				}
			} 
		
		 
		 
		 
	/*----------------mypage---------------*/
		 
	@RequestMapping(path = "/account/myQuestionList", method = RequestMethod.GET)
	public String MyQuestionList(Model model, HttpSession session) {
		
		Member loginuser = (Member) session.getAttribute("loginuser");
		String memberId = loginuser.getMemberId();

		List<Question> questions = questionService.findMyQuestionList(memberId);
			
		for(Question question : questions) {
			question.setAnswer(false);
			List<QuestionComment> comments = questionService.findCommentListByQuestionNo(question.getQuestionNo());
			for(QuestionComment comment : comments) {
				if(comment.getWriter().equals("manager")) {
					question.setAnswer(true);
				}
			}
		}
		
		model.addAttribute("questions", questions);
		model.addAttribute("loginuser", loginuser);
		
		return "account/myQuestionList"; 
	}
		 
}
