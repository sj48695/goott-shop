package com.shop.view;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.view.AbstractView;

import com.shop.vo.ProductImg;

public class DownloadView extends AbstractView {

	@Override
	protected void renderMergedOutputModel(
			Map<String, Object> params,	//Controller�뿉�꽌 �쟾�떖�븳 �뜲�씠�꽣媛� �쑀�엯�릺�뒗 �넻濡�
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ProductImg img = (ProductImg)params.get("file");
		
		//�떎�슫濡쒕뱶 泥섎━
		//1. 釉뚮씪�슦���뿉寃� 泥섎━�븷 �닔 �뾾�뒗 而⑦뀗痢좊줈 �븣�젮二쇱뼱�꽌 �떎�슫濡쒕뱶 泥섎━�븯�룄濡� 吏��젙
		response.setContentType("application/octet-stream");

		//2. �떎�슫濡쒕뱶 泥섎━�븷 �븣 �븘�슂�븳 �젙蹂� �젣怨�
		response.addHeader(
			"Content-Disposition", 
			String.format("Attachment;Filename=\"%s\"", 
				new String(img.getUserFileName().getBytes("utf-8"), "ISO-8859-1")));

		//3. �뙆�씪�쓣 �쓳�떟�뒪�듃由쇱뿉 湲곕줉
		ServletContext application = request.getServletContext();
		String file2 = application.getRealPath("/upload-files/" + img.getSavedFileName());
		BufferedInputStream istream = new BufferedInputStream(new FileInputStream(file2));
		BufferedOutputStream ostream = new BufferedOutputStream(response.getOutputStream());
		while (true) {
			int data = istream.read();
			if (data != -1) 
				ostream.write(data);
			else
				break;
		}
		istream.close();
		ostream.close();
	}

}
