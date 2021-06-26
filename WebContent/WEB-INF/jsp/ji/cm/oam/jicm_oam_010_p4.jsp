<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/oam/jicm_oam_010_p4    
/* 프로그램 이름     : jicm_oam_010_p4    
/* 소스파일 이름     : jicm_oam_010_p4.jsp
/* 설명              : 회원가입신청
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-01-27
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2015-01-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%
Map codeMap = new HashMap();
codeMap = (Map)request.getAttribute("resultMap");

%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입신청</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="googlebot" content="noindex" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<%-- 	<link href="<%=con_root%>/style/cmsadmin/base.css" type="text/css" rel="stylesheet" />
	<link href="<%=con_root%>/style/cmsadmin/layout.css" type="text/css" rel="stylesheet" /> --%>
<%@ include file="/WEB-INF/jsp/cm/CmCommonMsg.jsp" %>	
	<link rel="stylesheet" type="text/css" href="<%=con_root%>/style/print-preview.css" />
	<script type="text/javascript">var context_root = '<%= _context_root %>';</script>
	
	<!--<script type="text/javascript" src="<%=con_root%>/js/cross_browser_set.js"></script>-->
	<!--[if lt IE 7]><script type="text/javascript" src="<%=con_root%>/js/json2.js"></script><![endif]-->
	<!--[if IE 7]><script type="text/javascript" src="<%=con_root%>/js/json2.js"></script><![endif]-->
	<script type="text/javascript" src="<%=con_root%>/js/jquery-1.10.2.min.js"></script>

	<script type="text/javascript" src="<%=con_root%>/js/CmCommon.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/jquery.skipNav.js"></script>
	<script type="text/javascript" src="<%=con_root%>/js/common.js"></script>
	<script language="javascript" src="<%=con_root%>/js/calendar.js"></script>
	
	
	<!-- jqGrid -->
		<link rel="stylesheet" type="text/css" media="screen" href="/js/jqGrid.4.6/css/jquery-ui-custom.1.8.23.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="/js/jqGrid.4.6/css/ui.jqgrid.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="/js/jqGrid.4.6/css/ui.multiselect.css" />
		<style>
		    html, body { margin: 0; /* Remove body margin/padding */ padding: 0; /* overflow: hidden; */ /* Remove scroll bars on browser window */ /*font-size: 75%;*/ } 
		</style>
		<link href="<%=con_root%>/style/cmsadmin/default.css" type="text/css" rel="stylesheet" />	
			
		<!-- <script src="/js/jquery-1.10.2.min.js" type="text/javascript"></script> -->
		<script src="/js/jqGrid.4.6/i18n/grid.locale-kr.js" type="text/javascript"></script>
		<script type="text/javascript">
			$.jgrid.no_legacy_api = true;
			$.jgrid.useJSON = true;
		</script>
		<script src="/js/jqGrid.4.6/jquery-ui-custom.1.9.2.min.js" type="text/javascript"></script>
		<script src="/js/jqGrid.4.6/ui.multiselect.js" type="text/javascript"></script>
		<script src="/js/jqGrid.4.6/jquery.jqGrid.min.js" type="text/javascript"></script>
		
				<!-- com -->
		<script src="/js/com.js" type="text/javascript" charset="utf-8"></script>
		<script src="/js/com-jquery-fn.js" type="text/javascript" charset="utf-8"></script>
		
		<!-- jqplot -->
		<script type="text/javascript" src="/js/jqplot/excanvas.js"></script>
		<script type="text/javascript" src="/js/jqplot/excanvas.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/jquery.jqplot.js"></script>
		<script type="text/javascript" src="/js/jqplot/jquery.jqplot.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.json2.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.dateAxisRenderer.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.canvasTextRenderer.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.barRenderer.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.highlighter.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.cursor.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.pointLabels.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.pieRenderer.min.js"></script>
		<script type="text/javascript" src="/js/jqplot/plugins/jqplot.donutRenderer.min.js"></script>
		<link rel="stylesheet" type="text/css" hrf="/js/jqplot/jquery.jqplot.min.css" />
		<script type="text/javascript" src="/js/jqplot/syntaxhighlighter/scripts/shCore.min.js"></script>
   	 	<script type="text/javascript" src="/js/jqplot/syntaxhighlighter/scripts/shBrushJScript.min.js"></script>
   		<script type="text/javascript" src="/js/jqplot/syntaxhighlighter/scripts/shBrushXml.min.js"></script>
    	<link type="text/css" rel="stylesheet" href="/js/jqplot/syntaxhighlighter/styles/shCoreDefault.min.css" />
    	<link type="text/css" rel="stylesheet" href="/js/jqplot/syntaxhighlighter/styles/shThemejqPlot.min.css" />
  
		<!-- jqgrid multiselect & multiselectfilter -->
		<script type="text/javascript" src="/js/multselect/jquery.multiselect.js" ></script>
		<script type="text/javascript" src="/js/multselect/jquery.multiselectfilter.js" ></script>
		<link type="text/css" rel="stylesheet" href="/js/multselect/jquery.multiselect.css" />
		
		<!-- jqgrid autoselect -->
		<link href="/js/autoselect/singleSelect.css" rel="stylesheet" />
		<script src="/js/autoselect/singleSelect.js"></script>
		
</head>
<script type="text/javascript">


$(function(){
		//자격증관리
		var cols1 =[
		            {label:'번호'           ,name:'row_seq'           ,index:'row_seq'             ,align:'center'  ,width:'30'  ,hidden:true  ,sortable:false }
		            ,{label:'자격증 명'           ,name:'qual_nm'           ,index:'qual_nm'             ,align:'center'  ,width:'70'  ,hidden:false  ,sortable:false,formatter : certcd }
		            ,{label:'취득일'           ,   name:'acq_ymd'           ,index:'acq_ymd'             ,align:'center'  ,width:'60'  ,hidden:false  ,sortable:false,formatter : acqymd }
		            ,{label:'자격증 비고'           ,   name:'qual_desc'           ,index:'qual_desc'             ,align:'center'  ,width:'80'  ,hidden:false  ,sortable:false ,formatter : certdesc }
		            ,{label:'key'           ,   name:'emp_qual_seqno'           ,index:'emp_qual_seqno'             ,align:'center'  ,width:'1'  ,hidden:true  ,sortable:false }

		]
		//init grid
		var grid1 = com.grid.init({
		id			: '#jqGrid1' 
		,width : 600
		,height		: 150
		,rowNum		: 100
		,rowList	: 1000
		,multiselect: true
		,shrinkToFit : true
		,viewrecords: true
		,scroll 	: 1
		,autowidth : true
		,gridComplete: function(){
		mergeCellcomplet($(this));
		}
		,onSelectRow: function(id) { // row를 선택했을때 액션.	
		}
		,custom : { //custom
		cols : cols1 //컬럼정보 - 필수!
		,navButton : {
		excel : {
		exportName	: $('.con_title>h3').text().trim() //엑셀다운로드시 사용할 파일명
		}
		}
		}
		});	
		
	
	
		$("#btn_close").click(function(e){
			
			self.close();
		});
	
	
		//저장
		$("#btn_save").click(function(e){
			$("#pcode").val("join");
			var field = ["row_seq","jobduty_cd","rpsnt_job_yn","use_st_ymd","use_end_ymd","jobduty_desc","emp_jobduty_seqno"]; //grid 내 element id
			var field1 = ["row_seq","qual_nm","acq_ymd","qual_desc","emp_qual_seqno"]; //grid 내 element id
			var jridcheck1 = ["qual_nm","acq_ymd"]; //grid validation check
			if(!validation("cffrm")) return false; //필수 체크
			if(!gridValidation("jqGrid1",jridcheck1)) return false; //필수 체크
			
			
			
			if($('input[name=emp_id]').val().length != 8){
				alert("아이디는 사번을 기준으로 8자리만 입력되어야합니다.");
				document.getElementsByName("emp_id")[0].focus();
				return;
			}			
			
			if($('input[name=login_passwd]').val().length < 9 || $('input[name=login_passwd]').val().length > 20){
				alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
				document.getElementsByName("login_passwd")[0].focus();
				return;
			}
			
			if(!$('input[name=login_passwd]').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
				alert("비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
				document.getElementsByName("login_passwd")[0].focus();
				return;
			}	
			
			// 사용자동의 필수항목 체크여부 확인
			if($("#prv_agree1_1").is(":disabled")){
				alert("사용자 동의를 원문보기를 확인후 선택해주세요.");
				return;
			}	
			
			if($("#prv_agree1_1").is(":checked")==false){
				alert("개인정보(필수항목)의 수집 및 이용에 동의는 필수로 동의하셔야합니다.");
				return;
			}			
			
			if($("input:radio[name=prv_agree1]:checked").val()!="Y"){
				alert("개인정보(필수항목)의 수집 및 이용에 동의는 필수로 동의하셔야합니다.");
				return;
			}
			
			   $("#pstate").val("C");
			   $("#JobJSONDataList").val("[]") 
			   $("#CertJSONDataList").val(JSONDataList("jqGrid1",field1));
			   
			   // 자격증취득일 체크
				var chk_colModel = $("#jqGrid1").jqGrid('getGridParam','colModel');
				var chk_arrObj = new Array();
				var chk_ids = jQuery("#jqGrid1").jqGrid('getDataIDs');
				var chk_i=0;
				var chk_val0 = "";


				for ( chk_i=0; chk_i<chk_ids.length; chk_i++ ) {
					chk_val0 = $("#jqGrid1").find("#acq_ymd"+chk_ids[chk_i]).val();
					if((StrreplaceAll(chk_val0,"-","") >=  "<%=curDate%>")){
						$("#jqGrid1").find("#acq_ymd"+chk_ids[chk_i]).focus();
						alert("취득일은 현재일자보다 전날짜이어야 합니다.");

						return;
					}
				}
				
			var params = jQuery("#cffrm").serialize();
			
				CmopenLoading();
					 $.ajax({
			             type: "post",
			             url: "/cmsajax.do",
			             data: params,
			             async: false,
			             dataType:"json",
			             success: function(data){
			               if(data.result==true){
			            	   alert('가입요청이 완료되었습니다. 가입은 담당자 승인 후 가능합니다. ');
			                   self.close();
			               }else{
			            	   alert(''+data.TRS_MSG);
			            	   CmcloseLoading();
			            	   
			            	   
			               }
			               
			             }
			             /*,
					     error:function(request, status, error) {
					    	 alert('Error:'+error);
					    	 CmcloseLoading();
					    	 self.close();
			             }*/
			             
			             
			 
			      });
		});		
		
		
		// 그리드 삽입 
		$("#btn_add1").click(function(e){
			var ids = jQuery("#jqGrid1").jqGrid('getDataIDs');
			var addCnt  = 0;
			for(var i=0;i < ids.length;i++) {
				addCnt = ids[i];
				addCnt = addCnt.replace('jqg', '');
				}
	 	addCnt = parseInt(addCnt)+1;
			var targetData = "";
				targetData = { row_seq : ''
		                	  ,qual_nm          : ''
							  ,acq_ymd      : ''
		                	  ,qual_desc                 : ''
		                	  ,emp_id     : ''
		    		}
				
				jQuery("#jqGrid1").jqGrid('addRowData',addCnt,targetData);
			
			
		});
		
		//그리드 삭제
		$("#btn_remove1").click(function(e){
			  var ids = jQuery('#jqGrid1').jqGrid('getGridParam', 'selarrrow');
			    if(ids.length==0){
			    	alert('삭제할 항목을 선택하세요');
			    	return;
			    }
			    
			    for( var i=ids.length; i>0; i-- ){
			        $('#jqGrid1').jqGrid('delRowData', ids[i-1])
			      }
			
			
		});		
		
});


//Grid 데이터 json 데이터로 반환
function JSONDataList(jqGrid,field) {
	var colModel = $("#"+jqGrid).jqGrid('getGridParam','colModel');
	var arrObj = new Array();
	var ids = jQuery("#"+jqGrid).jqGrid('getDataIDs');
	var _value ="";
	var _type ="";
    for ( var i=0; i<ids.length; i++ ) {
        var vo = new Object();  
        for(var j=1;j<colModel.length;j++){
        	if(colModel[j].name!=""){
        		
        		//_value = $("#"+field[j-1]+[i+1]).val();
        	//$(":input "+field[j-1]+") 
        		_value = $("#"+jqGrid+" :input[name="+field[j-1]+"]:eq("+i+")").val();
        		_type = $("#"+jqGrid+" :input[name="+field[j-1]+"]:eq("+i+")").attr("type");
        		//console.log(_type);
        		if(_type=="radio"){
        			if($("#"+jqGrid+" input:radio[id="+field[j-1]+[i+1]+"]").is(":checked")){
        				_value = "Y"
        				eval("vo."+colModel[j].name+"=\""+_value+"\"");
        			}else{
        				_value = "N"
        				eval("vo."+colModel[j].name+"=\""+_value+"\"");
        			}
        		}else{
	        		//console.log(colModel[j].name+"      =         " +$("#"+field[j-1]+[i+1]).val()+"        field[j]       "+field[j-1]);
	        		if(_value==undefined){
	        			eval("vo."+colModel[j].name+"=\"\"");	
	        		}else{
	        			eval("vo."+colModel[j].name+"=\""+_value+"\"");
	        		}
        		}
        		//console.log("vo."+colModel[j].name+"=\""+_value+"\"");
        	}
        }
        arrObj.push(vo);   
    }
    return JSON.stringify(arrObj);
}





//자격증셋팅 
function certcd(cellvalue, options, rowObject) {
	var url ="";
	url = "<select name='qual_nm' id='qual_nm"+options.rowId+"'><option value=''>선택없음</option>"+"<%=(String)codeMap.get("certcd")%>"+"</selecd>";
    return url;
}

//취득일
function acqymd(cellvalue, options, rowObject) {
	var url ='<div class="item iDate mL5">';
	url += '<input type="text" name="acq_ymd" id="acq_ymd'+options.rowId+'" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();"  style="width:80px;" class="fL in" />';
	url +='<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById(\'acq_ymd'+options.rowId+'\'));return false;"></a></span>';
	url += '</div>';
    return url;
}


//비고
function certdesc(cellvalue, options, rowObject) {
	var url ="";
	url = "<input type='text' name='certdesc' id='certdesc"+options.rowId+"' maxlength='200' class='fL'/>";
    return url;
}

function optionGroup($this, lev){
    var param = "";
    var combobox="";
    var val=$this.val();
    var id =$($this).attr('name');
	var combolength = "";

   	combobox = $("#"+$("#"+id).parent().attr('id'));	
	//select id로 크기를 가져와서 더큰놈은 다지우기   	
    combolength = $("select[name^='"+id+"']").length;
	//alert(combolength);
	for(var i=combolength;lev<i;i--){
	    $("#"+id+Number(i-1)).remove();
	}
	
	$("#pcode").val("000246");
	$("#pstate").val("X3");
	$("#org_cd").val(val);
	//alert(val);
	var params = jQuery("#cffrm").serialize();
	    params += "&sorg_cd="+val;
	//alert(params);
    if	($this.val() != ''){
				 $.ajax({
		             type: "post",
		             url: "/cmsajax.do",
		             data:params,
		             async: false,
		             dataType:"json",
		             success: function(data){
		               if(data.optionlist!= ""){
		            	   //alert(data.optionlist);
		           		    combobox.append("<select name='"+id+"' id='"+(id+lev)+"' onchange='optionGroup($(this), "+Number(lev+1)+")'> <option value=''>선택없음</option> </select>");
		           		    combobox = $("#"+id+lev);
		                	combobox.append(data.optionlist);
		               }
		             }
		      });
				 
			  
    }
}

function chk_acq_ymd(selobj){
	
	
}
</script>

<body>
<form name="cffrm" id="cffrm" method="post" onSubmit='return false;Go_search();' >        
<input type="hidden" name="scode" id="scode" value="S01" title="사이트코드" />
<input type="hidden" name="pcode" id="pcode" value="join" title="페이지코드"  />
<input type="hidden" name="pstate" id="pstate" value="C" title="페이지상태"  />
<input type="hidden" name="org_cd" id="org_cd" value="" title="선택된인덱스" />
<input type="hidden" name="JobJSONDataList" id="JobJSONDataList" title="선택된인덱스" />
<input type="hidden" name="CertJSONDataList" id="CertJSONDataList" title="선택된인덱스" />
<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>회원가입신청</h1>
	<div class="desc">
	
	  <div class="sectionBlue">
	    <table class="tbl_type3">
	      <colgroup>
	      <col width="50" />
	      <col width="200" />
	      <col width="50" />
	      <col width="200" />
	      <col width="50" />
	      <col width="200" />
	      <col width="50" />
	      <col width="200" />
	      </colgroup>
	      	<tr>
	        	<th scope="row">조직<span class="pOrg">*</span></th>
	        	<td colspan="7" id="org_select_group">
	        		<select name="org" id="org" onchange="optionGroup($(this), 1)" >
	        		<option value=''>선택없음</option>
	        		<%=(String)codeMap.get("org_option")%>
	        		</select>
	        	</td>
	      	</tr>
	      
	      	<tr>
	        	<th scope="row">이름<span class="pOrg">*</span></th>
	        	<td>
	            	<input type="text" name="emp_nm" id="emp_nm" maxlength="50" title="" class="fL in" value="" />
	       		</td>
	       
	         	<th scope="row">ID<span class="pOrg">*</span></th>
	        	<td>
	            	<input type="text" name="emp_id" id="emp_id" maxlength="8" title="" class="fL in" value="" />
	       		</td>
	       		<th scope="row">비밀번호<span class="pOrg">*</span></th>
	        	<td colspan="3">
	            	<input type="password" name="login_passwd" id="login_passwd" maxlength="20" title="" class="fL in" value="" />
	       		</td> 
	       	</tr>
	       	
	      	<tr>
	        	<th scope="row" colspan="8">ID는 사번을 기준으로 8자리만 입력하세요<br />
	        	 가입후 확정아이디는 EX)한전:K00000000, 전우실업:Z00000000, 그외:E00000000 형식이됩니다.<br />
	        	 로그인시 신청한 조직에 맞게 해당 K, Z, E를  로그인 아이디 입력란에 추가하여 로그인해 주세요
	        	</th>

	       	</tr>	       	
	         
	       	<tr>
	         	<th scope="row">입사일</th>
	        	<td>
	        		<div class="item iDate">
	            	<input type="text" name="entcomp" id="entcomp" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" class="fL" /> 
	            	<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('entcomp'));return false;"></a></span>  
	         		</div>
	       		</td>  
	       		
	        	<th scope="row">직급</th>
	        	<td>
	        		<select name="now_jobgrd_cd" id="now_jobgrd_cd">
	        			<option value=''>선택없음</option>
	         			<%=(String)codeMap.get("jobcd")%> 
	        		</select>
	        	</td> 
	        	      
	            <th scope="row">학력</th>
	        	<td colspan="3">
	        		<select name="acadabt_cd" id="acadabt_cd">
	        		<option value=''>선택없음</option>
	        	 	<%=(String)codeMap.get("acadabt")%> 
	        		</select>
	        	</td>                 
	      	</tr>
	    </table>
	  </div>
	  
	  <!-- grid -->
	<div class="section mT5" style="position:relative;"> 
				<h3 class="fL"><span>&#8226;</span>기술자격</h3>
				<p class="fR">
				 <span class="btn_pack medium icon" id="btn_add1"><span class="add"></span><a href="# none;">추가</a></span> 
				 <span class="btn_pack medium icon" id="btn_remove1"><span class="delete"></span><a href="# none;">삭제</a></span>			</p> 
	</div>      
	<div class="section">
	  	<table id='jqGrid1'></table>
	</div>
	
	<!-- 개인정보수집 항목 -->
	<%@include file="/WEB-INF/jsp/ji/cm/oam/jicm_oam_010_i1.jsp"%>	
	<!-- 개인정보수집 항목 -->
		  	
	<div class="section aC mT10 mB5"> 
	<span class="btn_pack large" id="btn_save"><a href="# none;" >가입신청</a></span>
	<span class="btn_pack largeG" id="btn_close"><a href="# none;">닫기</a></span>
	</div>
 </div>
</div> 	
</form>
</body>
</html>
