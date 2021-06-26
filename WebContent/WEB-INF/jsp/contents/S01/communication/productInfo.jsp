<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/communication/productInfo.jsp
/* 프로그램 이름     : bestpractices    
/* 소스파일 이름     : bestpractices.jsp
/* 설명              : 소통마당>  > K - shop 중소기업 제품관 > 중소기업 제품정보
/* 버전              : 1.0.0
/* 최초 작성자       : lky
/* 최초 작성일자     : 2019-07-05
/* 최근 수정자       : lky
/* 최근 수정일시     : 2019-07-05
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>

                <div class="cts_mid">
                    <div class="prg">
                        <div class="imgArea">
                            <img src="<%=con_root%>/images/project_img/sub/productInfo01.jpg" alt="" />
                            <img src="<%=con_root%>/images/project_img/sub/productInfo02.jpg" alt="" />
                            <img src="<%=con_root%>/images/project_img/sub/productInfo03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">정보센터</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>정보센터-구분,목록</caption>
                                <colgroup>
                                    <col width="20%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>구분</th>
                                        <th>목 록</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th rowspan="6">법률정보</th>
                                        <td>국가를 당사자로 하는 계약에 관한 법률</td>
                                    </tr>
                                    <tr>
                                        <td>국가를 당사자로 하는 계약에 관한 법률 시행령</td>
                                    </tr>
                                    <tr>
                                        <td>중기제품 구매촉진 및 판로지원에 관한 법률</td>
                                    </tr>
                                    <tr>
                                        <td>중기제품 구매촉진 및 판로지원에 관한 법률 시행령</td>
                                    </tr>
                                    <tr>
                                        <td>공기업·준정부기관 계약사무규칙</td>
                                    </tr>
                                    <tr>
                                        <td><p>중기제품 구매목표비율제도</p>
                                            <p>중소기업자간 경쟁제품 지정품목</p>
                                            <p>공사용자재 직접구매 대상품목</p>
                                            <p>기술개발제품 목록</p></td>
                                    </tr>
                                    <tr>
                                        <th>업데이트 정보</th>
                                        <td><p>등록기업 리스트(기업명, 품목, 전화번호, 이메일, 홈페이지)</p>
                                            <p>발전소 O/H 계획(일정)</p>
                                            <p>구매지원담당자 명단</p>
                                            <p>전사 구매목록 리스트(매월 업데이트)</p></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">주요사이트</h4>
                        <ul class="siteList">
                            <li>
                                <a href="http://www.smpp.go.kr" target="_blank" title="공공구매종합정보망(새창)">
                                    <img src="<%=con_root%>/images/project_img/sub/pc01.png" alt="" />
                                    <div class="textArea">
                                        <span>공공구매종합정보망</span>
                                        <em>http://www.smpp.go.kr</em>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="http://www.buynp.or.kr" target="_blank" title="신기술인증제품 정보망(새창)">
                                    <img src="<%=con_root%>/images/project_img/sub/pc02.png" alt="" />
                                    <div class="textArea">
                                        <span>신기술인증제품 정보망</span>
                                        <em>http://www.buynp.or.kr</em>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="http://shopping.g2b.go.kr" target="_blank" title="기술개발제품 정보망(새창)">
                                    <img src="<%=con_root%>/images/project_img/sub/pc03.png" alt="" />
                                    <div class="textArea">
                                        <span>기술개발제품 정보망</span>
                                        <em>http://shopping.g2b.go.kr</em>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="https://www.sepp.or.kr" target="_blank" title="사회적기업제품 정보망(새창)">
                                    <img src="<%=con_root%>/images/project_img/sub/pc04.png" alt="" />
                                    <div class="textArea">
                                        <span>사회적기업제품 정보망</span>
                                        <em>https://www.sepp.or.kr</em>
                                    </div>
                                    </a>
                            </li>
                        </ul>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('productInfo');
});	


//]]>           
</script>  
