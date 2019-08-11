package com.shop.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

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
import com.shop.service.ManagerService;
import com.shop.service.ShopService;
import com.shop.vo.Buy;
import com.shop.vo.Product;
import com.shop.vo.ProductFile;

@Controller
@RequestMapping(value="/manager")
public class ManagerController {
	
	@Autowired
	@Qualifier("managerService")
	private ManagerService managerService;

	@Autowired
	@Qualifier("shopService")
	private ShopService shopService;
	
	
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

			MultipartFile titleImg = req.getFile("titleImgFile");
			if (titleImg != null) {
				userFileName = titleImg.getOriginalFilename();
				if (userFileName.contains("\\")) { // iexplore 경우
					// C:\AAA\BBB\CCC.png -> CCC.png
					
					userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
				}
				if (userFileName != null && userFileName.length() > 0) { // 내용이 있는 경우
					if (userFileName.contains("\\")) { // iexplore 경우
						// C:\AAA\BBB\CCC.png -> CCC.png
						userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
					}
					String uniqueFileName = Util.makeUniqueFileName(path, userFileName);// 파일이름_1.jpg
					// String uniqueFileName=Util.makeUniqueFileName(fileName);//고유한 파일이름.jpg
					titleImg.transferTo(new File(path, uniqueFileName));// 파일 저장

					ProductFile productFile = new ProductFile();
					productFile.setFileName(uniqueFileName);
					productFile.setFlag(true);
					product.setFile(productFile);
				}
			}

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
						productFile.setFlag(false);
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
	public String listProduct(Model model, String category, String keyword){
		
		if (category == null) {
			category = "전체";
		}
		
		if (keyword == null) {
			keyword = "";
		}
		
		// 전체리스트
		List<Product> products = managerService.findProductList(category,keyword);
		if(products == null) {
			return "redirect:/";
		}
		
		for(Product product : products) {
			product.setFile(managerService.findUploadFile(product.getProductNo()));
		}
		
		int allCount = shopService.findProductsCount();
		model.addAttribute("allCount", allCount);
		model.addAttribute("products", products);
		
		return "/manager/list-product";
	}
	
	@RequestMapping(value="/detail/{productNo}", method = RequestMethod.GET)
	public String detailProduct(@PathVariable int productNo, Model model){
		
		Product product = managerService.findProductByProductNo(productNo);
		
		if(product == null) {
			return "redirect:list-product";
		}
		
		List<ProductFile> files = managerService.findProductFilesByProductNo(productNo);
		
		product.setFiles((ArrayList<ProductFile>)files);
		
		model.addAttribute("product", product);
		
		return "manager/detail";
	}
	
	@RequestMapping(value="/update-product/{productNo}", method = RequestMethod.GET)
	public String updateProduct(@PathVariable int productNo, Model model) {
		Product product = managerService.findProductByProductNo(productNo);
		
		if(product == null) {
			return "redirect:/manager/list-product";
		}
		
		ProductFile titlefile = managerService.findProductFile(productNo);
		System.out.println(titlefile);
		List<ProductFile> productfiles = managerService.findProductFilesByProductNo(productNo);
		
		product.setFile(titlefile);
		product.setFiles((ArrayList<ProductFile>)productfiles);

		model.addAttribute("product", product);
		
		return "manager/update-product";
	}
	
	@RequestMapping(value="/update-product", method = RequestMethod.POST)
	public String updateProductForm(MultipartHttpServletRequest req, Product product, Model model) {
		
		product.setFile(managerService.findProductFile(product.getProductNo()));
		
		ServletContext application = req.getServletContext();
		String path = application.getRealPath("/resources/files/product-files");// 최종 파일 저장 경로
		String userFileName = "";
		try {
			
			MultipartFile titleImg = req.getFile("titleImgFile");
			if (titleImg != null) {
				userFileName = titleImg.getOriginalFilename();
				if (userFileName.contains("\\")) { // iexplore 경우
					// C:\AAA\BBB\CCC.png -> CCC.png
					userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
				}
				if (userFileName != null && userFileName.length() > 0) { // 내용이 있는 경우
					if (userFileName.contains("\\")) { // iexplore 경우
						// C:\AAA\BBB\CCC.png -> CCC.png
						userFileName = userFileName.substring(userFileName.lastIndexOf("\\") + 1);
					}
					String uniqueFileName = Util.makeUniqueFileName(path, userFileName);// 파일이름_1.jpg
					// String uniqueFileName=Util.makeUniqueFileName(fileName);//고유한 파일이름.jpg
					titleImg.transferTo(new File(path, uniqueFileName));// 파일 저장

					ProductFile productFile = new ProductFile();
					productFile.setFileName(uniqueFileName);
					productFile.setFlag(true);
					productFile.setProductNo(product.getProductNo());
					
					managerService.updateProductFile(productFile);
					
					product.setFile(productFile);
					
				}
			}

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
						productFile.setFlag(false);
						productFile.setProductNo(product.getProductNo());
						files.add(productFile);
						
						product.setFiles(files);
						
						managerService.insertProductFiles(product, product.getProductNo());
					}
				}
			}
			System.out.println(product);
			// 데이터 저장
			managerService.updateProduct(product);
			model.addAttribute("product", product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/manager/detail/" + product.getProductNo();
	}
	
	@RequestMapping(path = "/delete-product/{productNo}", method = RequestMethod.GET)
	public String delete(@PathVariable int productNo, Product product) {

		managerService.deleteProduct(productNo);

		return "redirect:/manager/list-product";  // new RedirectView("/upload/list");
	}
	
	@RequestMapping(path = "/delete-file", method = RequestMethod.GET)
	@ResponseBody
	public String deletefile(int productFileNo, Model model) {
		//데이터베이스에서 파일 정보 조회
		ProductFile file = managerService.findProductFileByProductFileNo(productFileNo);

		
		/*
		 * //파일 삭제 File f = new File(file.getSavedFileName()); if (f.exists()) {
		 * f.delete(); }
		 */
		
		//데이터베이스에서 파일 데이터 삭제
		managerService.deleteProductFile(productFileNo);

		return "success" ; 
	}
	
	@RequestMapping(value="/order-list", method = RequestMethod.GET)
	public String productOrderList(Model model){
		
		// 전체리스트
		List<Buy> order = managerService.findProductOrderList();
		if(order == null) {
			return "redirect:/";
		}

		model.addAttribute("order", order);
		
		return "/manager/order-list";
	}
}
