<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/CmCodeArray  
/* 프로그램 이름     : CmCodeArray    
/* 소스파일 이름     : CmCodeArray
/* 설명              : SYSTEM 코드 javascript배열 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-28
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-28
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<script type="text/javascript">
//<![CDATA[
	var <%=javasc_arr_nm%> = new Array();
	var <%=javasc_arr_nm%>_tmp = new Array(); 
<%


// 코드배열에 담긴값을 출력한다
if(code_select_List.size() > 0){
	for(ic=0 ;ic<code_select_List.size();ic++){
		rtn_row_Map = (Map)code_select_List.get(ic);
		//' 첫번째 데이터의 경우 초기 lv값을 셋팅한다
		if (ic==0){
			cinit_lv =  Integer.parseInt((String)rtn_row_Map.get("LV"));
		}
		ctmp_lv = Integer.parseInt((String)rtn_row_Map.get("LV")) - cinit_lv;

		if (ic==0){
		%>
				<%=javasc_arr_nm%>[<%=ctmp_lv%>] = new Array();
		<%
		}else if( cprev_lv < ctmp_lv ){
		%>
				<%=javasc_arr_nm%>[<%=ctmp_lv%>] = new Array();
		<%
		}
		%>
			<%=javasc_arr_nm%>_tmp = new Array();
			<%=javasc_arr_nm%>_tmp[0]  = "<%=rtn_row_Map.get("CODE_C")%>"; //' CODE_C
			<%=javasc_arr_nm%>_tmp[1]  = "<%=rtn_row_Map.get("CODE_NM")%>"; //' CODE_NM
			<%=javasc_arr_nm%>_tmp[2]  = "<%=rtn_row_Map.get("CODE_UP_C")%>"; //' CODE_UP_C
			<%=javasc_arr_nm%>_tmp[3]  = "<%=rtn_row_Map.get("DEPTH_NO")%>"; //' DEPTH_NO
			<%=javasc_arr_nm%>_tmp[4]  = "<%=rtn_row_Map.get("ORDER_NO")%>"; //' ORDER_NO
			<%=javasc_arr_nm%>_tmp[5]  = "<%=rtn_row_Map.get("USE_YN")%>"; //' USE_YN
			<%=javasc_arr_nm%>_tmp[6]  = "<%=rtn_row_Map.get("CODE_CS")%>"; //' CODE_CS
			<%=javasc_arr_nm%>_tmp[7]  = "<%=rtn_row_Map.get("LV")%>"; //' LV

			<%=javasc_arr_nm%>[<%=ctmp_lv%>].push(<%=javasc_arr_nm%>_tmp);
		<%

			cprev_lv = ctmp_lv;


	}
}
%>
//]]>
</script>