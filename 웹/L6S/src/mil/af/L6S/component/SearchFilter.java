package mil.af.L6S.component;

import mil.af.L6S.util.AbstractListFilter;

public class SearchFilter extends AbstractListFilter {
	private String pn;

	private String sn;

	private String name;

	private String rank;
	
	private String year;
	
	private String quarter;

	private String searchName;

	private String searchBelt;

	private String searchSosok;

	private String searchEduNum;

	private String searchBeltState;
	
	public String getName() {
		return name;
	}

	public String getPn() {
		return pn;
	}

	public String getQuarter() {
		return quarter;
	}

	public String getRank() {
		return rank;
	}

	public String getSearchBelt() {
		return searchBelt;
	}

	public String getSearchBeltState() {
		return searchBeltState;
	}

	public String getSearchEduNum() {
		return searchEduNum;
	}

	public String getSearchName() {
		return searchName;
	}

	public String getSearchSosok() {
		return searchSosok;
	}

	public String getSn() {
		return sn;
	}

	public String getYear() {
		return year;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPn(String pn) {
		this.pn = pn;
	}

	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}

	public void setRank(String rank) {
		this.rank = rank;
	}

	public void setSearchBelt(String searchBelt) {
		this.searchBelt = searchBelt;
	}

	public void setSearchBeltState(String searchBeltState) {
		this.searchBeltState = searchBeltState;
	}

	public void setSearchEduNum(String searchEduNum) {
		this.searchEduNum = searchEduNum;
	}

	public void setSearchName(String searchName) {
		this.searchName = searchName.trim();
	}

	public void setSearchSosok(String searchSosok) {
		this.searchSosok = searchSosok;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public void setYear(String year) {
		this.year = year;
	}

	@Override
	public String toString() {
		return "SearchFilter [pn=" + pn + ", sn=" + sn + ", name=" + name
				+ ", rank=" + rank + ", year=" + year + ", quarter=" + quarter
				+ ", searchName=" + searchName + ", searchBelt=" + searchBelt
				+ ", searchSosok=" + searchSosok + ", searchEduNum="
				+ searchEduNum + ", searchBeltState=" + searchBeltState + "]";
	}
}
