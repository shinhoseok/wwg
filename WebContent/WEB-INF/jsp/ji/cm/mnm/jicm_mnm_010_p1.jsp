<%--
/*=================================================================================*/
/* 시스템            : JRCMS 공통
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/mnm/jicm_mnm_010_p1
/* 프로그램 이름     : jicm_mnm_010_p1    
/* 소스파일 이름     : jicm_mnm_010_p1.jsp
/* 설명              : 공통 메뉴선택 팝업
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2015-04-27
/* 최근 수정자       : cys
/* 최근 수정일시     : 2018-04-04
/* 최종 수정내용     : 수정
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
	String multi_yn = HtmlTag.returnString((String)request.getAttribute("multi_yn"),"Y");
	String check_yn = HtmlTag.returnString((String)request.getAttribute("check_yn"),"Y");
%>
<script language="javascript" src="<%=con_root%>/js/com-tree.js"></script>
<script type="text/javascript">

$(function(){
	// 조직트리
	var cmtreeval = new Array();

	//init tree
	$.fn.cmtree({
		 id			: '#cmtree_data' 
		 ,treeAreaId : "#treeArea"
		 ,treeMenuId : "#treeMenu"
		 ,treeHeight : "440px"
		 ,treeWidth  : "430px"
		 ,treemHeight : "402px"
		 ,treemWidth : "390px"	 
		 <%
		 if(check_yn.equals("Y")){
		 %>
		 ,checkBoxYn: true
		 <%
		 }else{
		 %>
		 ,checkBoxYn: false
		 <%
		 }
		 %>		 
		 ,treeArr   : cmtreeval
		 ,onClickTitlefn: "treeClickTitle"
		 ,treeRelComboId : ""
		 ,treeRelComboboxId : ""
	});

	refreshTree();//트리조회
	
	$("#btn_search").click( function() {
		if(getLength($("#stext").val()) < 4){
			alert("검색어는 한글2자 영문4자이상 입력해주세요.");
			return;
		} 
		$.fn.cmtree.searchTree($("#sty").val(), $("#stext").val());
	});
	
	//확정버튼
	$("#btn_confirm").click(function(e){
		var rtnArr = $.fn.cmtree.chkTreeArr();
		//var rtnArr_valstr = rtnArr[0].join(',');
		//var rtnArr_textstr = rtnArr[1].join(',');
		//alert(rtnArr_valstr+"----"+rtnArr_textstr);
		if(rtnArr[0].length<1){
			alert("선택된 메뉴가 없습니다.");
			return;
		}		
		 <%
		 if(!multi_yn.equals("Y")){
		 %>		
			if(rtnArr[0].length>1){
				alert("메뉴를 한개만 선택해 주세요.");
				return;
			}
		 <%
		 }
		 %>
		opener.<%=dto_FUN_FN%>(rtnArr);
		self.close();
	    
	});
	
	//닫기
	$("#btn_close").click(function(e){
		self.close();
	});
	
});

//조회 : 트리조회
function refreshTree(){
	//alert('refreshTree');
	$("#pstate").val("MENUTREE");
	var params =  $("form[name=listfrm]").serialize();
	//var params = jQuery('form').serialize();
	//var params = com.frm.getParamJSON(document.listfrm);
	//alert(params);
	$.fn.cmtree.reload('#cmtree_data','/cmsajax.do',params);
}

//로딩 보이기
function openLoading(){
	$("#pageLoading").show();
}
//로딩 보이기
function closeLoading(){
	$("#pageLoading").hide();
}

function treeClickTitle(rtnArr){
	//0: TREE_SEQ, 1: TREE_CD, 2: TREE_NM, 3:TREE_UPPO_CD, 4: TREE_LEVEL, 5: TREE_NMS, 6: TREE_CDS, 7: TREE_SUB_CNT
	$.fn.cmtree.selTreeParentAll(rtnArr[1], rtnArr[4]);//조직트리 해당 조직으로 선택
}

</script>

<form id="listfrm"  name="listfrm" method="post" onSubmit='return false;Go_search();' >        
	<input type="hidden" name="scode" id="scode" value="<%=scode%>" title="사이트코드" />
	<input type="hidden" name="pcode" id="pcode" value="<%=pcode%>" title="페이지코드"  />
	<input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태"  />
	<input type="hidden" name="curr_page" id="curr_page" value="<%=curr_page%>" title="현재페이지번호"  />
	<input type="hidden" name="show_rows" id="show_rows" value="<%=show_rows%>" title="현재페이지당데이터수"  />
	<input type="hidden" name="sidx" id="sidx" value="" title="선택된인덱스" />
	<input type="hidden" name="JSONDataList" id="JSONDataList" value="" title="그리드데이터리스트" />
	<input type="hidden" name="delkey" id="delkey" value="" />
	<input type="hidden" name="dto_FUN_FN" value="<%=dto_FUN_FN%>" title="리턴될 함수명"  />
 
<!-- Layer Popup -->
<div id="popup" class="pop">
	<h1><span>&#8226;</span>메뉴 선택</h1>
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
	      <th scope="row">구분</th>
	      <td>	      	<select id="sty" name="sty" style="width:100px;" title="검색구분">
	          <option value="">---- 전체 ----</option>
	          <option value="nm">메뉴명</option>
	          <option value="cd">메뉴코드</option>
	        </select>
		  </td>
	      <th scope="row">검색어</th>
	      <td>	      	<input type="text" id="stext"  name="stext" maxlength="100" title="" style="width:100px;" class="fL" value="" />
	      </td>
	      <td>	      	<span class="btn_pack large mT5 fR "><a href="#" id="btn_search">검색</a></span>
	      </td>	      
	    </tr>
	  </table>
  	  
	</div>
    <div class="section mT10" style="height:460px;">
				<!-- 트리 영역 -->
				<div class="treeArea" id="treeArea">
					<p class="tit round">메뉴 TREE</p>
					<div class="treeMenu round fL mR10" id="treeMenu">
						<ul id="cmtree_data">
						</ul>
					</div>
				</div>
      </div>
    </div>
	<div class="btn">		<span class="btn_pack large"><a href="#" id="btn_confirm" >확인</a></span> 
		<span class="btn_pack largeG"><a href="#" id="btn_close">닫기</a></span>
	</div>
</div>
</form>
