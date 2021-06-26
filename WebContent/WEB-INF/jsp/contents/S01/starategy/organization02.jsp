<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/starategy/organization02.jsp
/* 프로그램 이름     : organization02    
/* 소스파일 이름     : organization02.jsp
/* 설명              : 동반성장전략 > 조직도 > 기술기획부 소개
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
                        <img src="<%=con_root %>/images/project_img/sub/technology.jpg" alt="기술기획부 소개 업무분장" />
                        <div class="chart hide">
                            <ul>
                                <li class="chart01">
                                    <p>부장</p>
                                    <span>김훈정</span>
                                </li>
                                <li class="chart03">
                                    <p>차장</p>
                                    <span>장재창, 박 철, 이성훈, 조승훈, 김경화</span>
                                </li>
                                <li class="chart04">
                                    <p>사원</p>
                                    <span>박승현, 김대진, 이정언, 임미자</span>
                                </li>
                            </ul>        
                        </div>
                    </div>
                    <div class="prg">
                        <p class="telNum"><span>대표번호</span>070-7511-1310~7, 1319, 1014</p>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>기술기획부 소개 업무분장 - 성명, 담당업무로 구성</caption>
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
                                        <th>부장 김훈정</th>
                                        <td>
                                            <div class="listbg">
                                                <p>부 업무 총괄</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 장재창<br>(차장 이성훈)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>발전설비 예산종합</p>
                                                <p>국회 및 내부경영평가 종합</p>
                                                <p>발전기술원 제도개선 등 조직 및 인사</p>
                                                <p>처내 총무업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 이성훈<br>(차장 조승훈)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>전력기술 종합발전계획 수립</p>
                                                <p>중장기 연구개발 기본계획 수립 및 추진</p>
                                                <p>연구개발과제 종합관리</p>
                                                <p>국가연구개발 및 전력연구원 연구과제 종합관리</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 조승훈<br>(차장 김경화)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>현장기술개발과제, 발전5사 협력연구개발과제 종합관리</p>
                                                <p>지식재산권 출원 및 종합관리</p>
                                                <p>기술이전 및 사업화 관련 업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 김경화<br>(차장 박  철)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>4차 산업혁명 추진·기획</p>
                                                <p>4차 산업혁명 추진과제 총괄관리</p>
                                                <p>발전설비 신기술 및 신공법 관련 도입</p>
                                                <p>대외 기술교류, 세미나·협력업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>차장 박  철<br>(차장 장재창)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>발전교육원 협력 및 기술직 경력개발제도 관련 업무</p>
                                                <p>발전요원의 교육훈련 및 현장조직 관련 업무</p>
                                                <p>업무계획 및 보안관련 업무</p>
                                                <p>청렴도, 윤리경영, 사회공헌활동 업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>주임 박승현<br>(사원 김대진)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>연구개발비 예산, 정산 및 통계</p>
                                                <p>연구개발과제 관리 및 경영공시</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>사원 김대진<br>(주임 박승현)</th>
                                        <td>
                                            <div class="listbg">
                                                <p>4차 산업혁명 관련 업무</p>
                                                <p>지식재산권 및 기술이전/사업화 관련 업무</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>사원 임미자</th>
                                        <td>
                                            <div class="listbg">
                                                <p>문서수발, 부속실 관련 업무</p>
                                                <p>시간외, 학자금 및 경조금 관련 업무</p>
                                                <p>근태처리, 연말정산 및 전표처리</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>대리 이정언</th>
                                        <td>
                                            <div class="listbg">
                                                <p>부사장(기술본부장) 비서 업무</p>
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
