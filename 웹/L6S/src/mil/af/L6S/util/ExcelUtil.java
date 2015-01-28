package mil.af.L6S.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

@SuppressWarnings("deprecation")
public class ExcelUtil {

	/**
	 * Border 생성
	 * 
	 * @param style
	 *            styleCell
	 * @param color
	 *            색상
	 * @param pattern
	 *            무늬
	 */
	public static void createBorder(HSSFCellStyle style, short color,
			short pattern) {

		style.setTopBorderColor(color);
		style.setBottomBorderColor(color);
		style.setLeftBorderColor(color);
		style.setRightBorderColor(color);

		style.setBorderTop(pattern);
		style.setBorderBottom(pattern);
		style.setBorderLeft(pattern);
		style.setBorderRight(pattern);
	}

	/**
	 * 배경색 설정
	 * 
	 * @param style
	 *            style cell
	 * @param color
	 *            색상
	 * @param pattern
	 *            무늬
	 */
	public static void createBackGround(HSSFCellStyle style, short color,
			short pattern) {

		style.setFillForegroundColor(color);
		style.setFillPattern(pattern);
	}

	/**
	 * 중앙정렬 하는 cell 생성 다른 style X
	 * 
	 * @param wb
	 *            workbook
	 * @param value
	 *            String 값
	 * @param row
	 *            열
	 * @param col
	 *            행
	 */
	public static void createCell(HSSFWorkbook wb, String value, HSSFRow row,
			short col) {

		HSSFCell cell = row.createCell(col);
		cell.setCellValue(value);

		HSSFCellStyle style = wb.createCellStyle();
		createBorder(style, HSSFColor.BLACK.index, HSSFCellStyle.BORDER_THIN);

		cell.setCellStyle(style);

	}

	/**
	 * 중앙정렬 하는 cell 생성 다른 style X
	 * 
	 * @param wb
	 *            workbook
	 * @param value
	 *            Integer 값
	 * @param row
	 *            열
	 * @param col
	 *            행
	 */
	public static void createCell(HSSFWorkbook wb, Integer value, HSSFRow row,
			short col) {

		HSSFCell cell = row.createCell(col);
		cell.setCellValue(value);

		HSSFCellStyle style = wb.createCellStyle();
		createBorder(style, HSSFColor.BLACK.index, HSSFCellStyle.BORDER_THIN);

		cell.setCellStyle(style);
	}

	/**
	 * 데이터가 없는곳 Cell 만들기
	 * 
	 * @param wb
	 *            workbook
	 * @param row
	 *            열
	 * @param col
	 *            행
	 */
	public static void createCell(HSSFWorkbook wb, HSSFRow row, short col,
			short color) {

		HSSFCell cell = row.createCell(col);

		HSSFCellStyle style = wb.createCellStyle();
		createBorder(style, HSSFColor.BLACK.index, HSSFCellStyle.BORDER_THIN);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER_SELECTION);

		createBackGround(style, color, HSSFCellStyle.SOLID_FOREGROUND);

		cell.setCellStyle(style);
	}

	/**
	 * column 크기 자동 조절
	 * 
	 * @param sheet
	 * @param size
	 */
	public static void autoSizeSheet(HSSFSheet sheet, int size) {
		for (int i = 1; i <= size; i++) {
			sheet.autoSizeColumn((short) i);
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i) + 1024));
		}
	}
	
	/**
	 * 중앙정렬 하는 cell 생성 다른 style X
	 * 
	 * @param wb
	 *            workbook
	 * @param value
	 *            double 값
	 * @param row
	 *            열
	 * @param col
	 *            행
	 */
	public static void createCell(HSSFWorkbook wb, Double value, HSSFRow row,
			short col) {

		HSSFCell cell = row.createCell(col);
		cell.setCellValue(value);

		HSSFCellStyle style = wb.createCellStyle();
		createBorder(style, HSSFColor.BLACK.index, HSSFCellStyle.BORDER_THIN);

		cell.setCellStyle(style);
	}
}
