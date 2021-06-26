<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/presentation.jsp
/* 프로그램 이름     : presentation    
/* 소스파일 이름     : presentation.jsp
/* 설명              : 중소기업 지원안내 > 판로확대 > 중소기업제품 설명회
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
                            <img src="<%=con_root %>/images/project_img/sub/presentation01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/presentation02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/presentation03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <div class="numList">
                            <ul>
                                <li class="f_left"><p>사업소 수요부서 담당자에게 우수제품 선택기회 제공</p></li>
                                <li class="f_right"><p>기업개발제품 판로확대 지원을 통한 중소기업 기술개발 촉진</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">내용</h4>
                        <h4 class="titleM2">참가대상(제품)</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>신기술인증(NEP)제품, 신기술인증(NET) 제품 보유기업</p></li>
                                <li class="f_right"><p>우수 소프트웨어(GS)인증제품, 성능인증제품, 조달우수제품 보유기업</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">제품 설명회 내용</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>분야별로 부서방문 또는 정해진 장소에서 자사제품 설명 및 상담</p></li>
                                <li class="f_right"><p>제품설명서, 홍보물, 카탈로그, 시제품 등을 이용한 중소기업의 판촉활동</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">설명회 추진일정</h4>
                            <div class="border_p">
                                <div class="numList">
                                    <ul>
                                        <li><p>개최시기 : 매년 3월, 8월 년 2회(상세일정은 추후 공지)</p></li>
                                        <li><p>대상사업소 : 보령발전본부, 인천발전본부, 서울발전본부, 서천건설본부 , 제주발전본부, 세종발전본부</p></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('presentation');
});	


//]]>           
</script>  
