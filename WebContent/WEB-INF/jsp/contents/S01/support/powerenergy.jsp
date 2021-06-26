<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/powerenergy.jsp
/* 프로그램 이름     : powerenergy    
/* 소스파일 이름     : powerenergy.jsp
/* 설명              : 중소기업 지원안내 > 인력·금융 > 금융지원(파워에너지론)
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
                            <img src="<%=con_root %>/images/project_img/sub/power01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/power02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/power03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">상품개요</h4>
                        <div class="border_p">
                            <p>한국중부발전㈜와 전자계약을 근거로 기업은행에서 계약금액의 최대 80%까지 선 자금을 지원하는 금융상품</p>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">상품구조 및 운영절차</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>협력기업 전자계약 낙찰</p></li>
                                <li class="f_right"><p>전자계약서에 근거하여 운영자금 1차 협력기업 대출</p></li>
                                <li class="f_left"><p>1차 협력기업이 2차 협력기업으로부터 구매한 물품에 대하여 은행에서 현금성 결제 지원</p></li>
                                <li class="f_right"><p>납품 후 대금지급시 사전에 고정된 대출은행 계좌로 대금 지급</p></li>
                                <li class="f_left"><p>은행에서 대출금 회수 후 잔액을 기업으로 송부</p></li>
                            </ul>
                        </div>
                        <div class="imgArea subimg">
                            <img src="<%=con_root %>/images/project_img/sub/energy.jpg" alt="파워에너지론 상품구조 및 운영절차 과정" />
                            <div class="hide">
                                <ol>
                                    <li>한국중부발전</li>
                                    <li>sPRM발주·결제정보중계시스템</li>
                                    <li>
                                        <dl>
                                            <dt>2차 협력회사</dt>
                                            <dd>운영자금 선지원(납품 후)</dd>
                                            <dd>IBK기업은행</dd>
                                        </dl>
                                    </li>
                                    <li>sPRM전자결제정보중계시스템</li>
                                    <li>
                                        <dl>
                                            <dt>3차 협력회사</dt>
                                            <dd>구매자금현금성결제</dd>
                                        </dl>
                                    </li>
                                </ol>                                                                                 
                            </div>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('power');
});	


//]]>           
</script>  
