<%--
/*=================================================================================*/
/* 시스템            : 공통
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/mtm/jicm_mtm_010_p1
/* 프로그램 이름     : jicm_mtm_010_p1    
/* 소스파일 이름     : jicm_mtm_010_p1.jsp
/* 설명              : 공통 - 파일업로드 공통팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-22
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2015-04-22
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@page pageEncoding="utf-8"%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%><!-- 공통 jsp 파일-->
<%@include file="/WEB-INF/jsp/cmsadmin/cm/Cmheader.jsp"%>

<% 
	String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
	String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
	String dto_FUN_FN = HtmlTag.returnString((String)request.getAttribute("dto_FUN_FN"),"");
	String rpcode = HtmlTag.returnString((String)request.getAttribute("rpcode"),"");
	String iuploadseq = HtmlTag.returnString((String)request.getAttribute("iuploadseq"),"");
	String ifilegroup = HtmlTag.returnString((String)request.getAttribute("ifilegroup"),"");
	String ikey_datas = HtmlTag.returnString((String)request.getAttribute("ikey_datas"),"");
	
	//수정모드구분 - 값이없으면 수정모드
	String updatemode = HtmlTag.returnString((String)request.getAttribute("updatemode"),"U");

%>
<script type="text/javascript" src="<%=con_root%>/js/jquery.form.min.js"  charset="utf-8"></script>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>	
<script type="text/javascript">

$(function(){
	
	//init file
	var file1 = $.fn.cmfile.init({
		 id				: 'cmfile' 
		 ,onClickNamefn	: "fileNameClick"
		 ,img_url 		: "<%=img_url%>"
		 ,uploadcnt		: <%=uploadcnt%>
		 ,extchk		: ['GIF','JPG','BMP','PNG','HWP','XLS','XLSX','ZIP','PDF','TIF','DOC','DOCX','PPT','PPTX','TXT']
		 ,dismode		: "p"
		 ,updatemode	: "<%=updatemode%>"
	});
	
	//확인버튼
	$("#btn_confirm").click(function(e){
		var gridArr = new Array();
		gridArr.push(new Array());
		gridArr.push(new Array());
		gridArr.push(new Array());	
		var fileobj_id = $.fn.cmfile.getfileOpt("cmfile", "id");
		
		//삭제후 확인시 - 파일첨부없이 확인 - 주석처리함 kss 2015.07.13
		//alert("file list size::"+$("#"+fileobj_id+"_FILE_LIST > option").length);
		//if($("#"+fileobj_id+"_FILE_LIST > option").length==0){
		//	alert("파일을 등록하세요");
		//	return;
		//}
		
		// 파일명을 정리해서 넣는다
		$("#filenms").val($.fn.cmfile.getfileliststr("cmfile"));
		//return;
		
		CmopenLoading();
		$("#pstate").val("PX1");
		var params = jQuery("#listfrm").serialize();
		
		jQuery("#listfrm").ajaxSubmit({
	          type: "post",
	          url: "/cmsajax.do",
	          data: params,
	          dataType:"json",			    	  
	    	  beforeSubmit:function(data,form,option){
	    		  ////console.log('33333');
	    		  return true;
	    	  // 성공시
	    	  },success: function(data){
	    		  setTimeout(CmcloseLoading,500);
	               if(data.result==true){
		                alert('저장 되었습니다.');
		                //$("#btn_list").trigger("click");
		                //console.log(data.rtn_fileseqlist.length);
		                gridArr[0].push(data.rtn_fileseqlist);
		                gridArr[1].push(data.rtn_filenmlist);
		    			//var r = {};
		    			//var val = "";
		    			//var i=0;
		    			//var fileseqlist_sp = gridArr[0].split(",");
		    			//var filenmlist_sp = gridArr[1].split(",");
		                //gridArr[0].push(fileseqlist_sp);
		                //gridArr[1].push(filenmlist_sp);
		                //console.log(data.rtn_filehtmlarra);
		                //var obj_htmlarr = StrreplaceAll(data.rtn_filehtmlarra,"\\","");
		                //var obj_html = eval(data.rtn_filehtmlarra)
		                //console.log(obj_htmlarr);
		                
		    			/*for(i=0;i<data.rtn_fileseqlist.length;i++){
		    				var vo = new Object(); 
		    				vo.file_seqno=data.rtn_fileseqlist[i];
		    				vo.file_nm=data.rtn_filenmlist[i];
		    				r[i] = vo;
		    			}*/
         
		                //console.log(data.rtn_filehtmlarra.length+":::"+data.rtn_filehtmlarra[0]['file_seqno']);
		    			//alert(data.rtn_filehtmlarra.length+"::"+data.rtn_filehtmlarra[0].length);
		    			gridArr[2].push(data.rtn_filehtmlarra);
		        		opener.<%=dto_FUN_FN%>(gridArr);
		        		//alert('11');
		        		self.close();		                
		           }else{
		            	alert(data.TRS_MSG);
		            	self.close();
		           }
	               //self.close();
	          // 실패시  
	    	  },error: function(request, status,error){
	    		  setTimeout(CmcloseLoading,500);
	    		  alert('전송에러입니다.'+error);
	    	  }
	      });
	    

	    

	    
	});
	
	//닫기
	$("#btn_close").click(function(e){
		
		self.close();
		
	});
	
	refreshFiles();
	
});

//조회 : 파일 조회
function refreshFiles(){

	if($("#iuploadseq").val()!=""){
		CmopenLoading();
		$("#pstate").val("X");
		
		var params =  jQuery("form[name=listfrm]").serialize();
		
			 $.ajax({
	             type: "post",
	             url: "/cmsajax.do",
	             data: params,
	             async: false,
	             dataType:"json",
	             success: function(data){
	            	setTimeout(CmcloseLoading,500);
					if(data.rows!= ""){
						$.fn.cmfile.setfileList("cmfile", data.rows);
						//console.log("data.rows:=="+data.rows);
					}else{
						//파일이 없는경우 자동적으로 닮힘 - 주석처리함 kss 2015.07.13
		            	//alert('파일정보를 불러오지 못했습니다.');
		            	//self.close();
					}	            	 

	               	$("#pstate").val("PF1");
	               
	             }
	    	});		
	
	}

}



</script>
<body>
<form id="listfrm"  name="listfrm" method="post" enctype="multipart/form-data" onSubmit='return false;' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="dto_FUN_FN" value="<%=dto_FUN_FN%>" title="리턴될 함수명"  />
	<input type="hidden" name="rpcode" id="rpcode" value="<%=rpcode%>" />
	<input type="hidden" name="filenms" id="filenms" value="" style="width:80%"/>

	<!-- Layer Popup -->
	<div id="popup" class="pop">
		<h1><span>&#8226;</span>파일 업로드</h1>
		<div class="desc">
	    <div class="searchArea">
		  <table class="tbl_search">
		    <colgroup>
		    <col width="50" />
		    <col width="120" />
		    <col width="60" />
		    <col width="90" />
		    <col width="*" />
		    </colgroup>
		    <tr>
		      <th scope="row" colspan=""><span>&#8226;</span>첨부파일</th>
		    </tr>
		    <tr>
		      <td colspan="5"><div id="cmfile"></div>
			  </td>
		    </tr>
		  </table>
	  	</div>
		</div>
	    <div class="btn">
      <% if(updatemode.equals("U")){ %>
   	  	<span class="btn_pack large"><a href="#" id="btn_confirm" >확인</a></span>
   	  <% } else { %>
   	  <% } %>
		<span class="btn_pack largeG"><a href="#" id="btn_close">닫기</a></span>
		</div>
	</div>
	<div id="pageLoading" style="position:absolute;width:100%;height:100%;top:0%;left:0%;z-index:9999;display:none;"></div>
	<input type="hidden" name="iuploadseq" id="iuploadseq" value="<%=iuploadseq%>" />
	<input type="hidden" name="ifilegroup" id="ifilegroup" value="<%=ifilegroup%>" />
	<input type="hidden" name="ikey_datas" id="ikey_datas" value="<%=ikey_datas%>" />
	
	<!-- 파일상세보기 추가함 - kss 2015.07.13 -->
	<iframe name ="successIframe" id="successIframe" width="0" height="0" title="결과처리프레임" style="display:none;"></iframe>  
	
</form>
</body>
</html>
