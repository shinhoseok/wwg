<%--/*=================================================================================*//* 시스템            : JRCMS 시스템 SYSTEM/* 프로그램 아이디   : /WEB-INF/jsp/cm/CmCodeSelect    /* 프로그램 이름     : CmCodeSelect    /* 소스파일 이름     : CmCodeSelect.jsp/* 설명              : SYSTEM INDEX페이지/* 버전              : 1.0.0/* 최초 작성자       : 이금용/* 최초 작성일자     : 2014-02-11/* 최근 수정자       : 이금용/* 최근 수정일시     : 2014-02-11/* 최종 수정내용     : 최초작성/*=================================================================================*/--%><%@page pageEncoding="utf-8"%><script type="text/javascript">//<![CDATA[	var <%=javasc_arr_nm%> = new Array();	var <%=javasc_arr_nm%>_tmp = new Array(); <%// 코드배열에 담긴값을 출력한다if(code_select_List.size() > 0){	for(ic=0 ;ic<code_select_List.size();ic++){		rtn_row_Map = (Map)code_select_List.get(ic);		//' 첫번째 데이터의 경우 초기 lv값을 셋팅한다		if (ic==0){			cinit_lv =  Integer.parseInt(String.valueOf(rtn_row_Map.get("lv")));		}		ctmp_lv = Integer.parseInt(String.valueOf(rtn_row_Map.get("lv"))) - cinit_lv;
		if (ic==0){		%>				<%=javasc_arr_nm%>[<%=ctmp_lv%>] = new Array();		<%		}else if( cprev_lv < ctmp_lv ){		%>				<%=javasc_arr_nm%>[<%=ctmp_lv%>] = new Array();		<%		}		%>			<%=javasc_arr_nm%>_tmp = new Array();			<%=javasc_arr_nm%>_tmp[0]  = "<%=rtn_row_Map.get("stdinfoDtlCd")%>"; //' CODE_C			<%=javasc_arr_nm%>_tmp[1]  = "<%=rtn_row_Map.get("stdinfoDtlNm")%>"; //' CODE_NM			<%=javasc_arr_nm%>_tmp[2]  = "<%=rtn_row_Map.get("stdinfoDtlUppoCd")%>"; //' CODE_UP_C			<%=javasc_arr_nm%>_tmp[3]  = "<%=rtn_row_Map.get("lv")%>"; //' DEPTH_NO			<%=javasc_arr_nm%>_tmp[4]  = "<%=rtn_row_Map.get("orderNo")%>"; //' ORDER_NO			<%=javasc_arr_nm%>_tmp[5]  = "<%=rtn_row_Map.get("DelYn")%>"; //' USE_YN			<%=javasc_arr_nm%>_tmp[6]  = "<%=rtn_row_Map.get("codeCs")%>"; //' CODE_CS			<%=javasc_arr_nm%>_tmp[7]  = "<%=rtn_row_Map.get("lv")%>"; //' LV			<%=javasc_arr_nm%>[<%=ctmp_lv%>].push(<%=javasc_arr_nm%>_tmp);		<%			cprev_lv = ctmp_lv;
	}
}
%>

$(document).ready(function() {	// 화면이 로드될경우 첫페이지를 보여준다
	Code_Cate_Init<%=inhtml_id%>("<%=javasc_arr_nm%>","<%=select_nm%>","<%=inhtml_id%>","<%=init_code_param%>");
});

// 동적 코드 select 박스를 초기화생성한다function Code_Cate_Init<%=inhtml_id%>(treemenuvalname, crobjname, divname, lastselval){	<%=javasc_arr_nm%>_sel = eval(treemenuvalname);	param_arr = new Array(<%=javasc_arr_nm%>_sel.length);	tmp_arr = new Array();	var chk_param_len = 0;
	// 초기데이터가 있을경우 값을 셋팅한다	if(lastselval!=""){		//alert("sdlfjsdl;fjsadl;"+<%=javasc_arr_nm%>_sel.length);		param_arr[<%=javasc_arr_nm%>_sel.length-1] = lastselval;		
		for(i=<%=javasc_arr_nm%>_sel.length-1;i>-1;i--){			tmp_arr = <%=javasc_arr_nm%>_sel[i];			chk_param_len = 0;			for(j=0;j<tmp_arr.length;j++){							if(tmp_arr[j][0]==param_arr[i]){					//alert(j+":::::"+tmp_arr[j][2]);					chk_param_len++;					param_arr[i-1]=tmp_arr[j][2];				}else if(i==0 && tmp_arr[j][0] == param_arr[1]){					//alert(lastselval+"::"+tmp_arr[j][2]+"::"+tmp_arr[j][3]+"::"+(i-1));					param_arr[i]=tmp_arr[j][0];				}			}			if(chk_param_len==0){				param_arr = new Array(i);				param_arr[i-1] = lastselval;			}
		}	}	//alert(param_arr.length+"::"+param_arr[0]);	// 배열의 길이만큼 셀렉트박스를 만든다	for(i=0;i<<%=javasc_arr_nm%>_sel.length;i++){		menu_name = crobjname+i;		//alert(i+":::"+treemenuval[i].length);		// 최상위 select 박스는 무조건보인다		if(i == 0){			<%			if(!onchg_func_nm.equals("")){			%>			document.getElementById(divname).innerHTML ="<select name='"+menu_name+"' onchange=\"<%=onchg_func_nm%><%=inhtml_id%>(this);Chg_Code_Cate<%=inhtml_id%>(this,'"+i+"','"+crobjname+"','"+treemenuvalname+"','"+divname+"')\"><option value=''>===선택===</option></select>";			<%			}else{			%>			document.getElementById(divname).innerHTML ="<select name='"+menu_name+"' onchange=\"Chg_Code_Cate<%=inhtml_id%>(this,'"+i+"','"+crobjname+"','"+treemenuvalname+"','"+divname+"')\"><option value=''>===선택===</option></select>";			<%			}			%>			//alert(treemenuval[i].length);			// 최상위 선택 메뉴셀렉트박스의 옵션들을 추가한다			se_add_obj=document.getElementsByName(menu_name)[0];			selAdd<%=inhtml_id%>(se_add_obj, <%=javasc_arr_nm%>_sel[i], "");		}else{			// 초기값이 있으면 값을셋팅해서 보여준다			if(param_arr != null){				if(param_arr.length > 0){					if(param_arr[i-1] != "" && param_arr[i-1]!=null){						document.getElementById(divname).innerHTML = document.getElementById(divname).innerHTML + "<select name='"+menu_name+"' onchange=\"Chg_Code_Cate<%=inhtml_id%>(this,'"+i+"','"+crobjname+"','"+treemenuvalname+"','"+divname+"')\"><option value=''>---선택---</option></select>";							//alert(treemenuval[i].length);						// 최상위 선택 메뉴셀렉트박스의 옵션들을 추가한다						//se_add_obj=eval(formname+"."+menu_name);						se_add_obj=document.getElementsByName(menu_name)[0];						selAdd<%=inhtml_id%>(se_add_obj, <%=javasc_arr_nm%>_sel[i], param_arr[i-1]);					}else{						document.getElementById(divname).innerHTML = document.getElementById(divname).innerHTML + "<select name='"+menu_name+"' style='display:none;'  onchange=\"Chg_Code_Cate<%=inhtml_id%>(this,'"+i+"','"+crobjname+"','"+treemenuvalname+"','"+divname+"')\"><option value=''>---선택---</option></select>";						}				}			}else{				document.getElementById(divname).innerHTML = document.getElementById(divname).innerHTML + "<select name='"+menu_name+"' style='display:none;'   onchange=\"Chg_Code_Cate<%=inhtml_id%>(this,'"+i+"','"+crobjname+"','"+treemenuvalname+"','"+divname+"')\"><option value=''>---선택---</option></select>";				}
							}
	}// for문종료
	// 만약선택된 값이 있으면 선택된상태로 보여지게 한다		if(param_arr != null){			if(param_arr.length > 0){				selSet<%=inhtml_id%>(param_arr);			}		}	}
function selOrign(frm,val){	for(i=0; i < document.getElementsByName(frm)[0].length ; i++){		if(document.getElementsByName(frm)[0].options[i].value == val){			document.getElementsByName(frm)[0].options.selectedIndex = i ;		}	}}
function selSet<%=inhtml_id%>(paramin_arr){	//alert(paramin_arr.length);	for(j=0;j<paramin_arr.length;j++){		menu_name = "<%=select_nm%>"+j;		se_add_obj=document.getElementsByName(menu_name)[0];				if(paramin_arr[j] != ""){				//alert("document.list_form."+menu_name+"::"+paramin_arr[j]);					selOrign(menu_name,paramin_arr[j]);				}	}}
function Chg_Code_Cate<%=inhtml_id%>(obj, sel_num, crobjname, treemenuvalname, divname){
	next_num = parseInt(sel_num,10)+1;	<%=javasc_arr_nm%>_sel = eval(treemenuvalname);	// 선택된값이 있고 배열의 값이 있을경우만 하위정보를 보여준다	if(obj.value!="" && <%=javasc_arr_nm%>_sel[next_num]!=undefined ){		// 만일 추가될 셀렉트박스보다 하위 셀렉트박스가 있을경우 셀렉트박스를 초기화하고 안보이게 한다		for(k=next_num;k<<%=javasc_arr_nm%>_sel.length;k++){			menu_name = crobjname+k;			//alert(menu_name);			if(k==next_num){				se_add_obj=document.getElementsByName(menu_name)[0];				se_add_obj.style.display = "";				selRemove<%=inhtml_id%>(se_add_obj);			}else{				del_add_obj=document.getElementsByName(menu_name)[0];				del_add_obj.style.display = "";				selRemove<%=inhtml_id%>(del_add_obj);				del_add_obj.style.display = "none";			}		}		//alert(se_add_obj+"::"+treemenuval[next_num]+"::"+obj.value);		selAdd<%=inhtml_id%>(se_add_obj, <%=javasc_arr_nm%>_sel[next_num], obj.value);		if(se_add_obj.length < 2){			se_add_obj.style.display = "none";		}	// 선택값이 없을경우 하위 SELECT박스를 초기화한다	}else if(obj.value==""){		// 하위레벨만큼 루프를 돌린다		for(k=0;k<<%=javasc_arr_nm%>_sel.length;k++){			if(k > sel_num){				menu_name = crobjname+k;				del_add_obj=document.getElementsByName(menu_name)[0];				del_add_obj.style.display = "";				selRemove<%=inhtml_id%>(del_add_obj);				del_add_obj.style.display = "none";							}
		}		//Code_Cate_Init("document.list", treemenuvalname, crobjname, divname);	}}

// 해당 select박스 object에 배열값에 들어있는 값을 요소로 추가한다function selAdd<%=inhtml_id%>(obj, add_arr, up_code){	// 최상위 셀렉트박스인경우 무조건 추가한다	if(up_code == ""){		//alert(obj.length+":"+add_arr.length);		for(j=obj.length;j<=add_arr.length;j++){			obj.options[j] = new Option(add_arr[j-1][1], add_arr[j-1][0]);// text, value		}	// 하위 셀렉트박스인경우 선택된 상위 코드에 해당하는 하위 값들만 보인다	}else{		k=obj.length;		for(j=obj.length;j<=add_arr.length;j++){			if(add_arr[j-1][2] == up_code){				obj.options[k] = new Option(add_arr[j-1][1], add_arr[j-1][0]);// text, value				k++;			}		}	}}
// 해당 select박스 object에 들어있는값을 초기화한다function selRemove<%=inhtml_id%>(obj){	// 기존 선택된 값을 저장한후 전부비우고 재설정한다	for(i=obj.length-1;i>0;i--){		obj.options[i]=null;	}
}//]]></script>