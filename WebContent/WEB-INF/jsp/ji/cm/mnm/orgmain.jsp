<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : main    
/* 소스파일 이름     : main.jsp
/* 설명              : SYSTEM 메뉴관리 메인페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-02-10
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-02-10
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->


					<!--내용시작  -->
					
					<%
						// 페이지 설정변수에 따라서 동적으로 리스트, 등록, 수정, 삭제, 답변페이지를 불러온다
					   if(pstate.equals("L")){

					%>
<script type="text/javascript">
//<![CDATA[
   //document.domain = "localhost";
   function orgset(top_code){
	   tree_html = "";
		for(i=0;i<treeleftval.length;i++){
			//alert(treeleftval[i].length);
			for(j=0;j<treeleftval[i].length;j++){
				var orgitem = null;
				//if(parseInt(treeleftval[i][j][7],10) == 2){
				//	alert();
				//}
				if(parseInt(treeleftval[i][j][7],10) == 2 && top_code==treeleftval[i][j][0]){
					orgitem = document.getElementById("orgIframe").contentWindow.document.createElement("li");
				}else{
					// 선택된 최상위코드의 하위코드이면
					if(treeleftval[i][j][6].indexOf(top_code) > -1){
						orgitem = document.getElementById("orgIframe").contentWindow.document.createElement("li");
					}else{
						orgitem = null;
					}
					
				}
				if(orgitem != null){
					// 트리의 값을 셋팅한다
					orgitem.id = "orgtreeid" + treeleftval[i][j][0];
					orgitem.m_code		= treeleftval[i][j][0];//' M_CODE
					orgitem.m_nm		= treeleftval[i][j][1];//' M_NM
					orgitem.m_up_code	= treeleftval[i][j][2];//' M_UP_CODE
					orgitem.depth_no	= treeleftval[i][j][3];//' DEPTH_NO
					orgitem.order_no	= treeleftval[i][j][4];//' ORDER_NO
					orgitem.link_ty	= treeleftval[i][j][5];//' LINK_TY
					orgitem.m_codes	= treeleftval[i][j][6];//' M_CODES
					orgitem.lv			= treeleftval[i][j][7];//' LV
					orgitem.link_path	= treeleftval[i][j][8];//' LINK_PATH
					orgitem.link_target	= treeleftval[i][j][9];//' LINK_TARGET
					orgitem.innerHTML = treeleftval[i][j][1]+"<ul id='"+"orgtreeulid" + treeleftval[i][j][0]+"'></ul>";


					if(parseInt(treeleftval[i][j][7],10) == 2 && top_code==treeleftval[i][j][0]){
							document.getElementById("orgIframe").contentWindow.document.getElementById("org").appendChild(orgitem);
							//alert("1레벨:"+treeleftval[i][j][1]);
					// 루트 노드가 아닐경우 상위 노드의 자식노드로 등록한다
					}else{
							//alert("3:"+"lefttreeid"+treeleftval[i][j][2]);
							document.getElementById("orgIframe").contentWindow.document.getElementById("orgtreeulid"+treeleftval[i][j][2]).appendChild(orgitem);
					}					
				}


			}// for문 종료
		}// for문 종료	   
	   document.getElementById("orgIframe").contentWindow.orgshow(); 
   }
   
 
	          
//]]>		
</script>           
<!--     <li>
       uhoon
       <ul>
         <li>Open API
           <ul>
             <li>Jquery API</li>
             <li>Google API</li>
             <li>Daum API</li>
             <li>Naver API</li>
             <li>단일 기능 API</li>
             <li>Javascript API</li>
           </ul>
         </li>
         <li>DataBase
           <ul>
             <li>MS-SQL</li>
             <li>MY-SQL</li>
           </ul>
         </li>
       </ul>
     </li>	-->				
<iframe name ="orgIframe" id="orgIframe" width="100%" height="100%" title="조직도프레임" frameborder="1" src="/common/orgmainsub.jsp"></iframe>
   
					<%	 
					   }else{
					%>

					<%
					   }
					%>
					<!--내용끝-->