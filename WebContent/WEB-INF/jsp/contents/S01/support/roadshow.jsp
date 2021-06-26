<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/roadshow.jsp
/* 프로그램 이름     : roadshow    
/* 소스파일 이름     : roadshow.jsp
/* 설명              : 중소기업 지원안내 > 판로확대 > 구매지원 담당제 운영
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
                            <img src="<%=con_root %>/images/project_img/sub/roadshow01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/roadshow02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/roadshow03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <div class="numList">
                            <ul>
                                <li class="f_left"><p>중소기업의 해외마케팅 강화 및 국제인지도 제고로 수출촉진 기여</p></li>
                                <li class="f_right"><p>중소기업과 동반성장 추진으로 우수기술의 해외 사업화 기반 마련</p></li>
                                <li class="f_left"><p>발전회사 지원으로 중소기업제품의 해외시장 진출 확대</p></li>
                            </ul>
                        </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">내용</h4>
                        <h4 class="titleM2">지원대상</h4>
                            <div class="border_p">
                            <div class="numList">
                                <ul>
                                    <li class="f_left"><p>우리회사 KOMIPO-BEST 상생협력사, 기자재공급자 및 정비적격 등록업체</p></li>
                                    <li class="f_right"><p>또는 최근 3년 이내에 납품 및 공사실적이 있는 업체 등</p></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">구매지원 담당자</h4>
                        <p>부스 및 운송비(왕복), 장치 설치비 등</p>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>전시회 현황 - 구분, 전시회명, 예정일정, 장소, 유관기관, 주관사로 구성</caption>
                                <colgroup>
                                    <col width="16%">
                                    <col width="24%">
                                    <col width="12%">
                                    <col width="12%">
                                    <col width="24%">
                                    <col width="12%">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>구 분</th>
                                        <th>전시회명</th>
                                        <th>예정일정</th>
                                        <th>장 소</th>
                                        <th>유관기관</th>
                                        <th>주관사</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th rowspan="6">국내전시회 (6회)</th>
                                        <td>SWEET 2019</td>
                                        <td>03.13 ~ 03.15</td>
                                        <td>광주</td>
                                        <td>김대중컨벤선센타</td>
                                        <td>서부</td>
                                    </tr>
                                    <tr>
                                        <td>국제전기전력전시회</td>
                                        <td>05.29 ~ 05.31</td>
                                        <td>서울</td>
                                        <td>한국전기기술인협회</td>
                                        <td>남부</td>
                                    </tr>
                                    <tr>
                                        <td>국제환경에너지산업전</td>
                                        <td>09.04 ~ 09.06</td>
                                        <td>부산</td>
                                        <td>투데이에너지</td>
                                        <td>동서</td>
                                    </tr>
                                    <tr>
                                        <td>대한민국 원자력산업대전</td>
                                        <td>09.26 ~ 09.27</td>
                                        <td>경주</td>
                                        <td>한국원자력신문사</td>
                                        <td>한수원</td>
                                    </tr>
                                    <tr>
                                        <td>발전산업대전</td>
                                        <td>10.16 ~ 10.19</td>
                                        <td>서울</td>
                                        <td>한국전기산업진흥회</td>
                                        <td>중부</td>
                                    </tr>
                                    <tr>
                                        <td>한국기계전</td>
                                        <td>10.22 ~ 10.25</td>
                                        <td>일산</td>
                                        <td>한국기계산업진흥회</td>
                                        <td>남동</td>
                                    </tr>
                                    <tr>
                                        <th rowspan="6">해외전시 (6회)</th>
                                        <td>환경에너지 산업전</td>
                                        <td>06.12 ~ 06.14</td>
                                        <td>베트남</td>
                                        <td>투데이에너지</td>
                                        <td>서부</td>
                                    </tr>
                                    <tr>
                                        <td>Power-Gen 유럽</td>
                                        <td>06.12 ~ 06.14</td>
                                        <td>프랑스</td>
                                        <td>한국전기기술인협회</td>
                                        <td>남부</td>
                                    </tr>
                                    <tr>
                                        <td>Power-Gen ASIA</td>
                                        <td>09.03 ~ 09.05</td>
                                        <td>말레이시아</td>
                                        <td>한국전기기술인협회</td>
                                        <td>남동</td>
                                    </tr>
                                    <tr>
                                        <td>WETEX 전시회</td>
                                        <td>10.21 ~ 10.23</td>
                                        <td>두바이</td>
                                        <td>한국전기기술인협회</td>
                                        <td>중부</td>
                                    </tr>
                                    <tr>
                                        <td>우크라이나 발전박람회</td>
                                        <td>11.05 ~ 11.07</td>
                                        <td>우크라이나</td>
                                        <td>한국전기기술인협회</td>
                                        <td>한수원</td>
                                    </tr>
                                    <tr>
                                        <td>Power-Gen USA</td>
                                        <td>12.04 ~ 12.06</td>
                                        <td>미국</td>
                                        <td>한국전기기술인협회</td>
                                        <td>동서</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원방법</h4>
                            <div class="border_p">
                            <p>전시회별 참가업체 공모, 발전5사 공동선정 및 지원</p>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('roadshow');
});	


//]]>           
</script>  
