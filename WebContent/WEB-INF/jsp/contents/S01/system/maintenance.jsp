<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/system/maintenance.jsp
/* 프로그램 이름     : maintenance    
/* 소스파일 이름     : maintenance.jsp
/* 설명              : 지원시스템 > 정비적격업체 통합관리 시스템
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
                        <img src="<%=con_root %>/images/project_img/sub/system04.png" alt="정비적격업체 통합관리 사이트" />
                    </div>
                    <div class="textArea">
                        <h4 class="titleB">한국중부발전 협력기업 지원시스템입니다.</h4>
                        <h4 class="titleM">정비적격업체 통합관리</h4>
                        <p>발전5사에서 공동사용하는 시스템으로서, 관리품목에 대한 기업의 기술 및 품질보증 능력을 평가하여 정비적격기업으로 선정하고 이를 운영·관리 하는 시스템입니다.</p>
                        <a href="https://withu.ewp.co.kr:8443/user" class="btnB" target="_blank">바로가기</a>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('maintenance');
});	


//]]>           
</script>  
