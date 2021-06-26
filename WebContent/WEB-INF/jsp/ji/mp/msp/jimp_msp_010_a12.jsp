<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%
//jimp_msp_010_a12.jsp
%>
<style type="text/css">
.squareList ul li{width: 27%;margin-right:4%;box-sizing:border-box;border-radius: 9px;position: relative;padding:14px 20px;}
.squareList ul li:nth-child(3):after{background:none;}
.squareList ul li:nth-child(3){width: 34%;}
.textArea{border:1px solid #ccc;height: 250px;overflow-x:hidden;overflow-y: scroll;font-size:15px;line-height: 24px;padding:20px;box-sizing: border-box;}
.btnArea a{width:210px;height: 50px;line-height: 48px;font-size:16px;display: inline-block;}
.btnArea{text-align: center;}
.prg{overflow: hidden;} 
.prg .certify{float: left;width:31.3%;margin-right:3%;text-align: center;position: relative;}
.prg .certify:after{content: '';width:100%;height: 301px;background: #eef1f2;position: absolute;left:0;bottom:0;display: block;}
.prg .certify:last-child{margin-right:0;}
.prg .certify .inner{margin:0 70px;position: relative;z-index: 10;}
.prg .certify p{font-size:20px;color: #333;letter-spacing: -1px;}
.titleB{margin-right:400px;}
</style>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>
<form action="<%=RequestURL%>" id="dataForm" name="dataForm" method="post">
<input type="hidden" 	id="scode" 				name="scode" 	value="<%=scode %>" />
 <input type="hidden" 	id="pcode" 				name="pcode" 	value="<%=pcode %>" />
 <input type="hidden" 	id="pstate" 			name="pstate" 	value="<%=pstate %>" />
<input type="hidden" 	id="page" 				name="page" 	value="${R_MAP.param.page}"/>

	<input type="hidden" name="sName" value="" />
	<input type="hidden" name="sBirthDate" value="" />
	<input type="hidden" name="sMobileNo" value="" />
	<input type="hidden" name="sDupInfo" value="" />
 	<input type="hidden" name="agree_1" value="${R_MAP.param.agree_1}" />

                <div class="cts_mid">
					<div class="prg">
                        <h4 class="titleM">작성 절차</h4>
                        <div class="border_p">
                            <div class="squareList">
                                <ul>
                                    <li class="f_left">
                                        <em>01</em>
                                        <div class="inner">
                                            <p >개인정보수집 및 이용동의</p>
                                            <span></span>
                                        </div>
                                    </li>
                                    <li class="f_left">
                                        <em>02</em>
                                        <div class="inner">
                                            <p style="font-weight:600;">본인인증</p>
                                            <span></span>
                                        </div>
                                    </li>
                                    <li class="f_left" >
                                        <em>03</em>
                                        <div class="inner">
                                            <p><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 작성</p>
                                            <span></span>
                                        </div>
                                    </li>
                                 </ul>
                            </div>
                        </div>
                    </div>
                                    
                    <div class="prg" style="text-align:center">
                    	<!-- <h4 class="titleB">본인인증</h4> -->
                    	<div style="text-align:center;display:inline-flex;"> 
		                   <div class="certify" style="width:50%;">
		                       <div class="inner">
		                           <img src="<%=con_root%>/images/project_img/common/certify01.png" alt="" />
		                           <div>
		                               <p>본인명의 핸드폰 인증</p>
		                               <div class="btnArea">
		                                   <a href="#" class="btnB" id="hpCfc">본인명의 핸드폰 인증</a>
		                               </div>
		                           </div>
		                       </div>
		                   </div>
		                   
	                        <div class="certify" style="width:50%;">
	                            <div class="inner">
	                                <img src="<%=con_root%>/images/project_img/common/certify02.png" alt="" />
	                                <div>
	                                    <p>아이핀(i-PIN) 인증</p>
	                                    <div class="btnArea">
	                                        <a href="#" class="btnG" id="ipinCfc">아이핀(i-PIN) 인증</a>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>		                                            	
                    	</div>
                    </div>
                    
                    <div class="btnArea">
                    	<a href="#" class="btnBK" id="btn_cancel" onclick="return false;">취소</a>
                    </div>                    
                </div>

  
 
</form>
	<!-- 본인인증 start -->
	<%@include file="/WEB-INF/jsp/ji/cm/oam/checkplus_main.jsp"%>
	<!-- 본인인증 end -->
	<!-- ipin start -->
	<%@include file="/WEB-INF/jsp/ji/cm/oam/ipin_main.jsp"%>
	<!-- ipin end --> 
	

<script type="text/javascript">
//<![CDATA[
	$(function(){
		$('#contents').parent('div').addClass('manager');
		
		$("#btn_cancel").click( function() {
			$("#dataForm").find("#pstate").val("L");
			$("#dataForm").submit();					
		});	
	});
	
	$("#hpCfc").click( function() {
		<%
		// 내부망에서 테스트가 안되므로 이동
		if(!svr_name.equals("10.132.5.98") && !svr_name.equals("localhost")){
		%>
		fnPopup("CF");
		<%
		// 실운영
		}else{
		%>
		$("#dataForm").find("#pstate").val("CF");
		$("#dataForm").submit();			
		<%
		}
		%>		
		
		
	});
	
	$("#ipinCfc").click( function() {
		<%
		// 내부망에서 테스트가 안되므로 이동
		if(!svr_name.equals("10.132.5.98") && !svr_name.equals("localhost")){
		%>
		fnPopup_ipin("CF");
		<%
		// 실운영
		}else{
		%>
		$("#dataForm").find("#pstate").val("CF");
		$("#dataForm").submit();			
		<%
		}
		%>			
		
	});
	

//]]>
</script>
