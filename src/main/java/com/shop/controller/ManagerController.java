package com.shop.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.shop.common.Util;
import com.shop.service.ManagerService;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

@Controller
@RequestMapping(value="/manager")
public class ManagerController {
	
	@Autowired
	@Qualifier("managerService")
	private ManagerService managerService;
	
	
	@RequestMapping(value="/write-product", method = RequestMethod.GET)
	public String writeProductForm(){
		return "/manager/write-product";
	}
	
	@RequestMapping(value="/write-product", method = RequestMethod.POST)
	public String writeProduct(MultipartHttpServletRequest req, Product product){
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("/resources/files/product-files");// 최종 파일 저장 경로
		String userFileName = "";
		try {

//			MultipartFile titleImg = req.getFile("titleImgFile");
//			if (titleImg != null) {
//				userFileName = titleImg.getOriginalFilename();
//				if (userFileName.contains("\\")) { // iexplore 경우
//					// C:\AAA\BBB\CCC.png -> CCC.png
//					userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
//				}
//				if (userFileName != null && userFileName.length() > 0) { // 내용이 있는 경우
//					if (userFileName.contains("\\")) { // iexplore 경우
//						// C:\AAA\BBB\CCC.png -> CCC.png
//						userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
//					}
//					String uniqueFileName = Util.makeUniqueFileName(path, userFileName);// 파일이름_1.jpg
//					// String uniqueFileName=Util.makeUniqueFileName(fileName);//고유한 파일이름.jpg
//					titleImg.transferTo(new File(path, uniqueFileName));// 파일 저장
//
//					SpaceFile spaceFile = new SpaceFile();
//					spaceFile.setSavedFileName(uniqueFileName);
//					spaceFile.setFlag(true);
//					space.setFile(spaceFile);
//				}
//			}

			List<MultipartFile> img = req.getFiles("imgFile");

			if (img != null) {
				File file = new File(path);
				ArrayList<ProductFile> files = new ArrayList<ProductFile>();

				for (int i = 0; i < img.size(); i++) {
					userFileName = img.get(i).getOriginalFilename();
					if (userFileName.contains("\\")) { // iexplore 경우
						// C:\AAA\BBB\CCC.png -> CCC.png
						userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
					}
					if (userFileName != null && userFileName.length() > 0) { // 내용이 있는 경우

						System.out.println(userFileName + " 업로드");
						// 파일 업로드 소스 여기에 삽입
						String uniqueFileName = Util.makeUniqueFileName(path, userFileName);// 파일이름_1.jpg
						file = new File(path, uniqueFileName);
						img.get(i).transferTo(file);

						ProductFile productFile = new ProductFile();
						productFile.setFileName(uniqueFileName);
						files.add(productFile);
						product.setFiles(files);
					}
				}
			}
			System.out.println(product);
			managerService.registerProductTx(product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/";
	
	}
	
	@RequestMapping(value="/list-product", method = RequestMethod.GET)
	public String listProduct(Model model){
		// 전체리스트
		List<Product> products = managerService.findProductList();
		if(products == null) {
			return "redirect:/";
		}
		
		for(Product product : products) {
			product.setFile(managerService.findUploadFile(product.getProductNo()));
		}
		

		model.addAttribute("products", products);
		
		return "/manager/list-product";
	}
}
