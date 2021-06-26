<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/support/material.jsp
/* 프로그램 이름     : material    
/* 소스파일 이름     : material.jsp
/* 설명              : 중소기업 지원안내 > 기술개발 > 연구시설 및 자재 공동활용
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
                            <img src="<%=con_root %>/images/project_img/sub/material01.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/material02.jpg" alt="" />
                            <img src="<%=con_root %>/images/project_img/sub/material03.jpg" alt="" />
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">목적</h4>
                        <div class="border_p">
                            <p>중소기업 지원을 통한 기술경쟁력 제고 및 동반성장 문화 확산</p>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">내용</h4>
                        <h4 class="titleM2">대상기업</h4>
                        <div class="numList">
                            <ul>
                                <li class="f_left"><p>우리회사 기자재공급자 및 정비적격등록업체</p></li>
                                <li class="f_right"><p>또는 최근 3년 이내에 납품 및 공사실적이 있는 업체</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">지원내용</h4>
                        <div class="numList">
                            <ul>
                                <li><p>계획예방정비 등 공사 시행시 참여 중소기업과 연구시설(장비) 및 자재를 공동으로 활용하고 전문인력 등을 지원</p></li>
                                <li><p>협약대상 : 해당 중소기업과 발전소</p></li>
                            </ul>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM2">추진일정</h4>
                        <div class="border_p">
                            <p>연중</p>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('material');
});	


//]]>           
</script>  
