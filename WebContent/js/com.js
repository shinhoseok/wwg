/**================================================================================
 * @name: javascript 공통 package 
 * @author: jhlee
 * @demo: 
 * @version: 0.1.0
 * @charset: utf-8
 ================================================================================*/
this.com = this.com || (function(nav,g,$){
	if(!$){ alert("jQuery 가 없습니다. jQuery아래에 적용바랍니다.."); return; }
	//상수
	var c = {
		grid : {
			 PREFIX_PRM : "jqGrid." //grid request param name prefix
			,ROWLIST : [15,30,50] //그리드의 페이지당 보여줄 Row의 수 리스트(페이지의comboBox리스트)
			,EXCEL_FILENAME : "excelExport" //엑셀다운 파일명
		}
		,tab : {
			rootId : "#contentHiddenTab" //tab root id
		}
	};
	
	//기본설정
	var def = {
		grid : {
			//url      	: "/cmsajax.do"
			datatype	: "local"
			//,mtype   	: "POST"
 			//,postData	: getGridParamDatas(document.listfrm) //parameter
			,jsonReader	: {repeatitems:false}
			,multiselect: false //다중선택 가능여부 - 선택 row 가져오기 : $("#jqGrid").jqGrid("getGridParam","selarrrow");
			//--[column]----------------------
			//,colNames	: colNms // 컬럼명
			//,colModel	: colMds // 컬럼 세부설정
			,sortable	: true //Column Reordering : Click and hold on a column header, then drag with the mouse to another column to re-order the columns.
			//--[sort]----------------------
			//,multiSort	: true
			//,sortname	: "VALUE1 DESC, VALUE2" // 정렬할 컬럼명인데 단독 컬렴명도 되지만 좌측처럼 여러 값을 넣어도 된다. 이 값은 sidx 라는 이름으로 파라미터가 넘어간다.
			//,sortorder	: "ASC" // 정렬방식. 파라미터 명은 sord 이다.
			//--[paging]--------------------
			//,rownumbers	: true //행번호 표시
			//,rownumWidth: 10 //행번호의 width
 			//,scroll 	: 1 //set the scroll property to 1 to enable paging with scrollbar - virtual loading of record
			,showpage	: true // 페이징 true
 			//,pager	: "#jqGridPager"
			,rowNum		: 15
			,rowList	: c.grid.ROWLIST //그리드의 페이지당 보여줄 Row의 수 리스트(페이지의comboBox리스트)
			//--[style]---------------------
			//,width  	: 700
			//,height 	: 220
			,shrinkToFit: false //가로스크롤기능
			,autowidth	: true //그리드의 width 자동설정
			,shrinkToFit: true // 컬럼이 그리드 width에 맞춰 자동으로 맞춰질지 여부
			,forceFit   : false //컬럼의 width를 변화시킬때 그리드의 width를 고정 여부
			//--[text]----------------------
			//,caption	: "그리드제목" //그리드제목
			//,viewrecords: true //화면하단에 페이지설명 문구 표시
			//,recordtext	: "view {0} - {1} of {2}" //페이지설명 문구 설정
			//,emptyrecords: "등록된 게시물이 없습니다." //데이터가 없을경우 화면하단에 표시할 문구
			,ajaxGridOptions: { contentType: "application/json;charset=utf-8" }
			//--[etc]-----------------------
			,gridview   : true //그리드 검색 속도향상 -  treeGrid, subGrid, afterInsertRow(event)에는 사용할 수 없다.
			//,hiddengrid	: true //그리드 숨기기
			,prmNames	: { //customizes names of the fields sent to the server on a POST request
			    page: c.grid.PREFIX_PRM+"page"
			    ,rows: c.grid.PREFIX_PRM+"rows"
			    ,sort: c.grid.PREFIX_PRM+"sidx"
			    ,order: c.grid.PREFIX_PRM+"sord"
			    ,search: c.grid.PREFIX_PRM+"_search"
			    ,nd: c.grid.PREFIX_PRM+"nd"
			    ,id: c.grid.PREFIX_PRM+"id"
			    ,filter: c.grid.PREFIX_PRM+"filters"
			    ,searchField: c.grid.PREFIX_PRM+"searchField"
			    ,searchOper: c.grid.PREFIX_PRM+"searchOper"
			    ,searchString: c.grid.PREFIX_PRM+"searchString"
			    ,oper: c.grid.PREFIX_PRM+"oper"
			    ,query: c.grid.PREFIX_PRM+"grid"
			    ,addoper: c.grid.PREFIX_PRM+"add"
			    ,editoper: c.grid.PREFIX_PRM+"edit"
			    ,deloper: c.grid.PREFIX_PRM+"del"
			    ,excel: c.grid.PREFIX_PRM+"excel"
			    ,subgrid: c.grid.PREFIX_PRM+"subgrid"
			    ,totalrows: c.grid.PREFIX_PRM+"totalrows"
			    ,autocomplete: c.grid.PREFIX_PRM+"autocmpl"
			}
			,afterInsertRow: function(rowid, rowdata, rowelem) { // 데이터를 로드할때의 액션
				/*
				var STATUS = rowdata.STATUS;
				var color=null;
				if(STATUS=="Ready"){ color = "#ff8c00";
				} else if(STATUS=="Started"){ color = "#ffa500"; }
				$("#jqGrid").setCell(rowid, "STATUS", STATUS, { background: color }); //컬럼값에 따라 색상변경
				*/
			}
			,onSelectRow: function(id) { // row를 선택했을때 액션.
				/*
				var ret = $("#jqGrid").jqGrid("getRowData",id); // ret는 선택한 row 값을 쥐고있는 객체다.
				var value1 = ret.VALUE1; // 이런식으로 값을 가져올 수 있다.
				*/
			}
			,loadError: function(xhr,st,err) {
				
			}
			,loadComplete: function(data) {
				if(data.result!=undefined && data.ajaxSystemCode!=undefined && data.TRS_MSG!=undefined){
					if(data.ajaxSystemCode=="901"){
						alert(data.TRS_MSG);
						top.location.href=""+con_root;
					}					
				}
				/*alert("result:"+data.result
						+":ajaxSystemCode:"+data.ajaxSystemCode
						+":TRS_MSG:"+data.TRS_MSG
					 );*/
				
				
			}			
			/*,loadComplete: function(xhr,st,err) {
				//alert("st:"+st+":err:"+err);
				
			}*/
			,gridComplete: function(){
				//var recs = $("#patchParamGrid").getGridParam("records");
				//var ids = $("#patchParamGrid").jqGrid("getDataIDs");
				
				//mergeCellcomplet($(this)); 
			}
			,custom: {
				 id : null
				,cols : [] //컬럼정보 - 필수!
				,navGrid : {edit:false,add:false,del:false,search:false} //그리드 기본 버튼
				,navButton : {
					 reorderCol : { //컬럼설정
						 show : true
					}
					,excel : { //엑셀다운
						 show : false		//엑셀버튼은 화면에서 따로 구현됨 -mrkim (2015-06/24))
						,exportName	: c.grid.EXCEL_FILENAME //엑셀다운로드시 사용할 파일명
					}
				}
				,navButtonAdd : [
					/*{
						 id: "test"
						,caption: "테스트버튼"
						,title: "Test Button"
						,buttonicon: "ui-icon-disk"
						,onClickButton: function(e) {
							alert("test입니다.");
						}
					}*/
				]
			}
		}
	};
	//제공함수
	var f = {
		//package info
		info : function(){
			var r = [];
			var nm = "";
			for(var _nm in g){
				if(g[_nm]==this){ nm=_nm; break;}
			}
			//r.push("package name :: "+nm);
			var _root = g[nm];
			for(var d1 in _root){
				var path = nm+"."+d1;
				if(typeof _root[d1] === "object"){
					for(var d2 in _root[d1]){
						path = nm+"."+d1+"."+d2;
						r.push("<"+(typeof _root[d1][d2])+"> "+path+(typeof _root[d1][d2]==="string"?"value[\""+_root[d1][d2]+"\"]":""));
					}
				}else{
					r.push("<"+(typeof _root[d1])+"> "+path+(typeof _root[d1]==="string"?"value[\""+_root[d1]+"\"]":""));
				}
			}
			return r.join("\n");
		}
		//상수값을 가져온다.
		,getConst : function(constPath){
			var r = eval("c."+constPath);
			return r;
		}
		//form 관련
		,frm : {
			getParamJSON : function(frm){
				var r = {};
				$.map($(frm).serializeArray(), function(n,i){
					//var val = $("*[name='"+n["name"]+"']",$(frm)).val();
					//console.log(i+"::"+n.name+"::=="+frm.name+"==::"+val);
					
					var val = n["value"];
					//console.log(n.name+"::=="+frm.name+"==::"+val);
					//if( $.isArray(val) ){ val = val.join(","); } //배열일 경우 comma(,)구분 string으로 전달
					r[n["name"]] = val;
				});
				
				return r;
			}
			,getParamJSON2 : function(frm){
				var r = {};
				var rtn = {};
				var tmp_arr = new Array();
				$.map($(frm).serializeArray(), function(n,i){
					//var val = $("*[name='"+n["name"]+"']",$(frm)).val();
					
					
					var val = n["value"];
					//console.log(i+"::"+n.name+"::=="+frm.name+"==::"+val+":::=="+r[n["name"]]);
					//console.log(n.name+"::=="+frm.name+"==::"+val);
					//if( r[n["name"]] ){ val = val.join(","); } //배열일 경우 comma(,)구분 string으로 전달
					//console.log(i+"::"+n.name+"::=="+frm.name+"==::"+val);
					// 기존에 셋팅된 값이 없이면 단일 폼객체
					if(r[n["name"]]==undefined){
						r[n["name"]] = val;
						//console.log("11111:::::"+i+"::"+n.name+"::=="+frm.name+"==::"+val+":::=="+r[n["name"]]);
					// 아니면 배열 객체
					}else{
						// 배열이면
						if( $.isArray(r[n["name"]]) ){
							
							tmp_arr = r[n["name"]];
							tmp_arr.push(val);
							r[n["name"]] = tmp_arr;
							//console.log("222222:::::"+i+"::"+n.name+"::=="+frm.name+"==::"+val+":::=="+r[n["name"]]);
						}else{
							tmp_arr = new Array();
							tmp_arr.push(r[n["name"]]);
							tmp_arr.push(val);
							r[n["name"]] = tmp_arr;
							//console.log("333333:::::"+i+"::"+n.name+"::=="+frm.name+"==::"+val+":::=="+r[n["name"]]);
						}
						 
					}
					
					
					
				});
				
				// 배열로된 객체를 제거한다
				//var rkey = Object.keys(r); // ie9이상지원 삭제
				for(var i in r){
					if($.isArray(r[i])){
						//console.log("배열임 key==::"+rkey[i]+" == data:"+r[rkey[i]]);
					}else{
						//console.log("배열아님 key==::"+rkey[i]+" == data:"+r[rkey[i]]);
						rtn[i] = r[i];
					}
				}
				//console.log("333333:::::"+r);
				return rtn;
			}
		}
		//jqGrid 관련
		,grid : {
			//초기화
			init : function(opt){
				//ID체크
				var _grdId = opt.id||opt.custom.id;
				if(!_grdId){
					alert("[필수]Grid ID가 없습니다."); return;
				}else if($(_grdId).length==0){
					alert("[필수]Grid ID에 해당하는 Element가 없습니다."); return;
				}
				
				//컬럼설정
				if(opt.colNames && opt.colModel){
					//...nothing... 컬럼정보가 존재하면 그대로 사용
				}else{
					if(!opt.custom.cols || opt.custom.cols.length==0){
						alert("[필수]Grid Column 설정정보가 없습니다."); return;
					}else{
						//컬럼정보 매핑
						var colNm = [];
						var colMd = [];
						$.each(opt.custom.cols,function(i,o){
							colNm.push(o.label);
							colMd.push(o);
						});
						opt.colNames = colNm;
						opt.colModel = colMd;
					}
				}
				//column sorting : default false
				$.each(opt.colModel,function(i,o){
					if(o.sortable===undefined){ o.sortable=false; }
				});
				
				//페이지 element 자동추가
				//if(opt.showpage !== false){
					if(!opt.pager){
						var pagerId = $(_grdId).attr("id")+"Pager";
						$("<div id=\""+pagerId+"\" />").insertAfter($(_grdId));
						opt.pager = "#"+pagerId;
					}
				//}
				
				//jqGrid start
				var sumOpt = $.extend(true,{},def.grid, opt);
				var grd = $(_grdId).jqGrid( sumOpt );
				
				grd.jqGrid("navGrid", sumOpt.pager, sumOpt.custom.navGrid); //navGrid init
				
				//그리드 왼쪽하단의 SHOW/HIDE 버튼 추가
				if(sumOpt.custom.navButton.reorderCol.show){
					grd.jqGrid("navButtonAdd",sumOpt.pager,{
						caption: "컬럼"
						,title: "Reorder Columns"
						,buttonicon: "ui-icon-gear"
					    ,onClickButton : function (){
					    	$(this).jqGrid("columnChooser");
					    }
					});
				}
				
				//그리드 왼쪽하단의 엑셀다운 버튼 추가
				if(sumOpt.custom.navButton.excel.show){
					grd.jqGrid("navButtonAdd",sumOpt.pager,{
				        id: "pager_excel"
				        ,caption: "엑셀"
				        ,title: "Export To Excel"
				        ,buttonicon: "ui-icon-disk"
				        ,onClickButton: function(e) {
				            try {
				            	var _prefix = com.getConst("grid.PREFIX_PRM");
				            	//postData 셋팅 여부 확인
				            	var is_param = false;
				            	for(var k in $(this).jqGrid("getGridParam","postData")){
					            	if(k.indexOf(_prefix)!=0){
					            		is_param = true; break;
					            	}
				            	}
				            	if(!is_param){
				            		alert("요청정보가 설정되지 않았습니다."); return;
				            	}
				            	//컬럼정보 설정
				            	var _colId = [];
				            	var _colNm=[];
				            	$.each($(this)[0].p.colModel, function(n,o){
				            		// 엑셀 출력시 숨김항목은 제외
				            		if(false==o.hidden && o.name != "cb"){
				            			_colId.push( o.name );
				            			_colNm.push(o.label);
				            		}
				            	});
				            	
				            	var _exportParam = "excelFileName="+ ( $(this)[0].p.custom.navButton.excel.exportName||"exportList" );
//				            	_exportParam += "&colNames="+ ( ($(this)[0].p.rownumbers?" ":"") + $(this)[0].p.colNames.join(",") );
				            	_exportParam += "&colNames="+ ( ($(this)[0].p.rownumbers?" ":"") + _colNm.join(",") );
				            	_exportParam += "&colId="+ ( _colId.join(",") );
				            	$(this).jqGrid("excelExport", {
				                	oper: _prefix+"oper"
				                    ,tag: "excel"
				                    ,url:  encodeURI("/cmsmain.do?" + _exportParam) //%가있는겨우 컬럼명이 전달되지 않아서 수정 2015-05-18 by.천유정
				                });
				            } catch(e) {
				            }
				        }
				    });	
				}
				
				//그리드 왼쪽하단의 기타 버튼들 추가
				$.each(sumOpt.custom.navButtonAdd, function(i,o){
					grd.jqGrid("navButtonAdd",sumOpt.pager,o);
				});
				
				return grd;
			}
			//제거
			,unload : function(id){
				//jQuery(id).jqGrid("GridDestroy");
				jQuery(id).jqGrid("GridUnload");
			}
			//검색
			,reload : function(id, url, params){
				jQuery(id).jqGrid("clearGridData");
				//alert(id);
				//alert(url);
				//console.log(params);
				//alert("reload");
				$(id).jqGrid("setGridParam",{
					 url:url
					,datatype:"json"
					,postData:params
					,timeout: 3000
				}).trigger("reloadGrid");
			}
			//검색시 현재 페이지정보등 유지
			,reload2 : function(id, url, params){
				var cur_page = jQuery(id).jqGrid("getGridParam","page");
				//alert("cur_page:=="+cur_page)
				//alert(id);
				//alert("reload2");
				jQuery(id).jqGrid("clearGridData");
				
				$(id).jqGrid("setGridParam",{
					 url:url
					,datatype:"json"
					,page: cur_page
					,postData:params
				}).trigger("reloadGrid");
			}			
		}
		//탭 관련
		,tab : {
			_rootId : c.tab.rootId //tab root id
			//탭 초기화
			,init : function(rtId){
				f.tab.setRootId(rtId);
				var r =$(f.tab._rootId).tabs({
					add: function(e, ui) {
						// append close thingy
						$(ui.tab).parents("li:first")
							.append("<span class=\"ui-tabs-close ui-icon ui-icon-close\" title=\"Close Tab\"></span>")
							.find("span.ui-tabs-close")
							.show()
							.click(function() {
								$(f.tab._rootId).tabs("remove", $("li", $(f.tab._rootId)).index($(this).parents("li:first")[0]));
							});
						// select just added tab
						$(f.tab._rootId).tabs("select", "#" + ui.panel.id);
					}
			    });
				return r;
			}
			,setRootId : function(id){
				if($('#'+f.util._removeFirstSharp(id)).length == 0){
					f.tab._rootId = c.tab.rootId;
				}else{
					f.tab._rootId = id;
				}
			}
			//탭ID접두어
			,_getTabIdPrefix : function(){
				return ($("input[name=scode]","form[name=pagego]").val()||"a") + "-" + ($("input[name=pcode]","form[name=pagego]").val()||"b") + "-";
			}
			//탭생성
			,add : function(id,label,url){
				var tabData = {id:f.util._removeFirstSharp(id), label:label, url:url};
				
				var st = "#"+f.tab._getTabIdPrefix()+tabData.id;
				if($(st).html() != null ) { //탭이 이미 있으면 선택
					$(f.tab._rootId).tabs("select",st);
				} else { //탭이 없으면 생성
					$(f.tab._rootId).tabs("add",st, tabData.label); //탭생성
					$.ajax({ //loading
						url: tabData.url,
						type: "GET",
						async: false,
						cache: false,
						dataType: "html",
						complete : function (req, err) {
							var tmpDiv = $("<div>").html(req.responseText);
							$(st,f.tab._rootId).append(tmpDiv.html());
						}
					});
				}
			}
			//탭제거
			,remove : function(id){
				$(f.tab._rootId).tabs("remove","#"+f.tab._getTabIdPrefix()+f.util._removeFirstSharp(id));
			}
			//탭 존재여부
			,isExist : function(){
				return $(f.tab._rootId).tabs().length != 0;
			}
			//2번째 탭 교체 - 탭 2개로 고정시 사용
			,changeS : function(url){
				this.add(f.util.getUID(),"SECONDTAB",url); //탭추가
				if($(f.tab._rootId).tabs("length")>2){
					this.closeS(); //2탭제거
				}
			}
			//2번째 탭 제거 - 탭 2개로 고정시 사용
			,closeS : function(){
				$(f.tab._rootId).tabs("remove",1);
			}
		}
		//기타 유틸
		,util : {
			//브라우저 정보
			 getBrowser : function(){
				var r = { name : "???", version : -1, realVersion : -1 }; //브라우저정보
				//브라우저 체크
				var agt = nav.userAgent.toLowerCase();
				if(nav.appName=="Microsoft Internet Explorer"){ // IE10이하 && IE11문서모드변경시
					r.name = "Internet Explorer";
				}else if(nav.appName=="Netscape" && agt.indexOf("trident")!=-1){ //IE11
					r.name = "Internet Explorer";
				}else{ //기타
					if (agt.indexOf("chrome") != -1) { r.name = "Chrome"; 
					} else if (agt.indexOf("opera") != -1) { r.name = "Opera"; 
					} else if (agt.indexOf("staroffice") != -1) { r.name = "Star Office"; 
					} else if (agt.indexOf("webtv") != -1) { r.name = "WebTV"; 
					} else if (agt.indexOf("beonex") != -1) { r.name = "Beonex"; 
					} else if (agt.indexOf("chimera") != -1) { r.name = "Chimera"; 
					} else if (agt.indexOf("netpositive") != -1) { r.name = "NetPositive"; 
					} else if (agt.indexOf("phoenix") != -1) { r.name = "Phoenix"; 
					} else if (agt.indexOf("firefox") != -1) { r.name = "Firefox"; 
					} else if (agt.indexOf("safari") != -1) { r.name = "Safari"; 
					} else if (agt.indexOf("skipstone") != -1) { r.name = "SkipStone"; 
					} else if (agt.indexOf("msie") != -1) { r.name = "Internet Explorer"; 
					} else if (agt.indexOf("netscape") != -1) { r.name = "Netscape"; 
					} else if (agt.indexOf("mozilla/5.0") != -1) { r.name = "Mozilla";
					}
				}
				
				//버전체크
				if(r.name=="Internet Explorer"){
					r.version = this.getInternetExplorerVersion(nav);
					r.realVersion = this.getInternetExplorerTridentVersion(nav);
				}else{
					//추후 필요시 추가...
				}
				
				return r;
			}
			//IE브라우저의 실제버전 (IE7이하는 구별불가: Trident3으로 동일)
			,getInternetExplorerTridentVersion : function(nav){
				var r = -1;
				var re = new RegExp("Trident/([0-9]{1,})[\.]{0,}");
				if(re.exec(nav.userAgent) != null){
					r = parseFloat(RegExp.$1)+4;
				}
				return r;
			}
			//IE브라우저의 문서버전
			,getInternetExplorerVersion : function (nav){
				var r = -1;
				if (nav.appName == "Microsoft Internet Explorer"){
					var ua = nav.userAgent;
					var re  = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
					if (re.exec(ua) != null){
						r = parseFloat( RegExp.$1 );
					}
				}else if (nav.appName == "Netscape"){
					var ua = nav.userAgent;
					var re  = new RegExp("Trident/.*rv:([0-9]{1,}[\.0-9]{0,})");
					if (re.exec(ua) != null){
						r = parseFloat( RegExp.$1 );
					}
				}
				return r;
			}
			//IE브라우저 확인
			,isIE : function(){
				return this.getBrowser().name == "Internet Explorer";
			}
			//맨앞의 "#"을 제거하여 반환 
			,_removeFirstSharp : function(v){
				if(typeof v !== 'string'){ return v; }
				var re  = new RegExp("^#(.*)");
				var r = v;
				if(re.exec(r)){
					r = RegExp.$1;
				}
				return r;
			}
			//16자리 unique 값
			,getUID : function(){
				return (new Date()).getTime()+''+parseInt(Math.random()*1000);
			// TODO : $.fn.cmtree.delay
			}
			,delay : function(gap){ /* gap is in millisecs */ 

				  var then,now; 
				  //alert(gap);

				  then=new Date().getTime(); 

				  now=then; 

				  while((now-then)<gap){ 

				    now=new Date().getTime();  // 현재시간을 읽어 함수를 불러들인 시간과의 차를 이용하여 처리 

				  } 

			} 
		}
	};
	var filter2Depth = function(obj){
		var r = {};
		for(var t in obj){ //3depth package
			if(typeof obj[t] === "object"){
				r[t] = {};
				for(var o in obj[t]){
					if(o.indexOf("_") != 0 && typeof obj[t][o] === "function"){ // "_"로 시작하는 함수는 공개안함.
						r[t][o] = obj[t][o];
					}
				}
			}else{
				if(t.indexOf("_") != 0 && typeof obj[t] === "function"){
					r[t] = obj[t];
				}
			}
		}
		return r;
	};
	var _init = function(){
		f.tab.init();
	}; 
	
	$(function(){
		_init();
	});
	
	var rto = filter2Depth(f);
	
	
	return rto;
})(navigator,this,jQuery);


//MERGE 관련/=================================================================================
/** 셀병합을 위한 변수 */
var mergeCellVal01 = { cellId: undefined, value: undefined };

/** 셀병합을 위한 변수 - 초기화 */
function resetVal(){
    mergeCellVal01 = { cellId: undefined, value: undefined };
}

/** rowspan Set */
function mergeCellcomplet(_grid){
    resetVal(); 
    var grid = _grid;
    $("td[rowspan=\"1\"]", grid).each(function () {
        var spans = $("td[rowspanid='" + this.id + "']", grid).length + 1;
        if (spans > 1) {
            $(this).attr("rowspan", spans);
        }
    });
}

/** merge cell : Cellattr 호출 */
function mergeCellattr01(rowId, val, rawObject, cm, rdata) {
    var result;
    // 비교대상 동일 : display none 처리
    if (mergeCellVal01.value == val) {
        result = " style=\"display: none\" rowspanid=\"" + mergeCellVal01.cellId + "\"";
    }
    // 비교대상 상이 : 변수 등록, 신규 cellID 등록
    else {
        var cellId = this.id + "_row_" + rowId + "_" + cm.name;
        result = " rowspan=\"1\" id=\"" + cellId + "\"";
        mergeCellVal01 = { cellId: cellId, value: val };
    }

    return result;
}
//MERGE 관련=================================================================================/

$(window).resize(function(){
	setTimeout(grid_win_resizeAuto, 200);
	
});

function grid_win_resizeAuto(){
	var grid_list=$("TABLE[id^=jqGrid]");
	var grid_div_wh = 0;
	var fixwidth = "N";
	var grid_wh = 0;
	var grid_gap = 0;
	//alert("11");
	grid_list.each(function(){
		if($(this).get(0).tagName=="TABLE"){
			grid_wh = $("#"+$(this).attr("id")).width();
			//alert($("#content").width());
			if($("#content").width()!=undefined){
				grid_div_wh = $("#content").width();
			}else{
				grid_div_wh = $("#content_popup").width();
				//alert(grid_div_wh);
			}
			
			if($("#"+$(this).attr("id")).attr("fixwidth")!=undefined){
				fixwidth = $("#"+$(this).attr("id")).attr("fixwidth");
			}
			
			if($("#"+$(this).attr("id")).attr("landcnt")!=undefined){
				if($("#"+$(this).attr("id")).attr("landcnt")>1){
					//console.log("landcnt==="+$("#"+$(this).attr("id")).attr("landcnt"));
					if($("#"+$(this).attr("id")).attr("minuswh")!=undefined){
						if($("#"+$(this).attr("id")).attr("minuswh")>0){
							grid_gap = (grid_div_wh-parseInt($("#"+$(this).attr("id")).attr("minuswh")))/parseInt($("#"+$(this).attr("id")).attr("landcnt"));
						}else{
							grid_gap = grid_div_wh/parseInt($("#"+$(this).attr("id")).attr("landcnt"));
						}
					}else{
						grid_gap = grid_div_wh/parseInt($("#"+$(this).attr("id")).attr("landcnt"));
					}
					
				}else{
					if($("#"+$(this).attr("id")).attr("minuswh")!=undefined){
						if($("#"+$(this).attr("id")).attr("minuswh")>0){					
							grid_gap = $("#"+$(this).attr("id")).width()+((grid_div_wh-parseInt($("#"+$(this).attr("id")).attr("minuswh")))-grid_wh);
						}else{
							grid_gap = $("#"+$(this).attr("id")).width()+(grid_div_wh-grid_wh);
						}
					}else{
						grid_gap = $("#"+$(this).attr("id")).width()+(grid_div_wh-grid_wh);
					}
				}
				
			}else{
				if($("#"+$(this).attr("id")).attr("minuswh")!=undefined){
					if($("#"+$(this).attr("id")).attr("minuswh")>0){					
						grid_gap = $("#"+$(this).attr("id")).width()+((grid_div_wh-parseInt($("#"+$(this).attr("id")).attr("minuswh")))-grid_wh);
					}else{
						grid_gap = $("#"+$(this).attr("id")).width()+(grid_div_wh-grid_wh);
					}
				}else{
					grid_gap = $("#"+$(this).attr("id")).width()+(grid_div_wh-grid_wh);
				}				

			}
			//console.log("fixwidth==="+fixwidth);
			
			//$("#"+$(this).attr("id")).setGridWidth($("#"+$(this).attr("id")).width()+(grid_div_wh-grid_wh),true);
			if(fixwidth=="N"){
				
				jQuery("#"+$(this).attr("id")).jqGrid("setGridWidth",grid_gap-26);
			}
			
		}
	});
	
}

//엑셀출력[화면,전체] - 파라미터(그리드명,엑셀구분[화면:"",전체:"A"],엑셀명)
function excelDownload(gridNm,excelGbn,excelNm, acurl){

	if(gridNm=="" || gridNm==undefined){
		gridNm="jqGrid";
	}
	
	if(excelGbn=="" || excelGbn==undefined){
		excelGbn="";
	}
	
	if(excelNm=="" || excelNm==undefined){
		excelNm="exportList";
	}

	try {
     	var _prefix = com.getConst("grid.PREFIX_PRM");
     	
     	//postData 셋팅 여부 확인
     	var is_param = false;
     	for(var k in $("#"+gridNm).jqGrid("getGridParam","postData")){
            	if(k.indexOf(_prefix)!=0){
            		is_param = true; break;
            	}
     	}

     	if(!is_param){
     		alert("요청정보가 설정되지 않았습니다."); return;
     	}
     	//컬럼정보 설정
     	var _colId = [];
     	var _colNm=[];
     	$.each($("#"+gridNm)[0].p.colModel, function(n,o){
     		
     		// 엑셀 출력시 숨김항목은 제외  -mrkim (2015-04-08) // multiselect가 있는 jqgrid에서 데이터 밀림 현상이 있어서  '&& o.name != "cb"' 부분 추가 - bkkim(2015-06-04)
     		if(false==o.hidden && o.name != "cb"){
     			_colId.push( o.name );
     			_colNm.push(o.label);
     		}
     	});
     	
     	//var _exportParam = "excelFileName="+ ( $("#"+gridNm)[0].p.custom.navButton.excel.exportName||""+excelNm );
     	var _exportParam = "excelFileName="+excelNm;
		//엑셀구분 - 화면출력[V] or 전체출력[A]
     	_exportParam += "&excelGbn="+excelGbn;
     	_exportParam += "&colNames="+ ( ($("#"+gridNm)[0].p.rownumbers?" ":"") + _colNm.join(",") );
     	_exportParam += "&colId="+ ( _colId.join(",") );
     	
     	//form의 조건으로 검색하여 엑셀출력처리 
//     	var formdata =  $("#"+gridNm).parents("form").serializeArray();  
//     	
//     	$.each(formdata, function(n,o){
//    		//console.log(n+"::"+o.name+"::"+o.value+"::"+o.type);
//    		if(o.name!=undefined){
//        		//if(o.name!="pstate"){
//    			_exportParam += "&"+o.name+"="+o.value;
//        		//}    			
//    		}
//
//     	}); 
     	
     	_exportParam = _exportParam.replace(new RegExp('<[^>]*([\\S\\s]*?)>','gi'), '');
     	//console.log("_exportParam==>"+_exportParam.replace(new RegExp('<[^>]*([\\S\\s]*?)>','gi'), ''));
     	//return;
     	$("#"+gridNm).jqGrid("excelExport", {
         	oper: _prefix+"oper"
             ,tag: "excel"
             ,url: encodeURI(acurl+"?" + _exportParam)
         });
     } catch(e) {
    	 //console.log("excelDownload:e==>"+e);
     }
     
}


function excelDownload3(gridNm,excelGbn,excelNm){

	if(gridNm=="" || gridNm==undefined){
		gridNm="jqGrid";
	}
	
	if(excelGbn=="" || excelGbn==undefined){
		excelGbn="";
	}
	
	if(excelNm=="" || excelNm==undefined){
		excelNm="exportList";
	}

	try {
     	var _prefix = com.getConst("grid.PREFIX_PRM");
     	var formid = "jqGridExcelfrm";
     	var form_html = "<form name='"+formid+"' id='"+formid+"'>";
     	//postData 셋팅 여부 확인
     	var is_param = 0;
     	var jqparam = $("#"+gridNm).jqGrid("getGridParam","postData");
     	// var jqparam = $("#jqGrid0").jqGrid("getGridParam","postData");jqparam;
        // alert(jqparam['jqGrid.nd']);
     	//console.log("jqparam==>"+jqparam);
     	for(var k in  $("#"+gridNm).jqGrid("getGridParam","postData")){
     		//console.log(k+"==>"+k.indexOf(_prefix));
            	if(k.indexOf(_prefix) !=0){
            		// 그리드 셋팅값만 셋팅한다
            		//console.log("gridparam11::::"+k+"==>"+$("#"+gridNm).jqGrid("getGridParam","postData")[k]+"\r\n");
            		//form_html += "<input type='hidden' name='"+k+"' id='"+k+"' value='"+$("#"+gridNm).jqGrid("getGridParam","postData")[k]+"' />\r\n";
            		//if(k=="pstate"){
            		//	form_html += "<input type='hidden' name='"+k+"' id='"+k+"' value='"+$("#"+gridNm).jqGrid("getGridParam","postData")[k]+"' />\r\n";
            		//}
            		is_param++;
            	            		
            	}else{
            		//console.log("gridparam22::::"+k+"==>"+$("#"+gridNm).jqGrid("getGridParam","postData")[k]+"\r\n");
            		form_html += "<input type='hidden' name='"+k+"' id='"+k+"' value='"+$("#"+gridNm).jqGrid("getGridParam","postData")[k]+"' />\r\n";
            	}

     	}
     	//console.log("form_html==>"+form_html);

/*
     	if(is_param==0){
     		alert("요청정보가 설정되지 않았습니다."); return;
     	}
*/
     	var formdata =  $("#"+gridNm).parents("form").serializeArray();
     	
     	$.each(formdata, function(n,o){
    		//console.log(n+"::"+o.name+"::"+o.value+"::"+o.type);
    		if(o.name!=undefined){
        		//if(o.name!="pstate"){
        			form_html += "<input type='hidden' name='"+o.name+"' id='"+o.name+"' value='"+o.value+"' />\r\n";
        		//}    			
    		}

     	}); 
     	
     	//컬럼정보 설정
     	var _colId = [];
     	var _colNm=[];
     	var _colWidth=[];
     	// var aaa=$("#jqGrid")[0].p;
     	// aaa;
     	$.each($("#"+gridNm)[0].p.colModel, function(n,o){
     		
     		// 엑셀 출력시 숨김항목은 제외  -mrkim (2015-04-08) // multiselect가 있는 jqgrid에서 데이터 밀림 현상이 있어서  '&& o.name != "cb"' 부분 추가 - bkkim(2015-06-04)
     		if(false==o.hidden && o.name != "cb"){
     			_colId.push( o.name );
     			_colWidth.push(o.width);
     			if(o.label==undefined || o.label=="" || o.label==null){
     				_colNm.push(StrreplaceAll($("#"+gridNm)[0].p.colNames[n],",","-"));
     			}else{
     				_colNm.push(StrreplaceAll(o.label,",","-"));
     			}
     			
     		}
     	});
    	
     	
     	
     	//return;
     	
     	//var _exportParam = "excelFileName="+ ( $("#"+gridNm)[0].p.custom.navButton.excel.exportName||""+excelNm );

     	form_html += "<input type='hidden' name='jqGrid.oper' id='jqGrid.oper' value='excel3'/>";
     	form_html += "<input type='hidden' name='excelFileName' id='excelFileName' value='"+excelNm+"' />";
     	form_html += "<input type='hidden' name='excelGbn' id='excelGbn' value='"+excelGbn+"' />";
     	form_html += "<input type='hidden' name='colNames' id='colNames' value='"+( ($("#"+gridNm)[0].p.rownumbers?" ":"") + _colNm.join(",").replace(new RegExp('<[^>]*([\\S\\s]*?)>','gi'), '') )+"' />";
     	form_html += "<input type='hidden' name='colId' id='colId' value='"+( _colId.join(",") )+"' />";
     	form_html += "<input type='hidden' name='colWidth' id='colWidth' value='"+( _colWidth.join(",") )+"' />";
     	form_html += "</form>";
     	
     	//console.log("form_html==>"+form_html);
     	//return;
     	var $sform = $(form_html);
     	$sform.attr("action",context_root+"/cmsmain.do");
     	$sform.attr("method","post");
     	$sform.attr("target","successIframe");
     	//$("#"+formid).attr("target","successIframe");     	
     	$sform.appendTo('body');
     	//$(body).append(form_html);
     	//console.log("form_obj==>"+$("#"+formid)+":::==>"+$("form[name="+formid+"]")+"===>"+$sform);
     	//$("#"+formid).attr("action","/cmsmain.do");
     	//$("#"+formid).attr("method","post");
     	//$("#"+formid).attr("target","successIframe");
     	//$("#"+formid).submit();
     	$sform.submit();
     	$(body).find("#"+formid).remove();
     	
     	//_exportParam = _exportParam.replace(new RegExp('<[^>]*([\\S\\s]*?)>','gi'), '');


     } catch(e) {
    	 //console.log("excelDownload:e==>"+e);
     }
     
}

// 그리드 컬럼의 속성에 해당하는 컬럼 데이타 취득(hidden:true 제외) -mrkim (2015-05-14)
//  예) getColumnsInfo("gridId", "name")
function getColumnsInfo(gridId, colAttr){	
 	var col_info = [];
 	$.each($("#"+gridId)[0].p.colModel, function(n,o){
 		if(false==o.hidden && !o.label==""){
 			if(colAttr=="name"){
 				col_info.push( o.name ); 				
 			}else if(colAttr=="label"){
 				col_info.push(o.label); 				
 			}else if(colAttr=="width"){
 				col_info.push(o.width); 				
 			}else{
 				col_info = "getColumnsInfo("+gridId+", "+colAttr+") :: 조회하려는 그리드 컬럼의 속성["+colAttr+"]을 잘못지정되었습니다.";
 				return false;
 			}
 		}
 	});
 	return col_info;
}

//그리드 컬럼의 속성에 해당하는 모든 컬럼 데이타 취득 -mrkim (2015-05-14)
//예) getColumnsInfo("gridId", "name")
function getColumnsInfoAll(gridId, colAttr){	
	var col_info = [];
	$.each($("#"+gridId)[0].p.colModel, function(n,o){
		if(!o.label==""){
			if(colAttr=="name"){
				col_info.push( o.name ); 				
			}else if(colAttr=="label"){
				col_info.push(o.label); 				
			}else if(colAttr=="width"){
				col_info.push(o.width); 				
			}else{
				col_info = "getColumnsInfo("+gridId+", "+colAttr+") :: 조회하려는 그리드 컬럼의 속성["+colAttr+"]을 잘못지정되었습니다.";
				return false;
			}
		}
	});
	return col_info;
}

//그리드 컬럼의 필수체크항목(*)을 반환  -mrkim (2015-05-14)
//예) getCheckField("gridId")
function getCheckField(gridId){	
	var checkField = [];
	$.each($("#"+gridId)[0].p.colModel, function(n,o){
		if(false==o.hidden && !o.label==""){
			if(o.label.indexOf("*")!=-1){
				checkField.push( o.name );
			}			
		}
	});
	return checkField;
}

//조회된 데이타가 없을 경우 알림메시지 표시 -mrkim (2015-06-22)
function isLoadData(data){	
	// 에러가 발생한경우 에러 메시지를 출력한다
	//alert(JSON.parse(JSON.stringify(data)).result+"::"+JSON.parse(JSON.stringify(data)).ajaxSystemCode+"::"+JSON.parse(JSON.stringify(data)).TRS_MSG);
	if(JSON.parse(JSON.stringify(data)).result!=null && JSON.parse(JSON.stringify(data)).result!=undefined){
		if(JSON.parse(JSON.stringify(data)).result==false){
			if(JSON.parse(JSON.stringify(data)).ajaxSystemCode=="901"){
				alert(JSON.parse(JSON.stringify(data)).TRS_MSG);
				return false;
			}	
			
			// 로그인 체크 에러일경우
			if(JSON.parse(JSON.stringify(data)).ajaxSystemCode=="903"){
				alert(JSON.parse(JSON.stringify(data)).TRS_MSG);
				top.location.href=JSON.parse(JSON.stringify(data)).TRS_URL;
				return false;				
			}
		}
	}

	
	if(JSON.parse(JSON.stringify(data)).rows!=null && JSON.parse(JSON.stringify(data)).rows!=undefined){
		if(JSON.parse(JSON.stringify(data)).rows.length==0){
			alert("조회된 데이타가 없습니다.");	//조회된 데이타가 없습니다.
			return false;
		}		
	}else if(JSON.parse(JSON.stringify(data)).ViewMap!=null && JSON.parse(JSON.stringify(data)).ViewMap!=undefined){
		if(JSON.parse(JSON.stringify(data)).ViewMap.length==0){
			alert("조회된 데이타가 없습니다.");	//조회된 데이타가 없습니다.
			return false;
		}
	}
	return true;
}