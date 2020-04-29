package com.bomshop.www.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.inject.Inject;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import com.bomshop.www.seller.dao.SellerSettlementManageDAO;
import com.bomshop.www.seller.dto.OrderComDTO;

public class DownloadExcel {
	
	static String filePath = "c://Temp";
	
	@Inject
	SellerSettlementManageDAO dao;

	public static String createFile(String selectValue, List<OrderComDTO> list, int totalAmount) {
		// 메모리에 100개의 행을 유지합니다. 행의 수가 넘으면 디스크에 적습니다. 
		SXSSFWorkbook wb = new SXSSFWorkbook(100);
		SXSSFSheet sheet = wb.createSheet();
		String excelName = selectValue+".Xlsx";
		
		//	컬럼명 넣기
		Row rowTitle = sheet.createRow(0);
		Cell cellTitle = null;
		cellTitle = rowTitle.createCell(0);
		cellTitle.setCellValue("날짜");
		cellTitle = rowTitle.createCell(1);
		cellTitle.setCellValue("상품명");
		cellTitle = rowTitle.createCell(2);
		cellTitle.setCellValue("색상");
		cellTitle = rowTitle.createCell(3);
		cellTitle.setCellValue("사이즈");
		cellTitle = rowTitle.createCell(4);
		cellTitle.setCellValue("수량");
		cellTitle = rowTitle.createCell(5);
		cellTitle.setCellValue("가격");
		
		//	리스트 내용
		for(int i = 0; i<list.size(); i++) {
			Row row = sheet.createRow(i+1);
			Cell cell = null; 
			cell = row.createCell(0);
			SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일");
			cell.setCellValue(sdf.format(list.get(i).getOrder().getOrder_com_date()));
			cell = row.createCell(1);
			cell.setCellValue(list.get(i).getGname());
			cell = row.createCell(2); 
			cell.setCellValue(list.get(i).getOption().getColor());
			cell = row.createCell(3);
			cell.setCellValue(list.get(i).getOption().getSize());
			cell = row.createCell(4); 
			cell.setCellValue(list.get(i).getOrder().getCount());
			cell = row.createCell(5);
			cell.setCellValue(list.get(i).getOrder().getPrice());
		}
		
		//	합계정보
		Row rowEnd = sheet.createRow(list.size()+1);
		Cell cellEnd = null;
		cellEnd = rowEnd.createCell(3);
		cellEnd.setCellValue(selectValue);
		cellEnd = rowEnd.createCell(4);
		cellEnd.setCellValue("합계");
		cellEnd = rowEnd.createCell(5);
		cellEnd.setCellValue(totalAmount);
		
		//엑셀파일 세팅 후 파일 생성
		String fileExcelPath = "";
		try {
			File file = new File(filePath);
			file.mkdirs();
			
			FileOutputStream fileOutputStream = 
					new FileOutputStream(file+File.separator+excelName);
			fileExcelPath = filePath+File.separator+excelName;
			//생성한 엑셀파일을 outputStream 해줍니다.
			wb.write(fileOutputStream);
			fileOutputStream.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return fileExcelPath;
	}


}
