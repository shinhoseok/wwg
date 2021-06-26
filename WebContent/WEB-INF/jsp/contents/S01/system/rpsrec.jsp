<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/system/rpsrec.jsp
/* 프로그램 이름     : rpsrec    
/* 소스파일 이름     : rpsrec.jsp
/* 설명              : 지원시스템 > RPS·REC 관리시스템
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
                    <div class="imgArea">
                        <img src="<%=con_root %>/images/project_img/sub/system06.png" alt="RPS·REC 관리시스템 사이트" />
                    </div>
                    <div class="textArea">
                        <h4 class="titleB">한국중부발전 협력기업 지원시스템입니다.</h4>
                        <h4 class="titleM">RPS·REC 관리시스템</h4>
                        <p>한국중부발전에서 운영하는 시스템으로, 전력거래 공급인증서를 발급받고, 대금지급현황을 관리하는 시스템 입니다.</p>
                        <a href="https://rec.komipo.co.kr:8557/WebContent/jsp/main/main.jsp" class="btnB" target="_blank">바로가기</a>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('rpsrec');
});	


//]]>           
</script>  
