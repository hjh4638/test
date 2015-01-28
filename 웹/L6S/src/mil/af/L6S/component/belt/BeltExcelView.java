package mil.af.L6S.component.belt;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mil.af.L6S.util.ExcelUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.view.document.AbstractExcelView;


/**
 *  성적별 GB 수료자 Excelizaion
 * @author 정성모
 *
 */
@SuppressWarnings("deprecation")
@Component
public class BeltExcelView extends AbstractExcelView {
	
	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request, 
			HttpServletResponse response)
			throws Exception {
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment; filename=Belt.xls");

		List<BeltVO> beltVO = (List<BeltVO>) model.get("beltVO");
		
		HSSFSheet sheet = workbook.createSheet("belt");
		int rowIndex = 1;
		short colIndex = 1;
		
		sheet.addMergedRegion(new Region(rowIndex, (short) 1, rowIndex, (short)(6)));
		HSSFRow titleRow = sheet.createRow(rowIndex);
		String title = "近 3년간 GB 과정 이수자 성적표";
		for(int i=1;i<=6;i++)
			ExcelUtil.createCell(workbook, title, titleRow, (short)i);
		rowIndex++;
		
		/* 메뉴  Cell 설정 */
		HSSFRow Menu = sheet.createRow(rowIndex);
		ExcelUtil.createCell(workbook, "군번", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "계급", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "성명", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "소속", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "교육차수", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "교육성적", Menu, colIndex++);
		rowIndex++;
		
		/* Excel 출력 */
		colIndex = 1;
		for(BeltVO belt : beltVO){
			HSSFRow datum  = sheet.createRow(rowIndex);
			ExcelUtil.autoSizeSheet(sheet, 6);
			ExcelUtil.createCell(workbook, belt.getSn(), datum, colIndex++);
			ExcelUtil.createCell(workbook, belt.getRank(), datum, colIndex++);
			ExcelUtil.createCell(workbook, belt.getName(), datum, colIndex++);
			ExcelUtil.createCell(workbook, belt.getSosokName(), datum, colIndex++);
			ExcelUtil.createCell(workbook, belt.getBeltDatum().get(0).getEduNum(), datum, colIndex++);
			ExcelUtil.createCell(workbook, belt.getBeltDatum().get(0).getScore(), datum, colIndex++);
			rowIndex++;
			colIndex = 1;
		}
				
		
	}

}
