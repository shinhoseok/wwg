<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/starategy/supportsystem.jsp
/* 프로그램 이름     : supportsystem    
/* 소스파일 이름     : supportsystem.jsp
/* 설명              : 동반성장전략 > 동반성장 지원체계·역할
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
                        <h4 class="titleM">동반성장 지원체계</h4>
                        <img src="<%=con_root %>/images/project_img/sub/supportImg.jpg" alt="동반성장 지원체계" />
                        <div class="hide">
                            <h3>동반성장위원회</h3>
                            <dl>
                                <dt>구성</dt>
                                <dd>위원장:CEO, 위원:경영진,사업소장,외부전문가</dd>
                                <dt>역할</dt>
                                <dd>정책개발, 실태점검, 자문위원단과 자문 및 정책조언</dd>
                                <dt>자문위원단</dt>
                                <dd>KOMIPO Global경영자문위원, KOMIPO-BEST상생협력사 대표</dd>
                            </dl>    
                            <h3>동반성장실</h3>
                            <dl>
                                <dt>역할</dt>
                                <dd>정부/유사기관(산업자원부, 대중소기업협력재단)과 지원 및 공조</dd>
                                <dt>사업소 실무부서</dt>
                                <dd>구매지원담당자, 자체 동반성장 위원회, 협력중소기업-기자재240개, 정비적격420개 업체와 지원 및 협력</dd>
                                <dt>본사관련부서</dt>
                                <dd>제도개선, 정보제공 등, 협력중소기업-기자재240개, 정비적격420개 업체와 지원 및 협력</dd>
                            </dl>                                         
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">역할 및 책임</h4>
                        <div class="tableArea">
                            <table class="tableC">
                                <caption>동반성장 지원체계·역할 - 추친과제, 주요역할로 구성</caption>
                                <colgroup>
                                    <col width="22%">
                                    <col width="*">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th>추진과제</th>
                                        <th>주요역할</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>CEO</th>
                                        <td>
                                            <div class="listbg">
                                                <p>동반성장 비전 및 방침제시</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>동반성장위원회</th>
                                        <td>
                                            <div class="listbg">
                                                <p>동반성장 추진실적 점검 및 목표달성 대책 수립</p>
                                                <p>동반성장의 자발적 역량강화 방안 추진</p>
                                                <p>중소기업 애로사항 해결방안 제시 및 추진</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>동반성장실</th>
                                        <td>
                                            <div class="listbg">
                                                <p>전사 동반성장 전략 및 계획 수립</p>
                                                <p>정부권장정책 추진(중소기업지원 및 중기제품 우선 구매)</p>
                                                <p>동반성장 개선방안 도출 및 성과측정</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>본사 관련부서</th>
                                        <td>
                                            <div class="listbg">
                                                <p>중소기업제품구매, 자금지원 등 인프라 지원</p>
                                                <p>공정거래를 위한 제도개선(공사용자재 직접구매 등)</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>사업소 실무부서</th>
                                        <td>
                                            <div class="listbg">
                                                <p>중소기업제품, 기술개발제품 활용 확대</p>
                                                <p>연구개발과제 발굴 및 Test Bed 제공</p>
                                                <p>장비지원, 기술지원 등</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>협력 중소기업</th>
                                        <td>
                                            <div class="listbg">
                                                <p>중소기업제품구매, 자금지원 등 인프라 지원</p>
                                                <p>공정거래를 위한 제도개선(공사용자재 직접구매 등)</p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>전력 그룹사</th>
                                        <td>
                                            <div class="listbg">
                                                <p>협력연구개발 등 동반성장사업 공조</p>
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
	$('#contents').parent('div').addClass('support');
});	


//]]>           
</script>  
