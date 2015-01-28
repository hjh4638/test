<%@ page language="java" contentType="text/xml; charset=EUC-KR"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.lang.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="<%=request.getContextPath() %>"></c:set>

<?xml version="1.0" encoding="UTF-8"?>
<%
	String db_driver = "";
	String db_connect_url = "";
	String db_uid = "";
	String db_passwd= "";
	
	
//	if(KAConf.was_pool_type == KAConf.DEFAULT){
//	    db_driver = KAConf.db_driver;
//	    db_connect_url = KAConf.db_connect_url;
//	    db_uid = KAConf.db_uid;
//	    db_passwd = KAConf.db_passwd;   
//	}
	
    db_driver = "oracle.jdbc.driver.OracleDriver";
    db_connect_url = "jdbc:oracle:thin:@10.10.1.211:1622/PORTAL";
    db_uid = "sso";
    db_passwd = "rxj##rp3";
    
	Class.forName(db_driver);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	try{
	    conn = DriverManager.getConnection(db_connect_url, db_uid, db_passwd);	request.setCharacterEncoding("EUC-KR");


	String dbUser=(String)request.getAttribute("dbuser");	
	String treeType=(String)request.getAttribute("treetype");
	String startCode = (String)request.getAttribute("startcode");
	
	treeType = "AVS11C0T";//사용안함
	dbUser = "a1";//사용안함
	StringBuffer strSQL = new StringBuffer();

//	strSQL.append("	select c0t.sosokcode AS SYSTEM_ID, (length(c0t.sosokcode)-4)/2 + 1 as LEV, c0t.sosokcode AS NODEID,  ") ;
//	strSQL.append("	C0T.ASS NODENAME ,a.dept_id") ;
//	strSQL.append("	from avs11c0t c0t , dept_global a") ;
//	strSQL.append("	WHERE c0t.sosokcode = a.numbering and c0t.sosokgubun='1' and c0t.sosokcode is not null ") ;
//	strSQL.append("	order by signsymbol, sosokcode ") ;
	
	strSQL.append("\nselect  system_id,												                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n        lev,                                                                                                                                                                                                                                                                                                                                                                                                                     ");
	strSQL.append("\n        nodeid,                                                                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n        nodename,                                                                                                                                                                                                                                                                                                                                                                                                                ");
	strSQL.append("\n        dept_id                                                                                                                                                                                                                                                                                                                                                                                                                ");
	strSQL.append("\n from   (    SELECT  system_id,                                                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n            lev,                                                                                                                                                                                                                                                                                                                                                                                                                 ");
	strSQL.append("\n            nodeid,                                                                                                                                                                                                                                                                                                                                                                                                              ");
	strSQL.append("\n            NVL(nodename, '부서명칭없음') as nodename                                                                                                                                                                                                                                                                                                                                                                            ");
	strSQL.append("\n      FROM  (   SELECT  signsymbol AS signsymbol,                                                                                                                                                                                                                                                                                                                                                                                ");
	strSQL.append("\n                        sosokcode AS system_id,                                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n                        DECODE(LENGTH(signsymbol), 3, DECODE(SUBSTRB(signsymbol, 2, 2), '00', 1, DECODE(SUBSTRB(signsymbol, 1, 1), 'A', ((length(sosokcode)-4)/2+1 + to_number(signsymbolflag)), ((length(sosokcode)-4)/2+2 + to_number(signsymbolflag)) ) ), DECODE(SUBSTRB(signsymbol, 1, 1), 'A', ((length(sosokcode)-4)/2+1 + to_number(signsymbolflag)), ((length(sosokcode)-4)/2+2 + to_number(signsymbolflag)) ) ) AS lev,");
	strSQL.append("\n                        sosokcode AS nodeid,                                                                                                                                                                                                                                                                                                                                                                                     ");
	strSQL.append("\n                        ass AS nodename                                                                                                                                                                                                                                                                                                                                                                                          ");
	strSQL.append("\n                 FROM   (   SELECT  sosokcode,                                                                                                                                                                                                                                                                                                                                                                                   ");
	strSQL.append("\n                                    ass,                                                                                                                                                                                                                                                                                                                                                                                         ");
	strSQL.append("\n                                    signsymbol,                                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n                                    signsymbolflag as signsymbolflag                                                                                                                                                                                                                                                                                                                                                             ");
	strSQL.append("\n                              FROM  avs11c0t                                                                                                                                                                                                                                                                                                                                                                                     ");
	strSQL.append("\n                             WHERE  sosokgubun = '1'                                                                                                                                                                                                                                                                                                                                                                             ");
	strSQL.append("\n                               AND  sosokcode IS NOT NULL                                                                                                                                                                                                                                                                                                                                                                        ");
	strSQL.append("\n                            MINUS                                                                                                                                                                                                                                                                                                                                                                                                ");
	strSQL.append("\n                            SELECT  sosokcode,                                                                                                                                                                                                                                                                                                                                                                                   ");
	strSQL.append("\n                                    ass,                                                                                                                                                                                                                                                                                                                                                                                         ");
	strSQL.append("\n                                    signsymbol,                                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n                                    signsymbolflag as signsymbolflag                                                                                                                                                                                                                                                                                                                                                             ");
	strSQL.append("\n                              FROM  avs11c0t                                                                                                                                                                                                                                                                                                                                                                                     ");
	strSQL.append("\n                             WHERE  sosokcode IN (   SELECT sosokcode                                                                                                                                                                                                                                                                                                                                                            ");
	strSQL.append("\n                                                      FROM a1.avs11c0t_mapping                                                                                                                                                                                                                                                                                                                                                   ");
	strSQL.append("\n                                                  )                                                                                                                                                                                                                                                                                                                                                                              ");
	strSQL.append("\n                               AND sosokgubun = 1                                                                                                                                                                                                                                                                                                                                                                                ");
	strSQL.append("\n                             UNION ALL                                                                                                                                                                                                                                                                                                                                                                                           ");
	strSQL.append("\n                             SELECT  sosokcode,                                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n                                     ass,                                                                                                                                                                                                                                                                                                                                                                                        ");
	strSQL.append("\n                                     mappingcode AS signsymbol,                                                                                                                                                                                                                                                                                                                                                                  ");
	strSQL.append("\n                                     xml_depth as signsymbolflag                                                                                                                                                                                                                                                                                                                                                                 ");
	strSQL.append("\n                               FROM  a1.avs11c0t_mapping                                                                                                                                                                                                                                                                                                                                                                         ");
	strSQL.append("\n                        )                                                                                                                                                                                                                                                                                                                                                                                                        ");
	strSQL.append("\n            )                                                                                                                                                                                                                                                                                                                                                                                                                    ");
	strSQL.append("\n    where signsymbol is not null                                                                                                                                                                                                                                                                                                                                                                                                 ");
	strSQL.append("\n    ORDER BY signsymbol, system_id                                                                                                                                                                                                                                                                                                                                                                                               ");
	strSQL.append("\n) aa, dept_global bb                                                                                                                                                                                                                                                                                                                                                                                                             ");
	strSQL.append("\nwhere aa.nodeid = bb.numbering(+)                                                                                                                                                                                                                                                                                                                                                                                                   ");

	stmt=conn.prepareStatement(strSQL.toString());
	rs = stmt.executeQuery();
%>   
<data>
	<tree label="tree">
	<%
	StringBuffer sb = new StringBuffer();
	java.util.Stack beforeDepthStack = new java.util.Stack();
	
	String NODENAME1 = "";
	String NODENAME2 = "";
	String NODENAME3 = "";
	String NODENAME4 = "";
	String NODENAME5 = "";
	String NODENAME6 = "";
	String NODENAME7 = "";
	String FNODENAME = "";
	
	while(rs.next()){
		
		String SYSTEM_ID = rs.getString("SYSTEM_ID");//소속코드
		int LEV = rs.getInt("LEV");//레벨
		String NODEID = rs.getString("NODEID");//소속코드
		String NODENAME = rs.getString("NODENAME");//직책명
		String dept_id = rs.getString("dept_id");//전자문서 dept_global 테이블의 dept_id 값
		
		if(LEV == 1){
			NODENAME1 = rs.getString("NODENAME");
			if(	NODENAME1.equals("전대급") || NODENAME1.equals("단급") || NODENAME1.equals("사령부급") || NODENAME1.equals("창급") || NODENAME1.equals("기타"))
			{
				NODENAME1 = "";				
			}
			NODENAME2 = "";
			NODENAME3 = "";
			NODENAME4 = "";
			NODENAME5 = "";
			NODENAME6 = "";
			NODENAME7 = "";
		}
		else if(LEV == 2){
			NODENAME2 = rs.getString("NODENAME");
			if(NODENAME2.equals("대외부서")){
				NODENAME2 = "";
			}else{
				NODENAME2 = " " + rs.getString("NODENAME");	
			}
			
			NODENAME3 = "";
			NODENAME4 = "";
			NODENAME5 = "";
			NODENAME6 = "";
			NODENAME7 = "";
		}
		else if(LEV == 3){
			NODENAME3 = " " + rs.getString("NODENAME");
			NODENAME4 = "";
			NODENAME5 = "";
			NODENAME6 = "";
			NODENAME7 = "";
		}
		else if(LEV == 4){
			NODENAME4 = " " + rs.getString("NODENAME");
			NODENAME5 = "";
			NODENAME6 = "";
			NODENAME7 = "";
		}
		else if(LEV == 5){
			NODENAME5 = " " + rs.getString("NODENAME");
			NODENAME6 = "";
			NODENAME7 = "";
		}
		else if(LEV == 6){
			NODENAME6 = " " + rs.getString("NODENAME");
			NODENAME7 = "";
		}
		else if(LEV == 7){
			NODENAME7 = " " + rs.getString("NODENAME");
		}
		
		FNODENAME = NODENAME1 + NODENAME2 + NODENAME3 + NODENAME4 + NODENAME5 + NODENAME6 + NODENAME7;//INTRASOSOKNAME 이 되는 값
		FNODENAME = FNODENAME.trim();//앞,뒤 공백값 제거
		
		//FNODENAME 이 AVS11C0T 테이블에 존재하지 않는 값
		/*
		FNODENAME = FNODENAME.replaceAll("전대급 ","");
		FNODENAME = FNODENAME.replaceAll("단급 ","");
		FNODENAME = FNODENAME.replaceAll("사령부급 ","");
		FNODENAME = FNODENAME.replaceAll("창급 ","");
		FNODENAME = FNODENAME.replaceAll("기타 ","");
		FNODENAME = FNODENAME.replaceAll("대외부서 ","");
		*/
		
		
		if(beforeDepthStack.size() > 0 )
		{
			int before = ((Integer)beforeDepthStack.get(beforeDepthStack.size()-1)).intValue();

			while(((Integer)beforeDepthStack.get(beforeDepthStack.size()-1)).intValue() >= LEV)
			{
				int closeValue = ((Integer)beforeDepthStack.pop()).intValue();
				%></tree<%= closeValue %>><%
				if(beforeDepthStack.size() < 1 )
				{
					break;
				}
				if(closeValue == 1)
				{
					break;
				}
			}
		}
		%>
		  <tree<%= LEV %> label="<%= NODENAME %>" href="<%=request.getContextPath() %>/approval_line/app/deptMemberList.do?sosokcode=<%=SYSTEM_ID%>" target="deptmember">
	<%
			beforeDepthStack.push(new Integer(LEV));
		}
		while(!beforeDepthStack.isEmpty()) {
	%>
		</tree<%= ((Integer)beforeDepthStack.pop()).intValue() %>>
	<%  } %>
	</tree>
</data>
<%
}
catch(SQLException ex)
{
System.out.println("sql exception : " + ex);
}
finally{
if(rs!=null)
	try{rs.close();}
	catch(SQLException ex) {}
if(stmt!=null)
	try{stmt.close();}
	catch(SQLException ex) {}
if(conn != null)
	try{conn.close();}
	catch(SQLException ex){}
}
%>