package mil.af.L6S.component.subject;

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

@SuppressWarnings("deprecation")
@Component
public class SubjectExcelView extends AbstractExcelView{

	@SuppressWarnings("unchecked")
	@Override
	protected void buildExcelDocument(Map<String, Object> model,
			HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition",
				"attachment; filename=SubjectExcel.xls");
		
		List<SubjectExcelVO> ExcelVO = (List<SubjectExcelVO>) model.get("ExcelDatum");
		
		HSSFSheet sheet = workbook.createSheet("Finance");
		int rowIndex = 1;
		short colIndex = 1;
		
		sheet.addMergedRegion(new Region(rowIndex, (short) 1, rowIndex, (short)(8)));
		HSSFRow titleRow = sheet.createRow(rowIndex);
		String title = "재무성과 비교(연도별 분류)";
		for(int i=1;i<=8;i++)
			ExcelUtil.createCell(workbook, title, titleRow, (short)i);
		rowIndex++;
		
		/* 메뉴  Cell 설정 */
		HSSFRow Menu = sheet.createRow(rowIndex);
		ExcelUtil.createCell(workbook, "소속", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "과제명", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "계급", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "성명", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "과제분류", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "개선 전", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "개선 후", Menu, colIndex++);
		ExcelUtil.createCell(workbook, "등록연도", Menu, colIndex++);
		rowIndex++;
		
		colIndex = 1;
		for(SubjectExcelVO excel : ExcelVO){
			HSSFRow datum  = sheet.createRow(rowIndex);
			ExcelUtil.autoSizeSheet(sheet, 8);
			ExcelUtil.createCell(workbook, excel.getPosition(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getSubject_Name(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getRank(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getName(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getSubject_Section(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getBefore(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getAfter(), datum, colIndex++);
			ExcelUtil.createCell(workbook, excel.getRegisterDay(), datum, colIndex++);
			rowIndex++;
			colIndex = 1;
		}
	}
}
