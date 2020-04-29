package com.bomshop.www.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.commons.io.IOUtils;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

public class SellerFileUpload {
	
	private static Object[] String;

	public static boolean uploadAD(int gno, String uploadPath, byte[] fileData) throws IOException {
		boolean isSuccess = false;
		String savedName = "AD.png";
		String path = uploadPath + File.separator + gno + File.separator;
		mkDir(path);
		
		File file = new File(path, savedName);
		FileCopyUtils.copy(fileData, file);
		isSuccess = true;
		return isSuccess;
	}
	
	public static String uploadMainImg(int gno, String uploadPath, byte[] fileData) throws IOException {
		String savedName = "mainImg.jpg";
		String gnoPath = File.separator + gno + File.separator;
		String path = uploadPath + gnoPath;
		mkDir(path);
		
		File file = new File(path, savedName);
		FileCopyUtils.copy(fileData, file);
		return gnoPath+savedName;
	}	
	
	public static String[] uploadSubImg(int gno, String uploadPath, List<MultipartFile> subList) throws IOException {
		String[] subImgNames = new String[subList.size()];
		String gnoPath = File.separator + gno + File.separator;
		String path = uploadPath + gnoPath;
		mkDir(path);
		
		for(int i=0; i<subList.size(); i++) {
			String savedName = "subImg"+i+".jpg";
			File file = new File(path, savedName);
			FileCopyUtils.copy(subList.get(i).getBytes(), file);
			subImgNames[i] = gnoPath + savedName;
		}
		return subImgNames;
	}

	//	폴더 생성
	private static void mkDir(String path) {
		if(new File(path).exists()) {
			return;
		}else {
			new File(path).mkdirs();
		}
	}

	//	임시 파일 위치 이동
	public static String changeDetailImg(int gno, String uploadPath, String gdetail, List<String> temp_img) throws IOException {
		FileInputStream tempFile = null;
		for(int i=0; i<temp_img.size(); i++) {
			File inputFile = new File(uploadPath+File.separator+temp_img.get(i));
			File outputFile = new File(uploadPath+File.separator+gno+File.separator+temp_img.get(i));
			tempFile = new FileInputStream(inputFile);
			byte[] bytes = IOUtils.toByteArray(tempFile);
			FileCopyUtils.copy(bytes, outputFile);
			gdetail = gdetail.replace(temp_img.get(i), gno+"/"+temp_img.get(i));
			System.out.println(inputFile.exists());
			tempFile.close();
		}
		
		File deleteFile = new File(uploadPath+File.separator);
		for(File file : deleteFile.listFiles()) {
			file.delete();
		}
		
		return gdetail;
	}
	
	//	광고신청 취소시 등록한 배너파일 삭제
	public static void deleteADImg(int gno, String uploadPath) throws Exception {
		String savedName = "AD.png";
		File deleteFile = new File(uploadPath+File.separator+gno+File.separator+savedName);
		System.out.println(uploadPath+File.separator+gno+File.separator+savedName);
		deleteFile.delete();
	}
}
