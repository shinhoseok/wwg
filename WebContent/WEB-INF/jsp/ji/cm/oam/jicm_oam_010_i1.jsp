<%--
/*=================================================================================*/
/* 시스템            : 개인정보수집원문
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/oam/jicm_oam_010_i1.jsp
/* 프로그램 이름     : jicm_oam_010_i1  
/* 소스파일 이름     : jicm_oam_010_i1.jsp
/* 설명              : 개인정보수집원문
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-10-08
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2015-10-08
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<script type="text/javascript">
//사용자동의 원문보기
function orginal_text_view(modes){
	CmopenpageDisable();
	// 원문보기 팝업창을 창안에 보여준다.
	$("#prv_dev_popup").css("left",(((document.documentElement.clientWidth - 600) / 2) + document.documentElement.scrollLeft )+"px");
	$("#prv_dev_popup").css("top", (((document.documentElement.clientHeight - 400) / 2) + document.documentElement.scrollTop )+"px");
	
	var sc_pos = 0;
	
	if(modes==1){
		sc_pos = 0;
	}else if(modes==2){
		sc_pos = 690;
	}else if(modes==3){
		sc_pos = 2000;
	}
	//alert($("#org_text_div").scrollTop()+"==>"+sc_pos);
	
	
	$("#prv_dev_popup").show(500);
	$("#org_text_div").scrollTop(sc_pos);
}

function orginal_text_close(){
	$("#prv_dev_popup").hide();
	CmclospageDisable();
}

function orginal_text_confirm(){
	for(var i=1;i<=4;i++){
		$("#prv_agree"+i+"_1").prop("disabled","");
		$("#prv_agree"+i+"_2").prop("disabled","");
		///console.log(i);
	}
	
	orginal_text_close();

}

function getBrowserName(){
	var nav = navigator;
	var agp = nav.userAgent.toLowerCase();
	var r = -1;
	var browser_name = "";
	if(nav.appName=="Microsoft Internet Explorer"){ // IE10이하 && IE11문서모드변경시
		browser_name = "Internet Explorer";
	}else if(nav.appName=="Netscape" && agt.indexOf("trident")!=-1){ //IE11
		browser_name = "Internet Explorer";
	}else{ //기타
		if (agt.indexOf("chrome") != -1) { browser_name = "Chrome"; 
		} else if (agt.indexOf("opera") != -1) { browser_name = "Opera"; 
		} else if (agt.indexOf("staroffice") != -1) { browser_name = "Star Office"; 
		} else if (agt.indexOf("webtv") != -1) { browser_name = "WebTV"; 
		} else if (agt.indexOf("beonex") != -1) { browser_name = "Beonex"; 
		} else if (agt.indexOf("chimera") != -1) { browser_name = "Chimera"; 
		} else if (agt.indexOf("netpositive") != -1) { browser_name = "NetPositive"; 
		} else if (agt.indexOf("phoenix") != -1) { browser_name = "Phoenix"; 
		} else if (agt.indexOf("firefox") != -1) { browser_name = "Firefox"; 
		} else if (agt.indexOf("safari") != -1) { browser_name = "Safari"; 
		} else if (agt.indexOf("skipstone") != -1) { browser_name = "SkipStone"; 
		} else if (agt.indexOf("msie") != -1) { browser_name = "Internet Explorer"; 
		} else if (agt.indexOf("netscape") != -1) { browser_name = "Netscape"; 
		} else if (agt.indexOf("mozilla/5.0") != -1) { browser_name = "Mozilla";
		}
	}	
	
	if (browser_name == "Internet Explorer"){
		var ua = nav.userAgent;
		var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null){
			r = parseFloat( RegExp.$1 );
		}
	}else if (browser_name != "Internet Explorer"){
		var ua = nav.userAgent;
		var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null){
			r = parseFloat( RegExp.$1 );
		}
	}	
	
	var re_arr = new Array();
	re_arr.push(browser_name, r);
	
	return re_arr;
}


//로딩 보이기 com.js 함수 참조
function CmopenpageDisable(){
	
	var browser_arr = getBrowserName();

	if(browser_arr[0]=="Internet Explorer" &&  parseInt(browser_arr[1],10)<=8){
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"100%","height":$("body").prop("scrollHeight")+"px","filter": "alpha(opacity=50)","background-color":"#000000","background-position":"center"});
		
	}else{
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"100%","height":$("body").prop("scrollHeight")+"px","background": "rgba(0, 0, 0, 0.5)"});
	}
	$("#pageDisable").show();

}

//로딩 보이기
function CmclospageDisable(){
	var browser_arr = getBrowserName();
	
	if(browser_arr[0]=="Internet Explorer" &&  parseInt(browser_arr[1],10)<=8){
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"0px","height":"0px","filter": "alpha(opacity=0)"});
		
	}else{
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"0px","height":"0px","background": ""});
	}
	//console.log("2222");
	$("#pageDisable").hide();
	//document.getElementById("pageLoading").style.display="none";
}


</script>

		  <!-- 개인정보 사용자 동의 -->
		  <div class="sectionBlue mT5">
		    <table class="tbl_type3">
		      <colgroup>
		      <col width="100" />
		      <col width="*" />
		      <col width="*" />
		      <col width="*" />
		      <col width="*" />
		      <col width="*" />
		      <col width="*" />
		      <col width="*" />
		      </colgroup>
		      	<tr>
					<th scope="row" colspan="8"><span class="pOrg">※ 원문보기 버튼을 클릭 해야만 동의가 가능합니다.</span></th>
				</tr>		      
		      	<tr>
					<th scope="row" rowspan="3">사용자 동의<span class="pOrg"></span></th>
		        	<td colspan="7" >
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>
			        		<span class="fL">[제15조] 개인정보의 수집·이용 동의 / [제16조] 취소 수집 및 서비스 제공 거부 / [제22조] 동의를 받는방법</span> <span class='btn_pack small fR'> <a href='#none' onclick='orginal_text_view(1)' >원문보기</a></span><br /><br />
			        		</td>
			        		</tr>
		        		</table>
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>		        		
		        		<span class="fL">개인정보(필수항목)의 수집 및 이용에 동의하십니까?</span>
		        		<span class="fR"><label class="radioArea" id="prv_agree1_area1" for=""><input type="radio"  id="prv_agree1_1" name="prv_agree1" disabled="disabled" value="Y">동의함</label>
		        		<label class="radioArea active" id="prv_agree1_area2" for=""><input type="radio"  id="prv_agree1_2" name="prv_agree1" disabled="disabled" checked="checked" value="N">동의하지않음</label></span>
			        		</td>
			        		</tr>		        		
		        		</table>
		        		
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>		        		
		        		<span class="fL">개인정보(선택항목)의 수집 및 이용에 동의하십니까?</span>
		        		<span class="fR"><label class="radioArea" id="prv_agree2_area1" for=""><input type="radio"  id="prv_agree2_1" name="prv_agree2" disabled="disabled" value="Y">동의함</label>
		        		<label class="radioArea active" id="prv_agree2_area2" for=""><input type="radio"  id="prv_agree2_2" name="prv_agree2" disabled="disabled" checked="checked" value="N">동의하지않음</label></span>
			        		</td>
			        		</tr>		        		
		        		</table>		        		
		        	</td>
		      	</tr>
		      
		      	<tr>
		        	<td colspan="7" >
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>
		        		<span class="fL">[제17조] 개인정보의 제공 / [제18조] 개인정보의 이용·제공 제한</span> <span class='btn_pack small fR'> <a href='#none' onclick='orginal_text_view(2)' >원문보기</a></span><br /><br />
			        		</td>
			        		</tr>		        		
		        		</table>	
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>		        			        		
		        		<span class="fL">상기내용에 동의하십니까?</span>
		        		<span class="fR"><label class="radioArea" id="prv_agree3_area1" for=""><input type="radio"  id="prv_agree3_1" name="prv_agree3" disabled="disabled" value="Y">동의함</label>
		        		<label class="radioArea active" id="prv_agree3_area2" for=""><input type="radio"  id="prv_agree3_2" name="prv_agree3" disabled="disabled" checked="checked" value="N">동의하지않음</label></span><br />
			        		</td>
			        		</tr>		        		
		        		</table>
		        	</td>
		      	</tr>	
		      	
		      	<tr>
		        	<td colspan="7" >
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>
		        		<span class="fL">[제21조] 개인정보의 파기</span> <span class='btn_pack small fR'> <a href='#none' onclick='orginal_text_view(3)' >원문보기</a></span><br /><br />
			        		</td>
			        		</tr>		        		
		        		</table>	
		        		<table cellspacing="0" cellpadding="0" border="0" style="width:100%;">
			        		<tr>
			        		<td>		        		
		        		<span class="fL">상기내용에 동의하십니까?</span>
		        		<span class="fR"><label class="radioArea" id="prv_agree4_area1" for=""><input type="radio"  id="prv_agree4_1" name="prv_agree4" disabled="disabled" value="Y">동의함</label>
		        		<label class="radioArea active" id="prv_agree4_area2" for=""><input type="radio"  id="prv_agree4_2" name="prv_agree4" disabled="disabled" checked="checked" value="N">동의하지않음</label></span><br />
			        		</td>
			        		</tr>		        		
		        		</table>
		        	</td>
		      	</tr>			      		      
		
		    </table>
		  </div>
		<div id="prv_dev_popup" class="ly_pop" style="position:absolute;top:0%;left:0%;z-index:9999;width:640px;height:470px;display:none;">
			<h1><span>&#8226;</span>개인정보 처리방침</h1><span class="close" id="btn_div_close_icon" onclick="orginal_text_close()"><a href="#none;" ></a></span>
			<div id="org_text_div" class="pop" style="margin:10px;width:620px;max-height:380px; min-height:50px; overflow:auto;border:1px #53698c solid !important;">
			<pre>
  <b>[제15조] 개인정보의 수집·이용 동의 / [제16조] 취소 수집 및 서비스 제공 거부
  [제22조] 동의를 받는 방법</b>
  
   <b>[도서발전통합관리시스템]</b> 은 내부사용자인 한국전력공사 직원은 시스템 관리자에게 이메일을
    활용한 사용요청 및 승인, 외부사용자인 전우실업 직원은 전우실업측 관리자에게 역시 이메일을
    활용한 사용요청 및 승인을 통해서만 시스템  내부 컨텐츠에 접근할 수 있습니다.
    또한 게시판 이용 등 특정 컨텐츠 이용 시 최소한의 개인정보가 활용될 수 있습니다.
    단, 사용자의 기본적 인권 침해의 우려가 있는 민감한 개인정보(인종 및 민족, 사상 및 신조,
    출신지 및 본적지, 정치적 성향 및 범죄기록, 건강상태 및 성생활 등)은 수집하지 않습니다.
    또한 해당시스템에서 수집된 개인정보는  최소한의 필수항목은 없으나 선택항목만 보유하고 
    있으며 홍보권유 등에 활용되지 않으므로 미동의를 이유로 재화  또는 서비스 제공 거부에 대한
    내용이 없음을 알려드립니다. 
  
  1. 개인정보항목 
    가. 필수항목 : 없음
    나. 선택항목 : 이메일주소, 일반전화번호, 핸드폰번호
  2. 수집목적 
    가. 성명, 아이디, 비밀번호 : 회원제 서비스 이용에 따른 본인여부 식별 절차 등에 활용
    나. 이메일주소, 일반전화번호 : 고지사항 전달 등 원활한 의사소통 경로의 확보
    다. 그 외 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료
  3. 수집방법 
    가. 내부사용자 : 인사DB 퇴사자 정보와 연동 (일부항목은 개인이 직접입력)
    나. 외부사용자 : 전우실업 관리자가 사용자 정보를 수집 받아 시스템 내 입력
  4. 보유 및 이용기간 : <b>[도서발전통합관리시스템]</b>은 서비스를 제공하는 기간(이용기간)
   동안 개인정보를 보유하고 이를 활용합니다. 다만, 법률에 특별한 규정이 있는 경우에는
   관계 법령에 따라 보관됩니다. 
    가. 이용기간 : 보유시스템 사용기간 중
    나. 보유기간 : 전보·퇴직 등 인사이동으로 취급자가 변경될 경우, 사용자가 더 이상 
    사용을 원하지 않을 경우 별도 요청
  5. 개인정보 수집 동의 거부의 권리 (거부권 및 불이익)
  
    <b>[도서발전통합관리시스템]</b>은 보다 원활한 서비스 제공을 위하여 기본 정보
     이외의 필요 시 추가정보를 수집할 수  있으며 추가 정보는 서비스 제공 시 활용되는 정보로
     제공을 원하지 않을 경우 수집하지 않으며, 미동의로 인해 이용 상의 불이익도 발생하지
     않습니다. 또한 홈페이지 운영에 있어 필요 시 고객의 정보를 찾아내고 저장하는
   ‘쿠키(cookie)'를 운용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버가
    고객의 브라우저에 보내는 텍스트 파일로서 사용자의 컴퓨터 하드디스크에 저장됩니다.
    사용자께서는 웹브라우저의 보안설정을 통해 쿠키에 의한 정보수집의 「허용」,「거부」
    여부를 선택 하 실 수 있습니다. 
      
    가. 쿠키(cookie)에 의해 수집되는 정보 및 이용목적
    나. 수집정보 : ID, 접속IP, 회원구분, 이용 콘텐츠 등 서비스 이용정보
    다. 이용목적 : 접속빈도 또는 방문시간 등을 분석하고 서비스 개편의 척도로 활용
    라. 고객은 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 웹브라우저에서 옵션을
     설정함으로써 쿠키에  의한 정보수집 수준의 선택을 조정할 수 있습니다.
    마. 웹브라우저의 [도구]메뉴에서 [인터넷옵션]→[보안]→[사용자정의수준]을
     선택하여 쿠키에  의한 정보수집 수준을 정할 수 있습니다.
    바. 위에 제시된 메뉴를 통해 쿠키가 저장될 때마다 확인을 하거나, 아니면 모든 쿠키의
     저장을  거부할 수도 있습니다. 다만, 쿠키 설치를 거부하였을 경우 콘텐츠 이용에
     어려움이 있을 수 있습니다.
        
  <b>[제17조] 개인정보의 제공 / [제18조] 개인정보의 이용·제공 제한</b>
  
  <b>[도서발전통합관리시스템]</b>은 ‘개인정보처리방침’에 따른 사용자의 개인정보
   수집, 이용, 제3자 제공 및 취급업무의 위탁 등에 대하여 아래와 같은 방법 중 하나를
   선택하여 동의하실 수 있습니다.
    또한 사용자는 개인정보 수집에 대해 동의하지 않을 권리가 있으며, 동의하지 않을
    경우에는 일부  서비스의 제한이 있을 수 있습니다. 
    가. 홈페이지 내에 게시된 ‘개인정보처리방침’의 동의내용을 확인 하신 후 ‘동의버튼‘
     또는 ’동의  하지 않음‘ 버튼을 클릭하는 방법을 원칙으로 한다. 
    나. 부득이 한 경우 우편, 전자우편 또는 팩스를 통하여 안내된 동의서(동의내용)에
     서명, 날인 후 제출하는 방법도 고려된다. 
  <b>[도서발전통합관리시스템]</b> 은 원칙적으로 사용자의 개인정보를 「개인정보의
   수집목적 및 이용목적」에서 고지한 범위 내에서 처리하며, 사용자의 사전 동의 없이는
   본래의 범위를 초과하여 처리하거나 제3자에게 제공하지 않습니다.
   다만, 아래의 경우에는 예외로 합니다. 
    가. 사용자들이 사전에 동의한 경우
    나. 법령의 규정에 의거하거나, 수사 목적 등으로 법령에 정해진 절차와 방법에 따라 
    수사기관의 요구가 있는 경우
    다. 고지 및 동의방법은 전자우편 등을 이용하여 1회 이상 개별적으로 고지합니다. 
    라. 고지하는 항목은 다음과 같습니다. 
      ○ 개인정보를 제공받는자 : 해당없음
      ○ 개인정보 항목 : 수정필요
      ○ 개인정보 이용목적 
        - 성명, 아이디, 비밀번호 : 회원제 서비스 이용에 따른 본인여부 식별 절차 등에 활용
        - 이메일주소, 일반전화번호 : 고지사항 전달 등 원활한 의사소통 경로의 확보
        - 그 외 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료
      ○ 보유 및 보유기간
        - 이용기간 : 보유시스템 사용기간 중
        - 보유기간 : 전보·퇴직 등 인사이동으로 취급자가 변경될 경우, 사용자가 더 이상 사용을 
          원하지 않을 경우 별도 요청
      ○ 거부권 및 불이익 : 원활한 서비스 제공을 위하여 기본 정보 이외의 필요 시 추가정보를 
         수집할 수 있으며 추가 정보는 서비스 제공 시 활용되는 정보로 제공을 원하지 않을 경우 
         수집하지 않으며, 미동의로 인해 이용 상의 불이익도 발생하지 않습니다. 
  <b>[도서발전통합관리시스템]</b> 은 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당정보를
   지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다. 
    가. 파기절차
      ○ 고객이 입력하신 정보는 목적이 달성된 후 별도의 DB로 옮겨져 내부방침 및 기타 관련
         법령에 따라 일정기간 저장된 후 즉시 파기됩니다. 이 때 DB로 옮겨진 개인정보는 법률에 
         의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다. 
      ○ 파기대상 : 보유기간 및 관련법령에 따른 보유기간이 종료된 정보
    나. 파기방법
      ○ 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기
      ○ 전자적 파일형태로 저장된 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제
  <b>[도서발전통합관리시스템]</b> 은 사용자의 개인정보가 분실, 도난, 누출, 변조 또는 훼손되지
   않도록 안정성 확보를 위하여 다음과 같인 기술적·관리적 대책을 마련하고 있습니다. 
    
  가. 기술적 보호대책
      ○ 개인정보는 비밀번호 정책 등에 의하여 보호되며, 중요한 데이터는 파일 및 전송데이터를 
         암호화하거나 파일잠금기능(Lock)을 사용하는 등 별도의 보안기능을 통해 보호됩니다. 
      ○ 사용자 PC의 백신 프로그램을 이용하여 컴퓨터 바이러스에 의한 피해를 방지하기 위한 
         조치를 취하셔야 합니다. 백신프로그램은 주기적으로 업데이트 되어야 하며, 갑작스런 
         바이러스가 출현할 경우 백신이 나오는 즉시 이를 도입, 적용해야 합니다.  
      ○ 네트워크 상의 개인정보 및 개인인증정보를 안전하게 전송 할 수 있도록 보안장치(SSL)을 
         채택하고 있습니다. 
      ○ 해킹 등에 의해 사용자의 개인정보가 유출되는 것을 방지하기 위하여 외부로부터 접근이 
         통제된 구역에 시스템을 설치하고 침입을 차단하는 장치를 이용
      ○ 네트워크 상의 개인정보 및 개인인증정보를 안전하게 전송 할 수 있도록 보안장치(SSL)을 
         채택하고 있습니다. 
      ○ 개인정보가 보관된 DB는 강화된 보안정책이 적용되어 있으며 안행부에서 요구하는 수준의
         암호화 정책이 적용되어 있습니다. 
    나. 관리적 보호대책
      ○ 개인정보를 취급할 수 있는 자를 최소한으로 제한하고 접근권한을 관리하며, 새로운 보안
         기술 습득 및 개인정보보호 의무 등에 관해 정기적인 사내교육 또는 외부위탁교육을 
         통하여 법규 및 정책을 준수 할 수 있도록 하고 있습니다. 사용자의 개인정보를 취급하는
         자는 다음과 같습니다. 
        - 사용자를 직·간접적으로 상대하여 업무를 수행하는 자
        - 개인정보관리책임자 및 개인정보관리담당자 등 개인정보 관리 및 개인정보보호 업무를
          담당하는 자
        - 기타 업무 상 개인정보의 취급이 불가피한 자
        - 전산실 자료보관실 등을 통제구역으로 설정하여 출입을 통제
        - 사용자 개인의 실수나 기본적인 인터넷의 위험성 때문에 일어나는 일들에 대해서는
          책임을 지지 않습니다. 사용자의 개인정보를 보호하기 위해서 자신의 ID와 비밀번호 등을
          철저히 관리하고 책임을 져야 합니다. 
          
  <b>[도서발전통합관리시스템]</b> 은 서비스 향상을 위하여 사용자의 개인정보를 외부에 수집·취급·관리
   등을 위탁하여 처리하고 있습니다. 
    가. 개인정보의 처리를 위탁하는 경우에는 위탁계약 등을 통하여 위탁서비스를 수행하는 
        자로소의 개인정보보호 관련규정 및 지시사항 엄수, 개인정보에 관한 비밀유지, 제3자 
        제공의 금지 및 사고시의 책임부담, 위탁기간, 처리 종료 후의 개인정보의 반환 또는 파기 
        등을 명확히 규정하고 당해 계약내용을 서면 또는 전자적으로 보관
    나. 개인정보를 위탁하는 사항은 다음과 같습니다. 
	<table cellspacing="0" cellpadding="0" style="width:100%;border:0px #53698c solid !important;">
  		     <colgroup>
  		     <col width="10%" />
  		     <col width="*" />
  		     <col width="10%" />
  		     </colgroup>
  		     <tr>
  		     <td>&nbsp;</td>
  		     <td>
		  		    <table class="bbs aC" style="width:100%;border-top:2px #53698c solid !important;">
		  		      <colgroup>
		  		      <col width="50%" />
		  		      <col width="*" />
		  		      </colgroup>
		  		      	<tr class="bgBlue">
		  					<th scope="row" ><b>수탁기관</b></th>
		  					<th scope="row" ><b>위탁내용</b></th>
		  		      	</tr>
		  		      	<tr >
		  					<td class="aC">한전KDN(주)</td>
		  					<td class="aC">웹 사이트 및 시스템 관리</td>
		  		      	</tr>		      	     
		  			</table>
		  	</td>
		  	<td>&nbsp;</td>
		  	</tr>
	</table>
  <b>[제21조] 개인정보의 파기</b>
  
  <b>[도서발전통합관리시스템]</b> 은 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당정보를
   지체없이 파기합니다. 파기절차 및 방법은 다음과 같습니다. 
    가. 이용목적 
      ○ 성명, 아이디, 비밀번호 : 회원제 서비스 이용에 따른 본인여부 식별 절차에 활용
      ○ 이메일주소, 일반전화번호 : 고지사항 전달 등 원활한 의사소통 경로의 확보
      ○ 그 외 선택항목 : 개인맞춤 서비스를 제공하기 위한 자료
    나. 파기절차
      ○ 고객이 입력하신 정보, 임시파일 및 출력자료는 보유기관경과 및 처리목적이 달성된 후 
         별도의 DB로 옮겨져 내부방침 및 기타 관련법령에 따라 일정기간 저장된 후 즉시 
         파기됩니다. 이 때 DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 
         이용되지 않습니다. 
      ○ 파기대상 : 보유기간 및 관련법령에 따른 보유기간이 종료된 정보
    다. 파기방법
      ○ 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기
      ○ 전자적 파일형태로 저장된 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제
		    </pre>
		
			</div>	
				<div class="section aC mT5 mB5">
				<span class="btn_pack largeG" id="btn_div_confirm"><a href="#none;" onclick="orginal_text_confirm()">확인</a></span>	
				<span class="btn_pack largeG" id="btn_div_close"><a href="#none;" onclick="orginal_text_close()">닫기</a></span>	
				</div>
		</div>
		<div id="pageDisable" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:9000;display:none;">
		</div>		
