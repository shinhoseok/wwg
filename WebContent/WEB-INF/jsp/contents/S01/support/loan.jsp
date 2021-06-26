<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/loan.jsp
/* 프로그램 이름     : loan    
/* 소스파일 이름     : loan.jsp
/* 설명              : 중소기업 지원안내 > 인력·금융 > KOMIPO 상생협력대출
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
                            <img src="<%=con_root %>/images/project_img/sub/loan01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/loan02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/loan03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">사업내용</h4>
                        <h4 class="titleM2">사업명 : KOMIPO-IBK기업은행 공동「KOMIPO 상생협력대출 사업」</h4>
                        <p>중부발전의 무이자 예탁금을 기반으로 중소기업에 대출이자 지원</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">사업 역무</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li class="f_left"><p>중부발전 : 정기예탁금을 활용, 중소기업 대출이자 지원</p></li>
                                    <li class="f_right"><p>기업은행 : 중소기업 대출 심사 및 경영지원 프로그램 제공</p></li>
                                    <li class="f_left"><p>협력기업 : 대출금리 인하 및 경영지원 프로그램 수혜</p></li>
                                </ul>
                            </div>
                            <div class="squareList">
                                <ul>
                                    <li class="f_left">
                                        <div class="inner">
                                            <p>한국중부발전</p>
                                            <span>정기예금 예치 및 협력중소기업 추천</span>
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <div class="inner">
                                            <p>기업은행</p>
                                            <span>대출기금 조성 및 경영지원프로그램 제공</span>
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <div class="inner">
                                            <p>협력 중소기업</p>
                                            <span>대출금리 인하 및 유동성 확보</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">사업추진현황</h4>
                        <h4 class="titleM2">협약은행 선정 : IBK 기업은행</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>예탁금 이자율 및 중소기업 대출금리감면 최고요율 제시</p></li>
                                <li class="f_right"><p>다수의 동반성장 프로그램 운용 : 참 좋은 무료컨설팅 등</p></li>
                                <li class="f_left"><p>中企금융 선도은행 : 中企대출 취급비중(77.7%, 시중은행 29%~39%)</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">은행별 제안 비교</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>은행별 제안 비교-구분,기업은행,우리은행,외환은행</caption>
                                <colgroup>
                                    <col width="25%">
                                    <col width="25%">
                                    <col width="25%">
                                    <col width="25%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>구 분</th>
                                        <th>기업은행</th>
                                        <th>우리은행</th>
                                        <th>외환은행</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>대출금리 감면</td>
                                        <td>최대 2.3%</td>
                                        <td>1.95%</td>
                                        <td>1.85%</td>
                                    </tr>
                                    <tr>
                                        <td>예탁금이자율</td>
                                        <td>미 실행분 1.95% (0.35% 추가인하)</td>
                                        <td>미 실행분 1.95%</td>
                                        <td>미 실행분 1.85%</td>
                                    </tr>
                                    <tr>
                                        <td>부가서비스</td>
                                        <td>경영컨설팅 등</td>
                                        <td>재무 컨설팅</td>
                                        <td>협력기업 환율우대</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">대출기금 : 200억원</h4>
                        <p>대출기금 내에서 협력 중소기업 대출이자 1.15% 지원</p>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원 대상</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>지역사회 상생협력방안으로 지역협력기업 우선지원(보령 · 서천)</p></li>
                                <li class="f_right"><p>상생협력사 및 우리회사 정비적격 인증업체 등 200여개사</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원 협약내용</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>지원 협약내용-구분,주요내용,비고</caption>
                                <colgroup>
                                    <col width="30%">
                                    <col width="*">
                                    <col width="30%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>구 분</th>
                                        <th>주요내용</th>
                                        <th>비 고</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>예치금액</td>
                                        <td>100억원(2배수 운용으로 대출기금 200억)</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>협약기간</td>
                                        <td>협약체결 후 1년간(1년 단위로 갱신)</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>예치이자</td>
                                        <td>무이자 원칙(미실행분 1.95%이자)</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>대출한도</td>
                                        <td>기업당 최고 10억원 한도</td>
                                        <td>기본한도 : 5억원</td>
                                    </tr>
                                    <tr>
                                        <td>책임한도</td>
                                        <td>대출여부 판단 및 미상환등에 대한 책임은 은행에 귀속</td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>기타</td>
                                        <td>참 좋은 무료컨설팅 등 경영지원 프로그램 운용</td>
                                        <td></td>
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
	$('#contents').parent('div').addClass('loan');
});	


//]]>           
</script>  
