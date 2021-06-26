<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/cm/S01/CmMain.jsp  
/* 프로그램 이름     : CmMain    
/* 소스파일 이름     : CmMain.jsp
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
<!-- 공통 jsp 파일-->

<script>
function linkMove(){
	var newWin = window.open('about:blank');
	newWin.location.href="https://www.winwinnuri.or.kr/";
}
</script>

<body>

	<%@include file="/WEB-INF/jsp/cm/S01/Cmtop.jsp"%>
    <section class="mainVisual"><!--메인비주얼영역-->
        <a id="contents" href="#n" tabindex="-1" class="hide">본문</a>
        <div class="visual_slide">  
            <div class="item item1">
                <div class="wrap">
                    <div class="main_tit">
                        <p>함께하는 <strong>도전</strong>ㆍ함께하는 <strong>성장</strong>ㆍ함께하는 <strong>미래</strong> <span>미래를 향한 꿈 함께 도전합니다</span></p>
                    </div>
                </div>
            </div>
            <div class="item item2">
                <div class="wrap">
                    <div class="main_tit">
                        <p>더불어 성장하는 <strong>힘</strong> <span>함께 키워갑니다</span></p>
                    </div>
                </div>
            </div>
            <div class="item item3">
                <div class="wrap">
                    <div class="main_tit">
                        <p>세상을 밝히는 <strong>길</strong> <span>함께 만들어 갑니다</span></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="control">
			<button class="play">재생</button>
		     <button class="pause">일시정지</button>
		</div>
        <div class="supportInfo">
            <div class="wrap">
                <h3>중소기업 지원안내</h3>
                <ul>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000399','000104','Y');return false;">경영혁신</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000105','000104','Y');return false;">기술개발</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000401','000104','Y');return false;">판로확대</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000402','000104','Y');return false;">인력금융</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000483','000104','Y');return false;">육성사업</a></li>
                </ul>
            </div>
        </div>
    </section><!--//메인비주얼영역-->
    <section class="mainNews"><!--뉴스,공고영역-->
        <div class="wrap">
            <div class="paradigm">
                <a href="#" onclick="Go_SubmenuTop(3,'000167','000049','Y');return false;">
                    <div class="paraInner">
                        <h3>동반성장 4.0 <br>New Paradigm</h3>
                        <p>중부발전은 중소기업과의 상생협력을 통해 동반성장의 길을 찾아갑니다</p>
                        <span class="detailBtn">자세히보기</span>
                    </div>
                </a>
            </div>
            <div class="newsList">
                <div class="list">
							<%
							rtn_tmp_Map = (Map)rtn_Map.get("getMainNotice2");// NEWS
							tmp_list = (List)rtn_tmp_Map.get("rows");
							int i = 0;
							if(tmp_list!=null){
								for(i=0;i<tmp_list.size();i++){	
									rtn_row_Map = (Map)tmp_list.get(i);
							%>
			                    
			                        <div class="newsInner">
			                            <span class="news_tit" onclick="Go_SubmenuTop(2,'000524','000090','Y');return false;" style="cursor:pointer;">NEWS</span>
			                            <a href="#" onClick="Go_SubmenuView('<%=rtn_row_Map.get("menu_cd") %>','<%=rtn_row_Map.get("data_seqno")%>');return false;">
			                            <h4><%=(String)rtn_row_Map.get("data_title")%><%if(dateUtility.getDaysBetweenPeriod(curDate.replaceAll("-", ""),rtn_row_Map.get("reg_dt").toString().replaceAll("-", "")) < 14){ %><img src="<%=img_url%>/main/board_new.png" alt="new" /><%} %></h4>
			                            <p><%=StringUtil.strCut(HtmlTag.StripStrInHtml(((String)rtn_row_Map.get("data_desc")).replaceAll("&amp;","&").replaceAll("&amp;","&").replaceAll("\"","'").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("\r\n", "<br />")),90)%></p>
			                            <span class="rightTime"><%=rtn_row_Map.get("reg_dt") %></span>
			                            </a>
			                        </div>
			                    								
							<%
									if(i==0){break;}
								}
							}else{
							%>
			                    
			                        <div class="newsInner">
			                            <span class="news_tit" onclick="Go_SubmenuTop(2,'000524','000090','Y');return false;" style="cursor:pointer;">NEWS</span>
			                            <a href="#" onclick="return false;">
			                            <h4>등록된 NEWS가 없습니다.</h4>
			                            <p></p>
			                            <span class="rightTime"></span>
			                            </a>	
			                        </div>
			                    						

							<%
							}
							%>                

                </div>
                <div class="list">
							<%
							rtn_tmp_Map = (Map)rtn_Map.get("getMainNotice1");// 공지사항
							tmp_list = (List)rtn_tmp_Map.get("rows");

							if(tmp_list!=null){
								for(i=0;i<tmp_list.size();i++){	
									rtn_row_Map = (Map)tmp_list.get(i);
							%>
			                    
			                        <div class="newsInner">
			                        	<span class="news_tit" onclick="Go_SubmenuTop(2,'000115','000090','Y');return false;" style="cursor:pointer;">NOTICE</span>
			                            <a href="#" onClick="Go_SubmenuView('<%=rtn_row_Map.get("menu_cd") %>','<%=rtn_row_Map.get("data_seqno")%>');return false;">
			                            <h4><%=(String)rtn_row_Map.get("data_title")%><%if(dateUtility.getDaysBetweenPeriod(curDate.replaceAll("-", ""),rtn_row_Map.get("reg_dt").toString().replaceAll("-", "")) < 14){ %><img src="<%=img_url%>/main/board_new.png" alt="new" /><%} %></h4>
			                            <p><%=StringUtil.strCut(HtmlTag.StripStrInHtml(((String)rtn_row_Map.get("data_desc")).replaceAll("&amp;","&").replaceAll("&amp;","&").replaceAll("\"","'").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("\r\n", "<br />")),90)%></p>
			                            <span class="rightTime"><%=rtn_row_Map.get("reg_dt") %></span>
			                            </a>	
			                        </div>
			                    							
							<%
									if(i==0){break;}
								}
							}else{
							%>
			                    
			                        <div class="newsInner">
			                            <span class="news_tit" onclick="Go_SubmenuTop(2,'000115','000090','Y');return false;" style="cursor:pointer;">NOTICE</span>
			                            <a href="#" onclick="return false;">
			                            <h4>등록된 공지사항이 없습니다.</h4>
			                            <p></p>
			                            <span class="rightTime"></span>
			                            </a>	
			                        </div>
			                    						

							<%
							}
							%>                

                </div>
                <div class="list">
							<%
							rtn_tmp_Map = (Map)rtn_Map.get("getMainNotice3");// 지원사업공고
							tmp_list = (List)rtn_tmp_Map.get("rows");
							if(tmp_list!=null){
								for(i=0;i<tmp_list.size();i++){	
									rtn_row_Map = (Map)tmp_list.get(i);
							%>
			                    
			                        <div class="newsInner">
			                        	<span class="news_tit" onclick="Go_SubmenuTop(2,'000091','000090','Y');return false;" style="cursor:pointer;">지원사업공고</span>
			                        				                           
			                            <a href="#" onClick="Go_SubmenuView('<%=rtn_row_Map.get("menu_cd") %>','<%=rtn_row_Map.get("data_seqno")%>');return false;">
			                            <h4><%=(String)rtn_row_Map.get("data_title")%><%if(dateUtility.getDaysBetweenPeriod(curDate.replaceAll("-", ""),rtn_row_Map.get("reg_dt").toString().replaceAll("-", "")) < 14){ %><img src="<%=img_url%>/main/board_new.png" alt="new" /><%} %></h4>
			                            <p><%=StringUtil.strCut(HtmlTag.StripStrInHtml(((String)rtn_row_Map.get("data_desc")).replaceAll("&amp;","&").replaceAll("&amp;","&").replaceAll("\"","'").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("\r\n", "<br />")),90)%></p>
			                            <span class="rightTime"><%=rtn_row_Map.get("reg_dt") %></span>
			                             </a>	
			                        </div>
			                   							
							<%
									if(i==0){break;}
								}
							}else{
							%>
			                    
			                        <div class="newsInner">
			                            <span class="news_tit" onclick="Go_SubmenuTop(2,'000091','000090','Y');return false;" style="cursor:pointer;">지원사업공고</span>
			                            <a href="#" onclick="return false;">
			                            <h4>등록된 지원사업공고가 없습니다.</h4>
			                            <p></p>
			                            <span class="rightTime"></span>
			                            </a>
			                        </div>
			                    							

							<%
							}
							%>                 

                </div>
            </div>
        </div>
    </section><!--//뉴스,공고영역-->
    <section class="mainService"><!--서비스영역-->
        <div class="wrap">
            <div class="cooperService">
                <h3>협력기업 지원 서비스</h3>
                <ul>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000162','000156','Y');return false;">입찰정보</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000163','000156','Y');return false;">계약이행 실적증명발급</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000164','000156','Y');return false;">기자재 공급 유자격 통합관리</a></li>
                </ul>
                <ul>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000487','000156','Y');return false;">정비적격업체 통합관리</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000488','000156','Y');return false;">시험성적서 검증</a></li>
                    <li><a href="#" onclick="Go_SubmenuTop(2,'000489','000156','Y');return false;">공급인증서(REC)거래</a></li>
                </ul>
            </div>
            <div class="serviceBanner">
                <ul>
                    <li class="serviceBanner01">
                        <a href="<c:url value='/cmsmain.do' />?scode=S01&pcode=000519" target="_new" tabindex="1" title="새창열림">
                            <h4>Power-Up K-글로벌<br>동반성장 모델 안내</h4>
                            <p>우리 나라의 중소기업이 세계적인 강소기업으로 성장할 수 있도록 총체적으로 지원하는 한국중부발전 고유의 중소기업 동반성장 특화 브랜드 장보고 프로젝트를 소개합니다.</p>
                        </a>
                    </li>
                    <li class="serviceBanner02">
                    	 <a href="javascript:void(0);" onclick="linkMove();" target="_new" tabindex="2" title="새창열림">
                            <h4>국가 대표 상생협력 종합 플랫폼<br><span style="font-size:30px; font-weight:bold;letter-spacing:7px;">상생누리</span></h4>
                            <p>대기업,공공기관의 우수한 상생협력 프로그램에 참여해 보세요!</p>
                        </a>
                    </li>
                </ul>
                <div class="control">
                    <button class="play">재생</button>
                    <button class="pause">일시정지</button>
                </div>
            </div>
            <div class="commuService">
                <h3>소통 지원 서비스</h3>
                <div class="service01">
                    <a href="#" onclick="Go_SubmenuTop(2,'000101','000090','Y');return false;">K - shop<br />중소기업 제품관</a>
                </div>
                <div class="service02">
                    <a href="#" onclick="Go_SubmenuTop(2,'000100','000090','Y');return false;">중소기업 Q&amp;A</a>
                </div>
            </div>
        </div>
    </section><!--//서비스영역-->
	<!--footer-->
	<%@include file="/WEB-INF/jsp/cm/S01/Cmfooter.jsp"%>
	<!--//footer-->     

	<!--main pop-->
	<%@include file="/WEB-INF/jsp/cm/S01/CmMainPop_i1.jsp"%>
	<!--//main pop-->     
</body>
</html>
