<%--/*=================================================================================*//* 시스템            : JRCMS 시스템 SYSTEM/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/oam/jicm_oam_050_a1/* 프로그램 이름     : jicm_oam_050_a1  /* 소스파일 이름     : jicm_oam_050_a1.jsp/* 설명              : 관리자메뉴 > 사용자관리 등록/* 버전              : 1.0.0/* 최초 작성자       : 이금용/* 최초 작성일자     : 2016-11-07/* 최근 수정자       : cys/* 최근 수정일시     : 2018/03/08/* 최종 수정내용     : 수정/*=================================================================================*/--%><%@page pageEncoding="utf-8"%><form name="cffrm" id="cffrm" method="post" onSubmit='return false;Go_search();' >        	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />	<input type="hidden" name="sidx" value="" title="선택된인덱스" />	<input type="hidden" name="used" id="used" value="" />	<input type="hidden" name="del" id="del" value="" />	<input type="hidden" name="suser_id" id="suser_id" value="" />	<input type="hidden" name="suser_seq" id="suser_seq" />	  <div class="supply_box"> 	<div class="board_A0_W">	<h3 class="fL mB5"><span>&#8226;</span><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%> 등록</h3>    <table>      <colgroup>	      <col width="14%" />	      <col width="35%" />	      <col width="15%" />	      <col width="36%" />      </colgroup>      <tr>        <th scope="row">사용자 ID</th>        <td>            <input type="text" name="user_id" id="user_id" onclick="fnJoinCheck();return false;" maxlength="50" title="" class="input_type01 w_50p" value="" readonly="readonly" />            <a href="#none" class="btn_1 size_t" id="chkId">중복확인</a>        </td>         <th scope="row" class="essential">개인/기관</th>        <td>	        <ul class="rc_box">	        	<li>	        		<input type="radio" class="radio_type01" name="indvdl_grp_se" id="indvdl_grp_se1" value="P" />	        		<label for="indvdl_grp_se1">개인</label>	        	</li>	            <li>	            	<input type="radio" class="radio_type01" name="indvdl_grp_se" id="indvdl_grp_se2" value="G" />	            	<label for="indvdl_grp_se2">기관</label>	            </li>	         </ul>        </td>       </tr>      <tr>        <th scope="row">기관명</th>        <td>            <input type="text" name="grp_nm" id="grp_nm" maxlength="50" title="" size="20" class="input_type01 w_50p" value="<%=HtmlTag.returnString((String)viewMap.get("grp_nm"),"") %>" />        </td>        <th scope="row">대표자</th>        <td>            <input type="text" name="rprsntv" id="rprsntv" maxlength="50" title="" class="input_type01 w_50p" value="<%=HtmlTag.returnString((String)viewMap.get("rprsntv"),"") %>" />        </td>      </tr>      <tr>        <th scope="row">담당부서</th>        <td>            <input type="text" name="use_dept" id="use_dept" maxlength="50" title="" class="input_type01 w_50p" value="<%=HtmlTag.returnString((String)viewMap.get("use_dept"),"") %>" />        </td>        <th scope="row">담당자</th>        <td>            <input type="text" name="charger" id="charger" maxlength="50" title="" class="input_type01 w_50p" value="<%=HtmlTag.returnString((String)viewMap.get("charger"),"") %>" />        </td>      </tr>            <tr>        <th scope="row">연락처</th>        <td colspan="3">            <input type="text" name="contact" id="contact" maxlength="13" title="" class="input_type01 w_50p" value="<%=HtmlTag.returnString((String)viewMap.get("contact"),"") %>" onkeyup="maskTel(this)" />        </td>      </tr>                    <tr>        <th scope="row" class="essential">성명</th>        <td>            <input type="text" name="user_nm" id="user_nm" maxlength="50" title="" class="input_type01 w_50p" value="<%=HtmlTag.returnString((String)viewMap.get("user_nm"),"") %>" />        </td>        <th scope="row" class="essential">생년월일</th>        <td>	       	<select  id="brthdy1" name="brthdy1" class="select_type01" title="연도를 선택해 주세요">				<option value="">-년도-</option>			</select>			<select  id="brthdy2" name="brthdy2" class="select_type01" title="월을 선택해 주세요">				<option value="">-월-</option>			</select>			<select  id="brthdy3" name="brthdy3" class="select_type01" title="일을 선택해 주세요">				<option value="">-일-</option>			</select>        </td>      </tr>     <tr>	      <th scope="row" class="essential">비밀번호</th>	      <td colspan="3">	      	<input type="password" name="password" id="password"  maxlength="200" title="" class="input_type01 w_20p" value="" /><br>			<p class="exp mat_5">비밀번호는 <b class="fc_1">9~12자의 영문 대문자, 소문자, 숫자, 특수문자를 혼합</b>해서 사용하실수 있습니다.</p>			<p class="exp mat_5">해당 특수문자는 사용하실 수 없습니다.(&nbsp;&nbsp;<b class="fc_1">&lt; ,&nbsp; &gt; ,&nbsp; / ,&nbsp; \\ ,&nbsp; &amp; ,&nbsp; | ,&nbsp;  ^ ,&nbsp; % ,&nbsp; + ,&nbsp; .</b>&nbsp;&nbsp;)</p>			<p class="exp mat_5">비밀번호 변경 시 우측 <b class="fc_1">보안등급을 참고</b>하셔서 안전한 비밀번호로 변경하시기 바랍니다.</p>	      </td>	 </tr>	 <tr>	      <th scope="row" class="essential">비밀번호확인</th>	      <td colspan="3">	      	<input type="password" name="confirmPassword" id="confirmPassword"  maxlength="200" title="" class="input_type01 w_20p" value="" />	      </td>     </tr>     <tr>   		<th scope="row" class="essential">휴대전화</th>        <td>			<select id="moblphon1" name="moblphon1" class="select_type01" title="휴대전화 앞자리">				<%=(String)rtn_Map.get("mob_cd_opts")%>			</select>			<span class="hyphen">-</span>			<input type="text" class="input_type01" name="moblphon2" id="moblphon2" title="휴대전화 중간자리" size="6" maxlength="4" />			<span class="hyphen">-</span>			<input type="text" class="input_type01" name="moblphon3" id="moblphon3" title="휴대전화 끝자리" size="6" maxlength="4" />      	</td>        <th scope="row" >전화번호</th>       	<td>			<select id="telno1" name="telno1" class="select_type01" title="전화번호 앞자리">				<%=(String)rtn_Map.get("tel_cd_opts")%>			</select>			<span class="hyphen">-</span>			<input type="text" class="input_type01" name="telno2" id="telno2" title="전화번호 가온데자리" size="6" maxlength="4" />			<span class="hyphen">-</span>			<input type="text" class="input_type01" name="telno3" id="telno3" title="전화번호 끝자리" size="6" maxlength="4" />       	</td>     </tr>     <tr>     	<th scope="row" class="essential">주소</th>       	<td colspan="3">			<input type="text" class="input_type01 w_large" name="zip" id="zip" title="주소 우편번호" readonly="readonly" />			<a href="#none" class="btn_2 size_t" id="juso">도로명 검색</a>			<input type="text" class="input_type01 w_95p mat_5" name="adres" id="adres" title="상세주소" readonly="readonly" />			<input type="text" class="input_type01 w_95p mat_5" name="bunji" id="bunji" title="번지" />										<input type="hidden" name="addr_sido" id="addr_sido" title="시도" />							<input type="hidden" name="addr_sigungu" id="addr_sigungu" title="시군구" />							<input type="hidden" name="addr_dong" id="addr_dong" title="동" />							<input type="hidden" name="addr_road" id="addr_road" title="도로명 길" />							<input type="hidden" name="addr_bunji" id="addr_bunji" title="번지" />							<input type="hidden" name="addr_raad_num" id="addr_raad_num" title="도로명 길 번호" />			       	</td>     </tr>     <tr>        <th scope="row" class="essential">이메일</th>       	<td colspan="3">       		<input type="text" name="user_email1" id="user_email1" maxlength="50" title="이메일주소" class="input_type01" value=""  />@            <select name="user_email2"  id="user_email2" title="이메일주소(도메인)">         		<%=(String)rtn_Map.get("mail_cd_opts")%>            </select>        	       	</td>     </tr>     <tr>	      <th scope="row">사용자비고</th>	      <td colspan="3">	      	<input type="text" name="user_desc" id="user_desc"  maxlength="200" title="사용자비고" class="input_type01 w_95p" value="" />	      </td>        </tr>      <tr style="display:none;">        <th scope="row">해피콜 제공여부</th>         <td colspan="3">	        <ul class="rc_box">	        	<li>	        		<input type="radio" class="radio_type01" name="happycl_provd_at" id="happycl_provd_at1" value="Y" />	        		<label for="happycl_provd_at1">동의함</label>	        	</li>	            <li>	            	<input type="radio" class="radio_type01" name="happycl_provd_at" id="happycl_provd_at2" value="N" />	            	<label for="happycl_provd_at2">동의하지 않음</label>	            </li>	         </ul>        </td>      </tr>    </table>    </div>    	<div class="board_A0_W mat_30">		<h3 class="fL mB5"><span>&#8226;</span>뉴스 &middot; 정보수신여부 설정</h3>				<table summary="">			<caption>뉴스 &middot; 정보수신여부 설정-메일수신여부,SMS수신여부,KEPCO뉴스레터,</caption>			<colgroup>		      <col width="14%" />		      <col width="35%" />		      <col width="15%" />		      <col width="36%" />			</colgroup>			<tbody>				<tr>					<th scope="row" class="essential"><label for="">메일 수신여부</label></th>					<td colspan="3">						<ul class="rc_box">							<li>								<input type="radio" class="radio_type01" id="email_recptn_at1" name="email_recptn_at" value="Y" />								<label for="email_recptn_at1">예</label>							</li>							<li>								<input type="radio" class="radio_type01" id="email_recptn_at2" name="email_recptn_at" value="N" />								<label for="email_recptn_at2">아니오</label>							</li>						</ul>					</td>				</tr>				<tr>					<th scope="row" class="essential"><label for="">SMS 수신여부</label></th>					<td colspan="3">						<ul class="rc_box">							<li>								<input type="radio" class="radio_type01" id="sms_recptn_at1" name="sms_recptn_at" value="Y" />								<label for="sms_recptn_at1">예</label>							</li>							<li>								<input type="radio" class="radio_type01" id="sms_recptn_at2" name="sms_recptn_at" value="N" />								<label for="sms_recptn_at2">아니오</label>							</li>						</ul>					</td>				</tr>				<tr style="display:none;">					<th scope="row" ><label for="">KEPCO 뉴스레터</label></th>					<td colspan="3">						<ul class="rc_box">							<li>								<input type="radio" class="radio_type01" id="new_recptn_at1" name="new_recptn_at" value="Y" />								<label for="new_recptn_at1">예</label>							</li>							<li>								<input type="radio" class="radio_type01" id="new_recptn_at2" name="new_recptn_at" value="N"/>								<label for="new_recptn_at2">아니오</label>							</li>						</ul>					</td>				</tr>			</tbody>		</table>	</div>	<!--//board_A0_write-->    	<div class="button a_r mat_15"> 		 <a href="#" class="btn_2 size_n" id="btn_list" onclick="return false;">목록</a>		 <a href="#" class="btn_1 size_n" id="btn_save" onclick="return false;">등록</a>	</div>    </div></form><form action="<%=RequestURL%>" method="post" id="dataForm" name="dataForm" onSubmit="return false;" target="popup_window">	<input type="hidden" name="scode" value="<%=scode %>" />	<input type="hidden" name="pcode" value="<%=pcode %>" /></form><script type="text/javascript">var searchYn = false;//TODO : $(function()$(function(){		//목록 이동		$("#btn_list").click(function(e){				  su_form=document.cffrm;			  su_form.method='post';			  su_form.pstate.value='L';			  su_form.action='<%=RequestURL%>';			  su_form.submit();			  su_form.target = "";		});				//저장		$("#btn_save").click(function(e){						if(!validation("cffrm")) return false; //필수 체크						// 아이디가 입력되어있을경우 아이디를 체크한다			if(!isEmpty($('input[name=user_id]').val()) ){				if($('input[name=user_id]').val().length > 12){					alert("아이디는 12자리까지만 입력되어야합니다.");					document.getElementsByName("user_id")[0].focus();					return;				}			}						// 비밀번호가 입력되어있을경우 비밀번호를 체크한다			if(!isEmpty($('input[name=login_passwd]').val()) ){				if($('input[name=login_passwd]').val().length < 9 || $('input[name=login_passwd]').val().length > 20){					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");					document.getElementsByName("login_passwd")[0].focus();					return;				}								if(!$('input[name=login_passwd]').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){					alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");					document.getElementsByName("login_passwd")[0].focus();					return;				}							}					   $("#pstate").val("C");			var params = jQuery("#cffrm").serialize();			CmopenLoading();				 $.ajax({		             type: "post",		             url: "<c:url value='/cmsajax.do'/>",		             data: params,		             async: false,		             dataType:"json",		             timeout: 3000,		             error: function (jqXHR, textStatus, errorThrown) {		                // 통신에 에러가 있을경우 처리할 내용(생략가능)	    	        	alert("네트웍장애가 발생했습니다. 다시시도해주세요");	    	        	CmcloseLoading();		             },		             success: function(data){		               if(data.result==true){		                	alert('저장 되었습니다.');		                	$("#btn_list").trigger("click");		               }else{		            	   	alert(data.TRS_MSG);		            	   	CmcloseLoading();		               }		               		             }		             /*,				     error:function(request, status, error) {				    	 CmcloseLoading();				    	 alert('저장 중 오류가 발생했습니다.');		             }*/		      });		});				$("#brthdy1").change( function(){			fnMonDay();	    });				$("#brthdy2").change( function(){			fnMonDay();	    });				$("#password").keyup(function(){			if($("input[name=user_id]").val() == ""){				alert("아이디를 입력해주세요.");				$("input[name=password]").val("");				$("input[name=user_id]").focus();				return false;			}else{				fnCheckPwd(this.value);			}		});		/*		$("#confirmPassword").keyup(function(){			fnCheckPwd(this.value);		});		*/		// 중복체크		$("#chkId").click( function() {			fnJoinCheck();		});				// 도로명검색		$("#juso").click( function() {			fnJusoPopup();		});				// email		$('#email3').change(function(){			$("input[name=email2]").val($('#email3 option:selected').val());		});				$("#user_id").keydown(function(e){			if(e.keyCode == 13){				fnJoinCheck();			}		});				$("#zip").click( function() {			fnJusoPopup();		});					});	var fnCheckPwd = function(inputVal){			var user_id = $("#user_id").val();		var ptrnCnt = 0;			var chk_num = inputVal.search(/[0-9]/g); 		var chk_lowerEng = inputVal.search(/[a-z]/g); 		var chk_upperEng = inputVal.search(/[A-Z]/g); 		var strSpecial = inputVal.search(/[`~!@#$*\'\";:?()\[\]]/gi);		var impossibleChar = inputVal.search(/[<>\/\\&|^%+.]/gi);    		var retVal = checkSpace(inputVal);			if(impossibleChar > -1){			alert("아래 특수문자만 허용됩니다.\n[`, ~, !, @, #, $, *, ', \", ;, :, ?, (, ), [, ] ]");			return false;		}			if(chk_num > -1){ ++ptrnCnt; }		if(chk_upperEng > -1){ ++ptrnCnt; }		if(chk_lowerEng > -1){ ++ptrnCnt; }		if(strSpecial > -1){ ++ptrnCnt; }				if(inputVal.indexOf(user_id) > -1) {			alertMsg = "비밀번호에 ID를 포함할수 없습니다.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (ID 포함 불가)");			return false;		}else if(retVal){			alertMsg = "비밀번호는 공백없이 입력해 주세요.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (공백 불가)");			return false;		}else if(inputVal.length < 9){			alertMsg = "9자 이상의 비밀번호만 입력 가능 합니다.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (8자리 이하 불가)");			return false;		}else if(ptrnCnt < 3){			alertMsg = "비밀번호는 대문자, 소문자, 숫자, 특수문자 중 세 가지 이상 조합되어야 합니다.";			$("#pwComment").html("※ 보안등급 : <span style='color: red;'>불가</span> (비밀번호 패턴 조합 미준수)");			return false;		}else{			alertMsg = "";			$("#pwComment").text("사용 가능한 비밀번호입니다.");						if((inputVal.length == 9 || inputVal.length == 10) && ptrnCnt == 3){				$("#pwComment").html("※ 보안등급 : 보통 ");			}else if((inputVal.length == 9 || inputVal.length == 10) && ptrnCnt == 4){				$("#pwComment").html("※ 보안등급 : <span style='color: blue;'>안전</span> ");			}else if(inputVal.length > 10 && ptrnCnt == 2){				$("#pwComment").html("※ 보안등급 : 보통 ");			}else if(inputVal.length > 10 && ptrnCnt > 2){				$("#pwComment").html("※ 보안등급 : <span style='color: blue;'>안전</span> ");			}			return true;		}	};		var fnMonDay = function(){		day.options.length = 1;		var febDay = year.value%4 == 0?29:28;		var Days = new Array;		Days = [31,febDay,31,30,31,30,31,31,30,31,30,31];		for(var i=1; i <= Days[month.value - 1]; i++){			if(i < 10){				day.options[i] = new Option("0" + i, "0" + i);			}else{				day.options[i] = new Option(i, i);				}		}	};		var checkSpace = function(str){		  if(str.search(/\s/) != -1){				return true;			}else{				return false;			}		};			// 중복체크	var fnJoinCheck = function(){		//popWin("<%=con_root%>/popup/join_check_popup.jsp", 'popup_window', 600, 400);		popWin("<c:url value='/cmsmain.do' />?scode=000008&pcode=000526", 'popup_window', 600, 400);	};		// 도로명주소	var fnJusoPopup = function(){		popWin("<%=con_root%>/doroApi/jusoPopup.jsp", 'popup_window', 600, 400);	};		// CallBack	var jusoCallBack = function(roadFullAddr,roadAddrPart1,addrDetail,roadAddrPart2,engAddr			,jibunAddr,zipNo, admCd, rnMgtSn, bdMgtSn			, detBdNmList, bdNm, bdKdcd, siNm, sggNm			, emdNm, liNm, rn, udrtYn, buldMnnm			, buldSlno, mtYn, lnbrMnnm, lnbrSlno){		// 우편번호		$("input[name=zip]").val(zipNo);		// 주소		$("input[name=adres]").val(roadAddrPart1);		// 주소상세		$("input[name=bunji]").val(addrDetail);				// 시도		$("input[name=addr_sido]").val(siNm);		// 시군구		$("input[name=addr_sigungu]").val(sggNm);		// 읍면동		$("input[name=addr_dong]").val(emdNm);		// 도로명		$("input[name=addr_road]").val(rn);				// 번지		$("input[name=addr_bunji]").val(lnbrMnnm);					// 도로번호		$("input[name=addr_raad_num]").val(buldMnnm);			};		var year	= document.getElementById("brthdy1");	var month	= document.getElementById("brthdy2");	var day		= document.getElementById("brthdy3");			for(var i=1, j=2014; i <=114; i++, j--){		year.options[i] = new Option(j, j);	}		for(var i=1; i <= 12; i++){		if(i <10){			month.options[i] = new Option("0" + i, "0" + i);		}else{			month.options[i] = new Option(i, i);		}	}	//Grid 데이터 json 데이터로 반환	function JSONDataList(jqGrid,field) {		var colModel = $("#"+jqGrid).jqGrid('getGridParam','colModel');		var arrObj = new Array();		var ids = jQuery("#"+jqGrid).jqGrid('getDataIDs');		var _value ="";		var _type ="";	    for ( var i=0; i<ids.length; i++ ) {	        var vo = new Object();  	        for(var j=1;j<colModel.length;j++){	        	if(colModel[j].name!=""){	        			        		_value = $("#"+jqGrid+" :input[name="+field[j-1]+"]:eq("+i+")").val();	        		_type = $("#"+jqGrid+" :input[name="+field[j-1]+"]:eq("+i+")").attr("type");	        		if(_type=="radio"){	        			if($("#"+jqGrid+" input:radio[id="+field[j-1]+[i+1]+"]").is(":checked")){	        				_value = "Y"	        				eval("vo."+colModel[j].name+"=\""+_value+"\"");	        			}else{	        				_value = "N"	        				eval("vo."+colModel[j].name+"=\""+_value+"\"");	        			}	        		}else{		        				        		if(_value==undefined){		        			eval("vo."+colModel[j].name+"=\"\"");			        		}else{		        			eval("vo."+colModel[j].name+"=\""+_value+"\"");		        		}	        		}	        	}	        }	        arrObj.push(vo);   	    }	    return JSON.stringify(arrObj);	}	</script>