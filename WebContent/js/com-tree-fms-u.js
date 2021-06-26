/**================================================================================
 * @name: javascript 공통 package - cmtree plugin
 * @author: jhlee
 * @demo: 
 * @version: 0.1.0
 * @charset: utf-8
 ================================================================================*/
(function($) {
  //var cmtreeval = new Array();
	var cmtreeval = {};
	var cmtreeval_defaults = {};
  //TODO : $.fn.cmtree
  $.fn.cmtree = function(opt) {
		//ID체크
		var _grdId = opt.id||opt.custom.id;
		if(!_grdId){
			alert("[필수]Grid ID가 없습니다."); return;
		}else if($(_grdId).length==0){
			alert("[필수]Grid ID에 해당하는 Element가 없습니다."); return;
		}
		var opts = $.extend({}, $.fn.cmtree.defaults, opt);
		$.fn.cmtree.defaults.id = opt.id;
		$.fn.cmtree.defaults.checkBoxYn = opt.checkBoxYn;
		if(opt.onClickTitlefn==undefined || opt.onClickTitlefn==null){
			$.fn.cmtree.defaults.onClickTitlefn = "";
		}else{
			$.fn.cmtree.defaults.onClickTitlefn = opt.onClickTitlefn;
		}
		
		if(opt.onClickCheckedfn==undefined || opt.onClickCheckedfn==null){
			$.fn.cmtree.defaults.onClickCheckedfn = "";
		}else{
			$.fn.cmtree.defaults.onClickCheckedfn = opt.onClickCheckedfn;
		}		
		

		$.fn.cmtree.defaults.treeAreaId = opt.treeAreaId;
		$.fn.cmtree.defaults.treeMenuId = opt.treeMenuId;
		$.fn.cmtree.defaults.treeHeight = opt.treeHeight;
		$.fn.cmtree.defaults.treeWidth = opt.treeWidth;
		$.fn.cmtree.defaults.treemHeight = opt.treemHeight;
		$.fn.cmtree.defaults.treemWidth = opt.treemWidth;
		
		
		if(opt.setAllYn==undefined){
			//console.log("opt.setAllYn1::"+opt.setAllYn);
			$.fn.cmtree.defaults.setAllYn = $.fn.cmtree.defaults.setAllYn;
		}else if(opt.setAllYn==""){
			//console.log("opt.setAllYn2::"+opt.setAllYn);
			$.fn.cmtree.defaults.setAllYn = opt.setAllYn;
		}else{
			//console.log("opt.setAllYn3::"+opt.setAllYn);
			$.fn.cmtree.defaults.setAllYn = opt.setAllYn;
		}
		
		$.fn.cmtree.defaults.treeRelComboId = (opt.treeRelComboId==undefined || opt.treeRelComboId=="")?"":opt.treeRelComboId;
		$.fn.cmtree.defaults.treeRelComboboxId = (opt.treeRelComboboxId==undefined || opt.treeRelComboboxId=="")?"":opt.treeRelComboboxId;
		
		//console.log("treeHeight---"+$.fn.cmtree.defaults.treeHeight+"---treemHeight---"+$.fn.cmtree.defaults.treemHeight);
		//console.log("treeWidth---"+$.fn.cmtree.defaults.treeWidth+"---treemWidth---"+$.fn.cmtree.defaults.treemWidth);
		
		if($.fn.cmtree.defaults.treeHeight!=""){
			$(""+$.fn.cmtree.defaults.treeAreaId).css("height",$.fn.cmtree.defaults.treeHeight.replace(/px/gi,"")-158);
			$(""+$.fn.cmtree.defaults.treeMenuId).css("height",$.fn.cmtree.defaults.treemHeight.replace(/px/gi,"")-158);
		}

		if($.fn.cmtree.defaults.treeWidth!=""){
			$(""+$.fn.cmtree.defaults.treeAreaId).css("width",$.fn.cmtree.defaults.treeWidth);
			$(""+$.fn.cmtree.defaults.treeMenuId).css("width",$.fn.cmtree.defaults.treemWidth);
		}
		
		$.fn.cmtree.defaults.treeImgPath = (opt.treeImgPath==undefined || opt.treeImgPath=="")?"":opt.treeImgPath;
		cmtreeval_defaults[opt.id] = {
					id			: $.fn.cmtree.defaults.id 
					,treeAreaId : $.fn.cmtree.defaults.treeAreaId
					,treeMenuId : $.fn.cmtree.defaults.treeMenuId
					,treeHeight : $.fn.cmtree.defaults.treeHeight
					,treeWidth : $.fn.cmtree.defaults.treeWidth	
					,treemHeight : $.fn.cmtree.defaults.treemHeight
					,treemWidth : $.fn.cmtree.defaults.treemWidth		
					,checkBoxYn : $.fn.cmtree.defaults.checkBoxYn
					,treeArr    : $.fn.cmtree.defaults.treeArr
					,setAllYn : $.fn.cmtree.defaults.setAllYn
					,onClickTitlefn: $.fn.cmtree.defaults.onClickTitlefn
					,onClickCheckedfn: $.fn.cmtree.defaults.onClickCheckedfn
					,treeRelComboId : $.fn.cmtree.defaults.treeRelComboId
					,treeRelComboboxId : $.fn.cmtree.defaults.treeRelComboboxId
					,dataSetYn : $.fn.cmtree.defaults.dataSetYn
					,createChildClickCnt : $.fn.cmtree.defaults.createChildClickCnt
					,seltreecd : $.fn.cmtree.defaults.seltreecd
					,seltreebg : $.fn.cmtree.defaults.seltreebg
					,treeImgPath : $.fn.cmtree.defaults.treeImgPath
					,treeRootCd : $.fn.cmtree.defaults.treeRootCd
				  };
		//console.log("opt.onClickTitlefn===>"+opt.onClickTitlefn);
  };

  // Option defaults
  // TODO : $.fn.cmtree.defaults
  $.fn.cmtree.defaults = {
	id			: '#cmtree_data' 
	,treeAreaId : '#treeArea'
	,treeMenuId : '#treeMenu'	
	,treeHeight : '400px'
	,treeWidth : '200px'	
	,treemHeight : "452px"
	,treemWidth : "210px"		
	,checkBoxYn : false
	,treeArr    : cmtreeval
	,setAllYn : true
	,onClickTitlefn: "treeClickTitle"
	,onClickCheckedfn: "treeClickchecked"
	,treeRelComboId : "org_select_group"
	,treeRelComboboxId : "org_option"
	,dataSetYn : false
	,createChildClickCnt : 0
	,seltreecd : ""
	,seltreebg : "#ff6600"
	,treeImgPath : "/images/tree"
	,treeRootCd : ""
  };
 
  // TODO : $.fn.cmtree.reload
  $.fn.cmtree.reload = function(id, url, params){
	  	$(id).html("");
		$.ajax({
			type: "post",
			url: url,
			data:params,
			async: false,
			dataType:"json",
			timeout: 3000,
		    error: function (jqXHR, textStatus, errorThrown) {
		           // 통신에 에러가 있을경우 처리할 내용(생략가능)
			        alert("네트웍장애가 발생했습니다. 다시시도해주세요");
			        CmLoadingChg_Zindex(8000);             
		    },			
			success: function(data){
				if(data.result==true){
					// 트리 데이터가 셋팅된경우
					if(data.treerows!= ""){
					//alert(data.optionlist);
						 $.fn.cmtree.treeDataToHtml(id, data.treerows);

					}else {
						alert("데이터가 존재하지 않습니다.");
					}					
				}else{
					alert(data.TRS_MSG);
					return false;
				}

					
			}
		});
	};
  
  // TODO : $.fn.cmtree.treeDataToHtml
  $.fn.cmtree.treeDataToHtml = function(id , treeList){
		//alert("조직갯수:"+treeList.length);
		//alert("체크박스여부:"+$.fn.cmtree.defaults.checkBoxYn);
	    
		var prev_lv = 0;
		var tmp_lv = 0;
		var init_lv = 0;
		var i=0;
		var j=0;
		var init_lev=0;
		//console.log("$.fn.cmtree.treeDataToHtml---treeList.length----"+treeList.length);
		// 레벨별로 트리데이터를 정리한다
		for(i=0;i<treeList.length;i++){
			//' 첫번째 데이터의 경우 초기 lv값을 셋팅한다
			if (i==0){
				cmtreeval[''+id] = new Array();
				init_lv =  parseInt(treeList[i]['tree_level']);
			}	
			tmp_lv = parseInt(treeList[i]['tree_level']) - init_lv;
			
			if (i==0){
				cmtreeval[id][tmp_lv] = new Array();
			}else if( prev_lv < tmp_lv ){
				cmtreeval[id][tmp_lv] = new Array();
			}
		
			var cmtreeval_tmp = new Array();
			cmtreeval_tmp[0]  = treeList[i]['tree_seq']+""; //' TREE_SEQ
			cmtreeval_tmp[1]  = treeList[i]['tree_cd']+""; //' TREE_CD
			//cmtreeval_tmp[2]  = treeList[i]['tree_nm']+""; //' TREE_NM
			if(treeList[i]['tree_nm'].indexOf("\r\n") > -1){
				cmtreeval_tmp[2]  = treeList[i]['tree_nm'].substring(0, treeList[i]['tree_nm'].indexOf("\r\n"))+"";
			}else{
				cmtreeval_tmp[2]  = treeList[i]['tree_nm']+"";
			}
			
			cmtreeval_tmp[3]  = treeList[i]['tree_uppo_cd']+""; //' TREE_UPPO_CD
			cmtreeval_tmp[4]  = treeList[i]['tree_level']+""; //' TREE_LEVEL
			cmtreeval_tmp[5]  = treeList[i]['tree_nms'].replace(/::/gi,"__")+""; //' TREE_NMS
			cmtreeval_tmp[6]  = treeList[i]['tree_cds'].replace(/::/gi,"__")+""; //' TREE_CDS
			cmtreeval_tmp[7]  = treeList[i]['tree_sub_cnt']+""; //' TREE_SUB_CNT
			cmtreeval_tmp[8]  = treeList[i]['tree_group_cd']+""; //' TREE_GROUP_CD
			cmtreeval_tmp[9]  = treeList[i]['tree_gbn_ty']+""; //' TREE_GBN_TY

			cmtreeval[id][tmp_lv].push(cmtreeval_tmp);	
			
			prev_lv = tmp_lv;
		}
		
		//console.log(cmtreeval[id].length);
		cmtreeval_defaults[id].treeArr = cmtreeval;
		cmtreeval_defaults[id].dataSetYn = true;
		//$.fn.cmtree.defaults.treeArr = cmtreeval;
		//$.fn.cmtree.defaults.dataSetYn = true;
		
		// 정리된 데이터를 html로 생성한다
		tmp_innerhtml_str = "";
		tmp_str = "";
		//console.log("$.fn.cmtree.defaults.setAllYn::"+$.fn.cmtree.defaults.setAllYn);
		//if($.fn.cmtree.defaults.setAllYn==true){
		if(cmtreeval_defaults[id].setAllYn==true){
			init_lev = cmtreeval[id].length;	
			
		}else{
			// 1레벨만 설정한다
			init_lev = 1;
		}
		

		for(i=0;i<init_lev;i++){
			//alert(cmtreeval[i].length);
			for(j=0;j<cmtreeval[id][i].length;j++){	
				if(i==0){
					tmp_str = "<li class='sub_1d on' id='tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"'>";
				}else{
					tmp_str = "<li class='sub_1d on' id='tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"'>";
				}
				
				// 체크박스여부가 true이면
				//if($.fn.cmtree.defaults.checkBoxYn == true){
				if(cmtreeval_defaults[id].checkBoxYn == true){
					if(i>0){
						tmp_str += " <input type='checkbox' id='tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' name='tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' value='"+cmtreeval[id][i][j][6]+"' style='float:left;margin-top:20px;margin-left:"+(10*(i+1))+"px;' onclick='$.fn.cmtree.chkTreeToggle(\""+id+"\",\""+cmtreeval[id][i][j][6]+"\",\""+cmtreeval[id][i][j][4]+"\", true);$.fn.cmtree.onClickTreeChecked(\""+id+"\",\""+cmtreeval[id][i][j][6]+"\")' /> ";
					}
					
				}
				//if(i==0){
				//	if(cmtreeval[id][i][j][7] > 1){
						//tmp_str += "<img  src='/images/tree/btn_plus.gif' alt='하위메뉴 보기' />";
				//	}
				//}
				//tmp_str += " <a href='#' id='tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' onclick='$.fn.cmtree.onClickTreeTitle(\""+cmtreeval[id][i][j][6]+"\")'>"+cmtreeval[id][i][j][2]+"</a>";
				//tmp_str += " <a href='#' id='tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' onclick='$.fn.cmtree.onClickTreeTitle(\""+id+"\",\""+cmtreeval[id][i][j][6]+"\");return false;'>"+cmtreeval[id][i][j][2]+"</a>";
				tmp_str += " <a href='#' id='tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' onclick='return false;'>"+cmtreeval[id][i][j][2]+"</a>";
				// 1레벨일경우
				if(i==0){
					if(parseInt(cmtreeval[id][i][j][7]) > 0){
						
						//tmp_str += "<ul id='tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' class='' style='height:"+($.fn.cmtree.defaults.treeHeight.replace(/px/gi,"")-168)+"px;width:"+$.fn.cmtree.defaults.treeWidth.replace(/px/gi,"")+"px; display:none;margin:auto; padding:0px 0px; overflow:auto; white-space:nowrap; scrollbar-face-color: #ecedf7; scrollbar-shadow-color: #bcc1e3; scrollbar-highlight-color: #cacaca; scrollbar-3dlight-color: #cacaca; scrollbar-darkshadow-color:#cacaca; scrollbar-track-color: #ecedf7; scrollbar-arrow-color: #012964;'></ul>";
						tmp_str += "<ul id='tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' class='' style='height:"+(cmtreeval_defaults[id].treeHeight.replace(/px/gi,"")-208)+"px;width:"+cmtreeval_defaults[id].treeWidth.replace(/px/gi,"")+"px; display:none;margin:auto; padding:0px 0px; overflow:auto; white-space:nowrap; scrollbar-face-color: #ecedf7; scrollbar-shadow-color: #bcc1e3; scrollbar-highlight-color: #cacaca; scrollbar-3dlight-color: #cacaca; scrollbar-darkshadow-color:#cacaca; scrollbar-track-color: #ecedf7; scrollbar-arrow-color: #012964;'></ul>";
						
						//$.fn.cmtree.defaults.treeRootCd = cmtreeval[id][i][j][6];
						cmtreeval_defaults[id].treeRootCd = cmtreeval[id][i][j][6];
					}
					tmp_str += "</li>";
					$(id).append(tmp_str);
				}else{
					if(parseInt(cmtreeval[id][i][j][7]) > 0){
						tmp_str += "<ul id='tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]+"' class='' style='display:none;'></ul>";
					}else{

					}
					tmp_str += "</li>";
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6].substring(0,cmtreeval[id][lev][j][6].lastIndexOf("__"))).append(tmp_str);
					if(parseInt(cmtreeval[id][i][j][7]) == 0){
						$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][i][j][6]).addClass("noneC");
					}
				}
				
				
			}
		}	
		
		

		//$("#tree_str").val($("#cmtree_data").html());
		
		var treeBtn=$(id+" a");
		var treeLi=$(id+" li");
		var firstLi=$(id+">ul>li:first-child");
		var lastLi=$(id+" ul li:last-child");
		var lastUl=lastLi.children("ul");
		
		firstLi.addClass("first");
		lastLi.addClass("last");
		lastUl.addClass("last");
		
		for(var i=0; i<treeLi.length; i++){
			var thisLi=treeLi.eq(i);
			var haveUl=thisLi.children("ul");
			var haveUlNum=haveUl.length;
			var thisbg=thisLi.attr("class");
			//if(thisLi.attr("id")=="tree_li_M00007"){
				//alert(haveUlNum+":::"+thisLi.attr("id"));
			//}

		}
		
		
		var treeBtn=$(id+" li a");
		
		treeBtn.click(function(){
			
			var thisNum=treeBtn.index(this);
			var thisBtn=treeBtn.eq(thisNum);
			var thisSubUl=thisBtn.parent().children("ul");
			var thislink = thisBtn.parent().children("a");
			var btn_tree_id_arr = "";
			
			//console.log("treeBtn>>>>>>>>>>>"+id);
			//if(thisSubUl.css("display") == ""){
			if(thisSubUl.is(":visible")){
				//thisSubUl.slideUp("500");
				//console.log(thisSubUl.attr("id")+"::hide");
				thisSubUl.hide();
			}else{
				//console.log(thisSubUl.attr("id")+"::show");
				//thisSubUl.show();
				thisSubUl.slideDown("300");
				//console.log(">>>>>>>>>>>"+$(this).parent().children("ul").children("ul").attr("id"));
				//$(this).parent().children("ul").children("li").show();
			}
			
			if($(thislink).attr("id")!=undefined){
				btn_tree_id_arr = $.fn.cmtree.rtnTreeArr(id,$(thislink).attr("id").replace("tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_",""));
				
			}else{
				btn_tree_id_arr = undefined;
			}
			//console.log(btn_tree_id_arr[3]+">>>>>>>>>>>"+btn_tree_id_arr[6]);
			//Tree 최상위(사업소) 클릭시 세팅 추가 2018-03-15 조완우
			if (btn_tree_id_arr[3] == btn_tree_id_arr[6] ){
				if(cmtreeval_defaults[id].onClickTitlefn!=""){
					window[""+cmtreeval_defaults[id].onClickTitlefn]($.fn.cmtree.rtnTreeArr(id, btn_tree_id_arr[6]));
				}			
			}

			//if($.fn.cmtree.defaults.setAllYn==false){
			if(cmtreeval_defaults[id].setAllYn==false){
				//alert($(thislink).attr("id"));
				//thislink.trigger("click");
				//$.fn.cmtree.onClickTreeTitle($(thislink).attr("id").replace("tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_",""));
				if($(thislink).attr("id")!=undefined){
					btn_tree_id_arr = $.fn.cmtree.rtnTreeArr(id,$(thislink).attr("id").replace("tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_",""));
					//if($.fn.cmtree.defaults.onClickTitlefn!=""){
					//	$.fn.cmtree.createChildTree(btn_tree_id_arr);
					//	window[""+$.fn.cmtree.defaults.onClickTitlefn]($.fn.cmtree.rtnTreeArr(btn_tree_id_arr));
					//}else{
						$.fn.cmtree.createChildTree(id, btn_tree_id_arr);
						//if($.fn.cmtree.defaults.treeRelComboId!=""){
						if(cmtreeval_defaults[id].treeRelComboId!=""){
							$.fn.cmtree.treeRelComboboxSet(id, btn_tree_id_arr[6], btn_tree_id_arr[4]);
							$.fn.cmtree.treeRelComboboxMake(id, btn_tree_id_arr[6],'', btn_tree_id_arr[4]);
							//$.fn.cmtree.onClickTreeTitle(btn_tree_id_arr[1]);
						}										
					//}
					
				
				}				

			}
			
			if(btn_tree_id_arr!=undefined){
				// 동레벨에 있는 모든 열린 트리를 닫아준다
				//$.fn.cmtree.closeTreeSameLevel(btn_tree_id_arr[1]+"", btn_tree_id_arr[4]+"");
			}
			
			//console.log("treeHeight---"+$.fn.cmtree.defaults.treeHeight+"---treemHeight---"+$.fn.cmtree.defaults.treemHeight);
			//console.log("treeWidth---"+$.fn.cmtree.defaults.treeWidth+"---treemWidth---"+$.fn.cmtree.defaults.treemWidth);
			


			//if($.fn.cmtree.defaults.treeWidth!=""){
				//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).css("width",$.fn.cmtree.defaults.treeWidth.replace(/px/gi,""));
				$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).css("width",cmtreeval_defaults[id].treeWidth.replace(/px/gi,""));
			//}		
				
				//if($.fn.cmtree.defaults.treeHeight!=""){
				//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).css("height",$.fn.cmtree.defaults.treeHeight.replace(/px/gi,""));
				$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).css("height",cmtreeval_defaults[id].treeHeight.replace(/px/gi,""));
				
				//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).css({"height":$.fn.cmtree.defaults.treeHeight.replace(/px/gi,"")+"px"});
				//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).height($.fn.cmtree.defaults.treeHeight.replace(/px/gi,"")+"px");
				//console.log("tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd+"---"+$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).css("height"));
				//console.log("treeheight---"+$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).css("height"));
			//}				
		
		});
		//console.log("$.fn.cmtree.treeDataToHtml---11111111111111----"+$.fn.cmtree.defaults.treeRootCd);
		//트리메뉴 끝	
		//$("#tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.treeRootCd).trigger("click");
		$("#tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).trigger("click");
		
	};
	
	// TODO : $.fn.cmtree.closeTreeSameLevel
	$.fn.cmtree.closeTreeSameLevel = function(id, treecd, treelev){	
		var selLevArr = cmtreeval[treelev-1];
		var iu = 0;
		var treeCdsStr = "";
		var treeCdsStrSp = null;
		//console.log("treecd::"+treecd);
		for(iu=0;iu<selLevArr.length;iu++){
			//console.log("selLevArr::"+selLevArr[iu][1]);
			if(selLevArr[iu][6] != treecd){
				//console.log("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+selLevArr[iu][1]+"::"+$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+selLevArr[iu][1]).css("display"));
				if($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+selLevArr[iu][6]).css("display")=="" || $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+selLevArr[iu][6]).css("display")=="block"){
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+selLevArr[iu][6]).hide();
				}
			}else{
				$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).show();
			}
		}		

		
	}	
	
	// 체크박스 선택에 따라 하위체크박스 토글
	// TODO : $.fn.cmtree.chkTreeToggle
	$.fn.cmtree.chkTreeToggle = function(id,treecd, treelev, fixchk){
		//alert(treecd+":start");
		var chkobj_yn = false;
		
		if(fixchk == true){
			chkobj_yn = $("#tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).is(":checked");
		}else{
			chkobj_yn = true;
		}
		
		//alert(chkobj_yn);
		// 체크박스를 선택하면 하위의 트리를 모두 연다
		if(chkobj_yn == true){
			//if($.fn.cmtree.defaults.setAllYn==false){
			if(cmtreeval_defaults[id].setAllYn==false){
				//선택된 레벨의 하위 레벨 트리를 생성해준다
				$.fn.cmtree.createChildTree(id,$.fn.cmtree.rtnTreeArr(id,treecd));
			
			}			
			$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).slideDown("300");
		}else{
			//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).slideUp("500");
			$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).hide();
			// 체크박스를 선택해제 할경우 상위 트리의 체크박스를 선택해제한다
			$.fn.cmtree.unchkTreeParentAll(id,treecd, treelev);
			
		}		
		
		//$($.fn.cmtree.defaults.id+" a").css("color","");
		$(cmtreeval_defaults[id].id+" a").css("color","");
		//if($.fn.cmtree.defaults.seltreecd!=""){
		if(cmtreeval_defaults[id].seltreecd!=""){
			//$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.seltreecd).children("a").css("color","");
		}else{
			//$.fn.cmtree.defaults.seltreecd = treecd;
			cmtreeval_defaults[id].seltreecd = treecd;
		}

		//$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("a").css("color", $.fn.cmtree.defaults.seltreebg);		
		$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("a").css("color", cmtreeval_defaults[id].seltreebg);
		
		// 하위의 모든 체크박스를 체크해주고 언체크해준다
		var subChkAll = "";
		//alert($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).length);
		if($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).length > 0){
			subChkAll = $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).find("input:checkbox[id^='tree_chk2_']");
		}else{
			subChkAll = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).find("input:checkbox[id^='tree_chk2_']");
			$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("ul").show();
		}
		
		var ic = 0;
		var chkcnt = 0;
		var unchkcnt = 0;

		
		subChkAll.each(function(){
			if(chkobj_yn == true){
				//$(this).attr("checked", true);
				document.getElementsByName($(this).attr("name"))[0].checked = true;
				//chkcnt++;
			}else{
				//$(this).attr("checked", false);
				document.getElementsByName($(this).attr("name"))[0].checked = false;
				//unchkcnt++;
				
			}
			//ic++;
		});		
		
		/*var subUlAll = $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd+" ul");
		subUlAll.each(function(){
			if(chkobj_yn == true){
				$(this).slideDown("500");
			}else{
				//$(this).slideUp("500");
				$(this).hide();
				
			}
		}); */
		
		// 하위츼 체크박스를 모두 선택한다
		/*var subChkAll = $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd+" input:checkbox[id^='tree_chk_']");
		var ic = 0;
		var chkcnt = 0;
		var unchkcnt = 0;

		
		subChkAll.each(function(){
			if(chkobj_yn == true){
				//$(this).attr("checked", true);
				document.getElementsByName($(this).attr("name"))[0].checked = true;
				//chkcnt++;
			}else{
				//$(this).attr("checked", false);
				document.getElementsByName($(this).attr("name"))[0].checked = false;
				//unchkcnt++;
				
			}
			//ic++;
		});*/
		
		//alert(treecd+":end:chkcnt:"+chkcnt+":unchkcnt:"+unchkcnt);

	}; 
	
	// TODO : $.fn.cmtree.unchkTreeParentAll
	$.fn.cmtree.unchkTreeParentAll = function(id, treecd, treelev){	
		var selLevArr = cmtreeval[id][treelev-1];
		var iu = 0;
		var iu2 = 0;
		var treeCdsStr = "";
		var tmptreeStr = "";
		var treeCdsStrSp = null;
		for(iu=0;iu<selLevArr.length;iu++){
			if(selLevArr[iu][6] == treecd){
				treeCdsStr = selLevArr[iu][6];
			}
		}
		
		
		treeCdsStrSp = treeCdsStr.split("__");
		//console.log(treeCdsStr+"---"+treeCdsStrSp.length);
		for(iu=0;iu<treeCdsStrSp.length;iu++){
			tmptreeStr = "";
			for(iu2=0;iu2<treeCdsStrSp.length-(iu+1);iu2++){
				if(iu2==0){
					tmptreeStr = treeCdsStrSp[iu2];
				}else{
					tmptreeStr = tmptreeStr +"__"+treeCdsStrSp[iu2];
				}
				
			}
			//console.log("tmptreeStr---"+tmptreeStr);
			if(document.getElementsByName("tree_chk_"+id.replace(/#/gi,"")+"_"+tmptreeStr)[0]!=null 
					&& document.getElementsByName("tree_chk_"+id.replace(/#/gi,"")+"_"+tmptreeStr)[0]!=undefined){
				document.getElementsByName("tree_chk_"+id.replace(/#/gi,"")+"_"+tmptreeStr)[0].checked = false;
			}
			
		}
		/*
		for(iu=treeCdsStrSp.length-1;iu>-1;iu--){
			if(treeCdsStrSp[iu]!=""){
				document.getElementsByName("tree_chk_"+id.replace(/#/gi,"")+"_"+treeCdsStrSp[iu])[0].checked = false;
			}
		}
		*/
		
	}
	
	// TODO : $.fn.cmtree.unchkTreeParentAll2
	$.fn.cmtree.unchkTreeParentAll2 = function(id, treecd, treelev){	
		var selLevArr = cmtreeval[id][treelev-1];
		var iu = 0;
		var treeCdsStr = "";
		var treeCdsStrSp = null;
		for(iu=0;iu<selLevArr.length;iu++){
			if(selLevArr[iu][6] == treecd){
				treeCdsStr = selLevArr[iu][6];
			}
		}
		
		treeCdsStrSp = treeCdsStr.split("__");
		//alert(treeCdsStr+"---"+treeCdsStrSp.length);
		for(iu=treeCdsStrSp.length-1;iu>-1;iu--){
			if(iu!=treeCdsStrSp.length-1){
				if(treeCdsStrSp[iu]!=""){
					//console.log(iu+"::"+treeCdsStrSp[iu]);
					document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treeCdsStrSp[iu])[0].checked = false;
				}				
			}

		}
		
	}	
	
	// TODO : $.fn.cmtree.onClickTreeTitle
	$.fn.cmtree.onClickTreeTitle = function(id, treecd){
		//alert("$.fn.cmtree.onClickTreeTitle==="+treecd);
		//eval($.fn.cmtree.defaults.onClickTitlefn+"("+$.fn.cmtree.rtnTreeArr(treecd)+")");
		//console.log("$.fn.cmtree.onClickTreeTitle :id==>"+id+":treecd==>"+treecd);
		// 최상위만 셋팅된 경우 하위레벨을 셋팅한다
		var cur_tree_arr;
		//if($.fn.cmtree.defaults.setAllYn==false){
		if(cmtreeval_defaults[id].setAllYn==false){
			//console.log("1111111----$.fn.cmtree.onClickTreeTitle :id==>"+id+":treecd==>"+treecd);
			cur_tree_arr = $.fn.cmtree.rtnTreeArr(id, treecd);
			//console.log("2222222----$.fn.cmtree.onClickTreeTitle :id==>"+id+":treecd==>"+treecd);
			//$(""+$.fn.cmtree.defaults.treeMenuId).animate({scrollTop:$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).position().top},'fast');
			//console.log("$.fn.cmtree.onClickTreeTitle :id==>"+id+":cur_tree_arr==>"+cur_tree_arr);
			//선택된 레벨의 하위 레벨 트리를 생성해준다
			$.fn.cmtree.createChildTree(id, cur_tree_arr);
			//console.log("3333333----$.fn.cmtree.onClickTreeTitle :id==>"+id+":treecd==>"+treecd);
		
		}
		//if($.fn.cmtree.defaults.onClickTitlefn!=""){
		if(cmtreeval_defaults[id].onClickTitlefn!=""){
			//window[""+$.fn.cmtree.defaults.onClickTitlefn]($.fn.cmtree.rtnTreeArr(id, treecd));
			//console.log("$.fn.cmtree.onClickTreeTitle :onClickTitlefn==>"+cmtreeval_defaults[id].onClickTitlefn+":$.fn.cmtree.rtnTreeArr(id, treecd)==>"+$.fn.cmtree.rtnTreeArr(id, treecd));
			window[""+cmtreeval_defaults[id].onClickTitlefn]($.fn.cmtree.rtnTreeArr(id, treecd));
		}
		
		
	}
	
	// TODO : $.fn.cmtree.createChildTree
	$.fn.cmtree.createChildTree = function(id,treecdarr){
			var j = 0;
			tmp_str = "";
			var lev = 0;
			lev = treecdarr[4];
			//console.log("$.fn.cmtree.createChildTree=--------treecdarr--"+treecdarr);
			//alert($.fn.cmtree.defaults.createChildClickCnt);
			//console.log("$.fn.cmtree.createChildTree=cmtreeval.length--"+cmtreeval[id].length);
			//console.log("$.fn.cmtree.createChildTree=--"+$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]).children("li").length);
				if($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]).children("li").length==0){
					//console.log("$.fn.cmtree.createChildTree=cmtreeval[lev].length--"+cmtreeval[id][lev].length);
					//console.log("$.fn.cmtree.createChildTree=cmtreeval[lev]--"+cmtreeval[id][lev]);
					// 하위배열이 있는경우만 실행한다
					if(cmtreeval[id][lev]!=undefined && cmtreeval[id][lev]!=null){
						
						for(j=0;j<cmtreeval[id][lev].length;j++){
							//console.log("cmtreeval[id][lev][j][6]--"+cmtreeval[id][lev][j][6]+"-----"+treecdarr[6]);
							if(cmtreeval[id][lev][j][6].substring(0,cmtreeval[id][lev][j][6].lastIndexOf("__"))==treecdarr[6]){
								//console.log("cmtreeval[lev].length--"+cmtreeval[id][lev][j][6].substring(0,cmtreeval[id][lev][j][6].lastIndexOf("__"))+"-----"+treecdarr[6]);
								tmp_str = "<li id='tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' class='sub_"+(Number(lev)+1)+"d'>";
								
								//tmp_str += "<span style=''>";
								// 체크박스여부가 true이면
								//if($.fn.cmtree.defaults.checkBoxYn == true){
								if(cmtreeval_defaults[id].checkBoxYn == true){
									//style='margin-top:"+(Number(lev)==1?"20":(Number(lev)<3?"10":"5"))+"px;margin-left:"+(8.5*(Number(lev)+1))+"px;border:1px;'
									//tmp_str += "<input type='checkbox' id='tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' name='tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' value='"+cmtreeval[id][lev][j][6]+"' style='margin-top:"+(Number(lev)==1?"20":(Number(lev)<3?"10":"5"))+"px;margin-left:"+(8.5*(Number(lev)+1))+"px;width:15px;height:15px;padding:15px 13px;border-bottom:1px solid #b5b5b5;' onclick='$.fn.cmtree.chkTreeToggle(\""+id+"\",\""+cmtreeval[id][lev][j][6]+"\",\""+cmtreeval[id][lev][j][4]+"\", true);$.fn.cmtree.onClickTreeChecked(\""+id+"\",\""+cmtreeval[id][lev][j][6]+"\")' /> ";
									tmp_str += "<input type='checkbox' id='tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' name='tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' value='"+cmtreeval[id][lev][j][6]+"' style='width:13px;height:13px;' onclick='$.fn.cmtree.chkTreeToggle(\""+id+"\",\""+cmtreeval[id][lev][j][6]+"\",\""+cmtreeval[id][lev][j][4]+"\", true);$.fn.cmtree.onClickTreeChecked(\""+id+"\",\""+cmtreeval[id][lev][j][6]+"\")' /> ";
								}

								tmp_str += "<a style='' href='#' id='tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' onclick='$.fn.cmtree.onClickTreeTitle(\""+id+"\",\""+cmtreeval[id][lev][j][6]+"\")'>"+cmtreeval[id][lev][j][2]+"";

								tmp_str += "</a>";
								
								//tmp_str += "</span>";
								
									if(parseInt(cmtreeval[id][lev][j][7]) > 0){
										tmp_str += "<ul id='tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]+"' class='' style='display:none;'></ul>";
									}else{

									}
									tmp_str += "</li>";
									
									$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6].substring(0,cmtreeval[id][lev][j][6].lastIndexOf("__"))).append(tmp_str);
									if(parseInt(cmtreeval[id][lev][j][7]) == 0){
										//console.log("-----"+cmtreeval[id][lev][j][7]+"------"+"---"+cmtreeval[id][lev][j][6]);
										$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][lev][j][6]).addClass("noneC");
									}									
							}

							
						}
						
						//console.log("-----"+treecdarr);
						var treeBtn=$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]+" a ");
						var treeLi=$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]+" li");
						var firstLi=$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]+">ul>li:first-child");
						var lastLi=$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]+" ul li:last-child");
						var lastUl=lastLi.children("ul");
						
						firstLi.addClass("first");
						lastLi.addClass("last");
						lastUl.addClass("last");
						
						for(var i=0; i<treeLi.length; i++){
							var thisLi=treeLi.eq(i);
							var haveUl=thisLi.children("ul");
							var haveUlNum=haveUl.length;
							var thisbg=thisLi.attr("class");
							//thisLi.children("a").prepend("<img src='/images/tree/bul_page.gif' />");
		
						}						

						
						var treeBtn=$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecdarr[6]+" li a");
						
						treeBtn.click(function(){
							var thisNum=treeBtn.index(this);
							var thisBtn=treeBtn.eq(thisNum);
							var thisSubUl=thisBtn.parent().children("ul");
							var thislink = thisBtn.parent().children("a");
							var btn_tree_id_arr = "";
							//console.log(thisSubUl.attr("id")+"::--------"+thisSubUl.is(":visible"));
							if(thisSubUl.is(":visible")){
								//thisSubUl.slideUp("500");
								//console.log(thisSubUl.attr("id")+"::hide");
								thisSubUl.hide();
							}else{
								//console.log(thisSubUl.attr("id")+"::show");
								//thisSubUl.show();
								thisSubUl.slideDown("300");
								//console.log(">>>>>>>>>>>"+$(this).parent().children("ul").children("ul").attr("id"));
								//$(this).parent().children("ul").children("li").show();
							}
							if(thisBtn.parent().hasClass("on") == false){
								thisBtn.parent().addClass("on");
							}else{
								thisBtn.parent().removeClass("on");
							}
							
							//console.log(thisBtn.parent().prop("tagName")+"::");
							
							if($(thislink).attr("id")!=undefined){
								btn_tree_id_arr = $.fn.cmtree.rtnTreeArr(id ,$(thislink).attr("id").replace("tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_",""));
								
							}else{
								btn_tree_id_arr = undefined;
							}
							
							//if($.fn.cmtree.defaults.setAllYn==false){
							if(cmtreeval_defaults[id].setAllYn==false){
								//thislink.trigger("click");
								if($(thislink).attr("id")!=undefined){
									btn_tree_id_arr = $.fn.cmtree.rtnTreeArr(id ,$(thislink).attr("id").replace("tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_",""));
									//if($.fn.cmtree.defaults.onClickTitlefn!=""){
									//	$.fn.cmtree.createChildTree(btn_tree_id_arr);
									//	window[""+$.fn.cmtree.defaults.onClickTitlefn]($.fn.cmtree.rtnTreeArr(btn_tree_id_arr));
									//}else{
										$.fn.cmtree.createChildTree(id, btn_tree_id_arr);
										//if($.fn.cmtree.defaults.treeRelComboId!=""){
										if(cmtreeval_defaults[id].treeRelComboId!=""){
											$.fn.cmtree.treeRelComboboxSet(id ,btn_tree_id_arr[6], btn_tree_id_arr[4]);
											//$.fn.cmtree.treeRelComboboxMake(id ,btn_tree_id_arr[6],'', btn_tree_id_arr[4]);
											
											//$.fn.cmtree.onClickTreeTitle(btn_tree_id_arr[6]);
										}										
									//}									
					
								}								
							
							}							
			
							if(btn_tree_id_arr!=undefined){
								// 동레벨에 있는 모든 열린 트리를 닫아준다
								//$.fn.cmtree.closeTreeSameLevel(btn_tree_id_arr[1]+"", btn_tree_id_arr[4]+"");
							}						
						
						});						
					}
				
				}	
				

		
	}
	
	// TODO : $.fn.cmtree.onClickTreeChecked
	$.fn.cmtree.onClickTreeChecked = function(id ,treecd){
		//alert("$.fn.cmtree.onClickTreeTitle==="+treecd);
		//eval($.fn.cmtree.defaults.onClickTitlefn+"("+$.fn.cmtree.rtnTreeArr(treecd)+")");
		console.log("$.fn.cmtree.onClickTreeChecked=-----"+treecd);
		var cur_tree_arr;
		//if($.fn.cmtree.defaults.setAllYn==false){
		if(cmtreeval_defaults[id].setAllYn==false){
			cur_tree_arr = $.fn.cmtree.rtnTreeArr(id ,treecd);
			$.fn.cmtree.delay(100);
			//선택된 레벨의 하위 레벨 트리를 생성해준다
			$.fn.cmtree.createChildTree(id ,treecd,cur_tree_arr[4]);
		
		}
		
		//if($.fn.cmtree.defaults.onClickCheckedfn!=""){
		if(cmtreeval_defaults[id].onClickCheckedfn!=""){
			//window[""+$.fn.cmtree.defaults.onClickCheckedfn]($.fn.cmtree.rtnTreeArr(treecd));
			window[""+cmtreeval_defaults[id].onClickCheckedfn]($.fn.cmtree.rtnTreeArr(treecd));
		}
		
		
	}	
	// TODO : $.fn.cmtree.delay
	$.fn.cmtree.delay = function(gap){ /* gap is in millisecs */ 

		  var then,now; 

		  then=new Date().getTime(); 

		  now=then; 

		  while((now-then)<gap){ 

		    now=new Date().getTime();  // 현재시간을 읽어 함수를 불러들인 시간과의 차를 이용하여 처리 

		  } 

	} 
	
	
	// TODO : $.fn.cmtree.unchkTreeChildrenAll
	$.fn.cmtree.unchkTreeChildrenAll = function(id ,treecd){	
		var subChkAll = $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd+" input:checkbox[id^='tree_chk_']");
		
		subChkAll.each(function(){

				//$(this).attr("checked", false);
				document.getElementsByName($(this).attr("name"))[0].checked = false;

		});
		
	}	
	
	// TODO : $.fn.cmtree.selTreeParentAll
	// 특정 코드에 해당하는 트리를 상위포함해서 오픈하고 체크박스를 선택상태로 셋팅한다
	$.fn.cmtree.selTreeParentAll = function(id, treecd, treelev){
		//alert(treelev);
		//console.log("$.fn.cmtree.selTreeParentAll-------id:--->"+id+"--id:--->"+treecd+"--treelev:--->"+treelev);
		
		//console.log("cmtreeval::==>"+$.type(id));
		//console.log("cmtreeval::==>"+Object.keys(cmtreeval));
		//console.log("cmtreeval::==>"+JSON.stringify(eval("cmtreeval."+id)));
		if(treecd!="" && treecd!=undefined && treelev!="" && treelev!=undefined){
			var obj_key_arr = Object.keys(cmtreeval);
			var cur_lev = (parseInt(treelev,10)-1);
			var selLevArr = new Array();
			for(iu=0;iu<obj_key_arr.length;iu++){
				if(id==obj_key_arr[iu]){
					selLevArr = cmtreeval[obj_key_arr[iu]][cur_lev];
					break;
				}
				
			}

			//var selLevArr = cmtreeval[id];
			var iu = 0;
			var treeCdsStr = "";
			var treeCdsStrSp = null;		
	
			for(iu=0;iu<selLevArr.length;iu++){
				if(selLevArr[iu][6] == treecd){
					treeCdsStr = selLevArr[iu][6];
					//alert(treeCdsStr);
				}
			}
	
		
			//console.log("2-------------------------");
			treeCdsStrSp = treeCdsStr.split("__");
			//alert(treeCdsStr+"---"+treeCdsStrSp.length);
			for(iu=0;iu<treeCdsStrSp.length;iu++){
				// 해당 코드가 있으면 해당 ul만 열어준다
				//console.log("treeCdsStrSp[iu]:===>"+treeCdsStrSp[iu]);
				if(treeCdsStrSp[iu]!=""){
					//선택된 레벨의 하위 레벨 트리를 생성해준다
					//$.fn.cmtree.onClickTreeTitle(treeCdsStrSp[iu]);
					//선택된 레벨의 하위 레벨 트리를 생성해준다
					//if($.fn.cmtree.defaults.setAllYn==false){
					if(cmtreeval_defaults[id].setAllYn==false){
						$.fn.cmtree.createChildTree(id ,$.fn.cmtree.rtnTreeArr(id ,treeCdsStrSp[iu]));
					}
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treeCdsStrSp[iu]).slideDown("300");
				}
			}
			//console.log("3-------------------------");
			//$($.fn.cmtree.defaults.id+" a").css("color","");
			$(cmtreeval_defaults[id].id+" a").css("color","");
			//if($.fn.cmtree.defaults.seltreecd!=""){
			if(cmtreeval_defaults[id].seltreecd!=""){
				//$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.seltreecd).children("a").css("color","");
			}else{
				//$.fn.cmtree.defaults.seltreecd = treecd;
				cmtreeval_defaults[id].seltreecd = treecd;
			}
			//console.log("4-------------------------");
			if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).hasClass("sub_1d") == false){
				//$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("a").css("color", $.fn.cmtree.defaults.seltreebg);
				$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("a").css("color", cmtreeval_defaults[id].seltreebg);
			}
			
			//console.log("41-------------------------");
			//alert($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("img").eq(0).attr("src"));
			if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("img").eq(0).attr("src")=="plus.gif" || $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("img").eq(0).attr("src")=="minus.gif"){
				//console.log("42-------------------------");
				$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("img").eq(0).attr("src",$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("img").eq(0).attr("src").replace("plus.gif","minus.gif"));
			}
			
			//console.log("43-------------------------");
			//if(treecd!=undefined && treecd!="" && $.fn.cmtree.defaults.treeRelComboId!=""){
			if(treecd!=undefined && treecd!="" && cmtreeval_defaults[id].treeRelComboId!=""){
				//console.log("44-------------------------");
				
				$.fn.cmtree.scrollTreecd(id ,treecd);
			}
			
			//console.log("5-------------------------");
			
			//$.fn.cmtree.defaults.seltreecd = treecd;
			cmtreeval_defaults[id].seltreecd = treecd;
			
			// 해당 선택된 트리를 선택된 상태로 조회한다
			//document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd)[0].checked = true;
			//$.fn.cmtree.chkTreeToggle(treecd, treelev, false);			
		}


	}	
	
	// TODO :$.fn.cmtree.scrollTreecd
	$.fn.cmtree.scrollTreecd = function(id ,treecd){
		//console.log($(""+$.fn.cmtree.defaults.treeMenuId).css("display"));
		//console.log($(""+$.fn.cmtree.defaults.treeAreaId).css("display"));
		// 객체가 보이는경우만 실행한다
		
		
		//if($(""+$.fn.cmtree.defaults.treeAreaId).css("display")!="none" 
		//	&& $(""+$.fn.cmtree.defaults.treeMenuId).css("display")!="none"){
		if($(""+cmtreeval_defaults[id].treeAreaId).css("display")!="none" 
			&& $(""+cmtreeval_defaults[id].treeMenuId).css("display")!="none"){	
			//console.log("$.fn.cmtree.scrollTreecd---"+treecd);
			//var cur_tree_arr = $.fn.cmtree.rtnTreeArr(treecd);
			//alert($(""+$.fn.cmtree.defaults.treeMenuId).find("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).position().top-180);
			//var scrollrto = parseInt($(""+$.fn.cmtree.defaults.treeMenuId).prop("scrollHeight")/$(""+$.fn.cmtree.defaults.treeMenuId).height());
			//var scrollbarh = parseInt($(""+$.fn.cmtree.defaults.treeMenuId).height()/scrollrto);
			//var scrollbartop = $(""+$.fn.cmtree.defaults.treeMenuId).find("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).position().top-30;
			//console.log(""+($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top-$(""+$.fn.cmtree.defaults.id).offset().top));
			//var scrollbartop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top-$(""+$.fn.cmtree.defaults.id).offset().top;
			
			//var scrollbartop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top-$(""+cmtreeval_defaults[id].id).offset().top;
			//console.log($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).height()+"---"+$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).position().top);
			//console.log(treecd+"---"+$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).position().top+"----"+$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top+"----");
			//var scrollbartop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).position().top-$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).position().top;
			//var scrollbartop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top - $.fn.cmtree.GetObjectTopRef($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd), $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd));
			var scrollbartop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top;
			//var scrollbartop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top;
			//var objtop = $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top;
			//alert($(""+$.fn.cmtree.defaults.id).offset().top+"======"+$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top+"======"+scrollbartop);
			//alert("======"+$(""+$.fn.cmtree.defaults.treeMenuId).prop("scrollHeight"));-178+(89*scrollrto)
			//alert("scrollbarh==>"+scrollbarh+":::===>"+$(""+$.fn.cmtree.defaults.treeMenuId).find("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).position().top);
			//$(""+$.fn.cmtree.defaults.treeMenuId).animate({scrollTop:scrollbartop},'fast');	//권한그룹관리에서 에러남(explore8에서 지원안하는듯함 - 위쪽에서도 주석처리되어있음) - 주석처리함 kss 20150716
			//$(""+$.fn.cmtree.defaults.treeMenuId).scrollTop(scrollbartop);	
			
			//$(""+cmtreeval_defaults[id].treeMenuId).scrollTop(scrollbartop);
			/*if(scrollbartop >=0 && scrollbartop <= 570){
				$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(scrollbartop-450);
				console.log("11111111");
			}else if(scrollbartop > 570 && scrollbartop < 1000){
				$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(scrollbartop+300);
				console.log("22222222");
				if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top < $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop() && $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top > 0){
					console.log("22222222-1111111111");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop()+450);
				}else if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top < 20){
					console.log("22222222-2222222222");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(0);	
				}else if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top > 1000){
					console.log("22222222-3333333333");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top+300);
				}else{
					console.log("22222222-4444444444");
					if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top > 0){
						$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset());
					}else{
						$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(0);
					}
					
				}	

			}else{
				console.log("33333333");
				if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top < $("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop() && $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top > 0){
					console.log("33333333-1111111111");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop()+450);
				}else if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top < 20){
					console.log("33333333-2222222222");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(0);	
				}else if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top > 1000){
					console.log("33333333-3333333333");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top+300);
					if($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top < 0){
						console.log("33333333-3333333333--3333333333333333");
						$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top+100);
					}else{
						
					}
					
				}else{
					console.log("33333333-4444444444");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(0);
				}
				//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop($("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top);
			}*/
			//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop(scrollbartop);
			setTimeout(function(){
				$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).attr("tabindex",-1).focus();
			},0);
			
			//console.log("scrollbartop---"+$.fn.cmtree.GetObjectTopRef($("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd), $("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd)));	
			//console.log("scrollbartop---"+scrollbartop);
			//console.log("scrolltop:::"+$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].treeRootCd).scrollTop());
			//console.log("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd+".offset().top:::"+$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).offset().top);
			//return;
		}
	}	
	
	
	
	// 특정 코드에 해당하는 트리를 상위포함해서 오픈하고 체크박스를 선택상태로 셋팅한다
	// TODO :$.fn.cmtree.selTreeParentAll2
	$.fn.cmtree.selTreeParentAll2 = function(id ,treecd){	
		var selLevArr = $.fn.cmtree.rtnTreeArr(id ,treecd);
		var iu = 0;
		var treeCdsStr = "";
		var treeCdsStrSp = null;
		var tmp_tree_str = "";

		treeCdsStr = selLevArr[6];

		//최초등록시 에러남 - 강삼수 추가함
		if(treeCdsStr==undefined){
			treeCdsStr = "__";
		}

		treeCdsStrSp = treeCdsStr.split("__");
		//console.log(treeCdsStr+"---"+treeCdsStrSp.length);
		for(iu=0;iu<treeCdsStrSp.length;iu++){
			// 해당 코드가 있으면 해당 ul만 열어준다
			if(treeCdsStrSp[iu]!="" ){
				//if($.fn.cmtree.defaults.setAllYn==false){
				if(iu > 0){
					tmp_tree_str = tmp_tree_str + "__"+treeCdsStrSp[iu];
				}else{
					tmp_tree_str = tmp_tree_str + ""+treeCdsStrSp[iu];
				}
				
				//console.log("$.fn.cmtree.selTreeParentAll2===>"+treeCdsStr+"---"+tmp_tree_str);
				if(iu > 0){
					if(cmtreeval_defaults[id].setAllYn==false){
						$.fn.cmtree.createChildTree(id, $.fn.cmtree.rtnTreeArr(id ,tmp_tree_str));
						//console.log("$.fn.cmtree.selTreeParentAll2===>createChildTree");
					}
					//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treeCdsStrSp[iu]).slideDown("300");	
					$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+tmp_tree_str+"").addClass("on");
					$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+tmp_tree_str).slideDown("300");
				}

	
				
			}
		}
		//if($.fn.cmtree.defaults.seltreecd!=""){
		if(cmtreeval_defaults[id].seltreecd!=""){
			//$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$.fn.cmtree.defaults.seltreecd).children("a").css("color","");
			$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval_defaults[id].seltreecd).children("a").css("color","");
		}
		
		

		//$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("a").css("color", $.fn.cmtree.defaults.seltreebg);
		$("#tree_li_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd).children("a").css("color", cmtreeval_defaults[id].seltreebg);
		//if(treecd!=undefined && treecd!="" && $.fn.cmtree.defaults.treeRelComboId!=""){
		if(treecd!=undefined && treecd!="" && cmtreeval_defaults[id].treeRelComboId!=""){
			//console.log("id "+id +",treecd "+treecd);
			$.fn.cmtree.scrollTreecd(id ,treecd);			
		}
		
		//$.fn.cmtree.defaults.seltreecd = treecd;
		cmtreeval_defaults[id].seltreecd = treecd;
		
		// 해당 선택된 트리를 선택된 상태로 조회한다
		//document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treecd)[0].checked = true;
		//$.fn.cmtree.chkTreeToggle(treecd, treelev, false);

	}	
	

	// TODO :$.fn.cmtree.searchTree
	$.fn.cmtree.searchTree = function(id, sty, stext){
		var ist=0;
		var jst=0;
		var kst=0;
		var search_sel_yn = false;
		var treeCdsStrSp = null;
		var searchtreeCd = new Array();
		var tmp_rtnArr = new Array();
		$("a[id^='tree_link_']").css("color","");

		//console.log(id+"-----"+sty+"-----"+stext);
		for(ist=0;ist<cmtreeval[id].length;ist++){
			//alert(cmtreeval[id][i].length);
			for(jst=0;jst<cmtreeval[id][ist].length;jst++){
				search_sel_yn = false;
				// 검색조건이 셋팅되면 해당하는 트리를 오픈하고 색상을 바꿔준다
				if(sty==""){
					//console.log()
					if(cmtreeval[id][ist][jst][6].indexOf(stext) > -1 || cmtreeval[id][ist][jst][2].indexOf(stext) > -1){
						search_sel_yn = true;
						searchtreeCd.push(cmtreeval[id][ist][jst][6]);
					}					
				}else if(sty=="cd"){
					if(cmtreeval[id][ist][jst][6].indexOf(stext) > -1){
						search_sel_yn = true;
						searchtreeCd.push(cmtreeval[id][ist][jst][6]);
					}					
				}else if(sty=="nm"){
					if(cmtreeval[id][ist][jst][2].indexOf(stext) > -1){
						search_sel_yn = true;
						searchtreeCd.push(cmtreeval[id][ist][jst][6]);
						//console.log("$.fn.cmtree.searchTree===>"+cmtreeval[id][ist][jst]);
					}					
				}
				
				if(search_sel_yn == true){
					treeCdsStrSp = cmtreeval[id][ist][jst][6].split("__");
					//$("#tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][ist][jst][6]).css("color", $.fn.cmtree.defaults.seltreebg);
					//console.log(id+"---"+cmtreeval_defaults[id].id+"------"+cmtreeval[id][ist][jst][6]+"------"+cmtreeval[id][ist][jst][1]);
					
					//$.fn.cmtree.createChildTree(id,$.fn.cmtree.rtnTreeArr(id,cmtreeval[id][ist][jst][6]));
					tmp_rtnArr = $.fn.cmtree.rtnTreeArr(id, cmtreeval[id][ist][jst][6]);
					$.fn.cmtree.selTreeParentAll2(id, tmp_rtnArr[6]);
					$.fn.cmtree.scrollTreecd(id ,tmp_rtnArr[6]);
					
					/*$("#tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+cmtreeval[id][ist][jst][6]).css("color", cmtreeval_defaults[id].seltreebg);
					
					for(kst=0;kst<treeCdsStrSp.length;kst++){
						// 해당 코드가 있으면 해당 ul만 열어준다
						if(treeCdsStrSp[kst]!=""){
							console.log(treeCdsStrSp[kst]);
							tmp_rtnArr = $.fn.cmtree.rtnTreeArr(id, treeCdsStrSp[kst]);
							//$.fn.cmtree.selTreeParentAll(id, tmp_rtnArr[6], tmp_rtnArr[4]);
							$.fn.cmtree.selTreeParentAll2(id, tmp_rtnArr[6]);
							//$("#tree_ul_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treeCdsStrSp[kst]).slideDown("300");
						}
					}*/
				}

			}
		}
		
		return searchtreeCd;
		
	}
	
	
	// 선택된 체크박스 코드를 배열로 리턴한다
	// TODO :$.fn.cmtree.chkTreeArr
	$.fn.cmtree.chkTreeArr = function(id ){
		var cmtreeChkArr = new Array();

		var tmp_treeArr = new Array();
		var treechecked=$(id+" input[name^='tree_chk_']:checked");
		
		//alert("선택된갯수:"+treechecked.length);
		treechecked.each(function(){
			//console.log($("#tree_link_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+$(this).val()).text());
			
			tmp_treeArr = $.fn.cmtree.rtnTreeArr(id ,$(this).val());
			/*cmtreeChkArr[0].push(tmp_treeArr[1]);//' TREE_CD
			cmtreeChkArr[1].push(tmp_treeArr[2]);//' TREE_NM
			cmtreeChkArr[2].push(tmp_treeArr[3]);//' TREE_UPPO_CD
			cmtreeChkArr[3].push(tmp_treeArr[4]);//' TREE_LEVEL
			cmtreeChkArr[4].push(tmp_treeArr[5]);//' TREE_NMS
			cmtreeChkArr[5].push(tmp_treeArr[6]);//' TREE_CDS
			cmtreeChkArr[6].push(tmp_treeArr[7]);//' TREE_SUB_CNT*/
			cmtreeChkArr.push(tmp_treeArr);
		}); 
		return cmtreeChkArr;
	};	
	
	
	// 입력된 트리에서 제외될 코드를 루프를 돌며 체크박스를 해제시킨다
	// TODO :$.fn.cmtree.unchkTreeArr
	$.fn.cmtree.unchkTreeArr = function(id ,unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu])[0].checked = false;
			// 하위체크박스를 해제 시킨다
			$.fn.cmtree.unchkTreeChildrenAll(id ,treechecks_sp[iu]);
		}

	};	
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를 해제시킨다
	// TODO :$.fn.cmtree.chkedTreeArr
	$.fn.cmtree.chkedTreeArr = function(id ,unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		var tree_arr = new Array();
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu])[0].checked = true;
			tree_arr = $.fn.cmtree.rtnTreeArr(id ,treechecks_sp[iu]);
			//console.log(treechecks_sp[iu]+"--"+tree_arr);
			// 상위트리를 열어준다
			$.fn.cmtree.selTreeParentAll(id ,treechecks_sp[iu], tree_arr[4]);
			// 하위체크박스를 해제 시킨다
			//$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};	
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를 해제시킨다
	// TODO :$.fn.cmtree.chkedTreeArr
	$.fn.cmtree.unchkedTreeAll = function(id ){

		$(""+id).find("input:checkbox").attr("checked", false);

	};	
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를  disabled
	// TODO :$.fn.cmtree.disabledTreeArr
	$.fn.cmtree.disabledTreeArr = function(id ,unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		var tree_arr = new Array();
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu])[0].disabled = true;
			tree_arr = $.fn.cmtree.rtnTreeArr(id ,treechecks_sp[iu]);
			//console.log(treechecks_sp[iu]+"--"+tree_arr);
			// 상위트리를 열어준다
			$.fn.cmtree.selTreeParentAll(id ,treechecks_sp[iu], tree_arr[4]);
			// 하위체크박스를 해제 시킨다
			//$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};		
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를  disabled
	// TODO :$.fn.cmtree.undisabledTreeArr
	$.fn.cmtree.undisabledTreeArr = function(id ,unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		var tree_arr = new Array();
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+cmtreeval_defaults[id].id.replace(/#/gi,"")+"_"+treechecks_sp[iu])[0].disabled = false;
			tree_arr = $.fn.cmtree.rtnTreeArr(id ,treechecks_sp[iu]);
			//console.log(treechecks_sp[iu]+"--"+tree_arr);
			// 상위트리를 열어준다
			$.fn.cmtree.selTreeParentAll(id ,treechecks_sp[iu], tree_arr[4]);
			// 하위체크박스를 해제 시킨다
			//$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};
	
	
	// TODO :$.fn.cmtree.rtnTreeArr
	$.fn.cmtree.rtnTreeArr = function(id, treecd){
		var tmp_rtn_arr = new Array();
		for(ir=0;ir<cmtreeval[id].length;ir++){
			//alert(cmtreeval[id][ir].length);
			for(jr=0;jr<cmtreeval[id][ir].length;jr++){	
				//console.log(cmtreeval[id][ir][jr][1]+"==="+treecd+"==="+(cmtreeval[id][ir][jr][1]==treecd));
				if(cmtreeval[id][ir][jr][6]==treecd){
					tmp_rtn_arr = cmtreeval[id][ir][jr];
					break;
				}
			}
			
		}
		//console.log("rtnTreeArr==="+tmp_rtn_arr+"==="+treecd+"===");
		return tmp_rtn_arr;
		
	};
	
	$.fn.cmtree.rtnTreeArr2 = function(id, treecd){
		var tmp_rtn_arr = new Array();
		for(ir=0;ir<cmtreeval[id].length;ir++){
			//alert(cmtreeval[id][ir].length);
			for(jr=0;jr<cmtreeval[id][ir].length;jr++){	
				//console.log(cmtreeval[id][ir][jr][1]+"==="+treecd+"==="+(cmtreeval[id][ir][jr][1]==treecd));
				if(cmtreeval[id][ir][jr][1]==treecd){
					tmp_rtn_arr = cmtreeval[id][ir][jr];
					break;
				}
			}
			
		}
		//console.log("rtnTreeArr==="+tmp_rtn_arr+"==="+treecd+"===");
		return tmp_rtn_arr;
		
	};	
	
	// 상위 콤보박스까지 생성해줘야한다
	// TODO :$.fn.cmtree.treeRelComboboxSet
	$.fn.cmtree.treeRelComboboxSet = function(id, seltreecd, treelev){
		/*var selLevArr = cmtreeval[treelev];
		var comboboxidstr = (treelev==1)?"#"+$.fn.cmtree.defaults.treeRelComboboxId:"#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(treelev-1);
		
		$(""+comboboxidstr+" > option[value="+seltreecd+"]").attr("selected", true);*/
		
		//if(cmtreeval[id].length < treelev){
		//	return;
		//}
		var selLevArr = cmtreeval[id][treelev-1];
		var treeCdsStr = "";
		var treeCdsStrSp = null;
		for(is=0;is<selLevArr.length;is++){
			if(selLevArr[is][6] == seltreecd){
				treeCdsStr = selLevArr[is][6];
				break;
			}
		}	
		
		//select id로 크기를 가져와서 더큰놈은 다지우기   	
	    //var combolarr = $("select[name^='"+$.fn.cmtree.defaults.treeRelComboboxId+"']");
		var combolarr = $("select[name^='"+cmtreeval_defaults[id].treeRelComboboxId+"']");
		//alert(combolength);
		//for(var i=combolarr.length;i>0;i--){
		//	combolarr[i-1].remove();
		//}	
		//console.log("treeRelComboboxSet combolarr.length----"+combolarr.length);
	    combolarr.each(function(idx){
	    	if(idx!=0){
	    		
	    		//$(this).remove();
	    		//$("#"+$.fn.cmtree.defaults.treeRelComboboxId+idx).remove();
	    		$("#"+cmtreeval_defaults[id].treeRelComboboxId+idx).remove();
	    	}
				

		});
		
	    //console.log("treeRelComboboxSet treeCdsStr==="+treeCdsStr);
		treeCdsStrSp = treeCdsStr.split("__");
		var bar_pos = treeCdsStr.indexOf("__");
		var tree_set_id = "";
		//alert(treeCdsStr);
		// 최상위부터 셀렉트 박스를 생성하며 데이터를 셋팅한다
		for(is=0;is<treeCdsStrSp.length;is++){
			tree_set_id = treeCdsStr.substring(0,bar_pos);
			if(is < treeCdsStrSp.length-1){
				bar_pos = tree_set_id.length+2+treeCdsStrSp[is+1].length;
			}
			
			if(is==0){
				//console.log("treeRelComboboxSet 0----"+treeCdsStrSp[is]);
				//$("#"+$.fn.cmtree.defaults.treeRelComboboxId+" > option[value="+treeCdsStrSp[is]+"]").attr("selected", true);
				if(treeCdsStrSp[is]!=undefined && treeCdsStrSp[is]!=""){
					$("#"+cmtreeval_defaults[id].treeRelComboboxId+" > option[value="+treeCdsStrSp[is]+"]").attr("selected", true);
				}
				
			}else{
				// 셀렉트박스가 있으면 값을 셋팅하고 없으면 생성하며 셋팅한다
				//console.log($("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)).length);

				
				//if($("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)).length > 0){
				if($("#"+cmtreeval_defaults[id].treeRelComboboxId+Number(is)).length > 0){
					// 옵션값을 삭제하고 다시 셋팅한다
					//console.log("treeRelComboboxSet 1----"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+"--"+$("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)).length);
					$.fn.cmtree.treeRelComboboxMake(id, treeCdsStrSp[is-1], treeCdsStrSp[is], is);
					
					//$("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+" > option[value="+treeCdsStrSp[is]+"]").attr("selected", true);
					$("#"+cmtreeval_defaults[id].treeRelComboboxId+Number(is)+" > option[value="+treeCdsStrSp[is]+"]").attr("selected", true);
				}else{
					
					//alert(treeCdsStrSp[is-1]+"------"+treeCdsStrSp[is]);
					//console.log("treeRelComboboxSet 2--"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+"--"+tree_set_id.substring(0,tree_set_id.lastIndexOf("__"))+"---"+tree_set_id);
					$.fn.cmtree.treeRelComboboxMake(id, tree_set_id.substring(0,tree_set_id.lastIndexOf("__")), tree_set_id, is+1);
					//$.fn.cmtree.treeRelComboboxMake(id, tree_set_id, tree_set_id, is+1);
					
					$("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+" > option[value="+tree_set_id+"]").attr("selected", true);
				}
				//$.fn.cmtree.treeRelComboboxMake= function(upseltreecd,seltreecd, treelev){
			}
		}
		
		// 마지막 셀렉트박스의 하위가 있으면 생성한다

	}
	
	// TODO :$.fn.cmtree.treeRelComboboxMake
	$.fn.cmtree.treeRelComboboxMake= function(id,upseltreecd,seltreecd, treelev){
		//if($.fn.cmtree.defaults.dataSetYn==false){
		if(cmtreeval_defaults[id].dataSetYn==false){
			alert("트리데이터가 셋팅되지않았습니다.");
			return;
		}
		var combostr = "";
		var it = 0;
		var is = 0;
		//alert(cmtreeval[id].length+"---"+(treelev-1));
		var selLevArr = cmtreeval[id][treelev];
		var sel = "";
		var optioncnt = 0;
	    //var comboboxlength = $("select[name^='"+$.fn.cmtree.defaults.treeRelComboboxId+"']").length;
		var comboboxlength = $("select[name^='"+cmtreeval_defaults[id].treeRelComboboxId+"']").length;
		//alert(combolength);
		//for(var is=comboboxlength;treelev<is;is--){
		//    $("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is-1)).remove();
		//}		
		// 최상위 레벨일경우
	    //console.log("treeRelComboboxMake---upseltreecd--"+upseltreecd+"----seltreecd--"+seltreecd+"----treelev--"+treelev);
		if(treelev==1){

				for(it=0;it<selLevArr.length;it++){
					if(selLevArr[it][6]!=undefined){
						sel = ( seltreecd.trim()==selLevArr[it][6].trim() ) ? "selected" : "";
					}else{
						sel = "";
					}					
					
					combostr += "<option title='"+selLevArr[it][2]+"' value='" + selLevArr[it][6] + "' id='" + selLevArr[it][6] + "'" + sel + ">" + selLevArr[it][2] + "</option>";
					optioncnt++;
				}
				//$("#"+$.fn.cmtree.defaults.treeRelComboboxId).append(combostr);
				$("#"+cmtreeval_defaults[id].treeRelComboboxId).append(combostr);

		}else{
			//console.log(selLevArr);
			//console.log("treeRelComboboxMake---"+cmtreeval_defaults[id].treeRelComboboxId+""+(Number(treelev)-2)+"----seltreecd--"+seltreecd);
			if(seltreecd!=""){
				if((Number(treelev)-2)>0){
					$("#"+cmtreeval_defaults[id].treeRelComboboxId+""+(Number(treelev)-2)+" > option[value="+seltreecd+"]").attr("selected", true);
				}else{
					$("#"+cmtreeval_defaults[id].treeRelComboboxId+""+" > option[value="+seltreecd+"]").attr("selected", true);
				}				
			}

			
			if(selLevArr!=undefined){
				for(it=0;it<selLevArr.length;it++){
					//console.log(upseltreecd+"=="+selLevArr[it][6]+"=="+selLevArr[it][6].substring(0,selLevArr[it][6].lastIndexOf("__")));
					if(selLevArr[it][6].substring(0,selLevArr[it][6].lastIndexOf("__")) == seltreecd){
						//console.log(seltreecd+"=="+selLevArr[it][6]+"=="+selLevArr[it][6].substring(0,selLevArr[it][6].lastIndexOf("__")));
						//console.log(seltreecd+"=="+selLevArr[it][i][2]);
						if(selLevArr[it][6]!=undefined){
							sel = ( seltreecd.trim()==selLevArr[it][6].trim() ) ? "selected" : "";
						}else{
							sel = "";
						}
						
						combostr += "<option title='"+selLevArr[it][2]+"' value='" + selLevArr[it][6] + "' id='" + selLevArr[it][6] + "'" + sel + ">" + selLevArr[it][2] + "</option>";
						optioncnt++;
					}
				}
				if(optioncnt>0){
					//$("#"+$.fn.cmtree.defaults.treeRelComboId).append("<select style='vertical-align:middle;' name='"+$.fn.cmtree.defaults.treeRelComboboxId+"' id='"+($.fn.cmtree.defaults.treeRelComboboxId+""+treelev)+"' onchange='optionGroup($(this), "+(Number(treelev)+1)+",\"N\",\"\")'> <option value=''>선택없음</option> </select>");
					//$("#"+$.fn.cmtree.defaults.treeRelComboboxId+""+treelev).append(combostr);
					
					$("#"+cmtreeval_defaults[id].treeRelComboId).append("<select style='vertical-align:middle;' name='"+cmtreeval_defaults[id].treeRelComboboxId+"' id='"+(cmtreeval_defaults[id].treeRelComboboxId+""+(Number(treelev)-1))+"' onchange='"+cmtreeval_defaults[id].treeRelComboboxId+"_optionGroup($(this), "+(Number(treelev)+1)+",\"N\",\"\")'> <option value=''>선택없음</option> </select>");
					$("#"+cmtreeval_defaults[id].treeRelComboboxId+""+(Number(treelev)-1)).append(combostr);					
				}				
			}

			
		}
		
		return true;
	};	
	
	// 선택된 체크박스 코드를 배열로 리턴한다
	$.fn.cmtree.chkTreeArr2 = function(id){
		var cmtreeChkArr = new Array();
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		cmtreeChkArr.push(new Array());
		var tmp_treeArr = new Array();
		var treechecked=$(id+" input[name^='tree_chk_']:checked");
		
		//alert("선택된갯수:"+treechecked.length);
		treechecked.each(function(){
			//console.log($("#tree_link_"+$(this).val()).text());
			
			tmp_treeArr = $.fn.cmtree.rtnTreeArr(id, $(this).val());
			cmtreeChkArr[0].push(tmp_treeArr[1]);//' TREE_CD
			cmtreeChkArr[1].push(tmp_treeArr[2]);//' TREE_NM
			cmtreeChkArr[2].push(tmp_treeArr[3]);//' TREE_UPPO_CD
			cmtreeChkArr[3].push(tmp_treeArr[4]);//' TREE_LEVEL
			cmtreeChkArr[4].push(tmp_treeArr[5]);//' TREE_NMS
			cmtreeChkArr[5].push(tmp_treeArr[6]);//' TREE_CDS
			cmtreeChkArr[6].push(tmp_treeArr[7]);//' TREE_SUB_CNT
		}); 
		return cmtreeChkArr;
	};	
	
	
	/**
	HTML 개체용 유틸리티 함수
	 **/
	// TODO :$.fn.cmtree.GetObjectTop
	$.fn.cmtree.GetObjectTop= function(obj){	
		
			if (obj.offsetParent == document.body)
				return obj.offsetTop;
			else
				return obj.offsetTop + $.fn.cmtree.GetObjectTop(obj.offsetParent);
	};
	
	// TODO :$.fn.cmtree.GetObjectLeft
	$.fn.cmtree.GetObjectLeft= function(obj){	
		
		if (obj.offsetParent == document.body)
			return obj.offsetLeft;
		else
			return obj.offsetLeft + $.fn.cmtree.GetObjectLeft(obj.offsetParent);
	};	
	
	// TODO :$.fn.cmtree.GetObjectLeft
	$.fn.cmtree.GetObjectTopRef= function(refobj, obj){	
		//console.log("tagName-----"+$(obj).prop("tagName")+"---ID-----"+$(obj).prop("id")+"---refobj ID-----"+$(refobj).prop("id"));
		if ($(obj).prop("tagName").toUpperCase() == "BODY" || $(refobj).prop("id") == $(obj).prop("id"))
			//return $(obj).offset().top;
			return $(obj).height();
		else
			return $(obj).height() + $.fn.cmtree.GetObjectTopRef($(refobj), $(obj).parent());
	};		

})(jQuery);


