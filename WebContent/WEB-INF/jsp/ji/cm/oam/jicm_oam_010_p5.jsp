<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   :  
/* 프로그램 이름     : CmLogin    
/* 소스파일 이름     : CmLogin.jsp
/* 설명              : 개인정보변경팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2014-01-27
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2014-01-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>
<!DOCTYPE html>
<html>
<title>개인정보수정</title>
<script type="text/javascript">
var org_option = '<%=CM_Util.nullToEmpty((String)viewMap.get("full_path"))%>';
org_option = org_option.split(',');
var qual_nm = new Array();
var jobduty_cd = new Array();


function orgoption(){
	for(var i=0;i<org_option.length;i++){
		$("#org"+i).val(org_option[i]);
		if(i==0){
			$("#org").val(org_option[i]);	
		}
	 	var combobox = "";
		$("#pstate").val("X3");
		var params = jQuery("#cffrm").serialize();
		    params += "&sorg_cd="+org_option[i];
					 $.ajax({
			             type: "post",
			             url: "/cmsajax.do",
			             data:params,
			             async: false,
			             dataType:"json",
			             success: function(data){
			               if(data.optionlist!= ""){
			            	   //alert(data.optionlist);
			           		    $("#org_select_group").append("<select name='org' id='org"+Number(i+1)+"' onchange='optionGroup($(this), "+Number(i+2)+")' disabled='disabled'> <option value=''>선택없음</option> </select>");
			           		    combobox = $("#org"+Number(i+1));
			                	combobox.append(data.optionlist);
			        			if(i==0){
			        				$("#org").val(org_option[i]);
			        			}else{
			        				$("#org"+i).val(org_option[i]);
			        			}	
			               }
			             }
			      });
		}
}

$(function(){
		//자격증관리
		var cols1 =[
		            {label:'번호'           ,name:'row_seq'           ,index:'row_seq'             ,align:'center'  ,width:'30'  ,hidden:true  ,sortable:false }
		            ,{label:'자격증 명'           ,name:'qual_nm'           ,index:'qual_nm'             ,align:'center'  ,width:'70'  ,hidden:false  ,sortable:false,formatter : certcd }
		            ,{label:'취득일'           ,   name:'acq_ymd'           ,index:'acq_ymd'             ,align:'center'  ,width:'60'  ,hidden:false  ,sortable:false,formatter : acq_ymd }
		            ,{label:'자격증 비고'           ,   name:'qual_desc'           ,index:'qual_desc'             ,align:'center'  ,width:'80'  ,hidden:false  ,sortable:false ,formatter : qual_desc }
		            ,{label:'key'           ,   name:'emp_qual_seqno'           ,index:'emp_qual_seqno'             ,align:'center'  ,width:'1'  ,hidden:true  ,sortable:false }

		]
		//init grid
		var grid1 = com.grid.init({
		id			: '#jqGrid1' 
		,width : 600
		,height		: 130
		,rowNum		: 100
		,rowList	: 1000
		,multiselect: true
		,shrinkToFit : true
		,viewrecords: true
		,scroll 	: 1
		,autowidth : true
		,gridComplete: function(){
		mergeCellcomplet($(this));
		},loadComplete: function() {
			var ids = jQuery("#jqGrid1").jqGrid('getDataIDs');
			for(var i=0;i<ids.length;i++){
				$("#qual_nm"+ids[i]).val(qual_nm[i]);
			}
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
		
	
		orgoption();
		$("#btn_close").click(function(e){
			
			self.close();
		});
	
	
		//저장
		$("#btn_save").click(function(e){
			var field1 = ["row_seq","qual_nm","acq_ymd","qual_desc","emp_qual_seqno"]; //grid 내 element id
			var jridcheck1 = ["qual_nm","acq_ymd"]; //grid validation check
			if(!validation("cffrm")) return false; //필수 체크
			
			/*alert($("#prv_agree1_1").is(":checked")+"===>"
					+$("#prv_agree1_1").is(":disabled")+"===>"
					+$("input:radio[name=prv_agree1]:checked").val());*/

			
			var check = false;
			if($("#login_passwd").val()!=""){
				  	$("#pstate").val("P3");
					var params = $("#cffrm").serialize();
					 $.ajax({
			             type: "post",
			             url: "/cmsajax.do",
			             data: params,
			             async: false,
			             dataType:"json",
			             success: function(data){
			               if(data.result==true){
			               }else{
								alert('현재 비밀번호가 틀렸습니다');
								$("#passwd").focus();
								check=true;
			               }
			             },
					     error:function(request, status, error) {
					    	 check=false;
			             }
			      });
				if(check){
					return;
				}
				
				if(!isEmpty($('input[name=login_passwd]').val()) || !isEmpty($('input[name=new_passwd]').val()) ){
					if($('input[name=login_passwd]').val() == $('input[name=new_passwd]').val()){
						alert("변경 비밀번호와 현재 비밀번호는 틀려야 합니다.");
						$("#new_passwd").focus();
						return;
					}					
				}
				

				
				if(!isEmpty($('input[name=new_passwd]').val()) ){
					if($('input[name=new_passwd]').val().length < 9 || $('input[name=new_passwd]').val().length > 20){
						alert("변경 비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
						$("#new_passwd").focus();
						return;
					}
					
					if(!$('input[name=new_passwd]').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~,(,),+])|([!,@,#,$,%,^,&,*,?,_,~,(,),+].*[a-zA-Z0-9])/)){
						alert("변경 비밀번호는 영문,숫자,특수문자 조합으로 9~20자리로 사용해야합니다.");
						$("#new_passwd").focus();
						return;
					}	
					
					if($('input[name=new_passwd]').val() != $('input[name=new_passwd1]').val()){
						alert("변경 비밀번호와 변경비밀번호 확인 값이 같지 않습니다.");
						$("#new_passwd").focus();
						return;
					}					
				}

				
			}
			
			
			if(!gridValidation("jqGrid1",jridcheck1)) return false; //필수 체크
			
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
			
			//return;			
			
			   $("#pstate").val("U1");
			   $("#CertJSONDataList").val(JSONDataList("jqGrid1",field1));
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
			            	   alert('수정 되었습니다.');
			                	self.close();
			               }else{
			            	   alert('수정중 오류가 발생했습니다.');
			            	   CmcloseLoading();
			               }
			               
			             },
					     error:function(request, status, error) {
					    	 alert('수정중 오류가 발생했습니다.');
					    	 CmcloseLoading();
			             }
			 
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
		
		<%
		// 사용자 동의 여부값이 모두 N이면 개인정보 수집동의를 하지 않은것이므로 값을 셋팅하지않는다
		if( ((String)viewMap.get("prv_agree1")).equals("N") && ((String)viewMap.get("prv_agree2")).equals("N")
				&& ((String)viewMap.get("prv_agree3")).equals("N") && ((String)viewMap.get("prv_agree4")).equals("N") ){
		
		// 사용자 동의 여부값이 한개라도 Y이면 개인정보 수집동의를 한것이므로 값을 셋팅하고 disable상태를 해제한다.
		}else{
		// jicm_oam_010_i1.jsp의 javascript 함수 호출
		%>
			orginal_text_confirm();
			<%
			if( ((String)viewMap.get("prv_agree1")).equals("Y") ){
			%>
			$("#prv_agree1_1").prop("checked","checked");
			<%
			}else{
			%>
			$("#prv_agree1_2").prop("checked","checked");
			<%
			}
			%>
			
			<%
			if( ((String)viewMap.get("prv_agree2")).equals("Y") ){
			%>
			$("#prv_agree2_1").prop("checked","checked");
			<%
			}else{
			%>
			$("#prv_agree2_2").prop("checked","checked");
			<%
			}
			%>	
			
			<%
			if( ((String)viewMap.get("prv_agree3")).equals("Y") ){
			%>
			$("#prv_agree3_1").prop("checked","checked");
			<%
			}else{
			%>
			$("#prv_agree3_2").prop("checked","checked");
			<%
			}
			%>
			
			<%
			if( ((String)viewMap.get("prv_agree4")).equals("Y") ){
			%>
			$("#prv_agree4_1").prop("checked","checked");
			<%
			}else{
			%>
			$("#prv_agree4_2").prop("checked","checked");
			<%
			}
			%>			
				
		<%
		}
		
		%>
		
		refreshsubGrid();	
		
});

function chgpass($this){
	var _value = $this.val();
	if(_value!=""){
	$("#passwd").parent("td").prev().html("현재 비밀번호<span class='pOrg'>*</span>");
	$("#new_passwd").parent("td").prev().html("변경 비밀번호<span class='pOrg'>*</span>");
	$("#new_passwd1").parent("td").prev().html("변경 비밀번호 확인<span class='pOrg'>*</span>");
	}else{
		$("#passwd").parent("td").prev().text("현재 비밀번호");
		$("#new_passwd").parent("td").prev().text("변경 비밀번호");		
		$("#new_passwd1").parent("td").prev().text("변경 비밀번호 확인");		
	}
}

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
	qual_nm.push(cellvalue);
	var url ="";
	url = "<select name='qual_nm' id='qual_nm"+options.rowId+"'><option value=''>선택없음</option>"+"<%=(String)rtn_Map.get("certcd")%>"+"</selecd>";
    return url;
}

//취득일
function acq_ymd(cellvalue, options, rowObject) {
	var url ='<div class="item iDate">';
	url += '<input type="text" name="acq_ymd" id="acq_ymd'+options.rowId+'" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();"  style="width:80px;" class="fL in" value="'+cellvalue+'" />';
	url += '<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById(\'acq_ymd'+options.rowId+'\'));return false;"></a></span>';
	url += '</div>';
    return url;
}


//비고
function qual_desc(cellvalue, options, rowObject) {
	if(cellvalue==null){
		cellvalue="";
	}
	var url ="";
	url = "<input type='text' name='qual_desc' id='qual_desc"+options.rowId+"' maxlength='200' class='fL' value='"+cellvalue+"'/>";
    return url;
}

//자격정보
function refreshsubGrid(){
	var _frm = document.cffrm;
	_frm.action='<%=RequestURL%>';
	var params = com.frm.getParamJSON(document.cffrm);
	params.pstate = 'X2';
	com.grid.reload('#jqGrid1','/cmsajax.do',params);
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


</script>

<body>
<form name="cffrm" id="cffrm" method="post" onSubmit='return false;Go_search();' >        
<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
<input type="hidden" name="pstate" id="pstate" value="" title="페이지상태"  />
<input type="hidden" name="org_cd" id="org_cd" value="" title="선택된인덱스" />
<input type="hidden" name="JobJSONDataList" id="JobJSONDataList" title="선택된인덱스" />
<input type="hidden" name="CertJSONDataList" id="CertJSONDataList" title="선택된인덱스" />
<input type="hidden" name="emp_seqno" id="emp_seqno" value="<%=CM_Util.nullToEmpty((String)viewMap.get("emp_seqno"))%>" />
<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>개인정보변경</h1>
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
		        		<select name="org" id="org" onchange="optionGroup($(this), 1)" disabled="disabled" title="조직정보 선택">
		        		<option value=''>선택없음</option>
		        		<%=(String)rtn_Map.get("org_option")%>
		        		</select>
		        	</td>
		      	</tr>
		      
		      	<tr>
		        	<th scope="row">이름<span class="pOrg">*</span></th>
		        	<td>
		            	<input type="text" name="emp_nm" id="emp_nm" maxlength="50" title="" class="fL in" value="<%=CM_Util.nullToEmpty((String)viewMap.get("user_nm"))%>" />
		       		</td>
		       
		         	<th scope="row">사번<span class="pOrg"></span></th>
		        	<td cospan="5">
		            <input type="text" name="emp_id" id="emp_id" maxlength="9" title="" class="fL in" readonly="readonly" value="<%=CM_Util.nullToEmpty((String)viewMap.get("user_id"))%>" />
		       		</td>
		       </tr>
		         
		       <tr>
		         	<th scope="row">입사일</th>
		        	<td>
		        	<div class="item iDate">
		            	<input type="text" name="entcomp" id="entcomp" onblur="is_valid_date(this);" onkeyup="maskCal();" onfocus="this.select();" class="fL" value="<%=CM_Util.nullToEmpty((String)viewMap.get("outcomp_ymd"))%>"/> 
		            	<span class="btnIc_calendar"><a href="#" onclick="Calendar_D(document.getElementById('entcomp'));return false;"></a></span>  
		         	</div>
		       		</td>  
		        	<th scope="row">직급</th>
		        	<td>
		        		<select name="now_jobgrd_cd" id="now_jobgrd_cd" title="직급선택">
		        		<option value=''>선택없음</option>
		         		<%=(String)rtn_Map.get("jobcd")%>
		        		</select>
		        	</td>       
		            <th scope="row">학력</th>
		        	<td cospan="3">
		        		<select name="acadabt_cd" id="acadabt_cd" title="학력선택">
		        		<option value=''>선택없음</option>
		        	 	<%=(String)rtn_Map.get("acadabt")%>
		        		</select>
		        	</td>                 
		      </tr>
		      <tr>
		          	<th scope="row">현재 비밀번호<span class="pOrg"></span></th>
		        	<td>
		            	<input type="password" name="login_passwd" id="login_passwd" maxlength="20" class="fL in" onkeyup="chgpass($(this));" />
		       		</td> 
		            <th scope="row">변경 비밀번호<span class="pOrg"></span></th>
		        	<td>
		            	<input type="password" name="new_passwd" id="new_passwd" maxlength="20" title="" class="fL in" value="" />
		       		</td> 
		            <th scope="row">변경 비밀번호 확인<span class="pOrg"></span></th>
		        	<td  cospan="3">
		            	<input type="password" name="new_passwd1" id="new_passwd1" maxlength="20" title="" class="fL in" value="" />
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
		 <span class="btn_pack large" id="btn_save"><a href="#none;" >수정</a></span>
		 <span class="btn_pack largeG" id="btn_close"><a href="#none;">닫기</a></span>
		 </div>
  </div>
</div>


</form>
</body>
</html>
