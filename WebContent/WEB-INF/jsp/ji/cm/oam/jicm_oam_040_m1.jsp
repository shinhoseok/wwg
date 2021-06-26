<%--/*=================================================================================*//* 시스템            : 회원존 > 회원가입 > 회원가입/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/oam/jicm_oam_040_m1.jsp/* 프로그램 이름     : jicm_oam_040_m1    /* 소스파일 이름     : jicm_oam_040_m1.jsp/* 설명              : 회원존 > 회원가입 > 회원가입/* 버전              : 1.0.0/* 최초 작성자       : 이금용/* 최초 작성일자     : 2017/02/24/* 최근 수정자       : 이금용/* 최근 수정일시     : 2017/02/24/* 최종 수정내용     : 최초작성/*=================================================================================*/--%><%@page pageEncoding="utf-8"%><%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일--><%String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");// 화면 권한을 셋팅한다// 시스템관리자의 경우 무조건 관리권한을 가진다boolean isMenuMng = true;// 관리자 페이지일경우if(scode.equals(SYS_ADMIN_CD)){%>	사용자페이지에서  확인하실수 있습니다.<%// 사용자 페이지일경우}else{%>																	<!-- Step 타이틀 --><div class="ex_title">	<c:choose>		<c:when test="${pcode == '000253'}">                    <div class="titleBox">                        <h4 class="titleB">한국중부발전 동반성오픈플랫폼<em>에 오신 것을 환영합니다.</em></h4>                        <p>서비스를 이용하시려면 로그인을 하셔야 합니다.</p>                    </div>		</c:when>		<c:when test="${pcode == '000254'}">                    <div class="titleBox">                        <h4 class="titleB">회원정보, 휴대폰 본인인증, 아이핀<em>으로 아이디를 찾을 수 있습니다.</em></h4>                    </div>		</c:when>		<c:when test="${pcode == '000255'}">                    <div class="titleBox">                        <h4 class="titleB">회원정보, 휴대폰 본인인증, 아이핀<em>으로 비밀번호를 찾을 수 있습니다.</em></h4>                    </div>		</c:when>		<c:when test="${pcode == '000274'}">			<!-- <h5 class="main_title">회원정보</h5> -->		</c:when>		<c:otherwise>                    <div class="join_tab">                        <ul>                            <li <c:if test="${pstate == 'L'}">class="tab"</c:if>><p>회원이용약관<span>STEP 01</span></p></li>                            <li <c:if test="${pstate == 'L2' || pstate == 'L3-1' || pstate == 'L3-2' || pstate == 'L3-0'}">class="tab"</c:if>><p>본인확인<span>STEP 02</span></p></li>                            <c:if test="${pstate == 'L3-2' || pstate == 'L3-3' || authFlag=='Y'}"><li <c:if test="${pstate == 'L3-3'}">class="tab"</c:if>"><p>법정대리인 동의</p></li></c:if>                            <li <c:if test="${pstate == 'L4'}">class="tab"</c:if>><p>개인정보입력<span>STEP 03</span></p></li>                            <li <c:if test="${pstate == 'L5'}">class="tab"</c:if>><p>회원가입완료<span>STEP 04</span></p></li>                        </ul>                    </div>							</c:otherwise></c:choose></div><%// 이용약관 동의	if(pstate.equals("L")){		// 로그인		if(pcode.equals("000253")){%>			<%@include file="/WEB-INF/jsp/cm/S01/CmLogin.jsp"%><%		// 아이디찾기		}else if(pcode.equals("000254")){%>			<%@include file="/WEB-INF/jsp/ji/cm/oam/find_id.jsp"%><%		// 비밀번호찾기		}else if(pcode.equals("000255")){%>			<%@include file="/WEB-INF/jsp/ji/cm/oam/find_pw.jsp"%><%		// 회원가입		}else{%>			<%@include file="/WEB-INF/jsp/ji/cm/oam/join_agree.jsp"%><%		}%><%// 본인확인 절차  }else if(pstate.equals("L2")){%>	<%@include file="/WEB-INF/jsp/ji/cm/oam/join_confirm.jsp"%><%	 // 본인인증 절차  }else if(pstate.equals("L3-1") || pstate.equals("L3-2") || pstate.equals("L3-3") || pstate.equals("L3-0")){%>   <%@include file="/WEB-INF/jsp/ji/cm/oam/join_confirm2.jsp"%><%	 // 개인정보 입력  }else if(pstate.equals("L4")){%>  <%@include file="/WEB-INF/jsp/ji/cm/oam/join_input.jsp"%><%	 // 회원가입 완료  }else if(pstate.equals("L5")){%>  <%@include file="/WEB-INF/jsp/ji/cm/oam/join_fin.jsp"%><%	// 아이디 찾기완료  }else if(pstate.equals("FJ") || pstate.equals("FH")){%>  <%@include file="/WEB-INF/jsp/ji/cm/oam/find_id_fin.jsp"%><%	// 비밀번호 찾기완료  }else if(pstate.equals("FPF") || pstate.equals("FI")){%>  <%@include file="/WEB-INF/jsp/ji/cm/oam/find_pw_fin.jsp"%><%  }%><%}%><script>$(function() {	//타이틀 변경	var menuCd = "<%=pcode%>";	if(menuCd === "000138") {		//타이틀 변경		var pstate = "<%=pstate%>";		if(pstate === "L3-0" || pstate === "L3-1" || pstate === "L3-2" || pstate === "L3-3" || pstate === "L3-4") {			$(document).attr("title","<%=M_PATH_STR.replaceAll("ROOT::","").replaceAll("::"," > ").replaceAll("amp;","")%>" + " > 본인확인"); 		} else if(pstate === "L4") {			$(document).attr("title","<%=M_PATH_STR.replaceAll("ROOT::","").replaceAll("::"," > ").replaceAll("amp;","")%>" + " > 개인정보입력");		} else if(pstate === "L5") {			$(document).attr("title","<%=M_PATH_STR.replaceAll("ROOT::","").replaceAll("::"," > ").replaceAll("amp;","")%>" + " > 회원가입완료");		} else {			$(document).attr("title","<%=M_PATH_STR.replaceAll("ROOT::","").replaceAll("::"," > ").replaceAll("amp;","")%>"+ " > 회원이용약관"); 		}	}});</script>