<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/S01/CmSubMain    
/* 프로그램 이름     : CmSubMain    
/* 소스파일 이름     : CmSubMain.jsp
/* 설명              : SYSTEM 시스템 메인컨텐츠 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-11-10
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-11-10
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>
<!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cm/S01/Cmheader.jsp"%>

<body>
<!-- 공통 jsp 파일-->
<link rel="stylesheet" type="text/css" href="<%=con_root %>/style/print-preview_land.css" />
<script type="text/javascript" src="<%=con_root %>/js/jquery.print-preview_land.js" ></script>
	<%@include file="/WEB-INF/jsp/cm/S01/Cmtop.jsp"%>
	<%
		int i = 0;
		Map depth1_class_map = new HashMap();
		depth1_class_map.put("000048","sub_strategy");// 동반성장전략 
		depth1_class_map.put("000063","sub_culture");// 동반성장 문화확산 
		depth1_class_map.put("000104","sub_support");// 중소기업 지원안내 
		depth1_class_map.put("000090","sub_notice");// 소통마당
		depth1_class_map.put("000156","sub_system");// 지원시스템
		depth1_class_map.put("000121","member");// 기타
		
		Map depth1_title_map = new HashMap();
		depth1_title_map.put("000048","동반성장전략");// 동반성장전략 
		depth1_title_map.put("000063","동반성장 문화확산");// 동반성장 문화확산 
		depth1_title_map.put("000104","중소기업 지원안내");// 중소기업 지원안내 
		depth1_title_map.put("000090","소통마당");// 소통마당
		depth1_title_map.put("000156","지원시스템");// 지원시스템
		depth1_title_map.put("000121","기타");// 기타	
		
		Map depth1_desc_map = new HashMap();
		depth1_desc_map.put("000048","동반성장전략 중부발전은 동반성장 정책을 선도적으로 추진합니다");// 동반성장전략 
		depth1_desc_map.put("000063","동반성장문화확산 중부발전은 중소기업과의 교류를 통해 동반성장 문화를 확산시키는데 기여합니다");// 동반성장 문화확산 
		depth1_desc_map.put("000104","중소기업 지원안내 중부발전은 중소기업의 성장을 지원하며 함께 합니다");// 중소기업 지원안내 
		depth1_desc_map.put("000090","소통마당 고객의 소중한 의견을 귀담아 듣는 중부발전이 되겠습니다");// 소통마당
		depth1_desc_map.put("000156","지원시스템 중부발전의 협력기업 지원시스템 입니다");// 지원시스템
		depth1_desc_map.put("000121","");// 기타			

		
		String depth1_class_str = "";
		String depth1_title_str = "";
		String depth1_desc_str = "";
		 
		if(CUR_M_PATH_CODE_arr.length > 0){
			depth1_class_str= (String)depth1_class_map.get(CUR_M_PATH_CODE_arr[1]);
			depth1_title_str= (String)depth1_title_map.get(CUR_M_PATH_CODE_arr[1]);
			depth1_desc_str= (String)depth1_desc_map.get(CUR_M_PATH_CODE_arr[1]);
		}
	%>	
 	<%--=CUR_M_PATH_CODE --%>
    <div id="content" class="<%=depth1_class_str %>"><!--본문시작-->
        <div class="subVisual">
            <div class="wrap">
                <div class="subTitle">
                    <h2><%=depth1_title_str %></h2>
                    <p><%=depth1_desc_str %></p>
                </div>
            </div>
        </div>
        <div class="lnbArea"><!--서브메뉴-->
            <div class="wrap">
                      
				<%@include file="/WEB-INF/jsp/cm/S01/Cmnav.jsp"%><!-- 공통 jsp 파일-->
                
                <div class="shareMenu">
                    <div class="snsShare">
                        <a href="#n">공유</a>
                        <div class="snsList">
                            <button class="url">url로 공유하기</button>
                            <button class="facebook">facebook으로 공유하기</button>
                            <button class="mail">메일로 공유하기</button>
                        </div>
                    </div>
                    <div class="printShare" id="print_subcon_btn">
                        <a href="#" id="printttttt">프린트</a>
                    </div>
                </div>
            </div>
        </div><!--//서브메뉴-->
        				
        <div class="contents" id="print_subcon_area"><!--본문내용-->
            <a id="contents" href="#" tabindex="-1" class="hide">본문</a>
           
            <div class="wrap" >
                    <div class="tabmenu" style="margin-top:0px;" id="maintabid">
                        <!--<ul>
                             <li class="tab-link current" data-tab="tab-1"><a href="#n">회원정보로 찾기</a></li>
                            <li class="tab-link" data-tab="tab-2"><a href="#n">휴대폰 본인인증</a></li>
                            <li class="tab-link" data-tab="tab-3"><a href="#n">아이핀(I-PIN)</a></li>
                            
                        </ul>-->
                    </div>            
                <div class="cts_title">
                    <h3><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2).replaceAll("&amp;amp;","&")%></h3>
                </div>
                <div>
					<%
					// 연결종류가 없음이면
					if(((String)MENUCFG.get("linkTy")).equals("000005")){
			
					// 연결종류가 컨텐츠이면
					}else if(((String)MENUCFG.get("linkTy")).equals("000006")){
			
						// LINK_PATH가 있으면 인클루드 아니면 데이터베이스에서 관리되는 내용을 출력
						if((HtmlTag.returnString((String)MENUCFG.get("linkPath"),"")).equals("")){
					%>
							<%@include file="/WEB-INF/jsp/cm/S01/CmContents.jsp"%><!-- 공통 jsp 파일-->
					<%
						}else{
					%>
							<!--  LINK_PATH:<%=(String)MENUCFG.get("linkPath") %><br />-->
							<jsp:include page='<%=(String)MENUCFG.get("linkPath")%>' flush="true">
								<jsp:param name="rtn_Map" value="${rtn_Map}" />
							</jsp:include>						
					<%
						}
					// 연결종류가 LINK이면
					}else if(((String)MENUCFG.get("linkTy")).equals("000007")){
					
					// 연결종류가 게시판이면
					}else if(((String)MENUCFG.get("linkTy")).equals("000008")){
					%>
						<%@include file="/WEB-INF/jsp/ji/cm/abd/jicm_abd_010_m1.jsp"%><!-- 공통 jsp 파일-->
					<%	
					// 연결종류가 프로그램이면
					}else if(((String)MENUCFG.get("linkTy")).equals("000009")){
						//RequestDispatcher dispatcher = request.getRequestDispatcher((String)MENUCFG.get("CLASS_PATH_JSP"));
						//dispatcher.include(request, response);
					%>
						<jsp:include page='<%=((String)MENUCFG.get("classPathJsp")).trim()%>' flush="true">
							<jsp:param name="rtn_Map" value="${rtn_Map}" />
						</jsp:include>
					<%						
					}
					%>
				</div>
            </div>
        </div><!--//본문내용-->
    </div><!--본문끝-->
	<!--footer-->
	<%@include file="/WEB-INF/jsp/cm/S01/Cmfooter.jsp"%>
	<!--//footer-->  
	
<script type='text/javascript'>
$(function() {
	var linkTy = "<%=MENUCFG.get("linkTy")%>";
	var menuCd = "<%=pcode%>";
	if(linkTy === "000008") { //공통게시판
		
	} else if(linkTy === "000009") { //프로그램
		//회원가입, 연구개발 아이디어 지원센터, 수출규제 중소기업 피해지원센터
		if(menuCd === "000138" || menuCd === "000470" || menuCd === "000552") {
			
		} else {
			// 타이틀 변경
			$(document).attr("title","<%=M_PATH_STR.replaceAll("ROOT::","").replaceAll("::"," > ").replaceAll("amp;","")%>"); 
		}
	} else {
		// 타이틀 변경
		$(document).attr("title","<%=M_PATH_STR.replaceAll("ROOT::","").replaceAll("::"," > ").replaceAll("amp;","")%>"); 
	}
	$('#print_subcon_btn').printPreview("#print_subcon_area","1",$("#print_subcon_area").children(".wrap").width());	

});	

printCloseFocus = function() {
	$("#printttttt").focus();
};
</script>
</body>
</html>

