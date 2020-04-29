package com.bomshop.www.common.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;

public class FileUtils {

	public static String uploadFile(
			String originalName,
			String uploadPath,
			byte[] fileData
			) throws Exception{
		String uploadFileName = "";
		
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString().replace("-", "")+"_"+originalName;
		
		String path = calcPath(uploadPath);
		
		File file = new File(uploadPath + path, savedName);
		
		FileCopyUtils.copy(fileData, file);
		
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		
		if(MediaUtils.getMediaType(formatName) != null) {
			// 이미지 파일
			uploadFileName = makeThumbnail(uploadPath, path, savedName);
			//uploadFileName = makeFileName(uploadPath, path, savedName);
		}else {
			uploadFileName = makeFileName(uploadPath, path, savedName);
		}
		
		System.out.println("uploadFileName : " + uploadFileName);
		return uploadFileName;
	}
	
	public static String uploadReviewImage(
			String originalName,
			int gno,
			String uploadPath,
			byte[] fileData
			) throws Exception{
		
		String uploadFileName = "";
		
		UUID uid = UUID.randomUUID();
		
		String savedName = uid.toString().substring(0, 8)+"_"+originalName;
		String path = calcReviewPath(uploadPath,gno);
		File file = new File(uploadPath + path, savedName);
		System.out.println(uploadPath+path);
		FileCopyUtils.copy(fileData, file);
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		
		if(MediaUtils.getMediaType(formatName) != null) {
			// 이미지 파일
			uploadFileName = makeFileName(uploadPath, path, savedName);
			//uploadFileName = makeFileName(uploadPath, path, savedName);
		}else {
			uploadFileName = makeFileName(uploadPath, path, savedName);
		}
		
		System.out.println("uploadFileName : " + uploadFileName);
		return uploadFileName;
	}
	
	private static String makeThumbnail(String uploadPath, String path, String savedName) throws Exception {
		// BufferedImage image = new BufferedImage(new FileInputStream(new File(uploadPath + path, savedName)));
		BufferedImage image = ImageIO.read(new File(uploadPath+path, savedName));
		
		BufferedImage sourceImage = Scalr.resize(image, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT,100);
		
		String thumbnailImage = uploadPath + path + File.separator + "s_" + savedName;
		
		String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
		File file = new File(thumbnailImage);
		
		ImageIO.write(sourceImage,formatName, file);
		
		String name = thumbnailImage.substring(uploadPath.length()).replace(File.separatorChar, '/');
		System.out.println(name);
		return name;
	}

	public static String makeFileName(String uploadPath, String path, String savedName) {
		String name= uploadPath + path + File.separator + savedName;
		String fileName = name.substring(uploadPath.length()).replace(File.separatorChar, '/');
		System.out.println("fileName : " + fileName);
		return fileName;
	}
	
	public static String calcPath(String uploadPath) {
		// upload/2020/01/21/savedName 식으로 파일 저장
		String datePath = "";
		
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		mkdir(uploadPath,yearPath,monthPath,datePath);
		return datePath;
	}
	
	public static String calcReviewPath(String uploadPath, int gno) {
		// upload/2020/01/21/savedName 식으로 파일 저장
				String datePath = "";
				String strGno = Integer.toString(gno);
				Calendar cal = Calendar.getInstance();
				String gnoPath = File.separator + strGno;
				String yearPath = gnoPath + File.separator + cal.get(Calendar.YEAR);
				String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
				datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
				mkdir(uploadPath,gnoPath,yearPath,monthPath,datePath);
				return datePath;
	}
	
	public static void mkdir(String uploadPath, String... path) {
		if(new File(uploadPath + path[path.length-1]).exists()) {
			return;
		}
		for(String p : path) {
			File file = new File(uploadPath+p);
			if(!file.exists()) {
				file.mkdir();
			}
		}
	}

	public static ResponseEntity<byte[]> displayFile(
			String uploadPath,
			String fileName
			) throws IOException{
		ResponseEntity<byte[]> entity = null;
		InputStream is = null;
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		System.out.println(formatName);
		
		is = new FileInputStream(uploadPath+fileName);
		HttpHeaders header = new HttpHeaders();
		MediaType mType = MediaUtils.getMediaType(formatName);
		System.out.println(mType);
		
		if(mType != null) {
			header.setContentType(mType);
		}else {
			fileName = fileName.substring(fileName.indexOf("_")+1);
			header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			header.add("content-disposition", "attachment;fileName=\""
					+ new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+ "\"");
		}
		entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(is),header,HttpStatus.CREATED);
		is.close();
		return entity;
	}

	public static ResponseEntity<String> deleteFile(String uploadPath, String fileName) {
		ResponseEntity<String> entity = null;
		
		System.out.println("삭제 요청 : " + fileName);
		
		// 섬네일 이미지 or 다른 파일 삭제
		new File(uploadPath+(fileName).replace('/', File.separatorChar)).delete();
		
		entity = new ResponseEntity<String>("DELETED",HttpStatus.OK);
		System.out.println("삭제완료");
		
		return entity;
	}
}
