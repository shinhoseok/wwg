<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/winwin.jsp
/* 프로그램 이름     : winwin    
/* 소스파일 이름     : winwin.jsp
/* 설명              : 중소기업 지원안내 > 육성사업 > 상생결제시스템 도입
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
                            <img src="<%=con_root %>/images/project_img/sub/winwin01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/winwin02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/winwin03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">상생결제 제도 안내문</h4>
                        <h4 class="titleM2">1. 상생결제 제도 개요</h4>
                        <div class="numList intable">
                            <ul>
                                <li>
                                    <p>중부발전이 발행한 외상매출채권(대금지급)을 기반으로 채권금액 한도내에서 1차가 2차에게, 2차가 3차기업에게 채권발행으로 결제대금을 정산하는 제도</p>
                                    <div class="tableArea">
                                        <table class="tableC">
                                            <caption>상생결제 제도-추진방향,1차기업,2차기업</caption>
                                            <colgroup>
                                                <col width="33%">
                                                <col width="33%">
                                                <col width="33%">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th>추진방향</th>
                                                    <th>1차 기업</th>
                                                    <th>2차 기업</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div class="listbg">
                                                            <p>매출채권 발행</p>
                                                            <p>우리,농협에 대금입금(채권발행후 1일)</p>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="listbg">
                                                            <p>대금수령 </p>
                                                            <p>2차로 채권발행<br>(대중소 농업협력재단 계좌로 발행  금액 예치)</p>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="listbg">
                                                            <p>대금수령 </p>
                                                            <p>2차는 자금융통을 위해 대출(할인)가능</p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <span>대중소 농업업협력재단 명의 계좌는 가압류 방지계좌</span>
                                </li>
                                <li><p>2차기업의 대출시(채권할인) 은행의 상환청구권이 없고 1차 기업이 부도가 발생해도 2차기업은 안전하게 금액을 받을수 있음</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">2. 1차 기업의 이익</h4>
                        <div class="numList">
                            <ul>
                                <li><p>환출이자 : 2차기업이 채권 할인(대출)시 이자(2.5%내외) 지급 (약정은행에 따라 약간 상이)</p></li>
                                <li><p>장려금 : 2차 협력기업이 채권을 만기보유시 MMDA(1%내외) 이자지급</p></li>
                                <li>
                                    <p>법인세 감면</p>
                                    <span>상생결제를 통한 지급금액 중 지급기한이 세금계산서 작성일로부터 15일 이내 0.2%, 15일~60일 0.1% 세액감면</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">3. 2차 기업의 이익</h4>
                        <div class="numList">
                            <ul>
                                <li><p>기존 어음이나 채권을 할인받을 때 고금리로 할인 받았다면 이제 대 기업(공공기관)과 같은 금리로 할인 받아 이자비용 절감</p></li>
                                <li><p>협력기업이 받은 대출(할인)은 은행이 상환 청구권을 행사하지 않음</p></li>
                                <li><p>가압류가 방지된 예치계좌로 상위 기업이 결제한 금액은 안전하게 지급</p></li>
                                <li><p>법인세 감면은 1차 기업의 이익과 동일</p></li>
                                <li>
                                    <p>예시</p>
                                    <span>대기업이 1차 기업에게 매출채권 5억원을 발행하고 1차 기업이 2차 기업에게 매출채권 3억원을 발행한 경우</span>
                                </li>
                            </ul>
                        </div>
                        <div class="imgBox">
                            <div class="imgArea">
                                <img src="<%=con_root %>/images/project_img/sub/winwinBg.png" alt="대기업/공공기관 1차협력기업(7/1~7/2 1일동안 5억발행), 1차협력기업 2차협력기업(7/1~8/15 45일동안 3억발행 7/3 2억할인)" />
                            </div>
                            <div class="textArea">
                                <div class="topText">
                                    <p>기존</p>
                                    <div class="listbg">
                                        <p>7/2 대기업/공공기관이 5억 지급</p>
                                        <p>1차 협력기업은 어음발생을 통해 2차 협력 기업에게 대금지급</p>
                                        <p>8/15까지 3억을 은행예치(MMDA금리 0.8%)</p>
                                        <span>- 이자수익 : 3억 * 44/365 * 0.008 = <em class="blue3">289,315</em></span>
                                    </div>
                                </div>
                                <div class="btmText">
                                    <p>상생결제시스템 적용</p>
                                    <div class="listbg">
                                        <p>1차 협력기업은 2차 협력기업에게 대금지급을 위해 8/15일 만기 채권발행</p>
                                        <p>2차 협력기업은 7/3일 은행에서 2억 할인(할인시 대기업금리 3%적용)</p>
                                        <span>- 환출이자 : 2억 * 43/365 * 0.003 = 706,849</span>
                                        <span>- 장려금 : 3억 * 1/365 * 0.008 = 6,575<em> 1억 * 43/365 * 0.008 = 94,247</em></span>
                                        <span>- 법인세감면 : 3억 * 0.001 = 300,000</span>
                                        <span>= 총 수익 : <em class="blue3">1,107,671</em></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">4. 은행 약정현황</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>2016.9.23 : 우리은행과 약정체결(우리은행 상생파트너론)</p></li>
                                <li class="f_right"><p>2017.7.28 : 농협은행 약정체결(NH 다같이 성장론)</p></li>
                                <li class="f_left"><p>2018.12.14 : IBK기업은행 약정체결(IBK 상생결제론)</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">5. 상생결제시스템 참여방법</h4>
                        <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li><p>대출(할인)을 받거나 매출채권 발행하고자 할 때 1차 협력기업은 중부발전이 발행한 매출채권을 은행에게 양도하는 계약체결 필요</p></li>
                                    <li><p>협력기업은 대출금(채권할인을 통한 대금) 수령등을 위하여 농협,우리 은행으로 주거래 은행 변경 필요</p></li>
                                    <li><p>1차 기업과 2차, 2차와 3차 기업간 채권발행 금액은 기업간 약정</p></li>
                                    <li><p>인터넷 뱅킹 또는 은행 방문하여 우리,농협은행에 법인회원 가입, 2차,3차 기업도 회원 가입 해야함</p></li>
                                    <li>
                                        <p>결제전산원(시스템 관리 회사)에 기업용 공인인증서로 회원가입</p>
                                        <span>협력기업 매출채권 발행, 대기업 발행 매출채권 조회 등 가능</span>
                                    </li>
                                </ul>
                            </div>
                            <p>※ 문의처 : 결제전산원 02-703-8881</p>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('winwin');
});	


//]]>           
</script>  
