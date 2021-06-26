<%--
/*=================================================================================*/
/* 시스템            : 포탈시스템
/* 프로그램 아이디   : /WEB-INF/jsp/ji/cm/tsr/jicm_tsr_010_s1.jsp
/* 프로그램 이름     : jicm_tsr_010_s1
/* 소스파일 이름     : jicm_tsr_010_s1.jsp
/* 설명              : 통합검색 > 통합검색 목록
/* 버전              : 1.0.0
/* 최초 작성자       : shkim
/* 최초 작성일자     : 2018-05-03
/* 최근 수정자       : shkim
/* 최근 수정일시     : 2018-05-03
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONSerializer"%>
<%@page import="java.util.Map.Entry"%>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>
<script language="javascript" src="<%=con_root%>/js/com-file.js"></script>

<%
String [][] Collections = new String[][]{{"fit_data","맞춤데이터제공","N","0"}
							,{"idea","아이디어 제안","N","0"}
							,{"notice","공지사항","N","0"}
							,{"bic_data","빅데이터 NEWS","N","0"}
							,{"board","자유게시판","N","0"}
							,{"reference","자료실","N","0"}
							,{"faq","FAQ","N","0"}
							,{"qna","Q&A","N","0"}
							};
LinkedHashMap searchRmap = new LinkedHashMap();
String collection = HtmlTag.returnString((String)request.getAttribute("collection"),"");

String curr_page = HtmlTag.returnString((String)request.getAttribute("curr_page"),"1");
String show_rows = HtmlTag.returnString((String)request.getAttribute("show_rows"),"10");
String sidx = HtmlTag.returnString((String)request.getAttribute("sidx"),"0");
String secretEx = HtmlTag.returnString((String)request.getAttribute("secretEx"),"N");

searchRmap = (LinkedHashMap)rtn_Map.get("searchR");

	JSONArray jsonArray;
	JSONArray jsonArray2;
	JSONSerializer jsonserial = new JSONSerializer();
	JSONObject jsonobj;
	JSONObject jsonRowobj;
	JSONObject jsonRowobj2;
	JSONObject jsonRowobj3;
	JSONObject jsonRowobj4;
	Map jsonRowMap = new HashMap();
	Iterator iterator;
	

	int i = 0;
	int j = 0;
	int curidx = 0;
	int totSearchCnt = 0;
	String curCollection = "";
	String prev_group = "";
	

	
	
%>
<%--="searchRmap::"+searchRmap --%>
<%
try{
	jsonobj = JSONObject.fromObject(JSONSerializer.toJSON((String) searchRmap.get("json")));
	jsonArray = (JSONArray)((JSONObject)jsonobj.get("SearchQueryResult")).get("Collection");
	//out.print("Collection==>"+jsonArray);
	
	
	// Collection for 시작
	for(i=0;i<jsonArray.size();i++){
		// 각 컬렉션정보
		//out.println(i+"::===>"+((Object)jsonArray.get(i)).getClass().getName()+"<br />");
		jsonRowobj = (JSONObject)jsonArray.get(i);
		%>
		<!-- <br />
		DocumentSet Id:<%=jsonRowobj.get("Id") %><br /> -->
		<%		
		// 현재 DocumentSet 어떤컬렉션인지 판단한다
		for(j=0;j<Collections.length;j++){
			if(((String)jsonRowobj.get("Id")).equals(Collections[j][0]+"_cnt")){
				if(collection.equals("")){
					Collections[j][2]="Y";
				}else{
					Collections[j][2]="N";
				}
				
				curCollection = Collections[j][0];
				curidx = j;
				//out.println(i+"::===>"+((Object)jsonRowobj.get("DocumentSet")).getClass().getName()+"<br />");
				jsonRowobj2 = (JSONObject)jsonRowobj.get("DocumentSet");

				Collections[curidx][3]=(String)jsonRowobj2.get("TotalCount");
				totSearchCnt = totSearchCnt+Integer.parseInt((String)jsonRowobj2.get("TotalCount"));				
				%>
				<!-- <br />
				curCollection:<%=curCollection %><br />
				curCollection cnt:<%=Collections[curidx][3] %>:::<%=jsonRowobj2.get("TotalCount") %><br /> -->
				<%				
				break;
			}
		}		

		
	}// Collection for 종료



%>

<form action="<%=RequestURL%>" id="searchFrm" name="searchFrm" method="post">
    <input type="hidden" name="scode"  id="scode" value="<%=scode%>" title="사이트코드" />
    <input type="hidden" name="pcode"  id="pcode" value="<%=pcode%>" title="페이지코드" />
    <input type="hidden" name="pstate" id="pstate" value="<%=pstate%>" title="페이지상태" />
    <input type="hidden" name="ifrm_rcept_no" title="맞춤데이터키" />  <!-- 맞춤데이터 키값 -->
    <input type="hidden" name="sGbOption" id="sGbOption" title="맞춤데이터검색조건" />  <!-- 맞춤데이터 검색조건 -->
    <input type="hidden" name="sKeyWord" id="sKeyWord" title="맞춤데이터검색어" />  <!-- 맞춤데이터 검색어 -->
    <input type="hidden" name="othbc_yn" id="othbc_yn" title="맞춤데이터비밀여부" />  <!-- 맞춤데이터 비밀여부 -->
    <input type="hidden" name="reg_id" id="reg_id" title="맞춤데이터등록자아이디" />  <!-- 맞춤데이터 등록자아이디 -->
    <input type="hidden" name="idea_propse_sn" title="오픈포탈키" />  <!-- 오픈포탈키값 -->
    <input type="hidden" name="se_text" id="se_text" title="공통게시판검색조건" />  <!-- 공통게시판 검색조건 -->
    <input type="hidden" name="se_field" id="se_field" title="공통게시판검색어" />  <!-- 공통게시판 검색어 -->
    <input type="hidden" name="sidx" title="키값" />  <!-- 공통게시판 키값명 -->
    <input type="hidden" name="boardTy" id="boardTy" title="키값" />  <!-- 공통게시판 구분값 -->
    <input type="hidden" name="collection" id="collection" title="통합검색컬렉션" value="<c:out value='${R_MAP.param.collection}'/>" />  <!-- 통합검색컬렉션 -->
    <input type="hidden" name="listCount" id="listCount" title="통합검색화면에 보여줄 개수" value="<c:out value='${R_MAP.param.listCount}'/>" />  <!-- 화면에 보여줄 개수 -->
    <input type="hidden" name="startCount" id="startCount" title="시작번호" value="<c:out value='${R_MAP.param.startCount}'/>" />  <!-- 시작번호 -->
    <input type="hidden" name="curr_page" id="curr_page" title="시작번호" value="<c:out value='${R_MAP.param.curr_page}'/>" />
    
    <input type="hidden" name="prevsearchText" id="prevsearchText" title="이전검색어" value="" />

	<h5 class="main_title">
		<strong><%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%></strong>
		<p class="copy">전력데이터 개방 포털시스템 <%=M_PATH_STR.substring(M_PATH_STR.lastIndexOf("::")+2)%>입니다.</p>
	</h5>

    <!--search-->
    <div class="search_total">
        <fieldset>
            <legend>통합검색</legend>
            <div class="box">
            	<div class="box_inner">
            		<div class="search_t">
		                <span class="selct_wrap" id="search_area_sel">
		                    <select id="searchField" name="searchField" title="검색조건 선택" onchange="searchFieldChg();return false;" style="width:100%;">
		                        <option value="TITLE,CONTENT,ATTACH,FILE_NAME,REG_NM" <c:if test="${R_MAP.param.searchField=='TITLE,CONTENT,ATTACH,FILE_NAME,REG_NM' || R_MAP.param.searchField==''}">selected="selected"</c:if>>전체</option>
		                        <option value="TITLE" <c:if test="${R_MAP.param.searchField=='TITLE'}">selected="selected"</c:if>>제목</option>
		                        <option value="CONTENT" <c:if test="${R_MAP.param.searchField=='CONTENT'}">selected="selected"</c:if>>내용</option>
		                        <option value="ATTACH" <c:if test="${R_MAP.param.searchField=='ATTACH'}">selected="selected"</c:if>>파일내용</option>
		                        <option value="FILE_NAME" <c:if test="${R_MAP.param.searchField=='FILE_NAME'}">selected="selected"</c:if>>파일명</option>
		                        
		                    </select>
		                </span> 
		                <input type="text" class="ime_mode" name="searchText" id="searchText" maxlength="100" value="<c:out value='${R_MAP.param.searchText}'/>" title="검색어 입력" placeholder="검색어를 입력하세요"  />
		                <button  class="search_btn" id="searchBtn">검색</button>
		              </div>
	                <span class="search_check" style="margin-left:10px;margin-top:10px;font-size:1.2em;font-weight:600;display:inline-block;"><input type="checkbox" name="secretEx" id="secretEx" value="Y" style="margin-left:10px;width:1.5em;height:1.5em;" <c:if test="${R_MAP.param.secretEx=='Y'}">checked</c:if> onclick="secretExClick();return false;" /> 비공개포함</span>
	             </div>
                
            </div>
<!-- 
            <div class="recent">
                <div class="rec_in">
                    <strong>최근검색어</strong>
                    <ul>
                        <li>전력통계</li>
                    </ul>
                </div>
            </div>
-->
        </fieldset>
        <div class="search_result">
            <strong>검색결과 : 키워드 <b class="fc_1">'<c:out value='${R_MAP.param.searchText}'/>'</b>에 대한 내용이 <b class="fc_1"><%=totSearchCnt %></b>건 검색되었습니다.</strong>
            <ul class="detail">
				<%		
				// 현재 DocumentSet 컬렉션별 카운트를 출력한다
				for(j=0;j<Collections.length;j++){
					// 컬렉션이 선택되지않은경우에는 페이지내에서 이동
					if(collection.equals("")){					
				%>
				<li><a href="#tsr<%=(j<10?"0"+j:j)%>"><%=Collections[j][1] %><span class="fc_0">(<%=Collections[j][3] %>)</span></a></li>
				<%
					// 컬렉션이 선택된경우 해당 상세화면으로 이동
					}else{
						if(Integer.parseInt(Collections[j][3]) > 0){
					
				%>
				<li><a href="#" onclick="searchlist('<%=Collections[j][0] %>');return false;" ><%=Collections[j][1] %><span class="fc_0">(<%=Collections[j][3] %>)</span></a></li>
				<%
						}else{
				%>
				<li><a href="#" onclick="alert('검색데이터가 없습니다.');return false;" ><%=Collections[j][1] %><span class="fc_0">(<%=Collections[j][3] %>)</span></a></li>
				<%							
						}
					}
				}
				%>            
            </ul>
        </div>
    </div>
    <!--//search-->

	<%
	prev_group = "";
	
	if(jsonArray.size()>0){
		// Collection for 시작
		for(i=0;i<jsonArray.size();i++){
			// 각 컬렉션정보
			//out.println(i+"::===>"+((Object)jsonArray.get(i)).getClass().getName()+"<br />");
			jsonRowobj = (JSONObject)jsonArray.get(i);
			curCollection = "";

			// 현재 DocumentSet 어떤컬렉션인지 판단한다
			for(j=0;j<Collections.length;j++){
				if(Collections[j][0].equals((String)jsonRowobj.get("Id")) && ((String)jsonRowobj.get("Id")).indexOf("_cnt") < 0){
					curCollection = Collections[j][0];
					curidx = j;
					break;
				}
			}		
			
			if(!curCollection.equals("")){
				%>
				<!-- <br />
				curCollection:<%=curCollection %><br /> -->
			
				<%		
				//out.println(i+"::===>"+((Object)jsonRowobj.get("DocumentSet")).getClass().getName()+"<br />");
				jsonRowobj2 = (JSONObject)jsonRowobj.get("DocumentSet");
	
				Collections[curidx][3]=(String)jsonRowobj2.get("TotalCount");
				totSearchCnt = totSearchCnt+Integer.parseInt((String)jsonRowobj2.get("TotalCount"));
	
				//out.println(i+"::===>"+((Object)jsonRowobj2.get("Document")).getClass().getName()+"<br />");
				jsonArray2 = (JSONArray)(jsonRowobj2.get("Document"));
				//out.println(i+": jsonArray2 :===>"+jsonArray2+"<br />");
				if(Integer.parseInt((String)jsonRowobj2.get("TotalCount")) > 0){
				%>
				<div id="tsr<%=(i<10?"0"+i:i) %>" class="board_A0_L mat_30" style="overflow:hidden"><!-- style="border-bottom:1px solid #b4b4b4;" -->
			    <h5 class="sub_title mab_10"><%=Collections[curidx][1] %>
			    <%
					// 컬렉션이 선택되지않은경우만 더보기 버튼을 보여준다
					if(collection.equals("")){			    
			    %>
			    <span class="right_txt"><a href="#" onclick="searchlist('<%=Collections[curidx][0] %>');return false;" class="btn_3 size_t">더보기</a></span>
			    <%
					}
			    %>
			    </h5>
			    <div class="TB_scroll">
				<table summary="<%=Collections[curidx][1] %> 목록이며 번호, 제목, 첨부파일, 작성자, 작성일을 제공하고 제목 링크를 통해 상세페이지로 이동합니다." style="border-collapse:separate;">
					<caption><%=Collections[curidx][1] %> 목록-번호,검색결과,작성일</caption>
					<colgroup>
		                <col width="100" />
		                <col width="*" />
		                <col width="200" />
					</colgroup>
					<thead>
		                <tr >
		                    <th scope="col" class="resp">번호</th>
		                    <th scope="col">검색결과</th>
		                    <th scope="col">작성일</th>
		                </tr>
					</thead>
					<tbody>			
				<%
				
	
				for(j=0;j<jsonArray2.size();j++){
					jsonRowobj3 = (JSONObject)jsonArray2.get(j);
					jsonRowobj4 = (JSONObject)jsonRowobj3.get("Field");
					iterator = jsonRowobj4.entrySet().iterator();
					jsonRowMap = new HashMap();
					  while (iterator.hasNext()) {
						   Entry entry = (Entry)iterator.next();
						   //entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonRowobj3.get(entry.getKey()))
						  
							//out.println(i+":"+j+":===>"+CM_Util.nullToEmpty((String)jsonRowobj3.get(entry.getKey()))+"<br />");
							jsonRowMap.put(entry.getKey().toString().toLowerCase(),CM_Util.nullToEmpty((String)jsonRowobj4.get(entry.getKey())));
						   //out.println(i+":"+j+":"+entry.getKey().toString()+"===>"+((Object)jsonRowobj3.get(entry.getKey())).getClass().getName()+"<br />");
					  }
					 // out.println(j+": jsonArray2 :===>"+prev_group+"::::"+jsonRowobj3.get("CollectionId")+"<br />");  
					 String MENU_CD = (jsonRowMap.get("menu_cd")==null?"":(String)jsonRowMap.get("menu_cd"));
					 String SECRET_YN = (jsonRowMap.get("secret_yn")==null?"":(String)jsonRowMap.get("secret_yn"));
					 String DOCID = (jsonRowMap.get("docid")==null?"":(String)jsonRowMap.get("docid"));
					 String REG_ID = (jsonRowMap.get("reg_id")==null?"":(String)jsonRowMap.get("reg_id"));
					 String TITLE = (jsonRowMap.get("title")==null?"":(String)jsonRowMap.get("title"));
					 String NEW_FLAG = (jsonRowMap.get("new_flag")==null?"":(String)jsonRowMap.get("new_flag"));
					 String REG_DT = (jsonRowMap.get("date")==null?"":(String)jsonRowMap.get("date"));
					 String CONTENT = (jsonRowMap.get("content")==null?"":(String)jsonRowMap.get("content"));
					 //CONTENT = CONTENT.replaceAll("\"","'").replaceAll("&lt;","<").replaceAll("&gt;",">").replaceAll("&amp;","&").replaceAll("\r\n", "<br />");
					 //CONTENT = CONTENT.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
					 //CONTENT = CONTENT.replaceAll("&lt;(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?&gt;", "");
					 CONTENT = CONTENT.replaceAll("\"","").replaceAll("'","");
					 //CONTENT = CONTENT.replaceAll("&lt;(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?&gt;", "");
					 //CONTENT = CONTENT.replaceAll("&lt;([a-zA-Z!-:]+[^>]+|[a-zA-Z!-:]+)&gt;", "");
					 CONTENT = CONTENT.replaceAll("\\&amp;lt;.*?\\&amp;gt;","'");
					 CONTENT = CONTENT.replaceAll("\\&lt;.*?\\&gt;","'");
					 CONTENT = CONTENT.replaceAll("\r\n", "<br />").replaceAll("&amp;","&").replaceAll("&amp;nbsp;"," ");
					 // 화면 크기기준 자르기 CONTENT = HtmlText.substring(CONTENT, 10);
					 // 바이트 단위로 자르기
					 CONTENT = StringUtil.strCut(CONTENT, 300);
					 if(REG_DT.length() > 8){
						 REG_DT =REG_DT.substring(0,4)+"-"+ REG_DT.substring(4,6)+"-"+ REG_DT.substring(6,8);
					 }
				%>
					<tr <%if(SECRET_YN.equals("Y")){ %>class="secret"<%} %>>
						<td class="resp"><%=(jsonArray2.size()-j) %></td>
						<td class="subject">
							<%--=jsonRowMap --%>
							<%
							if(curCollection.equals("fit_data")){
							%>
						    <a href="#" onclick="dpOutDetail('<%=MENU_CD %>', '<%=DOCID %>', '<%=SECRET_YN %>', '<%=REG_ID%>');return false;" style="font-weight:600;color:rgba(107, 183, 229, 1);"><%=TITLE %></a>
						    <%
							}else if(curCollection.equals("idea")){
							%>
							<a href="#" onclick="opOpnDetail('<%=MENU_CD %>', '<%=DOCID %>', '<%=SECRET_YN %>', '<%=REG_ID%>');return false;" style="font-weight:600;color:rgba(107, 183, 229, 1);"><%=TITLE %></a>
							<%
							}else{
								%>
								<a href="#" onclick="view('<%=MENU_CD %>', '<%=DOCID %>', '<%=SECRET_YN %>', '<%=REG_ID%>');return false;" style="font-weight:600;color:rgba(107, 183, 229, 1);"><%=TITLE %></a>
								<%						}
						    %>
						<%if(NEW_FLAG.equals("Y")){ %>
						   <span class="icon_new">새글</span>
						<%} %>
						<br />
						<%=CONTENT %>
						</td>
						<td><%=REG_DT %></td>
					</tr>			
				<%
					//if(!prev_group.equals(((String)jsonRowobj3.get("CollectionId")))){
					prev_group = curCollection;
				}
				%>
					</tbody>
				</table>
				</div>
			</div>		
			<%
				}// Collection 건수가 0이상인경우만 보여짐
			
				// 컬렉션이 선택된경우 페이징을 보여준다
				if(!collection.equals("")){
					//페이징 관련 변수설정
					String formname = "document.searchFrm";		// from 이름 ;; document.form[0];
					String action = RequestURL; 				// action
					String formele = "curr_page";
					int TotalCount = Integer.parseInt((String)jsonRowobj2.get("TotalCount"));
					int TotalPageCount = (int) Math.ceil( (double) TotalCount / ( (double) Integer.parseInt(show_rows)));
	        	      if (TotalPageCount == 0) {
	        	    	  TotalPageCount = 1;
		        	  }						
					String pagestr = CM_Util.PageindexS(TotalCount,curr_page,TotalPageCount,curr_page,formname,action,formele,img_url+"/cmsadmin");

			%>
			<!--paging-->
			<div class="paging">
		    <%=pagestr%>
		    </div>
		    <!-- //paging -->
			<%
				}
			}// 컬렉션 선택시 선택된 컬렉션만 보여지도록
		}// Collection for 종료		
	}else{
	%>
	통합검색 결과가 없습니다.
	<%
	}

} catch(NullPointerException e){
	// 통합검색오류
	totSearchCnt = 0;
	%>
	통합검색 결과가 없습니다.
	<%

} catch(ArrayIndexOutOfBoundsException e){
	
	// 통합검색오류
	totSearchCnt = 0;
	%>
	통합검색 결과가 없습니다.
	<%

}catch(Exception e){
	// 통합검색오류
	totSearchCnt = 0;
	%>
	통합검색 결과가 없습니다.
	<%
}	
%>

</form>
				<div id="searchSelBox" style="position:absolute;left:0px;top:0px;width:390px;z-index:0;background:#fff;">
					<ul id="searchSelBoxList" style="height: 162px; padding-top: 15px; padding-bottom: 15px; margin-top: 0px; margin-bottom: 0px; display: none;overflow-y:scroll;border:3px solid #ef4e4c;">
						<!-- <li><a onclick="Go_SubmenuTop(2,'000404','000121','Y');return false;" href="#">마이페이지</a></li> -->
					</ul>
				</div>
<script type="text/javascript">

$(function(){  //onload
	
    //검색버튼클릭
	$("#searchBtn").click(search);
	
	//$('#searchSelBox').css("top",$(".search_total #searchText").offset().top+"px");
	//$('#searchSelBox').css("left",$(".search_total #searchText").offset().left+"px");
	$('#searchSelBox').offset({top:$(".search_total #searchText").offset().top+$(".search_total #searchText").height()+2});
	$('#searchSelBox').offset({left:$(".search_total #searchText").offset().left});
	$('#searchSelBox').width($(".search_total #searchText").outerWidth()-50);
	
	/*$(".search_total #searchText").mouseover(function(){
		$('#searchSelBox').find("ul").stop().slideDown(100);
	});
	$('.search_total #searchText').mouseleave(function(){
		$('#searchSelBox').find("ul").stop().slideUp(100);
	});	
	*/
	
	$(".search_total #searchText").keyup(function (){
		if(isEmpty($("#searchText").val())){
			return;
		}
		
	
		if($("#prevsearchText").val()!=$("#searchText").val()){
			// 입력한 단어의 검색키워드목록 정보를 불러온다.
			$("form[name=searchFrm]").find("#pstate").val("X");
			
			var params =  $("form[name=searchFrm]").serialize();
			
			 $.ajax({
		        type: "post",
		        url: "<c:url value='/cmsajax.do'/>",
		        data: params,
		        async: false,
		        dataType:"json",
		        timeout: 3000,
		        error: function (jqXHR, textStatus, errorThrown) {
		            // 통신에 에러가 있을경우 처리할 내용(생략가능)
		        	alert("네트웍장애가 발생했습니다. 다시시도해주세요");
		        },
		        success: function(data){
				   var searchkeystr = "";
		           if(data.json != null || data.json != ""){
			        	var jsonObj = JSON.parse(data.json);
	        	   
			        	//console.log("totalcount::"+jsonObj.result[0].totalcount);
			        	//console.log("keyword::"+jsonObj.result[0].items[0].keyword);
			        	$("#searchSelBoxList").html("");
			        	if(jsonObj.responsestatus!=-1){
				        	if(jsonObj.result[0].totalcount > 0){
				        		

				        		for(var i=0;i<jsonObj.result[0].totalcount;i++ ){
				        			searchkeystr = searchkeystr +"<li onmouseover=\"$(this).css('background','#cccccc')\" onmouseout=\"$(this).css('background','#ffffff')\" ";
				        			searchkeystr = searchkeystr +"onclick=\"selkeywordset('"+jsonObj.result[0].items[i].keyword+"');return false;\" style=\"font-weight:600;\">";
				        			searchkeystr = searchkeystr +jsonObj.result[0].items[i].keyword+"</li>";
				        		}
				        		
				        		$("#searchSelBoxList").html(searchkeystr);
				        		$('#searchSelBox').find("ul").stop().slideDown(100);
				        	}else{
				        		if($('#searchSelBox').find("ul").css("display")=="none"){
				        			
				        		}else{
				        			$('#searchSelBox').find("ul").stop().slideUp(100);
				        		}
				        	
				        		
				        	}			        		
			        	}else{
			        		if($('#searchSelBox').find("ul").css("display")=="none"){
			        			
			        		}else{
			        			$('#searchSelBox').find("ul").stop().slideUp(100);
			        		}			        		
			        	}

		           }

		        }
				
			});	
			 
			 $("form[name=searchFrm]").find("#pstate").val("L");
		}
	});
	
	$("#prevsearchText").val($("#searchText").val());
	secretExClick();
});

function selkeywordset(seltext){
	$('#searchSelBox').find("ul").stop().slideUp(100);

	$("#searchText").val(seltext);
	$("#searchText").focus();
	
}

//validation 체크
function vdCheck() {
    var frm = document.searchFrm;

    $("#searchText").val($.trim($("#searchText").val()));
    
    if ($("#searchText").val()=="") {
    	alert("검색어를 입력해주세요.");
    	return false;
    }
    return true;
}

//통합검색
function search() {
	
	if (!vdCheck()) {
		return;
	}
	
	secretExClick();	
	
    var frm = document.searchFrm;
    frm.method       = "post";
    frm.pcode.value  = "000414";
    frm.pstate.value = "L";
    $("#collection").val("");
    $("#listCount").val("3");
    $("#startCount").val("0");
    $("#curr_page").val("1");
    
    frm.action       = "<%=RequestURL%>";
    frm.submit();
    frm.target = "";
}

function searchFieldChg(){
	secretExClick();
}

function secretExClick(){
	if( $('input[name=secretEx]').prop('checked')==true){
		if($("#searchField").val()!="TITLE"){
			alert("비공개포함 검색일경우는 제목에 대해서만 검색됩니다.");
		}
		$("#searchField").val("TITLE");
		$("#searchField").css("background","#cccccc");
		$("#search_area_sel").css("background","#cccccc");
		
	}else{
		$("#searchField").val("TITLE,CONTENT,ATTACH,FILE_NAME,REG_NM");
		$("#searchField").css("background","#ffffff");
		$("#search_area_sel").css("background","#ffffff");
	}
}

//더보기
function list(pcode, boardTy) {
	
	if (pcode=="000071") {  //맞춤데이터 검색어
		$("#sGbOption").val($("#searchField").val()=="title" ? "000264" : $("#searchField").val()=="cn" ? "000265" : $("#searchField").val()=="reg_nm" ? "000266" : "000263");
		$("#sKeyWord").val("<c:out value='${R_MAP.param.searchText}'/>");
	} else if (pcode=="000401") {  //오픈포탈 검색어
		$("#searchField").val($("#searchField").val()=="cn"||"title" ? "searchIdeaPropseCn" : $("#searchField").val()=="reg_nm" ? "searchRegId" : "");
		$("#searchText").val("<c:out value='${R_MAP.param.searchText}'/>");
	} else {  //공통게시판
// 		$("#se_field").val($("#searchField").val()=="title" ? "sc_title" : $("#searchField").val()=="cn" ? "sc_writer" : "");
		$("#se_text").val("<c:out value='${R_MAP.param.searchText}'/>");
	}
// 	if (boardTy!="") {
// 		$("#boardTy").val(boardTy);
// 	}
    var frm = document.searchFrm;
    frm.method       = "post";
    frm.pstate.value = "L";
    frm.pcode.value  = pcode;
    frm.action       = "<%=RequestURL%>";
    frm.submit();
    frm.target = "";
}

// 더보기 상세 전체 리스트
function searchlist(collection){
	$("form[name=searchFrm]").find('input[name=collection]').val(collection);
	$("form[name=searchFrm]").find('input[name=pcode]').val("000414");
	$("form[name=searchFrm]").find('input[name=pstate]').val("L");
	$("form[name=searchFrm]").find('input[name=listCount]').val("<%=show_rows%>");
	$("form[name=searchFrm]").find('input[name=startCount]').val("0");
	$("form[name=searchFrm]").attr("action","<%=RequestURL%>");
	$("form[name=searchFrm]").submit();
	$("form[name=searchFrm]").attr("target","");	
	
}

//맞춤데이터 상세보기
function dpOutDetail(pcode, ifrmRceptNo, othbcYn, regId) {
	//alert("othbcYn:"+othbcYn+"::아이디::<c:out value='${nUser}'/>");
	//if(othbcYn == 'N' && "<c:out value='${nUser}'/>" == 'N'){
	if("<c:out value='${nUser}'/>" == 'N'){
		if(confirm('로그인 후 사용가능합니다.\n로그인 하시겠습니까?')){
			document.location.href="/cmsmain.do?scode=S01&pcode=000253";
			return;
		}else{
			return;
		}
		
	}
	
	$("[name=pstate]").val("DFX");
	//$("#dataForm").find("#ifrm_rcept_no").val(ifrmRceptNo);
	$("#searchFrm input[name=ifrm_rcept_no]").val(ifrmRceptNo);  //맞춤데이터키값
	$("#othbc_yn").val((othbcYn=="Y"?"N":"Y"));// 검색엔진 쪽 맞춘데이터를 수정해준다
	$("#reg_id").val(regId);
	$("#pcode").val(pcode);
	
	var params = jQuery("#searchFrm").serialize();
	
	$.ajax({ type     : "post"
		   , url      : "<c:url value='/cmsajax.do'/>"
		   , data     : params
		   , async    : false
		   , dataType :"json"
		   , timeout  : 3000
		   , error    : function (jqXHR, textStatus, errorThrown) {
					// 통신에 에러가 있을경우 처리할 내용(생략가능)
					alert("네트웍장애가 발생했습니다. 다시시도해주세요");
	       }
	       , success  : function(data) {
		   				    if (data.result) {
			   				    if (othbcYn == 'Y') {
				   				    fnOpenPwLayer(ifrmRceptNo, "OUT");
			   					} else {
				   					$("#pstate").val("DF");
	    		   					$("#searchFrm").submit();
								}
		   					} else {
			   					alert(data.TRS_MSG);
		   					}
	   	   }
	});
}

//아이디어제안 상세보기
function opOpnDetail(pcode, key, othbcYn, regId) {
	if("<c:out value='${nUser}'/>" == 'N'){
		if(confirm('로그인 후 사용가능합니다.\n로그인 하시겠습니까?')){
			document.location.href="/cmsmain.do?scode=S01&pcode=000253";
			return;
		}else{
			return;
		}
		
	}	

	$("#searchFrm input[name=idea_propse_sn]").val(key);  //아이디어제안키값
	$("#pcode").val(pcode);
	fnOpenPwLayer(key, "OPEN");
}

//팝업호출후콜백함수
function fnCallBack(obj){
	if ($("#searchFrm").find("#pcode").val()=="000071") {
		$("#searchFrm").find("#pstate").val("DF");  //맞춤데이터
	} else if ($("#searchFrm").find("#pcode").val()=="000401") {
		$("#searchFrm").find("#pstate").val("R");  //아이디어제안
	} else {
	}
	
	$("#searchFrm").submit();
}

//상세 화면이동
function view(pcode, key, secretYn, regId) {
	
	//Q&A인경우 로그인 및 본인체크
	if(pcode=='000100' && secretYn=='Y'){
		if("<c:out value='${nUser}'/>" == 'N'){
			if(confirm('로그인 후 사용가능합니다.\n로그인 하시겠습니까?')){
				document.location.href="/cmsmain.do?scode=S01&pcode=000253";
				return;
			}else{
				return;
			}
		}else{
			if("<%=(String)SITE_SESSION.get("USER_ID")%>"!=regId){
				alert("비공개글은 열람하실 수 없습니다.");
				return;
			}
		}
	}
	
	
	var frm = document.searchFrm;
	frm.method = "post";
	frm.action = "<%=RequestURL%>";
	frm.pcode.value = pcode;
	$("#searchFrm input[name='sidx']").val(key);  //공통게시판키값
    frm.pstate.value = "R";
	frm.submit();
	frm.target = "";
}

//다운로드
function goDownfile(file_seqno){
    $.fn.cmfile.fileDownLoad("", file_seqno);
};

// 페이지 이동 재정의
function goPagination(form,URL,pageIndex,formele){
	eleobj = eval(form+"."+formele);
	eval(form).action=URL;
	eleobj.value=pageIndex;
	if(pageIndex==1){
		$("#startCount").val("0");
	}else{
		$("#startCount").val((parseInt(pageIndex)-1)*<%=show_rows%>);
		//alert($("#startCount").val());
	}
    
	if(eval(form).pstate!=undefined){
		eval(form).pstate.value="L";
	}
	
	eval(form).method="post";
	eval(form).submit();		
}

</script>