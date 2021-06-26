var rval="";
var timer=null;
checker = function (obj,count,textlimitName){
    if(rval != obj.value){
        if(textlimitName && document.getElementById(textlimitName) ){
            document.getElementById(textlimitName).innerHTML = obj.value.bytes();
        }
        rval = obj.value;
    }
    if (obj.value.bytes() > count){
        alert("최대 " + count + "byte이므로 초과된 글자수는 자동으로 삭제됩니다.");
        obj.value = obj.value.cut(count, '');
        stopchecker();
    }
    if(textlimitName){
        timer = setTimeout(function(){checker(obj,count,textlimitName);},10);
    }else{
        timer = setTimeout(function(){checker(obj,count);},10);
    }
};

stopchecker = function (){
    clearTimeout(timer);
    //timer = null;
};

String.prototype.bytes = function() 
{
    var str = this;
    var l = 0;
    for (var i=0; i<str.length; i++) 
        l += (str.charCodeAt(i) > 128) ? 2 : 1;

    return l;
};

String.prototype.cut = function(len, tail) 
{
    if(tail == null){tail = '...';}
    var str = this;
    var l = 0;
    for (var i=0; i<str.length; i++) 
    {
        l += (str.charCodeAt(i) > 128) ? 2 : 1;
        if (l > len) return str.substring(0,i) + tail;
    }
    return str;
};

fnPopupOpen = function(_url, _name, _width, _height, _scroll, _resizable, _status){
	
	var _tarurl =  typeof(_url) == "object" ?_url.href : _url;
	_width = _width || 600;
	_height = _height || 450;
	_name = _name || "Pop";
	var _Opts = "";
	_Opts += "width="+_width;
	_Opts += ",height="+_height;	
	var left = (screen.availWidth - _width )/2;
	var top = (screen.availHeight - _height )/2;
	_Opts += ",left="+left;
	_Opts += ",top="+top;
	
	_Opts += ",scrollbars="+(_scroll?_scroll:'no');
	_Opts += ",resizable="+(_resizable?_resizable:'no');
	_Opts += ",status="+(_status?_status:'no');
	
	var newWin = window.open(_tarurl , _name , _Opts);
	return newWin;	
};

//여백제거
trim = function (str){
	str = str.replace(/(^\s*)|(\s*$)/gi, "");
	return str;
};

/**
 * 모든 체크박스 체크 
 * parameter => obj : this
 *              eObj: 체크박스 객체 name
 * 
 * */
fn_AllCheck = function( obj , eObj ){ 
    var _checkbox = document.getElementsByName(eObj);
    var _flag = false;
    if( obj.checked ){
        _flag = true;
    }
    for(var i=0;i<_checkbox.length;i++){
        _checkbox[i].checked = _flag;
    }
    
};

/**
 * 페이지 이동함수
 * parameter => form:폼
 *              pageNo:pageIndex
 *              action:URL
 * */
_fn_paging = function(frm, pageNo, actUrl){

    if( actUrl != ""){
        frm.action = actUrl;
    }
    frm.pageIndex.value = pageNo;
    frm.submit();
    
};

/** 
 * 날짜 검색시 두 날짜 비교(두 날짜를 모두 입력해서 검색하는 경우에만 사용) 
 * parameter => sDate: 검색시작일자
 *              eDate: 검색종료일자
 * */
_compareTwoDate = function(sDate, eDate){
    var sDt, eDt;
    
    if( sDate || eDate ){
        
        if( sDate && eDate ){
            
            sDt = new Date(sDate);
            eDt = new Date(eDate);
             
            if( sDt > eDt) {
                alert("시작일자는 종료일자보다 이전일자여야 합니다.");
                return false;
            }
            return true;
        } else {
            alert("시작일과 종료일을 넣어 주시기 바랍니다.");
            return false;
            
        }
    } else {
        return true;
    }
    
};

/**
 * 검색어를 초기화 시킨다. selector는 ','로 구분한다.
 * parameter => selector: 초기화할 대상 selector
 *              target  : 초기화할 대상 type
 *              hiddenYn: hidden객체 초기화 여부
 * */
_initSearch = function(selector, target, hiddenYn){
    //try {   console.log("_initSearch("+selector+","+target+","+hiddenYn+")");   } catch (e) {console.log("error")};
    var el = $(selector).find(target);
    var elType = "";
    var elName = "";
    
    $(el).each(function(idx){
        
        elType = $(this).attr("type");
        elName = this.nodeName; //this.tagName;
        if ( elType !== undefined) { elType = elType.toLowerCase(); };
        if ( elName !== undefined) { elName = elName.toLowerCase(); };
        
        if( elName == "select" ) {
           
            $(this).find("option:nth-child(1)").attr("selected", true);
            return true;
           
        } else if ( elName == "input" ) {  
           
            if( elType == "text" ) {
                $(this).val("");
            } else if ( elType == "hidden" && hiddenYn == "Y") {
                $(this).val("");
            } else if ( elType == "radio" ) {
                $("[name='" + $(this).attr("name") + "']:nth-child(1)").attr("checked", true);
            }
            
        }
       
    });
};


/**
 * 검색어를 초기화 시킨다. except는 '@'를 양쪽에 감싸고 '@'로 구분한다.
 * parameter => targetId: 초기화할 대상 ID
 *              except: 초기화 예외 객체 ID (@pageIndex@searchKeywordFrom@searchKeywordTo@)
 * */
fn_searchInit = function(targetId, except){
    
    var el = $("#"+targetId).find("input,select,textarea");
    var elType = "";
    var elName = "";   
    
    $(el).each(function(idx){        
       
        elName = this.nodeName;
        if ( elName !== undefined) { elName = elName.toLowerCase(); };
        var elId = $(this).attr("id");
        if(elId == "pageIndex" || elId == "sortSubject" || elId == "sortDescend" || except.indexOf("@"+elId+"@") != -1){        	
        	return true;
        }
      
        if( elName == "select" ) {           
            $(this).find("option:nth-child(1)").attr("selected", true);  
        } else if ( elName == "input" ) {        	
        	elType = $(this).attr("type");             
            if ( elType !== undefined) { elType = elType.toLowerCase(); };           
            if(elType == "text" || elType == "hidden") {
                $(this).val("");
            } else if ( elType == "radio" ) {
                $("[name='" + $(this).attr("name") + "']:nth-child(1)").attr("checked", true);
            } else if ( elType == "checkbox" ) {
	            $(this).attr("checked", false);
	        }            
        }else if( elName == "textarea" ) {           
        	$(this).val("");                      
        }
    });
};

/**
 * a태그의 href실행 
 * ex) <a href="${basePath}/home/r/m/selectList.do" onclick="javascript:_jsHref(this); return false;">
 * */
function _jsHref(obj) {
    document.location.href = obj.href;    
}


/*
 * ajax 사용시 로딩바 적용 
 */

function showLoadingBar()
{	 
	$("#overlay").css({	  
	  width   : $(document).outerWidth(),
	  height  : $(document).outerHeight()
	});

	$("#img-load").css({
	  top  : ($(window).height() / 2 - 50),
	  left : ($(window).width() / 2 - 50)
	});

 	$("#overlay").fadeIn();
};

/*
 * ajax 사용시 로딩바 숨기기 
 */
function hideLoadingBar()
{
	$("#overlay").fadeOut();
	$(document).scrollTop(0);
};

/**  
 * 1. 개요 : 테이블에 행추가 
 * 2. 처리내용 : 
 * 		tableObjId 테이블에 templateTableObjId 테이블(hidden으로 설정)의 Row를 추가
 *		position : 'first' 첫행에 추가, 'last' 마지막행에 추가
 *  	사용 예) <input type="button" onclick="javascript:addRow('table1','templateTable1','last');" />
 */
addRow = function(tableObjId,templateTableObjId,position) {
	var trObj = "";
	if(position == null || position == '' || position == 'first'){
		trObj=$("#"+templateTableObjId+" > tbody > tr").clone(true).prependTo($("#" + tableObjId + " > tbody"));
	} else if(position == 'last'){
		trObj=$("#"+templateTableObjId+" > tbody > tr").clone(true).appendTo($("#" + tableObjId + " > tbody"));
	}
};

//첨부파일 확장자 체크
fn_fileExtChk = function(fileNm){
    var extention = fileNm.split(".");
    var ext = extention[(extention.length-1)].toLowerCase();
    var fChk = false;
    if( ext == 'xls' ||
        ext == 'xlsx' ||
        ext == 'doc' ||
        ext == 'docx' ||
        ext == 'hwp' ||
        ext == 'ppt' ||
        ext == 'pptx' ||
        ext == 'txt' ||
        ext == 'gif' ||
        ext == 'jpg' ||
        ext == 'jpeg' ||
        ext == 'png' ||
        ext == 'tar' ||
        ext == 'war' ||
        ext == 'zip' ||
        ext == 'jar' ||
        ext == 'bmp' ||
        ext == 'pdf' ){
        fChk = true;
    }
    return fChk;
};

function inputNumberFormat(obj) {
    obj.value = comma(uncomma(obj.value));
}

function comma(str) {
    str = String(str);
    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function uncomma(str) {
    str = String(str);
    return str.replace(/[^\d]+/g, '');
}
