package util;

import mil.af.asti.model.AstiBoardPaginationDTO;
import mil.af.asti.model.AstiBoardSearchDTO;

/**
 * @author 한다현
 * Pagination 처리용 Util 클래스
 */
public class PaginationUtil {
	
	/**
	 * 페이지 설정
	 * 현재 페이지 , 글 수를 집어넣으면
	 * 알아서 페이지를 생성해준다.
	 */
	public static AstiBoardPaginationDTO pageSetter(int currentPage,int contentsCount){	
		AstiBoardPaginationDTO pagination = 
		new AstiBoardPaginationDTO(currentPage,	contentsCount);
		return pagination;
	}
	
	/**
	 * 페이지 설정
	 * 현재 페이지 , 글 수 , 표시할 페이지 수 ,페이지 당 글 수를
	 * 집어넣으면 알아서 페이지를 생성해준다.
	 */ 
	public static AstiBoardPaginationDTO pageSetter(
			int currentPage,int contentsCount,
			int numberOfPage,int contentsPerPage){	
		AstiBoardPaginationDTO pagination = 
		new AstiBoardPaginationDTO(currentPage,	contentsCount);
		return pagination;
	}
	
}
