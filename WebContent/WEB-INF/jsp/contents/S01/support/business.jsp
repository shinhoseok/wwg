<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/business.jsp
/* 프로그램 이름     : business    
/* 소스파일 이름     : business.jsp
/* 설명              : 중소기업 지원안내 > 기술개발 > 중소기업지원협력연구개발사업
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
                            <img src="<%=con_root %>/images/project_img/sub/business01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/business02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/business03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <p>발전회사의 기술·자금·인력·정보·장비와 중소기업이 보유한 생산시설 및 기술자원을 결합하여 발전회사에 필요한 신기술·신제품 개발</p>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">내용</h4>
                        <h4 class="titleM2">지원대상</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>[중소기업기본법]에 의한 중소기업으로서 연구전담부서를 보유한 발전분야 관련 업체</p></li>
                                <li class="f_right"><p>기타 발전회사에서 인정하는 기술보유 중소기업</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원내용</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>지원내용-총 연구개발비,지원규모,비고</caption>
                                <colgroup>
                                    <col width="33%">
                                    <col width="33%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>총 연구개발비</th>
                                        <th>지원규모</th>
                                        <th>비 고</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>3억원 미만</td>
                                        <td>총 개발비의 75% 이내</td>
                                        <td rowspan="3">최대 5억원 지원</td>
                                    </tr>
                                    <tr>
                                        <td>3억원 이상~7억원 미만</td>
                                        <td>총 개발비의 70% 이내</td>
                                    </tr>
                                    <tr>
                                        <td>7억원 이상</td>
                                        <td>5억원 이내</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">추진일정</h4>
                        <div class="border_p">
                            <p>매년 2월 과제 공모 → 매년 4월 사업과제 공모 → 매년 6월 중 계약체결</p>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('business');
});	


//]]>           
</script>  
