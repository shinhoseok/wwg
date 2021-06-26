<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : 
/* 프로그램 이름     : CmMain    
/* 소스파일 이름     : CmMain.jsp
/* 설명              : SYSTEM 시스템 관리자 메인컨텐츠 페이지
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2016-03-15
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2016-03-15
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>

<!-- footer 시작 -->
<!--footer-->
<footer id="footer">
	<p>COPYRIGHTⓒ2019 한국중부발전 <%=_system_name %>. ALL RIGHTS RESERVED</p>
</footer>

	<form name="pagego" id="pagego">
	<input type="hidden" name="scode" id="scode" value="<%=HtmlTag.returnString((String)request.getAttribute("scode"),"")%>">
	<input type="hidden" name="pcode" id="pcode" value="<%=HtmlTag.returnString((String)request.getAttribute("pcode"),"")%>">
	<input type="hidden" name="pstate" id="pstate" value="<%=HtmlTag.returnString((String)request.getAttribute("pstate"),"")%>">
	</form>
	
<iframe name ="successIframe" id="successIframe" width="100%" height="0" title="결과처리프레임" style="display:none;"></iframe>
<div id="pageDisable" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:8000;display:none;"> </div>
<!--//footer-->
<!-- 등록,수정 창-->  
<div id="admInfoChgPop" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9000;width:600px;display:none;">
	<h1><span>&#8226;</span>정보변경</h1><span class="close" id="btn_oh_close_icon" onclick="admInfoChg_close();return false;"><a href="#" ></a></span>
	<form name="admInfoChg_formfm" method="post" onSubmit='return false;'>
		<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
		<input type="hidden" name="pcode" id="pcode" value="000013" title="페이지코드"  />
		<input type="hidden" name="pstate" id="pstate" value="U2" title="페이지상태"  />
		
        
        <table class="bbs" cellpadding="0" cellspacing="0" border="0" style="margin-top:4px;">
            <caption>정보변경-사용자명,사용자ID,소속,직위,휴대폰번호,전화번호,이메일</caption>
            <colgroup>
                <col width="20%" />
                <col width="*" />
                <col width="20%" />
                <col width="*" />
            </colgroup>
            <thead>
		      <tr>
		        <th scope="row" class="essential">사용자 명</th>
		        <td>
		            <input type="text" name="admInfo_user_nm" id="admInfo_user_nm" maxlength="20" title="" class="input_type01" value="<%=HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_NM"),"") %>" />
		        </td>
		        <th scope="row">사용자 ID</th>
		        <td >
		            <%=HtmlTag.returnString((String)SITE_ADM_SESSION.get("USER_ID"),"") %>
		        </td>
		     </tr>
		      <tr style="display:none;">
		        <th scope="row" class="essential">소속</th>
		        <td>
		            <input type="text" name="admInfo_sosok_han" id="admInfo_sosok_han" maxlength="40" title="" class="input_type01" value="" />
		        </td>
		        <th scope="row" class="essential">직위</th>
		        <td>
		            <input type="text" name="admInfo_zzjikmu_txt" id="admInfo_zzjikmu_txt" maxlength="20" title="" class="input_type01" value="" />
		        </td>
		      </tr>
		     <tr>
		   		<th scope="row" class="essential">휴대폰번호</th>
		        <td>
					<input type="text" name="admInfo_moblphon" id="admInfo_moblphon" maxlength="20" title="" class="input_type01" value="" onkeyup="maskHp(this)"/>
		      	</td>
		        <th scope="row">전화번호</th>
		       	<td>
					<input type="text" name="admInfo_naesun" id="admInfo_naesun" maxlength="20" title="" class="input_type01" value="" onkeyup="maskTel(this)"/>
		       	</td>
		     </tr>
		     <tr>
		        <th scope="row" class="essential">이메일</th>
		       	<td>
		            <input type="text" name="admInfo_email" id="admInfo_email" maxlength="50" title="" class="input_type01" value="" />
		       	</td>
		       	<th></th>
		       	<td></td>
		     </tr>
         
                
            	<tr>
                    <td scope="row" id="admInfoChg_in_btns" colspan="4">
						<div class="section aC mT5 mB5">
						<span class="btn_pack large" id="btn_admInfoChg_update"><a href="#" onclick="admInfoChg_update();return false;">변경</a></span>
						<span class="btn_pack large" id="btn_admInfoChg_close"><a href="#" onclick="admInfoChg_close();return false;">닫기</a></span>
						</div>                    
                    </td>                    
                </tr>                
            </thead>
         </table>
	</form>
</div>