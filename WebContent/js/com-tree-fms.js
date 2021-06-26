/**================================================================================
 * @name: javascript 공통 package - cmtree plugin
 * @author: jhlee
 * @demo: 
 * @version: 0.1.0
 * @charset: utf-8
 ================================================================================*/
(function($) {
  var cmtreeval = new Array();
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
		
		$.fn.cmtree.defaults.treeArr = opt.treeArr;
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
		if($.fn.cmtree.defaults.treeHeight!=""){
			$(""+$.fn.cmtree.defaults.treeAreaId).css("height",$.fn.cmtree.defaults.treeHeight);
			$(""+$.fn.cmtree.defaults.treeMenuId).css("height",$.fn.cmtree.defaults.treemHeight);
		}

		if($.fn.cmtree.defaults.treeWidth!=""){
			$(""+$.fn.cmtree.defaults.treeAreaId).css("width",$.fn.cmtree.defaults.treeWidth);
			$(""+$.fn.cmtree.defaults.treeMenuId).css("width",$.fn.cmtree.defaults.treemWidth);
		}
		
		$.fn.cmtree.defaults.treeImgPath = (opt.treeImgPath==undefined || opt.treeImgPath=="")?"":opt.treeImgPath;
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
		
		// 레벨별로 트리데이터를 정리한다
		for(i=0;i<treeList.length;i++){
			//' 첫번째 데이터의 경우 초기 lv값을 셋팅한다
			if (i==0){
				init_lv =  parseInt(treeList[i]['tree_level']);
			}	
			tmp_lv = parseInt(treeList[i]['tree_level']) - init_lv;
			
			if (i==0){
				cmtreeval[tmp_lv] = new Array();
			}else if( prev_lv < tmp_lv ){
				cmtreeval[tmp_lv] = new Array();
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
			cmtreeval_tmp[5]  = treeList[i]['tree_nms']+""; //' TREE_NMS
			cmtreeval_tmp[6]  = treeList[i]['tree_cds']+""; //' TREE_CDS
			cmtreeval_tmp[7]  = treeList[i]['tree_sub_cnt']+""; //' TREE_SUB_CNT
			cmtreeval_tmp[8]  = treeList[i]['tree_group_cd']+""; //' TREE_GROUP_CD

			cmtreeval[tmp_lv].push(cmtreeval_tmp);	
			
			prev_lv = tmp_lv;
		}
		
		$.fn.cmtree.defaults.dataSetYn = true;
		
		// 정리된 데이터를 html로 생성한다
		tmp_innerhtml_str = "";
		tmp_str = "";
		//console.log("$.fn.cmtree.defaults.setAllYn::"+$.fn.cmtree.defaults.setAllYn);
		if($.fn.cmtree.defaults.setAllYn==true){
			init_lev = cmtreeval.length;	
			
		}else{
			// 1레벨만 설정한다
			init_lev = 1;
		}
		

		for(i=0;i<init_lev;i++){
			//alert(cmtreeval[i].length);
			for(j=0;j<cmtreeval[i].length;j++){	
				if(i==0){
					tmp_str = "<li id='tree_li_"+cmtreeval[i][j][6]+"'>";
				}else{
					tmp_str = "<li id='tree_li_"+cmtreeval[i][j][6]+"'>";
				}
				
				// 체크박스여부가 true이면
				if($.fn.cmtree.defaults.checkBoxYn == true){
					tmp_str += " <input type='checkbox' id='tree_chk_"+cmtreeval[i][j][6]+"' name='tree_chk_"+cmtreeval[i][j][6]+"' value='"+cmtreeval[i][j][6]+"' style='margin-top:-3px;' onclick='$.fn.cmtree.chkTreeToggle(\""+cmtreeval[i][j][6]+"\",\""+cmtreeval[i][j][4]+"\", true);$.fn.cmtree.onClickTreeChecked(\""+cmtreeval[i][j][6]+"\")' /> ";
				}
				//if(i==0){
				//	if(cmtreeval[i][j][7] > 1){
						//tmp_str += "<img  src='/images/tree/btn_plus.gif' alt='하위메뉴 보기' />";
				//	}
				//}
				tmp_str += " <a href='#none' id='tree_link_"+cmtreeval[i][j][6]+"' onclick='$.fn.cmtree.onClickTreeTitle(\""+cmtreeval[i][j][6]+"\")'>"+cmtreeval[i][j][2]+"</a>";
				// 1레벨일경우
				if(i==0){
					if(parseInt(cmtreeval[i][j][7]) > 0){
						
						tmp_str += "<ul id='tree_ul_"+cmtreeval[i][j][6]+"' style='display:none;'></ul>";
					}
					tmp_str += "</li>";
					$(id).append(tmp_str);
				}else{
					if(parseInt(cmtreeval[i][j][7]) > 0){
						tmp_str += "<ul id='tree_ul_"+cmtreeval[i][j][6]+"' style='display:none;'></ul>";
					}else{

					}
					tmp_str += "</li>";
					$("#tree_ul_"+cmtreeval[lev][j][6].substring(0,cmtreeval[lev][j][6].lastIndexOf("__"))).append(tmp_str);
					
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
			thisLi.children("a").prepend("<img src='"+$.fn.cmtree.defaults.treeImgPath+"/tree/bul_page.gif' />");
				if(haveUlNum=="0"){
					if(thisbg=="first"){
						 thisLi.addClass("none_first");
					}else if(thisbg=="last"){
						thisLi.addClass("none_last");
					}else{
						thisLi.addClass("noneTree");
					}
				}else if(haveUlNum!="0"){
					thisLi.children("a").before("<img id='tree_pm_btn_"+cmtreeval[0][0][6]+"' src='"+$.fn.cmtree.defaults.treeImgPath+"/tree/btn_plus.gif' alt='하위메뉴 보기' />");
				}
		}
		
		// 최상위 레벨의 경우 하위레벨의 존재여부를 확인해서 해당 +, -버튼을 없앤다
		if($.fn.cmtree.defaults.setAllYn==false){
			for(j=0;j<cmtreeval[0].length;j++){	
				if(parseInt(cmtreeval[0][j][7]) < 1){
					var onelevel_img = $("#tree_li_"+cmtreeval[0][j][6]).children("img");
					onelevel_img.each(function(){
						if($(this).attr("src") == ""+$.fn.cmtree.defaults.treeImgPath+"/tree/btn_plus.gif"
							|| $(this).attr("src") == ""+$.fn.cmtree.defaults.treeImgPath+"/tree/btn_minus.gif"){
							$(this).remove();
						}
					});					

				}
				
			}
		}
		
		var treeBtn=$(id+" li img");
		
		treeBtn.click(function(){
			
			var thisNum=treeBtn.index(this);
			var thisBtn=treeBtn.eq(thisNum);
			var thisSubUl=thisBtn.parent().children("ul");
			var thislink = thisBtn.parent().children("a");
			var btn_tree_id_arr = "";
			
			//console.log(">>>>>>>>>>>"+$(this).parent().children("ul").children("ul").attr("id"));
			/*if(thisSubUl.is(":visible")){
				thisBtn.attr("src",thisBtn.attr("src").replace("minus.gif","plus.gif"));
				//thisSubUl.slideUp("500");
				thisSubUl.hide();
			}else{
				thisBtn.attr("src",thisBtn.attr("src").replace("plus.gif","minus.gif"));
				thisSubUl.slideDown("300");
				//console.log(">>>>>>>>>>>"+$(this).parent().children("ul").children("ul").attr("id"));
				//$(this).parent().children("ul").children("li").show();
			}*/
			
			if($(thislink).attr("id")!=undefined){
				btn_tree_id_arr = $.fn.cmtree.rtnTreeArr($(thislink).attr("id").replace("tree_link_",""));
				
			}else{
				btn_tree_id_arr = undefined;
			}
			
			//console.log("btn_tree_id_arr--"+btn_tree_id_arr)
			/*if($.fn.cmtree.defaults.setAllYn==false){
				//alert($(thislink).attr("id"));
				
				
				if($(thislink).attr("id")!=undefined){
					btn_tree_id_arr = $.fn.cmtree.rtnTreeArr($(thislink).attr("id").replace("tree_link_",""));
					//if($.fn.cmtree.defaults.onClickTitlefn!=""){
					//	$.fn.cmtree.createChildTree(btn_tree_id_arr);
					//	window[""+$.fn.cmtree.defaults.onClickTitlefn]($.fn.cmtree.rtnTreeArr(btn_tree_id_arr));
					//}else{
						$.fn.cmtree.createChildTree(btn_tree_id_arr);
						
						if($.fn.cmtree.defaults.treeRelComboId!=""){
							$.fn.cmtree.treeRelComboboxSet(btn_tree_id_arr[6], btn_tree_id_arr[4]);
							$.fn.cmtree.treeRelComboboxMake(btn_tree_id_arr[6],'', btn_tree_id_arr[4]);
							//$.fn.cmtree.onClickTreeTitle(btn_tree_id_arr[1]);
						}	
						//$.fn.cmtree.onClickTreeTitle(btn_tree_id_arr[6]);
					//}
					
				
				}
				//thislink.trigger("click");
							

			}*/
			
			
			//console.log("btn_tree_id_arr--"+btn_tree_id_arr);
			if(btn_tree_id_arr!=undefined){
				// 동레벨에 있는 모든 열린 트리를 닫아준다
				//$.fn.cmtree.closeTreeSameLevel(btn_tree_id_arr[1]+"", btn_tree_id_arr[4]+"");
				//console.log("btn_tree_id_arr--"+btn_tree_id_arr);
				$.fn.cmtree.onClickTreeTitle($(thislink).attr("id").replace("tree_link_",""));	
			}
		
		});
		//트리메뉴 끝				
	};
	
	// TODO : $.fn.cmtree.closeTreeSameLevel
	$.fn.cmtree.closeTreeSameLevel = function(treecd, treelev){	
		var selLevArr = cmtreeval[treelev-1];
		var iu = 0;
		var treeCdsStr = "";
		var treeCdsStrSp = null;
		//console.log("treecd::"+treecd);
		for(iu=0;iu<selLevArr.length;iu++){
			//console.log("selLevArr::"+selLevArr[iu][1]);
			if(selLevArr[iu][6] != treecd){
				//console.log("#tree_ul_"+selLevArr[iu][1]+"::"+$("#tree_ul_"+selLevArr[iu][1]).css("display"));
				if($("#tree_ul_"+selLevArr[iu][6]).css("display")=="" || $("#tree_ul_"+selLevArr[iu][6]).css("display")=="block"){
					$("#tree_ul_"+selLevArr[iu][6]).hide();
				}
			}else{
				$("#tree_ul_"+treecd).show();
			}
		}		

		
	}	
	
	// 체크박스 선택에 따라 하위체크박스 토글
	// TODO : $.fn.cmtree.chkTreeToggle
	$.fn.cmtree.chkTreeToggle = function(treecd, treelev, fixchk){
		//alert(treecd+":start");
		var chkobj_yn = false;
		
		if(fixchk == true){
			chkobj_yn = $("#tree_chk_"+treecd).is(":checked");
		}else{
			chkobj_yn = true;
		}
		
		//alert(chkobj_yn);
		// 체크박스를 선택하면 하위의 트리를 모두 연다
		if(chkobj_yn == true){
			if($.fn.cmtree.defaults.setAllYn==false){
				//선택된 레벨의 하위 레벨 트리를 생성해준다
				$.fn.cmtree.createChildTree($.fn.cmtree.rtnTreeArr(treecd));
			
			}			
			$("#tree_ul_"+treecd).slideDown("300");
		}else{
			//$("#tree_ul_"+treecd).slideUp("500");
			$("#tree_ul_"+treecd).hide();
			// 체크박스를 선택해제 할경우 상위 트리의 체크박스를 선택해제한다
			$.fn.cmtree.unchkTreeParentAll(treecd, treelev);
			
		}		
		
		$($.fn.cmtree.defaults.id+" a").css("color","");
		if($.fn.cmtree.defaults.seltreecd!=""){
			//$("#tree_li_"+$.fn.cmtree.defaults.seltreecd).children("a").css("color","");
		}else{
			$.fn.cmtree.defaults.seltreecd = treecd;
		}

		$("#tree_li_"+treecd).children("a").css("color", $.fn.cmtree.defaults.seltreebg);		
		
		// 하위의 모든 체크박스를 체크해주고 언체크해준다
		var subChkAll = "";
		//alert($("#tree_ul_"+treecd).length);
		if($("#tree_ul_"+treecd).length > 0){
			subChkAll = $("#tree_ul_"+treecd).find("input:checkbox[id^='tree_chk2_']");
		}else{
			subChkAll = $("#tree_li_"+treecd).find("input:checkbox[id^='tree_chk2_']");
			$("#tree_li_"+treecd).children("ul").show();
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
		
		/*var subUlAll = $("#tree_ul_"+treecd+" ul");
		subUlAll.each(function(){
			if(chkobj_yn == true){
				$(this).slideDown("500");
			}else{
				//$(this).slideUp("500");
				$(this).hide();
				
			}
		}); */
		
		// 하위츼 체크박스를 모두 선택한다
		/*var subChkAll = $("#tree_ul_"+treecd+" input:checkbox[id^='tree_chk_']");
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
	$.fn.cmtree.unchkTreeParentAll = function(treecd, treelev){	
		var selLevArr = cmtreeval[treelev-1];
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
			if(treeCdsStrSp[iu]!=""){
				document.getElementsByName("tree_chk_"+treeCdsStrSp[iu])[0].checked = false;
			}
		}
		
	}
	
	// TODO : $.fn.cmtree.unchkTreeParentAll2
	$.fn.cmtree.unchkTreeParentAll2 = function(treecd, treelev){	
		var selLevArr = cmtreeval[treelev-1];
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
					document.getElementsByName("tree_chk_"+treeCdsStrSp[iu])[0].checked = false;
				}				
			}

		}
		
	}	
	
	// TODO : $.fn.cmtree.onClickTreeTitle
	$.fn.cmtree.onClickTreeTitle = function(treecd){
		//alert("$.fn.cmtree.onClickTreeTitle==="+treecd);
		//eval($.fn.cmtree.defaults.onClickTitlefn+"("+$.fn.cmtree.rtnTreeArr(treecd)+")");
		//console.log("$.fn.cmtree.onClickTreeTitle :==>"+treecd);
		// 최상위만 셋팅된 경우 하위레벨을 셋팅한다
		var cur_tree_arr;
		if($.fn.cmtree.defaults.setAllYn==false){
			cur_tree_arr = $.fn.cmtree.rtnTreeArr(treecd);
			//$(""+$.fn.cmtree.defaults.treeMenuId).animate({scrollTop:$("#tree_li_"+treecd).position().top},'fast');
			//선택된 레벨의 하위 레벨 트리를 생성해준다
			$.fn.cmtree.createChildTree(cur_tree_arr);
		
		}
		// 
		//console.log("treecd::"+treecd);
		//$("#tree_pm_btn_"+treecd).trigger("click");
		
		var treeCdsStrSp = treecd.split("__");
		var treeul_full_str = "";
		//alert(treeCdsStr+"---"+treeCdsStrSp.length);
		
		if($("#tree_ul_"+treecd).is(":visible")){
			if($("#tree_pm_btn_"+treecd).attr("src")!=undefined){
				$("#tree_pm_btn_"+treecd).attr("src",$("#tree_pm_btn_"+treecd).attr("src").replace("minus.gif","plus.gif"));
				//thisSubUl.slideUp("500");
				$("#tree_ul_"+treecd).hide();				
			}

		}else{
			//console.log($("#tree_pm_btn_"+treecd));
			//console.log($("#tree_pm_btn_"+treecd).attr("src"));
			if($("#tree_pm_btn_"+treecd).attr("src")!=undefined){
				$("#tree_pm_btn_"+treecd).attr("src",$("#tree_pm_btn_"+treecd).attr("src").replace("plus.gif","minus.gif"));
				for(iu=0;iu<treeCdsStrSp.length;iu++){
					// 해당 코드가 있으면 해당 ul만 열어준다
					//console.log("treeCdsStrSp[iu]:===>"+treeCdsStrSp[iu]);
					if(treeCdsStrSp[iu]!=""){
						//선택된 레벨의 하위 레벨 트리를 생성해준다
						//$.fn.cmtree.onClickTreeTitle(treeCdsStrSp[iu]);
						//선택된 레벨의 하위 레벨 트리를 생성해준다
						if($.fn.cmtree.defaults.setAllYn==false){
							//console.log("treeCdsStrSp[iu]:===>"+treeCdsStrSp[iu]);
							$.fn.cmtree.createChildTree($.fn.cmtree.rtnTreeArr(treeCdsStrSp[iu]));
						}
						if(iu==0){
							treeul_full_str = treeCdsStrSp[iu];
						}else{
							treeul_full_str = treeul_full_str +"__"+ treeCdsStrSp[iu];
						}
						
						//console.log("treeul_full_str:===>"+treeul_full_str);
						$("#tree_ul_"+treeul_full_str).slideDown("300");
					}
				}				
			}

		}

		
		if($.fn.cmtree.defaults.onClickTitlefn!=""){
			window[""+$.fn.cmtree.defaults.onClickTitlefn]($.fn.cmtree.rtnTreeArr(treecd));
		}
		
		
	}
	
	
	
	// TODO : $.fn.cmtree.createChildTree
	$.fn.cmtree.createChildTree = function(treecdarr){
			var j = 0;
			tmp_str = "";
			var lev = 0;
			lev = treecdarr[4];
			//alert($.fn.cmtree.defaults.createChildClickCnt);
			
				if($("#tree_ul_"+treecdarr[6]).children("li").length==0){
					// 하위배열이 있는경우만 실행한다
					if(cmtreeval[lev]!=undefined && cmtreeval[lev]!=null){
						for(j=0;j<cmtreeval[lev].length;j++){	
							if(cmtreeval[lev][j][3]==treecdarr[1]){
								tmp_str = "<li id='tree_li_"+cmtreeval[lev][j][6]+"'>";
								
								// 체크박스여부가 true이면
								if($.fn.cmtree.defaults.checkBoxYn == true){
									tmp_str += "<input type='checkbox' id='tree_chk_"+cmtreeval[lev][j][6]+"' name='tree_chk_"+cmtreeval[lev][j][6]+"' value='"+cmtreeval[lev][j][6]+"' style='margin-top:-3px;' onclick='$.fn.cmtree.chkTreeToggle(\""+cmtreeval[lev][j][6]+"\",\""+cmtreeval[lev][j][4]+"\", true);$.fn.cmtree.onClickTreeChecked(\""+cmtreeval[lev][j][6]+"\")' /> ";
								}
								if(cmtreeval[lev][j][7]>0){
									tmp_str += "<img id='tree_pm_btn_"+cmtreeval[lev][j][6]+"' src='"+$.fn.cmtree.defaults.treeImgPath+"/tree/btn_plus.gif' alt='하위메뉴 보기' />";
								}
								tmp_str += "<a href='#none' id='tree_link_"+cmtreeval[lev][j][6]+"' onclick='$.fn.cmtree.onClickTreeTitle(\""+cmtreeval[lev][j][6]+"\")'><img src='"+$.fn.cmtree.defaults.treeImgPath+"/tree/bul_page.gif' />"+cmtreeval[lev][j][2]+"</a>";

									if(parseInt(cmtreeval[lev][j][7]) > 0){
										tmp_str += "<ul id='tree_ul_"+cmtreeval[lev][j][6]+"' style='display:none;'></ul>";
									}else{

									}
									tmp_str += "</li>";
									//console.log("-----"+cmtreeval[lev][j][6]+"------"+cmtreeval[lev][j][6].lastIndexOf("__")+"---"+cmtreeval[lev][j][6].substring(0,cmtreeval[lev][j][6].lastIndexOf("__")));
									$("#tree_ul_"+cmtreeval[lev][j][6].substring(0,cmtreeval[lev][j][6].lastIndexOf("__"))).append(tmp_str);						
							}

							
						}
						
						//console.log("-----"+treecdarr);
						var treeBtn=$("#tree_ul_"+treecdarr[6]+" a ");
						var treeLi=$("#tree_ul_"+treecdarr[6]+" li");
						var firstLi=$("#tree_ul_"+treecdarr[6]+">ul>li:first-child");
						var lastLi=$("#tree_ul_"+treecdarr[6]+" ul li:last-child");
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
								if(haveUlNum=="0"){
									if(thisbg=="first"){
										 thisLi.addClass("none_first");
									}else if(thisbg=="last"){
										thisLi.addClass("none_last");
									}else{
										thisLi.addClass("noneTree");
									}
								}else if(haveUlNum!="0"){
									//thisLi.children("a").before("<img  src='/images/tree/btn_plus.gif' alt='하위메뉴 보기' />");
								}
						}						

						
						var treeBtn=$("#tree_ul_"+treecdarr[6]+" li img");
						
						treeBtn.click(function(){
							var thisNum=treeBtn.index(this);
							var thisBtn=treeBtn.eq(thisNum);
							var thisSubUl=thisBtn.parent().children("ul");
							var thislink = thisBtn.parent().children("a");
							var btn_tree_id_arr = "";

							/*//alert(thisSubUl.is(":visible"));
							if(thisSubUl.is(":visible")){
								thisBtn.attr("src",thisBtn.attr("src").replace("minus.gif","plus.gif"));
								//thisSubUl.slideUp("500");
								thisSubUl.hide();
							}else{
								thisBtn.attr("src",thisBtn.attr("src").replace("plus.gif","minus.gif"));
								thisSubUl.slideDown("300");
								//$(this).parent().children("ul").children("li").show();
							}*/
							
							if($(thislink).attr("id")!=undefined){
								btn_tree_id_arr = $.fn.cmtree.rtnTreeArr($(thislink).attr("id").replace("tree_link_",""));
								
							}else{
								btn_tree_id_arr = undefined;
							}
							
							/*if($.fn.cmtree.defaults.setAllYn==false){
								//thislink.trigger("click");
								if($(thislink).attr("id")!=undefined){
									btn_tree_id_arr = $.fn.cmtree.rtnTreeArr($(thislink).attr("id").replace("tree_link_",""));
									//if($.fn.cmtree.defaults.onClickTitlefn!=""){
									//	$.fn.cmtree.createChildTree(btn_tree_id_arr);
									//	window[""+$.fn.cmtree.defaults.onClickTitlefn]($.fn.cmtree.rtnTreeArr(btn_tree_id_arr));
									//}else{
										$.fn.cmtree.createChildTree(btn_tree_id_arr);
										if($.fn.cmtree.defaults.treeRelComboId!=""){
											$.fn.cmtree.treeRelComboboxSet(btn_tree_id_arr[6], btn_tree_id_arr[4]);
											$.fn.cmtree.treeRelComboboxMake(btn_tree_id_arr[6],'', btn_tree_id_arr[4]);
											
											//$.fn.cmtree.onClickTreeTitle(btn_tree_id_arr[6]);
										}										
									//}									
					
								}								
							
							}	*/						
			
							if(btn_tree_id_arr!=undefined){
								// 동레벨에 있는 모든 열린 트리를 닫아준다
								//$.fn.cmtree.closeTreeSameLevel(btn_tree_id_arr[1]+"", btn_tree_id_arr[4]+"");
								//console.log("btn_tree_id_arr==>"+btn_tree_id_arr);
								//console.log("(thislink).attr(id)==>"+$(thislink).attr("id"));
								$.fn.cmtree.onClickTreeTitle($(thislink).attr("id").replace("tree_link_",""));
							}						
						
						});						
					}
				
				}	
				

		
	}
	
	// TODO : $.fn.cmtree.onClickTreeChecked
	$.fn.cmtree.onClickTreeChecked = function(treecd){
		//alert("$.fn.cmtree.onClickTreeTitle==="+treecd);
		//eval($.fn.cmtree.defaults.onClickTitlefn+"("+$.fn.cmtree.rtnTreeArr(treecd)+")");
		
		var cur_tree_arr;
		if($.fn.cmtree.defaults.setAllYn==false){
			cur_tree_arr = $.fn.cmtree.rtnTreeArr(treecd);
			$.fn.cmtree.delay(100);
			//선택된 레벨의 하위 레벨 트리를 생성해준다
			$.fn.cmtree.createChildTree(treecd,cur_tree_arr[4]);
		
		}
		
		if($.fn.cmtree.defaults.onClickCheckedfn!=""){
			window[""+$.fn.cmtree.defaults.onClickCheckedfn]($.fn.cmtree.rtnTreeArr(treecd));
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
	$.fn.cmtree.unchkTreeChildrenAll = function(treecd){	
		var subChkAll = $("#tree_ul_"+treecd+" input:checkbox[id^='tree_chk_']");
		
		subChkAll.each(function(){

				//$(this).attr("checked", false);
				document.getElementsByName($(this).attr("name"))[0].checked = false;

		});
		
	}	
	
	// TODO : $.fn.cmtree.selTreeParentAll
	// 특정 코드에 해당하는 트리를 상위포함해서 오픈하고 체크박스를 선택상태로 셋팅한다
	$.fn.cmtree.selTreeParentAll = function(treecd, treelev){
		//alert(treelev);
		//console.log("1-------------------------");
		if(treecd!="" && treecd!=undefined && treelev!="" && treelev!=undefined){
			var selLevArr = cmtreeval[treelev-1];
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
			var treeul_full_str = "";
			//alert(treeCdsStr+"---"+treeCdsStrSp.length);
			for(iu=0;iu<treeCdsStrSp.length;iu++){
				// 해당 코드가 있으면 해당 ul만 열어준다
				//console.log("treeCdsStrSp[iu]:===>"+treeCdsStrSp[iu]);
				if(treeCdsStrSp[iu]!=""){
					//선택된 레벨의 하위 레벨 트리를 생성해준다
					//$.fn.cmtree.onClickTreeTitle(treeCdsStrSp[iu]);
					//선택된 레벨의 하위 레벨 트리를 생성해준다
					if($.fn.cmtree.defaults.setAllYn==false){
						//console.log("treeCdsStrSp[iu]:===>"+treeCdsStrSp[iu]);
						$.fn.cmtree.createChildTree($.fn.cmtree.rtnTreeArr(treeCdsStrSp[iu]));
					}
					if(iu==0){
						treeul_full_str = treeCdsStrSp[iu];
					}else{
						treeul_full_str = treeul_full_str +"__"+ treeCdsStrSp[iu];
					}
					
					//console.log("treeul_full_str:===>"+treeul_full_str);
					//$("#tree_ul_"+treeul_full_str).slideDown("300");
				}
			}
			//console.log("3-------------------------");
			$($.fn.cmtree.defaults.id+" a").css("color","");
			if($.fn.cmtree.defaults.seltreecd!=""){
				//$("#tree_li_"+$.fn.cmtree.defaults.seltreecd).children("a").css("color","");
			}else{
				$.fn.cmtree.defaults.seltreecd = treecd;
			}
			//console.log("4-------------------------");
			
			$("#tree_li_"+treecd).children("a").css("color", $.fn.cmtree.defaults.seltreebg);
			//console.log("41-------------------------");
			
			if($("#tree_li_"+treecd).children("img").eq(0).attr("src")=="plus.gif" || $("#tree_li_"+treecd).children("img").eq(0).attr("src")=="minus.gif"){
				//console.log("42-------------------------");
				$("#tree_li_"+treecd).children("img").eq(0).attr("src",$("#tree_li_"+treecd).children("img").eq(0).attr("src").replace("plus.gif","minus.gif"));
			}
			
			//console.log("43-------------------------");
			if(treecd!=undefined && treecd!="" && $.fn.cmtree.defaults.treeRelComboId!=""){
				//console.log("44-------------------------");
				
				$.fn.cmtree.scrollTreecd(treecd);
			}
			
			//console.log("5-------------------------");
			
			$.fn.cmtree.defaults.seltreecd = treecd;
			
			// 해당 선택된 트리를 선택된 상태로 조회한다
			//document.getElementsByName("tree_chk_"+treecd)[0].checked = true;
			//$.fn.cmtree.chkTreeToggle(treecd, treelev, false);			
		}


	}	
	
	// TODO :$.fn.cmtree.scrollTreecd
	$.fn.cmtree.scrollTreecd = function(treecd){
		//console.log($(""+$.fn.cmtree.defaults.treeMenuId).css("display"));
		//console.log($(""+$.fn.cmtree.defaults.treeAreaId).css("display"));
		// 객체가 보이는경우만 실행한다
		
		
		if($(""+$.fn.cmtree.defaults.treeAreaId).css("display")!="none" 
			&& $(""+$.fn.cmtree.defaults.treeMenuId).css("display")!="none"){
			//console.log("$.fn.cmtree.scrollTreecd---"+treecd);
			//var cur_tree_arr = $.fn.cmtree.rtnTreeArr(treecd);
			//alert($(""+$.fn.cmtree.defaults.treeMenuId).find("#tree_li_"+treecd).position().top-180);
			//var scrollrto = parseInt($(""+$.fn.cmtree.defaults.treeMenuId).prop("scrollHeight")/$(""+$.fn.cmtree.defaults.treeMenuId).height());
			//var scrollbarh = parseInt($(""+$.fn.cmtree.defaults.treeMenuId).height()/scrollrto);
			//var scrollbartop = $(""+$.fn.cmtree.defaults.treeMenuId).find("#tree_li_"+treecd).position().top-30;
			//console.log(""+($("#tree_li_"+treecd).offset()+"---"+$(""+$.fn.cmtree.defaults.id).offset()));
			var scrollbartop = 0;
			if($("#tree_li_"+treecd).offset()!=undefined){
				scrollbartop = $("#tree_li_"+treecd).offset().top-$(""+$.fn.cmtree.defaults.id).offset().top;
			}
			//var objtop = $("#tree_li_"+treecd).offset().top;
			//alert($(""+$.fn.cmtree.defaults.id).offset().top+"======"+$("#tree_li_"+treecd).offset().top+"======"+scrollbartop);
			//alert("======"+$(""+$.fn.cmtree.defaults.treeMenuId).prop("scrollHeight"));-178+(89*scrollrto)
			//alert("scrollbarh==>"+scrollbarh+":::===>"+$(""+$.fn.cmtree.defaults.treeMenuId).find("#tree_li_"+treecd).position().top);
			//$(""+$.fn.cmtree.defaults.treeMenuId).animate({scrollTop:scrollbartop},'fast');	//권한그룹관리에서 에러남(explore8에서 지원안하는듯함 - 위쪽에서도 주석처리되어있음) - 주석처리함 kss 20150716
			
			
			//$(""+$.fn.cmtree.defaults.treeMenuId).scrollTop(scrollbartop);	
			setTimeout(function(){
				$("#tree_li_"+treecd).attr("tabindex",-1).focus();
			},0);
			//return;
		}
	}	
	
	
	
	// 특정 코드에 해당하는 트리를 상위포함해서 오픈하고 체크박스를 선택상태로 셋팅한다
	// TODO :$.fn.cmtree.selTreeParentAll2
	$.fn.cmtree.selTreeParentAll2 = function(treecd){	
		var selLevArr = $.fn.cmtree.rtnTreeArr(treecd);
		var iu = 0;
		var treeCdsStr = "";
		var treeCdsStrSp = null;

		treeCdsStr = selLevArr[6];

		//최초등록시 에러남 - 강삼수 추가함
		if(treeCdsStr==undefined){
			treeCdsStr = "__";
		}

		treeCdsStrSp = treeCdsStr.split("__");
		//alert(treeCdsStr+"---"+treeCdsStrSp.length);
		for(iu=0;iu<treeCdsStrSp.length;iu++){
			// 해당 코드가 있으면 해당 ul만 열어준다
			if(treeCdsStrSp[iu]!=""){
				if($.fn.cmtree.defaults.setAllYn==false){
					$.fn.cmtree.createChildTree($.fn.cmtree.rtnTreeArr(treeCdsStrSp[iu]));
				}
				$("#tree_ul_"+treeCdsStrSp[iu]).slideDown("300");
	
				
			}
		}
		if($.fn.cmtree.defaults.seltreecd!=""){
			$("#tree_li_"+$.fn.cmtree.defaults.seltreecd).children("a").css("color","");
		}
		
		

		$("#tree_li_"+treecd).children("a").css("color", $.fn.cmtree.defaults.seltreebg);
		if(treecd!=undefined && treecd!="" && $.fn.cmtree.defaults.treeRelComboId!=""){
			$.fn.cmtree.scrollTreecd(treecd);			
		}
		
		$.fn.cmtree.defaults.seltreecd = treecd;
		
		// 해당 선택된 트리를 선택된 상태로 조회한다
		//document.getElementsByName("tree_chk_"+treecd)[0].checked = true;
		//$.fn.cmtree.chkTreeToggle(treecd, treelev, false);

	}	
	

	// TODO :$.fn.cmtree.searchTree
	$.fn.cmtree.searchTree = function(sty, stext){
		var ist=0;
		var jst=0;
		var kst=0;
		var search_sel_yn = false;
		var treeCdsStrSp = null;
		var searchtreeCd = new Array();
		$("a[id^='tree_link_']").css("color","");

		for(ist=0;ist<cmtreeval.length;ist++){
			//alert(cmtreeval[i].length);
			for(jst=0;jst<cmtreeval[ist].length;jst++){
				search_sel_yn = false;
				// 검색조건이 셋팅되면 해당하는 트리를 오픈하고 색상을 바꿔준다
				if(sty==""){
					//console.log()
					if(cmtreeval[ist][jst][6].indexOf(stext) > -1 || cmtreeval[ist][jst][2].indexOf(stext) > -1){
						search_sel_yn = true;
						searchtreeCd.push(cmtreeval[ist][jst][6]);
					}					
				}else if(sty=="cd"){
					if(cmtreeval[ist][jst][6].indexOf(stext) > -1){
						search_sel_yn = true;
						searchtreeCd.push(cmtreeval[ist][jst][6]);
					}					
				}else if(sty=="nm"){
					if(cmtreeval[ist][jst][2].indexOf(stext) > -1){
						search_sel_yn = true;
						searchtreeCd.push(cmtreeval[ist][jst][6]);
					}					
				}
				
				if(search_sel_yn == true){
					treeCdsStrSp = cmtreeval[ist][jst][6].split("__");
					$("#tree_link_"+cmtreeval[ist][jst][6]).css("color", $.fn.cmtree.defaults.seltreebg);
					for(kst=0;kst<treeCdsStrSp.length;kst++){
						// 해당 코드가 있으면 해당 ul만 열어준다
						if(treeCdsStrSp[kst]!=""){
							$("#tree_ul_"+treeCdsStrSp[kst]).slideDown("300");
							$.fn.cmtree.scrollTreecd(treeCdsStrSp[kst]);
						}
					}
				}

			}
		}
		
		return searchtreeCd;
		
	}
	
	
	// 선택된 체크박스 코드를 배열로 리턴한다
	// TODO :$.fn.cmtree.chkTreeArr
	$.fn.cmtree.chkTreeArr = function(){
		var cmtreeChkArr = new Array();

		var tmp_treeArr = new Array();
		var treechecked=$($.fn.cmtree.defaults.id+" input[name^='tree_chk_']:checked");
		
		//alert("선택된갯수:"+treechecked.length);
		treechecked.each(function(){
			//console.log($("#tree_link_"+$(this).val()).text());
			
			tmp_treeArr = $.fn.cmtree.rtnTreeArr($(this).val());
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
	$.fn.cmtree.unchkTreeArr = function(unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+treechecks_sp[iu])[0].checked = false;
			// 하위체크박스를 해제 시킨다
			$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};	
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를 해제시킨다
	// TODO :$.fn.cmtree.chkedTreeArr
	$.fn.cmtree.chkedTreeArr = function(unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		var tree_arr = new Array();
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+treechecks_sp[iu])[0].checked = true;
			tree_arr = $.fn.cmtree.rtnTreeArr(treechecks_sp[iu]);
			//console.log(treechecks_sp[iu]+"--"+tree_arr);
			// 상위트리를 열어준다
			$.fn.cmtree.selTreeParentAll(treechecks_sp[iu], tree_arr[4]);
			// 하위체크박스를 해제 시킨다
			//$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};	
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를 해제시킨다
	// TODO :$.fn.cmtree.chkedTreeArr
	$.fn.cmtree.unchkedTreeAll = function(){

		$("#cmtree_data").find("input:checkbox").attr("checked", false);

	};	
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를  disabled
	// TODO :$.fn.cmtree.disabledTreeArr
	$.fn.cmtree.disabledTreeArr = function(unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		var tree_arr = new Array();
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+treechecks_sp[iu])[0].disabled = true;
			tree_arr = $.fn.cmtree.rtnTreeArr(treechecks_sp[iu]);
			//console.log(treechecks_sp[iu]+"--"+tree_arr);
			// 상위트리를 열어준다
			$.fn.cmtree.selTreeParentAll(treechecks_sp[iu], tree_arr[4]);
			// 하위체크박스를 해제 시킨다
			//$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};		
	
	// 입력된 트리에서 체크될 코드를 루프를 돌며 체크박스를  disabled
	// TODO :$.fn.cmtree.undisabledTreeArr
	$.fn.cmtree.undisabledTreeArr = function(unchkstr){

		var treechecks_sp = unchkstr;
		var iu =  0;
		var tree_arr = new Array();
		
		for(iu=0;iu<treechecks_sp.length;iu++){
			// 자기자신을 체크해제 시킨다
			//console.log("tree_chk_"+treechecks_sp[iu]);
			document.getElementsByName("tree_chk_"+treechecks_sp[iu])[0].disabled = false;
			tree_arr = $.fn.cmtree.rtnTreeArr(treechecks_sp[iu]);
			//console.log(treechecks_sp[iu]+"--"+tree_arr);
			// 상위트리를 열어준다
			$.fn.cmtree.selTreeParentAll(treechecks_sp[iu], tree_arr[4]);
			// 하위체크박스를 해제 시킨다
			//$.fn.cmtree.unchkTreeChildrenAll(treechecks_sp[iu]);
		}

	};
	
	
	// TODO :$.fn.cmtree.rtnTreeArr
	$.fn.cmtree.rtnTreeArr = function(treecd){
		var tmp_rtn_arr = new Array();
		for(ir=0;ir<cmtreeval.length;ir++){
			//alert(cmtreeval[ir].length);
			for(jr=0;jr<cmtreeval[ir].length;jr++){	
				//console.log(cmtreeval[ir][jr][1]+"==="+treecd+"==="+(cmtreeval[ir][jr][1]==treecd));
				if(cmtreeval[ir][jr][6]==treecd){
					tmp_rtn_arr = cmtreeval[ir][jr];
					break;
				}
			}
			
		}
		//console.log("rtnTreeArr==="+tmp_rtn_arr+"==="+treecd+"===");
		return tmp_rtn_arr;
		
	};
	
	// 상위 콤보박스까지 생성해줘야한다
	// TODO :$.fn.cmtree.treeRelComboboxSet
	$.fn.cmtree.treeRelComboboxSet = function(seltreecd, treelev){
		/*var selLevArr = cmtreeval[treelev];
		var comboboxidstr = (treelev==1)?"#"+$.fn.cmtree.defaults.treeRelComboboxId:"#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(treelev-1);
		
		$(""+comboboxidstr+" > option[value="+seltreecd+"]").attr("selected", true);*/
		//alert(treelev+"--"+seltreecd);
		var selLevArr = cmtreeval[treelev-1];
		var treeCdsStr = "";
		var treeCdsStrSp = null;
		for(is=0;is<selLevArr.length;is++){
			if(selLevArr[is][6] == seltreecd){
				treeCdsStr = selLevArr[is][6];
				break;
			}
		}	
		
		//select id로 크기를 가져와서 더큰놈은 다지우기   	
	    var combolarr = $("select[name^='"+$.fn.cmtree.defaults.treeRelComboboxId+"']");
		//alert(combolength);
		//for(var i=combolarr.length;i>0;i--){
		//	combolarr[i-1].remove();
		//}	
	    combolarr.each(function(idx){
	    	if(idx!=0){
	    		
	    		//$(this).remove();
	    		$("#"+$.fn.cmtree.defaults.treeRelComboboxId+idx).remove();
	    	}
				

		});
		
	    //console.log("treeCdsStr==="+treeCdsStr);
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

				$("#"+$.fn.cmtree.defaults.treeRelComboboxId+" > option[value="+treeCdsStrSp[is]+"]").attr("selected", true);
			}else{
				// 셀렉트박스가 있으면 값을 셋팅하고 없으면 생성하며 셋팅한다
				//console.log($("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)).length);

				
				if($("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)).length > 0){
					// 옵션값을 삭제하고 다시 셋팅한다
					//console.log("1----"+$("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)).length);
					$.fn.cmtree.treeRelComboboxMake(treeCdsStrSp[is-1], treeCdsStrSp[is], is);
					
					$("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+" > option[value="+treeCdsStrSp[is]+"]").attr("selected", true);
				}else{
					
					//alert(treeCdsStrSp[is-1]+"------"+treeCdsStrSp[is]);
					//console.log("2--"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+"--"+tree_set_id.substring(0,tree_set_id.lastIndexOf("__"))+"---"+tree_set_id);
					$.fn.cmtree.treeRelComboboxMake(tree_set_id.substring(0,tree_set_id.lastIndexOf("__")), tree_set_id, is);
					
					$("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is)+" > option[value="+tree_set_id+"]").attr("selected", true);
				}
				//$.fn.cmtree.treeRelComboboxMake= function(upseltreecd,seltreecd, treelev){
			}
		}
		
		// 마지막 셀렉트박스의 하위가 있으면 생성한다

	}
	
	// TODO :$.fn.cmtree.treeRelComboboxMake
	$.fn.cmtree.treeRelComboboxMake= function(upseltreecd,seltreecd, treelev){
		if($.fn.cmtree.defaults.dataSetYn==false){
			alert("트리데이터가 셋팅되지않았습니다.");
			return;
		}
		var combostr = "";
		var it = 0;
		var is = 0;
		//alert(cmtreeval.length+"---"+(treelev-1));
		var selLevArr = cmtreeval[treelev];
		var sel = "";
		var optioncnt = 0;
	    var comboboxlength = $("select[name^='"+$.fn.cmtree.defaults.treeRelComboboxId+"']").length;
		//alert(combolength);
		//for(var is=comboboxlength;treelev<is;is--){
		//    $("#"+$.fn.cmtree.defaults.treeRelComboboxId+Number(is-1)).remove();
		//}		
		// 최상위 레벨일경우
	    //console.log("treeRelComboboxMake---upseltreecd--"+upseltreecd+"----seltreecd--"+seltreecd+"----treelev--"+treelev);
		if(treelev==0){

				for(it=0;it<selLevArr.length;it++){
					if(selLevArr[it][2]!=undefined){
						sel = ( seltreecd.trim()==selLevArr[it][2].trim() ) ? "selected" : "";
					}else{
						sel = "";
					}					
					
					combostr += "<option title='"+selLevArr[it][2]+"' value='" + selLevArr[it][6] + "' id='" + selLevArr[it][6] + "'" + sel + ">" + selLevArr[it][2] + "</option>";
					optioncnt++;
				}
				$("#"+$.fn.cmtree.defaults.treeRelComboboxId).append(combostr);

		}else{
			if(selLevArr!=undefined){
				for(it=0;it<selLevArr.length;it++){
					
					if(selLevArr[it][6].substring(0,selLevArr[it][6].lastIndexOf("__")) == upseltreecd){
						//console.log(upseltreecd+"=="+selLevArr[it][6]+"=="+selLevArr[it][6].substring(0,selLevArr[it][6].lastIndexOf("__")));
						//console.log(seltreecd+"=="+selLevArr[it][i][2]);
						if(selLevArr[it][2]!=undefined){
							sel = ( seltreecd.trim()==selLevArr[it][2].trim() ) ? "selected" : "";
						}else{
							sel = "";
						}
						
						combostr += "<option title='"+selLevArr[it][2]+"' value='" + selLevArr[it][6] + "' id='" + selLevArr[it][6] + "'" + sel + ">" + selLevArr[it][2] + "</option>";
						optioncnt++;
					}
				}
				if(optioncnt>0){
					$("#"+$.fn.cmtree.defaults.treeRelComboId).append("<select style='vertical-align:middle;' name='"+$.fn.cmtree.defaults.treeRelComboboxId+"' id='"+($.fn.cmtree.defaults.treeRelComboboxId+""+treelev)+"' onchange='optionGroup($(this), "+(Number(treelev)+1)+",\"N\",\"\")'> <option value=''>선택없음</option> </select>");
					$("#"+$.fn.cmtree.defaults.treeRelComboboxId+""+treelev).append(combostr);
				}				
			}

			
		}
		
		return true;
	};
	
	/**
	HTML 개체용 유틸리티 함수
**/
	// TODO :$.fn.cmtree.GetObjectTop
	$.fn.cmtree.GetObjectTop= function(obj){	
		
			if (obj.offsetParent == document.body)
				return obj.offsetTop;
			else
				return obj.offsetTop + GetObjectTop(obj.offsetParent);
	};
	
	// TODO :$.fn.cmtree.GetObjectLeft
	$.fn.cmtree.GetObjectLeft= function(obj){	
		
		if (obj.offsetParent == document.body)
			return obj.offsetLeft;
		else
			return obj.offsetLeft + GetObjectLeft(obj.offsetParent);
	};	
	
	// TODO :$.fn.cmtree.GetObjectLeft
	$.fn.cmtree.GetObjectTopRef= function(refobj, obj){	
		
		if (obj.offsetParent == document.body || refobj == obj.offsetParent)
			return obj.offsetTop;
		else
			return obj.offsetTop + GetObjectTop(obj.offsetParent);
	};	



	

})(jQuery);


