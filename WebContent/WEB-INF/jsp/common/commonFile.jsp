<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>컨텐츠 관리시스템</title>
</head>
<body>
<script type="text/javascript">
var isFileCnt = "<c:out value='${MENUCFG.isFileCnt}'/>"
$(function() {
	if(isFileCnt) {
		isFileCnt = (isFileCnt*1)-1;
	} else {
		isFileCnt = 4;
	}
});
var fileArr = [];
var deleteFileArr = [];
var fileIndex = 0;
var totalFileSize = 0;
var fileList = new Array();
var fileSizeList = new Array();
var uploadSize = 300;
var maxUploadSize = 300;
//	var uploadSize = 999999999;
//	var maxUploadSize = 999999999;


selectFile = function(fileObj) {
	
	var pcode = "<c:out value='${pcode}'/>";
	var files = fileObj;
	//파일이 존재하면
	if(files != null) {
		if(files != null && files.length > 0) {
			$("#fileDragDesc").hide();
			$("#fileListTable").show();
		} else {
			$("#fileDragDesc").show();
			$("#fileListTable").hide();
		}
		if(files.length == 0) {
//			alert("디렉토리는 등록이 불가능합니다.");
			if(fileList.length > 0) {
				$("#fileDragDesc").hide();
				$("#fileListTable").show();
			}
			return;
		}
		for(var i=0; i<files.length; i++) {
			var fileName = files[i].name;
			var fileNameArr = fileName.split("\.");
			var ext = fileNameArr[fileNameArr.length -1].toLowerCase();
			var fileSize = files[i].size;
			if(fileSize <= 0) {
				alert(fileName+"의 크기가 0kb 입니다. 파일을 확인해주세요.");
				return;
			}
			var fileSizeKb = fileSize / 1024;
			var fileSizeMb = fileSizeKb / 1024;
			var fileSizeStr = "";
			var fiveMega = (1024*1024)*5; //5메가
			if(fiveMega <= fileSize) {
				fileSizeStr = fileSizeMb.toFixed(2)+" Mb";
			} else if((1024) <= fileSize) {
				fileSizeStr = parseInt(fileSizeKb) +" kb";
			} else {
				fileSizeStr = parseInt(fileSize)+" byte";
			}
			if($.inArray(ext, ['gif', 'jpg', 'jpeg', 'bmp', 'png', 'hwp', 'xls', 'xlsx', 'zip', 'pdf', 'tif', 'doc', 'docx', 'ppt', 'ppts', 'pptx', 'txt']) <= 0) {
				alert("등록이 불가능한 파일 입니다. ("+fileName+")");
				if(fileList.length == 0) {
					$("#fileDragDesc").show();
				}
				return;
			} else if(fileSizeMb > uploadSize) {
				alert("용량 초과\n업로드 가능 용량 : "+uploadSize+" MB");
				return;
			} else if(fileList.length > isFileCnt) {
				alert("파일은 최대 "+(isFileCnt+1)+"개까지 등록 가능합니다.");
				return;
			} else {
				totalFileSize += fileSizeMb;
				fileList[fileIndex] = files[i];
				fileSizeList[fileIndex] = fileSizeMb;
				addFileList(fileIndex, fileName, fileSizeStr);
				fileIndex++;
			}
		}
	} else {
		alert("등록된 첨부파일이 존재하지 않습니다.");
		return;
	}
};

addFileList = function(fIndex, fileName, fileSizeStr) {
	var html = "";
	html += "<tr id='fileTr_"+fIndex+"'>";
	html += "	<td id='dropZone' class='left'>";
	html += "		<span style='float:left;'>"+ fileName + " ("+fileSizeStr+") " +"</span>" +"<span style='margin-left:5px;'><a href='javascript:void(0);' onclick='deleteFile("+fIndex+")';><img class='btn_remove_attach' src='/KomipoWwg/images/common/del_bt_re.png' width=14 height=14/></a></span>";	
	html += "	</td>";
	html += "</tr>";
	$("#fileDragDesc").css("height", "70px");
	$("#fileListTable").css("height", "70px");
	$("#fileTableTbody").append(html);
};

deleteFile = function(fIndex) {
	if(fileArr[fIndex]) {
		deleteFileArr.push(fileArr[fIndex]);
	} else { 
	}
	totalFileSize -= fileSizeList[fIndex];
	delete fileList[fIndex];
	delete fileSizeList[fIndex];
	fileList.splice(fIndex, 1);
	$("#fileTr_"+fIndex).remove();
	if(totalFileSize > 0) {
		$("#fileDragDesc").css("height", "70px");
		$("#fileDragDesc").hide();
		$("#fileListTable").show();
	} else {
		$("#fileListTable").css("height", "0px");
		$("#fileDragDesc").show();
// 		$("#fileListTable").hide();
		$("#fileTableTbody").children().remove();
	}
};

fileDropDown = function(id) {
	var dropZone = $("#"+id);
	dropZone.on('dragenter', function(e) {
		e.stopPropagation();
		e.preventDefault();
		dropZone.css('background-color', '#E3F2FC');
	});
	dropZone.on('dragleave', function(e) {
		e.stopPropagation();
		e.preventDefault();
		dropZone.css('background-color', '#FFFFFF');
	});
	dropZone.on('dragover', function(e) {
		e.stopPropagation();
		e.preventDefault();
		dropZone.css('background-color', '#E3F2FC');
	});
	dropZone.on('drop', function(e) {
		e.stopPropagation();
		e.preventDefault();
		dropZone.css('background-color', '#FFFFFF');
		var files = e.originalEvent.dataTransfer.files;
		if(files != null) {
			selectFile(files);
		} else {
			alert("파일을 확인해 주세요.");
			return;
		}
	});
};


//파일업로드 및 게시판 인서트
fn_uploadFile = function(formData, url) {
	$.ajax({ 	
		url: url,
		enctype : 'multipart/form-data',
		processData : false,
		contentType : false,
		type: 'POST',
		dataType : "json",
		data : formData,
		cache : false,
		error: function(){
			 alert("현재 파일 서비스가 원활하지 않습니다.\n관리자에게 문의주시기 바랍니다.");
			 return;
		},
		success: function(r) {
			alert(r.message);
			location.href=r.redirectUrl;
		}
	});
};

fn_getBrowser = function() {
	var browser = "";
	var ua = window.navigator.userAgent;
	if(ua.indexOf('MSIE') > 0 || ua.indexOf('Trident') > 0) {
		browser = "IE";
	} else {
		browser = "ETC";
	}
	return browser;
};

</script>
</body>
</html>