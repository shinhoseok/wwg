<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/starategy/organization03.jsp
/* 프로그램 이름     : organization03    
/* 소스파일 이름     : organization03.jsp
/* 설명              : 동반성장전략 > 조직도 > 계약관리부 소개
/* 버전              : 1.0.0
/* 최초 작성자       : lky
/* 최초 작성일자     : 2019-06-27
/* 최근 수정자       : lky
/* 최근 수정일시     : 2019-06-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>

                <div class="cts_mid">
                    <div class="prg">
                        <h4 class="titleM">업무 분장</h4>
                        <img src="<%=con_root %>/images/project_img/sub/contact.jpg" alt="계약관리부 소개 업무분장" />
                        <div class="chart hide">
                            <ul>
                                <li class="chart01">
                                    <p>부장</p>
                                    <span>류종열</span>
                                </li>
                                <li class="chart03">
                                    <p>차장</p>
                                    <span>임채훈, 김수현, 이재혁, 전지영</span>
                                </li>
                                <li class="chart04">
                                    <p>사원</p>
                                    <span>정보경, 최훈렬, 김정숙, 성희순</span>
                                </li>
                            </ul>        
                        </div>
                    </div>
                    <div class="prg">
                        <p class="telNum"><span>대표번호</span>070-7511-1711~7, 1719</p>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>계약관리부 소개 업무분장 - 성명, 담당업무로 구성</caption>
                                <colgroup>
                                    <col width="22%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>성명</th>
                                        <th>담당업무</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>부장 류종열</th>
                                        <td>
                                            <div class="listbg">
                                                <p>부서 업무 총괄</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 임채훈</th>
                                        <td>
                                            <div class="listbg">
                                                <p>구매 10억원 이상 가격조사</p>
                                                <p>물자 및 기자재관리 업무, 기자재 공급자 관리 총괄</p>
                                                <p>대외기관(감사원, 국회 등) 관련 업무 총괄</p>
                                                <p>처주무(회의자료, 업무계획, 보안) 및 내부평가 총괄</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 김수현</th>
                                        <td>
                                            <div class="listbg">
                                                <p>공사 30억원 이상 계약 및 사후관리</p>
                                                <p>구매 10억원 이상 계약 및 사후관리</p>
                                                <p>구매 2.1억원 ~ 10억원 미만 가격조사</p>
                                                <p>경영공시</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 이재혁</th>
                                        <td>
                                            <div class="listbg">
                                                <p>용역 4억원 이상 계약 및 사후관리</p>
                                                <p>보험료 2억원 이상 계약 및 보험업무 총괄</p>
                                                <p>계약규정, 계약제도 관리, 계약담당자 교육</p>
                                                <p>정부 경평관련 업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 전지영</th>
                                        <td>
                                            <div class="listbg">
                                                <p>신보령, 신서천, 서울복합, 제주복합 주기기 사후관리 총괄</p>
                                                <p>외자업무 총괄 및 정비외자 10억원 이상 구매</p>
                                                <p>구매 10억원 미만 계약 및 사후관리</p>
                                                <p>인수, 통관업무 총괄</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>주임 정보경</th>
                                        <td>
                                            <div class="listbg">
                                                <p>공사 30억원 미만 계약 및 사후관리</p>
                                                <p>용역 4억원 미만 계약 및 용역계약 사후관리</p>
                                                <p>2.1억원 미만 구매 가격조사</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>사원 최훈렬</th>
                                        <td>
                                            <div class="listbg">
                                                <p>정비외자 10억원 미만 구매/인수, 통관 업무 지원</p>
                                                <p>주기기 사후관리(신보령, 신서천, 서울복합, 제주복합)</p>
                                                <p>보험료 2억원 미만 계약 및 보험계약 사후관리</p>
                                                <p>기자재 공급자 관리 보조</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>대리 김정숙</th>
                                        <td>
                                            <div class="listbg">
                                                <p>구매 2.1억원 미만 계약 및 사후관리</p>
                                                <p>대외기관(감사원, 국회 등) 관련 업무 지원</p>
                                                <p>계약대장 및 SRM 통계(수급계획, 사전정보공개 등)</p>
                                                <p>주무업무(교욱, 인사, 내평, 청렴(감사) 등) 보조</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>주임 성희순</th>
                                        <td>
                                            <div class="listbg">
                                                <p>경영공시 입찰정보 모니터링</p>
                                                <p>보안 관련업무 보조</p>
                                                <p>일반서무(문서수발, 카드, 후생, 근태)</p>
                                                <p>적하보험 부보 및 계약실적증명서 발급업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('organization');
});	


//]]>           
</script>  
