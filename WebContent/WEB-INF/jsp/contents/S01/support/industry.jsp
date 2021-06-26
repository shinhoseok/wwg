<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/industry.jsp
/* 프로그램 이름     : industry    
/* 소스파일 이름     : industry.jsp
/* 설명              : 중소기업 지원안내 > 경영혁신 > 산업재산권 취득 지원
/* 버전              : 1.0.0
/* 최초 작성자       : lky
/* 최초 작성일자     : 2019-06-28
/* 최근 수정자       : lky
/* 최근 수정일시     : 2019-06-28
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>

                <div class="cts_mid">
                    <div class="prg">
                        <div class="imgArea">
                            <img src="<%=con_root %>/images/project_img/sub/industry01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/industry02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/industry03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <p>중소기업 보유기술의 산업재산권화를 지원하여 사업화 촉진</p>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">지원대상 및 내용</h4>
                        <h4 class="titleM2">대상기업</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>우리회사 기자재공급자 및 정비적격등록업체</p></li>
                                <li class="f_right"><p>또는 최근 3년 이내에 납품 및 공사실적이 있는 업체</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원내용</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>특허, 실용실안 등의 산업재산권 취득 및 관련비용</p></li>
                                <li class="f_right"><p>사업비용의 75%이내, 업체당 500만원 지원</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">추진일정</h4>
                            <div class="border_p">
                                <div class="numList">
                                <ul>
                                    <li class="f_left"><p>매년 4월 : 지원사업 공고 및 선정</p></li>
                                    <li class="f_right"><p>매년 5월 ~ 12월 : 지원대상 선정 및 지원시행</p></li>
                                </ul>
                            </div> 
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('industry');
});	


//]]>           
</script>  
