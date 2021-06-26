/**================================================================================
 * @name: javascript 공통 package - cmfile plugin
 * @author: jhlee
 * @demo: 
 * @version: 0.1.0
 * @charset: utf-8
 ================================================================================*/
(function($) {
  var cmfileArr = new Array();
	// Option defaults

	
  $.fn.cmfile = {
	init: function(opt) {
		//ID체크
		var _grdId = opt.id||opt.custom.id;
		if(!_grdId){
			alert("[필수]file그룹 ID가 없습니다."); return;
		}else if($("#"+_grdId).length==0){
			alert("[필수]file그룹에 해당하는 Element가 없습니다."); return;
		}else if($("#"+_grdId).length>1){
			alert("[필수]file그룹에 해당하는 Element가 여러개입니다"); return;
		}
		var opts = $.extend({}, $.fn.cmfile, opt);
		cmfileDefaults = new Array();
		cmfileDefaults['id'] = opt.id;
		cmfileDefaults['onClickNamefn'] = opt.onClickNamefn;
		cmfileDefaults['img_url'] = opt.img_url;
		cmfileDefaults['uploadcnt'] = opt.uploadcnt;
		cmfileDefaults['extchk'] = opt.extchk;
		if(opt.dismode == undefined){
			cmfileDefaults['dismode'] = "n";
		}else{
			cmfileDefaults['dismode'] = opt.dismode;
		}
		
		cmfileDefaults['modify_yn'] ="n";
		cmfileDefaults['onefile_seq'] ="";
		
		cmfileArr[cmfileDefaults['id']] = cmfileDefaults;
		
		var file_width = "90%";
		var file_height = "68px";
		if(cmfileDefaults['dismode']=="p"){
			file_width = "95%";
			file_height = "116px";
		}

		var updatemode=opt.updatemode==undefined || opt.updatemode=="undefined" || opt.updatemode == null || "null"==opt.updatemode || ""==opt.updatemode ? "U":opt.updatemode; 
		
		//해당 파일그룹을 초기화한다
			// 파일입력 폼을 생성한다
		if(updatemode=="U"){
			$("#"+cmfileDefaults['id']).append("<div id='"+cmfileDefaults['id']+"_FILEAREA' style='margin-bottom:5px;' >"
					+"<input type='file' class='inputFile' id='"+cmfileDefaults['id']+"_FILE1' name='"+cmfileDefaults['id']+"_FILE1' title='첨부파일 찾기' onchange='$.fn.cmfile.fileChange(\""+cmfileDefaults['id']+"\",this);' style='width:"+file_width+";'  />"
					+"</div>");			
		}

		// 업로드 갯수가 1개이상일경우만 셀렉트박스와 객체와 파일버튼을 생성한다
		if(Number(cmfileDefaults['uploadcnt'],10)>1){

			// 팝업화면 모드일경우 버튼을 아래로 보낸다
			if(cmfileDefaults['dismode']=="p"){
				if(updatemode=="U"){
					$("#"+cmfileDefaults['id']).append("<p style='float:left;width:100%;'>파일은 <span class='pointR' style='display:inline;margin-top:0px;'>최대 "+Number(cmfileDefaults['uploadcnt'],10)+"개</span> 까지, 용량은<span class='pointR' >10MB까지</span> 가능(첨부가능파일:"+cmfileDefaults['extchk'].join(",")+")</p>");
				}
				
				// 파일 셀렉트박스를 생성한다
				$("#"+cmfileDefaults['id']).append("<select id='"+cmfileDefaults['id']+"_FILE_LIST' name='"+cmfileDefaults['id']+"_FILE_LIST' size='4' title='첨부파일선택' style='float:left;width:"+file_width+";height:"+file_height+";' ondblclick='$.fn.cmfile.onClickNamefn(\""+cmfileDefaults['id']+"\",this)'>"
						+"</select>");
				// 파일 버튼을 생성한다
				//$("#"+cmfileDefaults['id']).append("<div style='vertical-align:top;'>"
				//	+"<a href='#' onclick='$.fn.cmfile.removeFILE(\""+cmfileDefaults['id']+"\");return false;'><img src='"+cmfileDefaults['img_url']+"/cm/minus.gif' border='0' align='absmiddle'>파일삭제</a>"
				//		+"</div>");	
				if(updatemode=="U"){
					$("#"+cmfileDefaults['id']).append("<div class='filebtn' >"
							+"<button onclick='$.fn.cmfile.removeFILE(\""+cmfileDefaults['id']+"\");return false;' class='remove'>파일삭제</button>"
							+"</div>");				
				}
				//<span class='btn_pack small icon'><span class='add'></span><a href='#' >파일추가</a></span>
			}else{
				if(updatemode=="U"){
					$("#"+cmfileDefaults['id']).append("<p  style='float:left;width:100%;'>파일은 <span class='pointR' style='display:inline;margin-top:0px;'>최대 "+Number(cmfileDefaults['uploadcnt'],10)+"개</span> 까지, 용량은<span class='pointR' style='display:inline;margin-top:0px;'>10MB까지</span> 가능(첨부가능파일:"+cmfileDefaults['extchk'].join(",")+")</p>");
				}
				// 파일 셀렉트박스를 생성한다
				$("#"+cmfileDefaults['id']).append("<select id='"+cmfileDefaults['id']+"_FILE_LIST' name='"+cmfileDefaults['id']+"_FILE_LIST' size='4' title='첨부파일선택' style='float:left;width:"+file_width+";height:"+file_height+";' ondblclick='$.fn.cmfile.onClickNamefn(\""+cmfileDefaults['id']+"\",this)'>"
						+"</select>");
				// 파일 버튼을 생성한다
				//$("#"+cmfileDefaults['id']).append("<span style='vertical-align:top;'>"
				//		+"<a href='#' onclick='$.fn.cmfile.removeFILE(\""+cmfileDefaults['id']+"\");return false;'><img src='"+cmfileDefaults['img_url']+"/cm/minus.gif' border='0' align='absmiddle'>파일삭제</a>"
				//		+"</span>");
				if(updatemode=="U"){
					$("#"+cmfileDefaults['id']).append("<div class='filebtn'>"
							+"<button onclick='$.fn.cmfile.removeFILE(\""+cmfileDefaults['id']+"\");return false;' class='remove'>파일삭제</button>"
							+"</div>");				
				}
			}
			
		}

		//console.log("cmfileArr.length:=="+$("#CMFILE_GROUP_IDX").length);
		//console.log("cmfileArr.length:=="+document.getElementsByName("CMFILE_GROUP_IDX").length);
		
		// 파일 관련 form객체를 생성한다
		$("#"+cmfileDefaults['id']).append("<div id='"+cmfileDefaults['id']+"_HIDDENS' style='display:none;'><input type='text' id='"+cmfileDefaults['id']+"_FILES' name='"+cmfileDefaults['id']+"_FILES' value='' title='파일객체명' style='width:80%;' />"
				+"<input type='text' id='"+cmfileDefaults['id']+"_FILES_NO' name='"+cmfileDefaults['id']+"_FILES_NO' value='1' title='파일번호' style='width:80%;' />"
				+"<input type='text' id='"+cmfileDefaults['id']+"_FILES_DEL_CNT' name='"+cmfileDefaults['id']+"_FILES_DEL_CNT' value='' title='삭제할 파일갯수' style='width:80%;' />"
				+"<input type='text' id='"+cmfileDefaults['id']+"_FILES_DEL' name='"+cmfileDefaults['id']+"_FILES_DEL' value='' title='삭제할 파일정보' style='width:80%;' />"
				+"<input type='text' id='CMFILE_GROUP_IDX' name='CMFILE_GROUP_IDX' value='"+Number(document.getElementsByName("CMFILE_GROUP_IDX").length+1)+"' title='파일그룹인덱스' style='width:80%;' />"
				+"<input type='text' id='CMFILE_GROUP' name='CMFILE_GROUP' value='"+cmfileDefaults['id']+"' title='파일그룹정보' style='width:80%;' />"
				+"</div");
		return $.fn.cmfile;

	}	

	// 파일변경
	,fileChange : function(id, obj){
		//console.log(id);
		//console.log(cmfileArr[id]['extchk']);
		var agt = navigator.userAgent.toLowerCase();
		var brow_kind = "";
		//var file_width = "80%";
		var file_width = "90%";
		//alert(cmfileArr[id].dismode);
		if(cmfileArr[id].dismode=="p"){
			file_width = "95%";
		}
		//alert(file_width);
		
		if (agt.indexOf("msie") != -1) brow_kind =  'Internet Explorer'; 
		// IE10이하
		//if(brow_kind == 'Internet Explorer'){
			//alert("1111");
			var val = $(obj).val().split("\\");
			var filename = val[val.length-1];
			var fileType = "";
			var fileType_chk = false;
			// 현재추가한 파일의 인덱스
			var idx = $('#'+id+' input[type=file]').index(obj);
			
			if($('#'+id+' input[type=file]').length > cmfileArr[id].uploadcnt){
				alert("최대파일갯수 "+cmfileArr[id].uploadcnt+"개를 초과할수 없습니다.");
				return;
			}		
			//alert(filename.lastIndexOf(".")+"::"+filename.substring(filename.lastIndexOf("."),filename.length));
			//fileType = filename.substring(filename.length -3,filename.length);
			fileType = filename.substring(filename.lastIndexOf(".")+1,filename.length);
			fileType = fileType.toUpperCase();
	        //alert('fileType='+fileType);
			//확장자 체크
			for(var i=0;i<cmfileArr[id].extchk.length;i++){
				//console.log(cmfileArr[id].extchk[i].toUpperCase()+":"+fileType+":"+(fileType==cmfileArr[id].extchk[i]));
				fileType_chk = (fileType==cmfileArr[id].extchk[i].toUpperCase());
				if(fileType_chk==true){
					break;
				}
				
			}
			// 허용되지 않는 파일이면
			if(fileType_chk==false) {
				// 업로드 갯수가 1개이상일경우만 셀렉트박스와 객체를 조절한다
				//if(parseInt(cmfileArr[id].uploadcnt,10)>1){
					// 파일객체를 삭제한다
					$('#'+id+' input[type=file]').last().remove(); 
					if(Number(cmfileArr[id].uploadcnt,10)<2){
						$('#'+id+' input[name='+id+'_FILES]').val("");
					}
					
					// 파일객체가 한개도 안남아있을시 새로 생성한다
					if($('#'+id+' input[type=file]').length < 1){
						//console.log("file1");
						$('#'+id+'_FILEAREA').append('<input type="file" class="inputFile" id="'+id+'_FILE1" name="'+id+'_FILE1" title="첨부파일 찾기" onchange="$.fn.cmfile.fileChange(\''+id+'\',this);" style="width:'+file_width+';"  />');
					}else{//파일객체의 순번을 조절한다
						//console.log("file2");
						$('#'+id+' input[type=file]').first().before('<input type="file" class="inputFile" id="'+id+'_FILE'+(Number($('#'+id+'_FILES_NO').val())+1)+'" name="'+id+'_FILE'+(Number($('#'+id+'_FILES_NO').val())+1)+'" title="첨부파일 찾기" onchange="$.fn.cmfile.fileChange(\''+id+'\',this);" style="width:'+file_width+';"  />');
					}	
				//}
				alert('지정되지 않은 파일 타입입니다.!\r\n허용되는파일['+cmfileArr[id].extchk.join(",")+']');
				return;
			}			
			// 업로드 갯수가 1개이상일경우만 셀렉트박스와 객체를 조절한다
			if(Number(cmfileArr[id].uploadcnt,10)>1){
				// 새로 파일객체를 추가한다
				$('#'+id+'_FILEAREA').append('<input type="file" class="inputFile" id="'+id+'_FILE'+(Number($('#'+id+'_FILES_NO').val())+1)+'" name="'+id+'_FILE'+(Number($('#'+id+'_FILES_NO').val())+1)+'" title="첨부파일 찾기" onchange="$.fn.cmfile.fileChange(\''+id+'\',this);" style="width:'+file_width+';"  />');
				
				// 셀렉트 박스에 추가한 내요을 입력한다
				$('#'+id+' select[id='+id+'_FILE_LIST]').append("<option value=\"\">"+filename+"</option>");
				//alert($('input[name=B_FILES]').val().split("::").length);
				if(isEmpty($('#'+id+' input[name='+id+'_FILES]').val())){
					$('#'+id+' input[name='+id+'_FILES]').val($(obj).attr("name"));
				}else{
					$('#'+id+' input[name='+id+'_FILES]').val($('#'+id+' input[name='+id+'_FILES]').val()+"::"+$(obj).attr("name"));
				}
				$('#'+id+' input[name='+id+'_FILES_NO]').val(Number($('#'+id+'_FILES_NO').val())+1);
			
			
				// 현재추가한 파일객체를 숨긴다
				//console.log("id:=="+id+":idx:=="+idx);
				$('#'+id+' input[type=file]:eq('+idx+')').hide();
			}else{
				$('#'+id+' input[name='+id+'_FILES]').val($(obj).attr("name"));
				// 업로드 파일갯수가 1개일경우는
				// 기존파일정보가 있을경우 삭제한다
				$("input[name="+id+"_FILES_DEL]").val(cmfileArr[id].onefile_seq);
			}
			 
	 
	}	
	// 파일변경
	,removeFILE : function(id){	

		var file_width = "80%";
		if(cmfileArr[id].dismode=="p"){
			file_width = "95%";
		}
	    if ($("#"+id+"_FILE_LIST option").index($("#"+id+"_FILE_LIST option:selected")) != -1 ) {
	    	// 셀렉트박스에서 선택된 객체의 파일명
	        var str = $("#"+id+"_FILE_LIST option:selected").text();
	        var val = $("#"+id+"_FILE_LIST option:selected").val();
	        // 셀렉트박스에서 선택된 객체 순번
	        var sindex = $("#"+id+"_FILE_LIST option:selected").index();
	        //var sindex = $("#"+id+"_FILE_LIST option").index($("#"+id+"_FILE_LIST option:selected"));
	        // 현재 등록할 파일객체의 name들
	        var bfiles = $("input[name="+id+"_FILES]").val().split("::");
	        var rf=0;
	        var mbfiles = "";
			for(rf=0;rf<bfiles.length;rf++){
				if(rf==sindex){
					
				}else{
					if(isEmpty(mbfiles)){
						mbfiles = bfiles[rf];
					}else{
						mbfiles = mbfiles+"::"+bfiles[rf];
					}
					
				}
				
			}
	        $("input[name="+id+"_FILES]").val(mbfiles);	 
	        //$('#'+id+' input[name='+id+'_FILES_NO]').val(parseInt($('#'+id+' input[name='+id+'_FILES_NO]').val())-1);
	        //console.log("sindex:=="+sindex);
	        //$("#"+id+"_FILE_LIST option").index(null);
	        // 선택된 셀렉트박스의 value값이 있을경우 수정할 데이터의 첨부파일삭제이므로 해당 정보를 저장한다
	        
	        if(!isEmpty(val)){
	        	if(isEmpty($("input[name="+id+"_FILES_DEL]").val())){
	        		$("input[name="+id+"_FILES_DEL]").val($("#"+id+"_FILE_LIST option:selected").val()); 
	        	}else{
	        		$("input[name="+id+"_FILES_DEL]").val($("input[name="+id+"_FILES_DEL]").val()+"::"+$("#"+id+"_FILE_LIST option:selected").val()); 
	        	}
	        	
	        }
	        $("#"+id+"_FILE_LIST option:selected").remove();
	        //alert(sindex);
	        // 선택된 file객체를 삭제한다
	        
	       	if(sindex >= 0 && isEmpty(val)){
			
	       		$("#"+id+" input[type=file]:eq("+sindex+")").remove(); 
	    	}

	        // 파일객체가 없으면 파일객체는 1개를 남겨놓는다
	        //alert($("#"+id+" input[type=file]").length);
	        if($("#"+id+" input[type=file]").length < 1){
	        	$('#'+id+'_FILEAREA').append('<input type="file" class="inputFile" id="'+id+'"_FILE'+(Number($('#'+id+'_FILES_NO').val())+1)+'" name="'+id+'"_FILE'+(Number($('#'+id+'_FILES_NO').val())+1)+'" title="첨부파일 찾기" onchange="$.fn.cmfile.fileChange(\''+id+'\',this);" style="width:'+file_width+';"  />');
	        }
	        
	    

	    } else {
	        alert("삭제할 첨부파일을 먼저 선택해 주세요.");
	        return;
	    }
	}	
	// 파일객체 default옵션확인
	,getfileOpt : function(id, optnm){	
		return cmfileArr[id][optnm];
	}
	// 파일객체에 배열로 들어온 파일정보를 셋팅한다
	,setfileList : function(id, fileListrows){	
		var ifr = 0;
		// 파일갯수가 1개를 초과한경우
		if(Number(cmfileArr[id]['uploadcnt'],10)>1){
			for(ifr=0;ifr<fileListrows.length;ifr++){
				$('select[id='+id+'_FILE_LIST]').append("<option value=\""+fileListrows[ifr]['file_seqno'].replace(/:/gi,"")+"\">"+fileListrows[ifr]['file_nm'].replace(/:/gi,"")+"</option>");
			}
		// 파일갯수가 1개인경우 파일다운로드 링크를 생성한다
		}else{
			for(ifr=0;ifr<fileListrows.length;ifr++){
				$('#'+id+'_FILEAREA').append("<div><a href='#' onclick=\"$.fn.cmfile.fileDownLoad('"+id+"','"+fileListrows[ifr]['file_seqno'].replace(/:/gi,"")+"');\">"+fileListrows[ifr]['file_nm'].replace(/:/gi,"")+"</a><div>");
				cmfileArr[id].onefile_seq = fileListrows[ifr]['file_seqno'].replace(/:/gi,"");
			}			
		}
		
		if(cmfileArr[id]['dismode']!='p'){
			cmfileArr[id]['modify_yn']="y";
		}else{//팝업일 경우에도 파일보기를 위해 추가함[밑에조건에서필요함] - kss 2015.07.13
			cmfileArr[id]['modify_yn']="y";
		}
		
	}	
	// 파일객체에 있는 파일명을 리턴한다
	,getfileliststr : function(id){	
		//console.log("23232");
		var ifr = 0;
		var fileselect = $("#"+id+"_FILE_LIST option");
		var rtn_str = "";
		//console.log("fileselect.length:=== "+fileselect.length );
		for(ifr=0;ifr<fileselect.length;ifr++){
			rtn_str += $(fileselect).eq(ifr).text();
			if(ifr < fileselect.length-1){
				rtn_str += ",";
			}
		}	
		return rtn_str;
	}
	// 해당 파일그룹에 있는 파일 갯수를 확인
	,getfilelistcnt : function(id){	
		if(Number(cmfileArr[id].uploadcnt,10)>1){
			var fileselect = $("#"+id+"_FILE_LIST option");
			return fileselect.length;			
		}else{
			if($("#"+id+"_FILE1").val()!=""){
				return 1;
			}else{
				return 0;
			}
			
		}

	}
	// 파일객체에 배열로 들어온 파일정보를 셋팅한다
	,setfileListPopup : function(id, fileListrows){	
		var ifr = 0;
		$('#'+id).html("");
		for(ifr=0;ifr<fileListrows.length;ifr++){
			//console.log(id+":==:"+fileListrows[ifr]['file_seqno']+":==:"+fileListrows[ifr]['file_nm']);
			$('#'+id).append("<div><a href='#' onclick=\"$.fn.cmfile.fileDownLoad('"+id+"','"+fileListrows[ifr]['file_seqno']+"');\">"+fileListrows[ifr]['file_nm']+"</a><div>");
		}	
		
	}	
	// 파일셀렉트박스 선택시
	,onClickNamefn : function(id, obj){
		//alert("111");
        var selstr = $("#"+id+"_FILE_LIST option:selected").text();
        var selval = $("#"+id+"_FILE_LIST option:selected").val();
        //console.log("111:"+cmfileArr[id]['onClickNamefn']);
		if(cmfileArr[id]['modify_yn']=="y"){
			if(cmfileArr[id]['onClickNamefn'] !=""){
			
				//alert("함수호출:=="+window[""+cmfileArr[id]]);
		        if(window[""+cmfileArr[id]['onClickNamefn']]!=undefined){
		        	//console.log("111");
		        	window[""+cmfileArr[id]['onClickNamefn']](selstr, selval);
		        }else{
		        	//console.log("2222");
		        	$.fn.cmfile.fileDownLoad(id, selval);
		        	//alert("파일 객체생성시 지정한 파일선택시 호출할 함수가 작성되지않았습니다.");
		        }
				
			}else{
				//console.log("333");
				$.fn.cmfile.fileDownLoad(id, selval);
				//alert("파일선택시 이벤트가 없을경우 파일다운로드 작업 진행");
			}			
		}

	}
	// 파일다운로드 선택시
	,fileDownLoad : function(id, fileseq){
		//console.log("id:"+id+":::"+fileseq);
		if(fileseq !=undefined && fileseq !=""){
			var r = {};
			var val = '000008';
			r['scode'] = val;
			val = '000015';
			r['pcode'] = val;
			val = 'FILEDOWN2';
			r['pstate'] = val;				
			val = ''+fileseq+'';
			r['file_seqno'] = val;			

			var params = r;
			//alert("/cmsmain.do?scode="+params.scode+"&pcode="+params.pcode+"&pstate="+params.pstate+"&file_seqno="+params.file_seqno);
			$("#successIframe").attr("src",context_root+"/cmsmain.do?scode="+params.scode+"&pcode="+params.pcode+"&fpcode=&pstate="+params.pstate+"&file_seqno="+params.file_seqno);
			
			 /*$.ajax({
	             type: "post",
	             url: "/cmsmain.do",
	             data: params,
	             async: false,
	             dataType:"json",
	             success: function(data){

	             }
	    	});	*/		
			// http://localhost:8088/cmsajax.do?scode=000008&pcode=000009&pstate=FILEDOWN&file_seqno=79
			// http://localhost:8088/cmsmain.do?scode=000008&pcode=000009&pstate=FILEDOWN&file_seqno=79
			//alert("파일다운로드 작업예정");
			//alert("id:=="+id+":==fileseq==:"+fileseq);
			//window[""+cmfileArr[id]['onClickNamefn']]();
		}
	}
  };

	
})(jQuery);


