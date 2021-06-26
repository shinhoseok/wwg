<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/joint.jsp
/* 프로그램 이름     : joint    
/* 소스파일 이름     : joint.jsp
/* 설명              : 중소기업 지원안내 > 기술개발 > 민·관공동투자 기술개발사업
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
                            <img src="<%=con_root %>/images/project_img/sub/joint01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/joint02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/joint03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <p>정부와 수요처가 공동으로 중소기업의 기술개발에 투자하는 지원자금을 미리 조성한 후,수요처는 국산화 또는 신제품 개발수요에 따라 개발과제를 발굴·제안하고정부는 개발에 적합한 중소기업을 선정하여 개발비를 지원</p>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">내용</h4>
                        <h4 class="titleM2">지원내용</h4>
                        <p>수요처에서 개발을 제안하여 채택한 국산화 또는 신제품 개발과제에 대해 목형.사출, 생산공정 설계, 신뢰성 검사 및 인증, 시험생산 등 양산용 시제품까지 개발에 소요되는 비용지원</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원조건</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>지원조건-구분,개발기간 및 금액,지원금 비중(정부 및 수요처 1:1 지원)</caption>
                                <colgroup>
                                    <col width="33%">
                                    <col width="33%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>구 분</th>
                                        <th>개발기간 및 금액</th>
                                        <th>지원금 비중 (정부 및 수요처 1:1 지원)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>수요조사과제</td>
                                        <td>최대 2년, 10억원</td>
                                        <td> 총 개발비의 75%이내</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">추진절차</h4>
                        <div class="squareList">
                            <ul>
                                <li class="f_left list1">
                                    <em>01</em>
                                    <div class="inner">
                                        <p>과제발굴, 제출</p>
                                        <span>운영기관:수요처</span>
                                    </div>
                                </li>
                                <li class="f_left list1">
                                    <em>02</em>
                                    <div class="inner">
                                        <p>RFP검증</p>
                                        <span>관리기관</span>
                                    </div>
                                </li>
                                <li class="f_left list1">
                                    <em>03</em>
                                    <div class="inner">
                                        <p>과제공고</p>
                                        <span>중소기업청</span>
                                    </div>
                                </li>
                                <li class="f_left list1">
                                    <em>04</em>
                                    <div class="inner">
                                        <p>과제신청</p>
                                        <span>주관기관</span>
                                    </div>
                                </li>
                                <li class="f_right list2">
                                    <em>05</em>
                                    <div class="inner">
                                        <p>서면평가</p>
                                        <span>전문기관</span>
                                    </div>
                                </li>
                                <li class="f_right list2">
                                    <em>06</em>
                                    <div class="inner">
                                        <p>대면평가</p>
                                        <span>전문기관</span>
                                    </div>
                                </li>
                                <li class="f_right list2">
                                    <em>07</em>
                                    <div class="inner">
                                        <p>현장평가</p>
                                        <span>관리기관</span>
                                    </div>
                                </li>
                                <li class="f_right list2">
                                    <em>08</em>
                                    <div class="inner">
                                        <p>표준계약체결</p>
                                        <span>운영기관:수요처</span>
                                    </div>
                                </li>
                                <li class="f_left list3">
                                    <em>09</em>
                                    <div class="inner">
                                        <p>협약 및 사업비지급</p>
                                        <span>전문기관</span>
                                    </div>
                                </li>
                                <li class="f_left list3">
                                    <em>10</em>
                                    <div class="inner">
                                        <p>진도점검</p>
                                        <span>관리기관</span>
                                    </div>
                                </li>
                                <li class="f_left list3">
                                    <em>11</em>
                                    <div class="inner">
                                        <p>최종점검</p>
                                        <span>관리기관</span>
                                    </div>
                                </li>
                                <li class="f_left list3">
                                    <em>12</em>
                                    <div class="inner">
                                        <p>최종평가</p>
                                        <span>전문기관</span>
                                    </div>
                                </li>
                            </ul>
                        </div> 
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">신청자격</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li class="f_left"><p>[중소기업기본법] 제2조에 해당하는 중소기업</p></li>
                                    <li class="f_right"><p>과제신청시 협력펀드 조성에 참여한 한국중부발전㈜의 추천을 받아 신청</p></li>
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
	$('#contents').parent('div').addClass('joint');
});	


//]]>           
</script>  
