$(document).ready(function() {
	/*
	 * jquery form에 있는 데이터을 json으로 리턴, serializeJSON 사용하게 추가
	 * ex : $("#formId").serializeJSON();
	 * */
	(function( $ ){
		$.fn.serializeJSON=function() {
			var json = {};
			jQuery.map($(this).serializeArray(), function(n, i){
			json[n['name']] = n['value'];
		});
		return json;
		};
	})( jQuery );
});

HashMap = function(){  
    this.map = new Array();
};  
HashMap.prototype = {  
	count : 0,
    put : function(key, value){  
        this.map[key] = value;		        
        this.count++;
    },  
    get : function(key){  
        return this.map[key];
    },  
    getAll : function(){  
        return this.map;
    },  
    clear : function(){  
        this.map = new Array();
        this.count=0;
    },  
    getKeys : function(){  
        var keys = new Array();  
        for(var i in this.map){  
            keys.push(i);
        }  
        return keys;
    }
};
/* ----------------------------------------------------
	Mouse Right Button NonUse

function nomenu(){ 
	return false; 
}
document.oncontextmenu = nomenu; 
------------------------------------------------------ */
var    _intValue   = '0123456789';
var    _checkzipcode   = '0123456789-';
var	_checkNumValue   = '0123456789.-';
var	_checkDateValue   = '0123456789.';
var	_checkMoneyValue   = '0123456789-,';
var    _upperValue = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var    _lowerValue = 'abcdefghijklmnopqrstuvwxyz';
var    _etcValue   = '~`!@#$%%^&*()-_=+\|[{]};:\'\",<.>/?';
var    dayOfMonth = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
/* ----------------------------------------------------
				String 문자 자르기.
------------------------------------------------------ */
/*String.prototype.cut = function(len) {
	var str = this;
	var l = 0;
	for (var i=0; i<str.length; i++) {
		l += (str.charCodeAt(i) > 128) ? 2 : 1;
		if (l > len) return str.substring(0,i);
	}
	return str;
}*/

/* ----------------------------------------------------
	String 공백 지우기.
------------------------------------------------------ */
String.prototype.trim = function(){
	if( typeof this == "string"){
		return this.replace(/(^\s*)|(\s*$)/g, "");
	}else{
		return this;
	}
}

/* ----------------------------------------------------
	문자열 전체 바꾸기 예) replaceAll("", "");
------------------------------------------------------ */
/*String.prototype.replaceAll = function(str1, str2){

	var temp_str = "";

	if (this.trim() != "" && str1 != str2) {
		temp_str = this.trim();

		while (temp_str.indexOf(str1) > -1){
			temp_str = temp_str.replace(str1, str2);
		}
	}

	return temp_str;
}*/

/* ----------------------------------------------------
	String 총 바이트 수 구하기.
------------------------------------------------------ */
/*String.prototype.bytes = function() {
	var str = this;
	var l = 0;
	for (var i=0; i<str.length; i++) l += (str.charCodeAt(i) > 128) ? 2 : 1;
	return l;
}*/

// 이미지 크게보기
/*String.prototype.popupView = function () { 
	var img_view = this; 
	var x = x + 20 ; 
	var y = y + 30 ; 
	htmlz = "<html><head><title>-이미지크게보기</title><style>body{margin:0;cursor:hand;}</style></head><body scroll=auto onload='width1=document.all.Timage.width;if(width1>1024)width1=1024;height1=document.all.Timage.height;if(height1>768)height1=768;top.window.resizeTo(width1+30,height1+54);' onclick='top.window.close();'><img src='"+img_view+"'  title='클릭하시면 닫힙니다.' name='Timage' id='Timage'></body></html>" 
	imagez = window.open('', "image", "width="+ 100 +", height="+ 100 +", top=0,left=0,scrollbars=auto,resizable=1,toolbar=0,menubar=0,location=0,directories=0,status=1"); 
	imagez.document.open(); 
	imagez.document.write(htmlz) 
	imagez.document.close();

}*/ 


/* ----------------------------------------------------
	클립보드에 해당 내용을 복사함.
-------------------------------------------------------- */
function setClipBoardText(strValue){
	window.clipboardData.setData('Text', strValue);
	alert("" + strValue +" \n\n위 내용이 복사되었습니다.\n\nCtrl + v 키를 사용하여, 붙여 넣기 하실 수 있습니다.");
}

/* ********************************** WINDOW CALL ************************************ */


/* ----------------------------------------------------
	팝업윈도우 중앙표시
-------------------------------------------------------- */
function popWin(url, nm, w, h){

	LeftPosition = (screen.width) ? (screen.width-w)/2:0;
	TopPostion = (screen.height) ? (screen.height-h)/2:0;

	setting="height="+h+", width="+w+", top="+TopPostion+", left="+LeftPosition+", toolbar=no, status=yes, resizable=no, scrollbars=no";
	popupwin=window.open(url, nm, setting);
	/*if(w==0 || h==0){
		if(w==0){
			w_after = popupwin.document.body.scrollWidth;
		}
		if(h==0){
			h_after = popupwin.document.body.scrollHeight;
		}
		popupwin.resizeTo(w_after,h_after);
	}*/
	popupwin.focus();
}

function popWinScroll(url, nm, w, h){

	LeftPosition = (screen.width) ? (screen.width-w)/2:0;
	TopPostion = (screen.height) ? (screen.height-h)/2:0;

	setting="height="+h+", width="+w+", top="+TopPostion+", left="+LeftPosition+", toolbar=no, status=yes, resizable=no, scrollbars=yes";
	winobj=window.open(url, nm, setting);
	return winobj;
}

function popWinScrollP(url, nm, w, h, t,l){

	LeftPosition = (screen.width) ? ((screen.width-w)/2)+l:0;
	TopPostion = (screen.height) ? ((screen.height-h)/2)+t:0;

	setting="height="+h+", width="+w+", top="+TopPostion+", left="+LeftPosition+", toolbar=no, status=yes, resizable=no, scrollbars=yes";
	winobj=window.open(url, nm, setting);
	return winobj;
}

function popWinnor(url, nm){
	LeftPosition = 20;
	TopPostion = 20;
	setting="";
	window.open(url, nm, setting);
}

/* ************************************ SELECT BOX ************************************ */

/* ----------------------------------------------------
	select 에서 기존의 선택 값이 선택되게
-------------------------------------------------------- */
function selOrign(frm,val){
	for(i=0; i < document.getElementsByName(frm)[0].length ; i++){
		if(document.getElementsByName(frm)[0].options[i].value == val){
			document.getElementsByName(frm)[0].options.selectedIndex = i ;
		}
	}
}

function selOrignTitle(objname,titlefn){
				for(i=0; i < document.getElementsByName(objname)[0].length ; i++){
					if(document.getElementsByName(objname)[0].options[i].text == titlefn){
						document.getElementsByName(objname)[0].options.selectedIndex = i ;
					}
				}
}

function selOrignTitle_default(objname,titlefn, defaults){
	chk_cnt=0;
				for(i=0; i < document.getElementsByName(objname)[0].length ; i++){
					if(document.getElementsByName(objname)[0].options[i].text == titlefn){
						document.getElementsByName(objname)[0].options.selectedIndex = i ;
						chk_cnt++;
					}
				}
				// 만약에 일치하는 코드가 없으면 기본 선택값으로 셋팅한다
				if(chk_cnt == 0 && defaults!=""){
					for(i=0; i < document.getElementsByName(objname)[0].length ; i++){
						if(document.getElementsByName(objname)[0].options[i].text == defaults){
							document.getElementsByName(objname)[0].options.selectedIndex = i ;
						}
					}
				}
}


/* ************************************ CHECK BOX ************************************ */

/* ---------------------------------------------------------
	checkbox 에서 기존의 선택 값이 선택되게
------------------------------------------------------------- */
function chkboxOrign(frm,val){
	if(frm.length == null){
		if(frm.value == val)
			frm.checked = true;
	}else{
		for(i=0;i<frm.length;i++){
			if(frm[i].value == val){
				frm[i].checked = true;
			}
		}
		return;
	}
}

function chkboxOrign_multi(frm,objchk,val){
	var i = 0;
	for(i=0;i<frm.elements.length;i++){
		if(frm.elements[i].name == objchk){
			if(frm.elements[i].value == val){
				frm.elements[i].checked = true;
			}
		}
	}
}

/* ---------------------------------------------------------------------
	checkbox 에서 기존의  ARRAY NUM 값이 선택되게
------------------------------------------------------------------------- */
function chkboxOrignNum(frm,val){
	if(frm.length == null){
		if(frm.value == val)
			frm.checked = true;
	}else{
		for(i=0;i<frm.length;i++){
			if(i == val){
				frm[i].checked = true;
			   //document.all.list[i].style.backgroundColor="#F6F3EF";
			}else{
				frm[i].checked = false;
				//document.all.list[i].style.backgroundColor="";
			}
		}
		return;
	}
}

/* ---------------------------------------------------------------------
	checkbox 에서 기존의  ARRAY NUM값이 선택되게
------------------------------------------------------------------------- */
function chkboxOrignInit(frm){
	if(frm.length == null){
		frm.checked = false;
	}else{
		for(i=0;i<frm.length;i++){
			frm[i].checked = false;
		}
		return;
	}
}

/* ---------------------------------------------------------------------
	checkbox 에서 체크 순서
------------------------------------------------------------------------- */
function chkboxValue(frm){
	var rStr="";
	if(frm.length == null){
		if(frm.checked == true)
			rStr=0;
			
	}else{
		for(var i=0;i<frm.length;i++){
			if(frm[i].checked == true){
				rStr=i;
			}
		}		
	}

	return rStr;
}

/* ************************************ RADIO BUTTON ************************************ */

/* ---------------------------------------------------------------------
	Radio 에서 기존의 선택 값이 선택되게
------------------------------------------------------------------------- */
function radioOrign(frm,val){
	for(i=0; i < frm.length ; i++){
		if(frm[i].value == val){
			frm[i].checked = true ;
			return ;
		}
	}
}

/* ---------------------------------------------------------------------
	Radio Button / Check Box 값 추출 (예 : form, "field")
------------------------------------------------------------------------- */
function getCheckedValue(frm, strNm){

	for(i=0; i<frm.elements.length; i++){
		if(frm.elements[i].name == strNm && frm.elements[i].checked)
			return frm.elements[i].value;
	}

	return "";
}

/* ************************************ NUMBER CHECK ************************************ */

/* -----------------------------------------------------------------------------------------------------------
//숫자만 입력 아닐수 inputbox 모두 지움 예) onkeyup="inputNum(this);" style="IME-MODE:disabled"
------------------------------------------------------------------------------------------------------------- */
function inputNum(obj){
	//alert("obj.value===>"+obj.value+":::::obj.id===>"+obj.id);
	if(!isEmpty(obj.value)){
		if(/[^0-9]/g.test(obj.value)){

			alert("숫자만 입력 가능합니다.");
			obj.value = '';

		}		
	}


}

/* ---------------------------------------------------------------------
	숫자만 입력받기 예) onKeyUp="return onlyNum();"
------------------------------------------------------------------------- */
function onlyNum(evt){
	//var keyCode = evt.which?evt.which:event.keyCode;
	//alert(event.keyCode);
	var keyCode;
	if(window.event!=null && window.event!=undefined ){
		keyCode = window.event.keyCode;
		//alert('aa');
	}else{
		keyCode = evt.which;
		//alert('bb');
	}
	//alert('1:'+keyCode+":"+window.event+":"+evt.which);
	if(
		(keyCode >= 48 && keyCode <=57) ||
		
		(keyCode >= 37 && keyCode <=40) ||
		keyCode == 9 ||
		keyCode == 8 ||
		keyCode == 46 ||
		(keyCode >= 96 && keyCode <=105)
		){
		//48-57(0-9)
		//96-105(키패드0-9) (keyCode >= 96 && keyCode <=105) || 노특북에서 안됨
		//8 : backspace
		//46 : delete key
		//9 :tab
		//37-40 : left, up, right, down
		//alert('11:'+keyCode);
		event.returnValue=true;
		
	}
	else{
		//alert('숫자만 입력 가능합니다.');
		//alert('22:'+event.keyCode);
		//if(window.event){
		//	alert('221:'+event.keyCode);
		//  event.returnValue=false; //IE , - Chrome both 
		//}else{ 
		//	alert('222:'+event.keyCode);
		  evt.preventDefault(); //FF , - Chrome both 
		//} 		
		
	}
}

function onlyNum_test(evt){
	var keyCode = evt.which?evt.which:event.keyCode;

		//alert('숫자만 입력 가능합니다.');
		alert('2::'+keyCode);
		if(window.event){
			keyCode = event.keyCode;
			if((keyCode >= 48 && keyCode <=57) ||
					(keyCode >= 96 && keyCode <=105) ||
					(keyCode >= 37 && keyCode <=40) ||
					keyCode == 9 ||
					keyCode == 8 ||
					keyCode == 46){
				//48-57(0-9)
				//96-105(키패드0-9)
				//8 : backspace
				//46 : delete key
				//9 :tab
				//37-40 : left, up, right, down
				//alert('1'+event.keyCode);	
				alert('1::'+keyCode+":"+evt.which);
				event.returnValue=false;
				
			}else{
				alert('2::'+keyCode+":"+evt.which);
				event.returnValue=true; //IE , - Chrome both 
			}
		  
		}else{ 
			if((keyCode >= 48 && keyCode <=57) ||
					(keyCode >= 96 && keyCode <=105) ||
					(keyCode >= 37 && keyCode <=40) ||
					keyCode == 9 ||
					keyCode == 8 ||
					keyCode == 46){
				//48-57(0-9)
				//96-105(키패드0-9)
				//8 : backspace
				//46 : delete key
				//9 :tab
				//37-40 : left, up, right, down
				//alert('1'+event.keyCode);				
				//alert('3::'+keyCode);
				
			}else{
				//alert('4::'+keyCode);
				evt.preventDefault(); //FF , - Chrome both 
			}			
					
		  
		} 		
		

}

function onlyNumFloat(evt){
	//var keyCode = evt.which?evt.which:event.keyCode;
	//alert(event.keyCode);
	var keyCode;
	if(window.event!=null && window.event!=undefined ){
		keyCode = window.event.keyCode;
		//alert('aa');
	}else{
		keyCode = evt.which;
		//alert('bb');
	}
	//alert('1:'+keyCode+":"+window.event+":"+evt.which);
	if(
		(keyCode >= 48 && keyCode <=57) ||
		
		(keyCode >= 37 && keyCode <=40) ||
		keyCode == 9 ||
		keyCode == 8 ||
		keyCode == 46 || event.keyCode == 190
		){
		//48-57(0-9)
		//96-105(키패드0-9) (keyCode >= 96 && keyCode <=105) || 노특북에서 안됨
		//8 : backspace
		//46 : delete key
		//9 :tab
		//37-40 : left, up, right, down
		//190 : (.소수점)
		//alert('11:'+keyCode);
		event.returnValue=true;
		
	}
	else{
		//alert('숫자만 입력 가능합니다.');
		//alert('2'+event.keyCode);
		if(window.event){
		  event.returnValue=false; //IE , - Chrome both 
		}else{ 
		  evt.preventDefault(); //FF , - Chrome both 
		} 		
		
	}
}

function onlyNumFloatChk(evt){
	//var keyCode = evt.which?evt.which:event.keyCode;
	//alert(event.keyCode);
	var keyCode;
	var evtobj;

	if(window.event!=null && window.event!=undefined ){
		keyCode = window.event.keyCode;
		//alert("window.event.srcElement.id:"+window.event.srcElement.id);
		evtobj = window.event.srcElement;
	}else{
		keyCode = evt.which;
		//alert("evt.target.id:"+evt.target.id);
		evtobj = evt.target;
	}	

	//alert('1:'+keyCode+":");
	if(
		(keyCode >= 48 && keyCode <=57) ||
		
		(keyCode >= 37 && keyCode <=40) ||
		keyCode == 9 ||
		keyCode == 8 ||
		keyCode == 46 || event.keyCode == 190
		){
		//48-57(0-9)
		//96-105(키패드0-9) (keyCode >= 96 && keyCode <=105) || 노특북에서 안됨
		//8 : backspace
		//46 : delete key
		//9 :tab
		//37-40 : left, up, right, down
		//190 : (.소수점)
		//alert('11:'+keyCode);
		//소숫점이 입력된경우 기존 문자에 .소수점이 있으면 입력못하도록 막는다
		var i=0;
		var increment=0;
		if(event.keyCode == 190){
			//alert(evtobj.value);
			for(i=0; i < evtobj.value.length; i++){

				if(evtobj.value.substring(i, i+1).indexOf(".") == 0){
					increment = increment+1;
				}
			}

			if(increment > 0){
				if(window.event){
					  event.returnValue=false; //IE , - Chrome both 
				}else{ 
					  evt.preventDefault(); //FF , - Chrome both 
				} 
				
				//alert("소숫점은 한번만 입력 가능합니다.");
				//obj.value = obj.value.substring(0, i);
				//return false;
			}else{
				event.returnValue=true;
			}
		}else{
			event.returnValue=true;
		}
		
	}
	else{
		//alert('숫자만 입력 가능합니다.');
		//alert('2'+event.keyCode);
		if(window.event){
		  event.returnValue=false; //IE , - Chrome both 
		}else{ 
		  evt.preventDefault(); //FF , - Chrome both 
		} 		
		
	}
}

function maskOnlyNumFloat(obj , intlen, poinlen){
	var sp_point = obj.value.split(".");
	var intstr = "";
	var intchk = false;
	var pointstr = "";
	var pointchk = false;
	// 정수부분이 지정길이를 초과하면 마지막숫자를 지운다
	if(intlen < getLength(sp_point[0]) ){
		intstr = sp_point[0].substring(0, getLength(sp_point[0])-1);
		intchk = true;
	}else{
		intstr = sp_point[0];
	}
	//소수부분이 있으면
	if(sp_point.length>1){
		if(poinlen < getLength(sp_point[1]) ){
			pointstr = sp_point[1].substring(0, getLength(sp_point[1])-1);
			pointchk = true;
		}else{
			pointstr = sp_point[1];
		}
		
		intstr = intstr +"."+pointstr;
	}
	if(intchk == true || pointchk==true){
		obj.value = intstr;
	}
	
	//self.window.focus();
}

function maskOnlyNumFloatComma(obj , intlen, poinlen){
	var del_comma_str = del_comma2(obj.value);
	//var sp_point = obj.value.split(".");
	var sp_point = del_comma_str.split(".");
	var intstr = "";
	var intchk = false;
	var pointstr = "";
	var pointchk = false;
	// 정수부분이 지정길이를 초과하면 마지막숫자를 지운다
	if(intlen < getLength(sp_point[0]) ){
		intstr = sp_point[0].substring(0, getLength(sp_point[0])-1);
		intchk = true;
	}else{
		intstr = sp_point[0];
	}
	//소수부분이 있으면
	if(sp_point.length>1){
		if(poinlen < getLength(sp_point[1]) ){
			pointstr = sp_point[1].substring(0, getLength(sp_point[1])-1);
			pointchk = true;
		}else{
			pointstr = sp_point[1];
		}
		
		intstr = intstr +"."+pointstr;
	}
	
	//console.log(intstr);
	//console.log(add_comma5(intstr));
	if(intchk == true || pointchk==true){
		obj.value = add_comma5(intstr);
	}else{
		obj.value = add_comma5(intstr);
	}
	
	//self.window.focus();
}

/* ---------------------------------------------------------------------
	숫자만 입력받기(메시지 표시) 예) onKeyUp="onlyNumberForPlan();"
------------------------------------------------------------------------- */
function onlyNumberForPlan() {
    var objEv = event.srcElement;
 if(!isNumComma(objEv)){
        alert("숫자만 입력가능합니다.");
        objEv.value = "";
        objEv.focus();
        return false;
    }
    return true;
}
function isNumComma(input) {
    var chars = ",0123456789";
    return containsCharsOnly(input,chars);
}
function containsCharsOnly(input,chars) {
    for (var inx = 0; inx < input.value.length; inx++) {
       if (chars.indexOf(input.value.charAt(inx)) == -1)
           return false;
    }
    return true;
}

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------
	지정된 길이반큼만 입력받기	예) onKeyUp="return  checkAllowLength(현재숫자보여지는객체,필드객체명 ,자리수);"
-------------------------------------------------------------------------------------------------------------------------------------------------------------- */
function checkAllowLength(objView, objTar, max_cnt){
	if(event.keyCode > 31 || event.keyCode == "") {
		if(objTar.value.bytes() > max_cnt){
			alert("최대 " + max_cnt + "byte를 넘길 수 없습니다.");
			objTar.value = objTar.value.cut(max_cnt);
		}
	}
	objView.value = objTar.value.bytes();
}

/* ----------------------------------------------------------------------------------------------------------------------------------------------------------
	지정된 길이반큼만 입력받기2 예) onKeyUp="return  checkInputLength(타이틀명, 필드객체명 ,자리수);"
-------------------------------------------------------------------------------------------------------------------------------------------------------------- */
function checkInputLength(title, objTar, max_cnt){

	if(event.keyCode > 31 || event.keyCode == "") {
		if(objTar.value.bytes() > max_cnt){
			alert(title + "(은)는 최대 " + max_cnt + " byte를 넘길 수 없습니다.");
			objTar.value = objTar.value.cut(max_cnt);
		}
	}
}
//-------------------------------------------------------------------
// 숫자인가를 체크하는 함수  // Arg로 받은 한 값이 조건에 맞는지 하나씩 체크해야 함.
//-------------------------------------------------------------------
function is_int(value) {
    var   j;
    for(j=0;j<_intValue.length;j++)
        if(value == _intValue.charAt(j)) {
            return true;
        }
    return false;
}


//-------------------------------------------------------------------
//숫자인가를 체크하는 함수  // Arg로 받은 한 값이 조건에 맞는지 하나씩 체크해야 함.
//-------------------------------------------------------------------
function is_zipcode(value) {
 var   j;
 for(j=0;j<_checkzipcode.length;j++)
     if(value == _checkzipcode.charAt(j)) {
         return true;
     }
 return false;
}


//-------------------------------------------------------------------
// 숫자로 구성된 문자열인가를 체크하는 함수 (마이너스, 콤마, Dot 모두 허용)
//-------------------------------------------------------------------
function check_digit(obj)
{
    var    i;
    var    str =  new String(del_comma(obj));
    for(i=0;i<str.length;i++)
        if(!is_numeric(str.charAt(i))){           // 0425, is_digit() 로 된것을 수정.
			alert('숫자만 입력가능합니다.');
			obj.value = "";
            obj.focus();
            return false;
        }
    return true;
}

//-------------------------------------------------------------------
// 숫자로 구성된 문자열인가를 체크하는 함수 (예:onKeyUp="is_digit(this)")
//-------------------------------------------------------------------
function is_digit(obj)
{
    var    i;
    var    str =  new String(obj.value);
	str = del_comma(obj);

    for(i=0;i<str.length;i++)
        if(!is_int(str.charAt(i))){
            alert('숫자만 입력가능합니다.');
			obj.value = "";
            obj.focus();
            return false;
        }
    return true;
}



//-------------------------------------------------------------------
//숫자로 구성된 문자열인가를 체크하는 함수 (예:onKeyUp="is_digit(this)")
//-------------------------------------------------------------------
function check_zipcode(obj)
{
 var    i;
 var    str =  new String(obj.value);
	str = del_comma(obj);

 for(i=0;i<str.length;i++)
     if(!is_zipcode(str.charAt(i))){
         alert('숫자만 입력가능합니다.');
			obj.value = "";
         obj.focus();
         return false;
     }
 return true;
}

//-------------------------------------------------------------------
//숫자로 구성된 문자열인가를 체크하는 함수 (예:onKeyUp="is_digit(this)")
//-------------------------------------------------------------------
function is_digit2(obj)
{
 var    i;
 var    str =  new String(obj.value);
	str = del_comma(obj);

 for(i=0;i<str.length;i++)
     if(!is_int(str.charAt(i))){
		 obj.value = "";
         obj.focus();
         return false;
     }
 return true;
}


//-------------------------------------------------------------------
// 숫자값에서 -, 소숫점도 허용하게 하고 숫자열을 체크하는 함수    '.'  '-' 도 허용하게 수정함. // Arg로 받은 한 값이 조건에 맞는지 하나씩 체크해야 함.
//-------------------------------------------------------------------
function is_numeric(value) {
    var   j;
    for(j=0;j<_checkNumValue.length;j++)
        if(value == _checkNumValue.charAt(j)) {
            return true;
        }
    return false;
}

/* --------------------------------------------------------------------------------------------------------
	숫자열에 3자리 단위로 ','를 삽입(금액 등) (Object)
------------------------------------------------------------------------------------------------------------ */
function add_comma(obj) {
	var str =  String(obj.value);
    var x = 0;
    if (str.length < 1) {
        return "";
    } else {
        var tm = "";
        var ck = "";
        if (str.substring(0, 1) == "-") {
            tm = str.substring(1, str.length);
            ck = "Y";
        } else {
            tm = str;
            ck = "N";
        }
        var st = "";
        var cm = ",";
        for (var i = tm.length, j = 0; i > 0; i--, j++) {
            if ((j % 3) == 2) {
                if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
                else st = cm + tm.substring(i - 1, i) + st;
            } else {
                st = tm.substring(i - 1, i) + st;
            }
        }
        if (ck == "Y") st = "-" + st;
        return st;
    }
}


/* --------------------------------------------------------------------------------------------------------
	금액을 나타내는 숫자열에 3자리 단위로 ','를 삽입하는 함수 (String)
------------------------------------------------------------------------------------------------------------ */
function add_comma2(str) {
	//var str =  String(obj.value);
    var x = 0;
    if (str.length < 1) {
        return "";
    } else {
        var tm = "";
        var ck = "";
        if (str.substring(0, 1) == "-") {
            tm = str.substring(1, str.length);
            ck = "Y";
        } else {
            tm = str;
            ck = "N";
        }

        var st = "";
        var cm = ",";
        for (var i = tm.length, j = 0; i > 0; i--, j++) {
            if ((j % 3) == 2) {
                if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
                else st = cm + tm.substring(i - 1, i) + st;
            } else {
                st = tm.substring(i - 1, i) + st;
            }
        }
        if (ck == "Y") st = "-" + st;
        return st;
    }
}

/* --------------------------------------------------------------------------------------------------------
금액을 나타내는 숫자열에 3자리 단위로 ','를 삽입하는 함수 (String)
------------------------------------------------------------------------------------------------------------ */
function add_comma3(str) {
var x = 0;
	if (str.length < 1) {
	    return "";
	} else {
	    var tm = "";
	    var ck = "";
	    if (str.substring(0, 1) == "-") {
	        tm = str.substring(1, str.length);
	        ck = "Y";
	    } else {
	        tm = str;
	        ck = "N";
	    }
	
	    var st = "";
	    var cm = ",";
	    for (var i = tm.length, j = 0; i > 0; i--, j++) {
	        if ((j % 3) == 2) {
	            if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
	            else st = cm + tm.substring(i - 1, i) + st;
	        } else {
	            st = tm.substring(i - 1, i) + st;
	        }
	    }
	    if (ck == "Y") st = "-" + st;
	    return document.write(st);
	}
}


/* --------------------------------------------------------------------------------------------------------
금액을 나타내는 숫자열에 3자리 단위로 ','를 삽입하는 함수 (String) 소숫점 포함 자리수 콤마처리
------------------------------------------------------------------------------------------------------------ */
function add_comma4(str) { 
	
//var str =  String(obj.value);
str = StrreplaceAll(str,",","");	
var x = 0;
	if (str.length < 1) {
	    return "";
	} else {
	    var tm = "";
	    var ck = "";
	    var tm_s = "";
	    var tm_s_i = 0;
	    if (str.substring(0, 1) == "-") {
	        tm = str.substring(1, str.length);
	        ck = "Y";
	    } else {
	        tm = str;
	        ck = "N";
	    }
	    
	    // 소숫점이 있으면
	    if(tm.indexOf(".") > -1){
	    	tm_s = tm.substring(tm.indexOf(".")+1, str.length);
	    	
	    	// 소숫점 아래 값이 0보다 크면 있으면 소숫점 앞까지
	    	tm_s_i = parseInt(tm_s,10);
	    	
	    	tm = tm.substring(0 ,tm.indexOf("."));
	    }
	
	    var st = "";
	    var cm = ",";
	    for (var i = tm.length, j = 0; i > 0; i--, j++) {
	        if ((j % 3) == 2) {
	            if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
	            else st = cm + tm.substring(i - 1, i) + st;
	        } else {
	            st = tm.substring(i - 1, i) + st;
	        }
	    }
	    if (ck == "Y") st = "-" + st;
	    
	    if (tm_s_i > 0){ 
	    	st = st+"."+tm_s;
	    	//if(str=="17.09"){alert(tm_s+":::::"+tm_s_i);}
	    }
	    return st;
	}
}


/* --------------------------------------------------------------------------------------------------------
금액을 나타내는 숫자열에 3자리 단위로 ','를 삽입하는 함수 (String) 소숫점 포함 자리수 콤마처리
------------------------------------------------------------------------------------------------------------ */
function add_comma5(str) { 
	
//var str =  String(obj.value);
str = StrreplaceAll(str,",","");	
var x = 0;
	if (str.length < 1) {
	    return "";
	} else {
	    var tm = "";
	    var ck = "";
	    var tm_s = "";
	    var tm_s_i = 0;
	    if (str.substring(0, 1) == "-") {
	        tm = str.substring(1, str.length);
	        ck = "Y";
	    } else {
	        tm = str;
	        ck = "N";
	    }
	    
	    // 소숫점이 있으면
	    if(tm.indexOf(".") > -1){
	    	tm_s = tm.substring(tm.indexOf(".")+1, str.length);
	    	
	    	// 소숫점 아래 값이 0보다 크면 있으면 소숫점 앞까지
	    	tm_s_i = parseInt(tm_s,10);
	    	
	    	tm = tm.substring(0 ,tm.indexOf("."));
	    }
	
	    var st = "";
	    var cm = ",";
	    for (var i = tm.length, j = 0; i > 0; i--, j++) {
	        if ((j % 3) == 2) {
	            if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
	            else st = cm + tm.substring(i - 1, i) + st;
	        } else {
	            st = tm.substring(i - 1, i) + st;
	        }
	    }
	    if (ck == "Y") st = "-" + st;
	    
	    //console.log("str.indexOf:"+str.indexOf("."));
	    if(str.indexOf(".") > -1){
		    if (tm_s_i > 0){ 
		    	//console.log("dfdsfs");
		    	st = st+"."+tm_s;
		    	//if(str=="17.09"){alert(tm_s+":::::"+tm_s_i);}
		    }else{
		    	//console.log("2222");
		    	st = st+".";
		    }	    	
	    }

	    return st;
	}
}

/* --------------------------------------------------------------------------------------------------------
금액을 나타내는 숫자열에 3자리 단위로 ','를 삽입하는 함수 (String) 소숫점 포함 자리수 콤마처리 전기요금단가표에서 사용하는 소숫점아래 자리수 채움
------------------------------------------------------------------------------------------------------------ */
function add_comma_elec(str) { 
	
//var str =  String(obj.value);
str = StrreplaceAll(str,",","");	
var x = 0;
if (str.length < 1) {
    return "";
} else {
    var tm = "";
    var ck = "";
    var tm_s = "";
    var tm_s_i = 0;
    if (str.substring(0, 1) == "-") {
        tm = str.substring(1, str.length);
        ck = "Y";
    } else {
        tm = str;
        ck = "N";
    }
    
    // 소숫점이 있으면
    if(tm.indexOf(".") > -1){
    	tm_s = tm.substring(tm.indexOf(".")+1, str.length);
    	
    	// 소숫점 아래 값이 0보다 크면 있으면 소숫점 앞까지
    	tm_s_i = parseInt(tm_s,10);
    	
    	tm = tm.substring(0 ,tm.indexOf("."));
    }

    var st = "";
    var cm = ",";
    for (var i = tm.length, j = 0; i > 0; i--, j++) {
        if ((j % 3) == 2) {
            if (tm.length == j + 1) st = tm.substring(i - 1, i) + st;
            else st = cm + tm.substring(i - 1, i) + st;
        } else {
            st = tm.substring(i - 1, i) + st;
        }
    }
    if (ck == "Y") st = "-" + st;
    
    if (tm_s_i > 0){ 
    	st = st+"."+tm_s;
    	//if(str=="17.09"){alert(tm_s+":::::"+tm_s_i);}
    }
    
    // 소숫점아래 자리수가 몇자리인지 확인해서 자리수를 맞춰준다
    // 소숫점아래가 없는경우 소숫점아래 2자리를 채워준다
    if(pointlowlen(st)==0){
    	st = st+".00";
    // 소숫점아래 자리가 있는경우 보족한 자리수만큰 채워준다
    }else{
    	if(pointlowlen(st)==1)
    		st = st+ "0";
    	}
    }
    
    return st;
}


// 소수 자리수 반올림
function roundXL(n, digits) {
  if (digits >= 0) return parseFloat(n.toFixed(digits)); // 소수부 반올림

  digits = Math.pow(10, digits); // 정수부 반올림
  var t = Math.round(n * digits) / digits;

  return parseFloat(t.toFixed(0));
}

// 기준단위표시
function b_unit(n, digits) {
  rtn_str="";
  if(n.length < digits){
	rtn_str = "0";
  }else{
	rtn_str = n.substring(0,n.length-digits);

  }

  return rtn_str;
}

// 소숫점아래  자리수 확인
function pointlowlen(str){
	var tm_s = "";
    // 소숫점이 있으면
    if(str.indexOf(".") > -1){
    	tm_s = str.substring(str.indexOf(".")+1, str.length);
    }
    return tm_s.length;
}


/* --------------------------------------------------------------------------------------------------------
	금액을 나타내는 숫자열에 3자리 단위로 ','를 삽입하는 함수 (obj)
------------------------------------------------------------------------------------------------------------ */
function add_comma_replace(obj){
	obj.value = add_comma(obj);
}


/* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// 입력창에 숫자 데이터를 입력할때 자동으로 ',' 가 붙어 입력되게 하기 위해 사용한다.
// 하지만 이 함수는 항상 커서가 맨 뒤로 가기 때문에 숫자의 맨 앞이나 중간 값을 삭제할 때 문제를 발생 시킨다.
// 이 함수를 사용하기 위해서는 다음과 같이 정의하여야 한다.
// <INPUT name="amt1" value="" size="10" maxlength="10" class="input01" onKeyUp = 'is_add_comma(myForm.amt1, amt1)'>
// 상기 예처럼 인자를 폼 객체와 Input 박스 이름을 준다.
// * 주의  : 상기 함수를 사용하였다면 Input 박스 값이 숫자 값인지 체크할 때는 is_digit(obj); 를 쓴다.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- */
function is_add_comma(obj) {

	var i = 0;
	var num = '';
	var num = new String(del_comma(obj));

	if ((num.length < 1)||(num == '')) {
        return '';
    } else {
        var tm = "";
        var ck = "";
        if (num.substring(0, 1) == "-") {
            tm = num.substring(1, num.length);
            ck = "Y";
        } else {
            tm = num;
            ck = "N";
        }
		var j = 0;
		var k = 0;
        var st = "";
        var cm = ",";
		var tm_prev = "";
		var tm_next = "";
	    for(i=0;i<num.length;i++) {
			if(!is_numeric(num.charAt(i))){    // '.', '-'를 체크하지 못해 is_numeric()를 새로 추가함 0425
				alert("입력 값이 잘못되었습니다.");
				obj.value = "";
				obj.focus();
				return "";
			}
		}
		for (i = 0; i < tm.length; i++) {   // '.'이 한개 이상 나오면 Error 처리
			if (tm.substring(i, i + 1) == ".")
				j = j + 1;
			if (tm.substring(i, i + 1) == "-")
				k = k + 1;
		}

		if (j > 1 || k > 0) {
			alert("입력 값이 잘못되었습니다.");
			obj.value = "";
			obj.focus();
			return "";
		}

		tm = tm.split('.'); // '.'가 하나만 있는 상태에서 '.' 앞 뒤 숫자를 분리한다
		tm_prev = tm[0];
		tm_next = tm[1];

		for (var i = tm_prev.length, j = 0; i > 0; i--, j++) {

			if ((j % 3) == 2) {
				if (tm_prev.length == j + 1) st = tm_prev.substring(i - 1, i) + st;
				else st = cm + tm_prev.substring(i - 1, i) + st;
			} else {
				st = tm_prev.substring(i - 1, i) + st;
			}
		}
		if (tm_next == '' || tm_next == undefined)  // 소숫점 이후에 값이 없는 경우
		{
			st = st;	
		}
		else if (tm_prev == '' || tm_prev == undefined) // 소숫점을 먼저 찍고 숫자를 이어 쓴 경우
		{
			st = '0.'+tm_next;
		}
		else 	st = st+"."+tm_next;		//분리된 '.' 이하 자릿수를 붙인다.
		if (ck == "Y") st = "-" + st;		//분리된 '-' 를 붙인다.
			obj.value = st;
	}

/*
    var Key = event.keyCode;
    if (Key == 9)
        obj.select();
*/

}

/* --------------------------------------------------------------------------------------------------------
	숫자열의 ',' 문자를 제거하는 함수
------------------------------------------------------------------------------------------------------------ */
function del_comma(obj) {

//	var obj_str = String(obj);
	var str =  String(obj.value);
    if (str.length < 1) {
        return "";
    } else {
        var st = "";
        var sp = ",";
        for (var i = 0; i < str.length; i++) {
            if (sp.indexOf(str.substring(i, i + 1)) == -1) {
                st += str.substring(i, i + 1);
            }
        }
        return st;
    }
}

function del_comma2(objstr) {

//	var obj_str = String(obj);
	var str =  objstr;
    if (str.length < 1) {
        return "";
    } else {
        var st = "";
        var sp = ",";
        for (var i = 0; i < str.length; i++) {
            if (sp.indexOf(str.substring(i, i + 1)) == -1) {
                st += str.substring(i, i + 1);
            }
        }
        return st;
    }
}

function del_comma_replace(obj) {
	obj.value =  del_comma(obj);
}


/* --------------------------------------------------------------------------------------------------------
	숫자체크 및 소숫점 중복입력, 소수점자리수 체크 (예: if(!pointCheck(frm.dto_sEconoUp, 3)) return; )
	mrkim 2015-07-06 수정
------------------------------------------------------------------------------------------------------------ */

function pointCheck(obj, len){

	var increment = 0;

	// 숫자유무체크
	if(check_digit(obj)){

		if(obj.value.indexOf(".") == 0){
			obj.value = "";
			return false;
		}
//		else if(obj.value.indexOf(".") == "-1" && obj.value.length > len) {
//			alert("정수는 "+ len+"자리 이상 입력할 수 없습니다.");
//			obj.value = obj.value.substring(0,3);
//			return false;
//		}


		for(i=0; i < obj.value.length; i++){

			if(obj.value.substring(i, i+1).indexOf(".") == 0){
				increment = increment+1;

				if(increment > 1){
					alert("소숫점은 한번만 입력 가능합니다.");
					obj.value = obj.value.substring(0, i);
					return false;
				}
			}
		}
		
		if(pointlowlen(obj.value)>len){
			alert("소숫점은 "+len+"자리까지 입력 가능합니다.");
			obj.value = obj.value.substring(0, obj.value.indexOf(".")+(Number(len)+1));
			return false;
		}
	}

	return true;
}



/* --------------------------------------------------------------------------------------------------------
	소숫점 입력 위치체크 (예 : onKeyDown='pointLength(this, 3, "정수 3자리, 소숫점 5자리까지 입력가능합니다.")') 2006-01-18
------------------------------------------------------------------------------------------------------------ */
function pointLength(obj, length, msg){

	if(check_digit(obj)){

		if(obj.value.indexOf(".") > length){
			alert(msg);
			return false;
		}
	}

	return true;
}



/* ************************************ IMAGE ************************************ */

/* ---------------------------------------------------------------------
	이미지 RESIZE
------------------------------------------------------------------------- */
function resizeImg(imgObj, max_width, max_height){

	var dst_width;
	var dst_height;
	var img_width;
	var img_height;

	img_width = parseInt(imgObj.width);
	img_height = parseInt(imgObj.height);

	if(img_width == 0 || img_height == 0){
		imgObj.style.display = '';
		return false;
	}

    // 가로비율 우선으로 시작
    if(img_width > max_width || img_height > max_height) {
        // 가로기준으로 리사이즈
        dst_width = max_width;
        dst_height = Math.ceil((max_width / img_width) * img_height);

        // 세로가 max_height 를 벗어났을 때
        if(dst_height > max_height) {
			dst_height = max_height;
			dst_width = Math.ceil((max_height / img_height) * img_width);
        }

        imgObj.width = dst_width;
        imgObj.height = dst_height;
    }
    // 가로비율 우선으로 끝

	imgObj.style.display = '';

	return true;
}


/* ---------------------------------------------------------------------
	xml data 읽어오기
------------------------------------------------------------------------- */
function getXmlHttpRequest(_url, _param){
    var objXmlConn;
    try{objXmlConn = new ActiveXObject("Msxml2.XMLHTTP.3.0");}
    catch(e){try{objXmlConn = new ActiveXObject("Microsoft.XMLHTTP");}catch(oc){objXmlConn = null;}}

    if(!objXmlConn && typeof XMLHttpRequest != "undefined") objXmlConn = new XMLHttpRequest();

    objXmlConn.open("GET", _url + "?" + _param, false);
    objXmlConn.send(null);
	
	//code|message 형태로 리턴
    return objXmlConn.responseText.trim().split("|");
}

/* ************************************ COOKIE SETTING ************************************ */

/* ---------------------------------------------------------------------
	cookie 설정
------------------------------------------------------------------------- */
function getCookieVal (offset) {
   var endstr = document.cookie.indexOf (";", offset);
   if (endstr == -1) endstr = document.cookie.length;
   return unescape(document.cookie.substring(offset, endstr));
}

function GetCookie (name) {
   var arg = name + "=";
   var alen = arg.length;
   var clen = document.cookie.length;
   var i = 0;
   while (i < clen) {	//while open
      var j = i + alen;
      if (document.cookie.substring(i, j) == arg)
         return getCookieVal (j);
      i = document.cookie.indexOf(" ", i) + 1;
      if (i == 0) break; 
   }	//while close
   return null;
}

function SetCookie (name, value) {
   var argv = SetCookie.arguments;
   var argc = SetCookie.arguments.length;
   var expires = (2 < argc) ? argv[2] : null;
   var path = (3 < argc) ? argv[3] : null;
   var domain = (4 < argc) ? argv[4] : null;
   var secure = (5 < argc) ? argv[5] : false;
   document.cookie = name + "=" + escape (value) +
      ((expires == null) ? "" : 
         ("; expires=" + expires.toGMTString())) +
      ((path == null) ? "" : ("; path=" + path)) +
      ((domain == null) ? "" : ("; domain=" + domain)) +
      ((secure == true) ? "; secure" : "");
} 

/* ************************************ CHECK / PARRTEN / VALUE ************************************ */

/* ---------------------------------------------------------------------
	특수문자 체크 예) if(!checkSpecialChar()) return;
------------------------------------------------------------------------- */
function checkSpecialChar(_obj){
    if(_obj.value.search(/[\",\',<,>]/g) >= 0) {
        alert("문자열에 특수문자( \",  ',  <,  > )가 있습니다.\n특수문자를 제거하여 주십시오!");
        _obj.select();
        _obj.focus();
    }
}


/* ---------------------------------------------------------------------
	조회시 dto_curr_page 값 셋팅
------------------------------------------------------------------------- */
function goPagination(form,URL,pageIndex,formele){
		eleobj = eval(form+"."+formele);
		eval(form).action=URL;
		eleobj.value=pageIndex;
		if(eval(form).pstate!=undefined){
			eval(form).pstate.value="L";
		}
		
		eval(form).method="get";
		eval(form).submit();		
	}	
	
/* ---------------------------------------------------------------------
	List Scroll Event
------------------------------------------------------------------------- */
function bodyScroll(){
    var sctop=event.srcElement.scrollTop;
    var scleft=event.srcElement.scrollLeft;
    var header=document.all('header');
    header.scrollLeft=scleft;
}

/* ---------------------------------------------------------------------
	V Scroll Control
------------------------------------------------------------------------- */
function ChListTableWidth(col, row, Twidth){

	tw = 25;
	row = (row==0)?1:row-1;

	tit = new Array(col);
	listTd = new Array(col);
	wid = new Array(col);
	for(i=0;i<col;i++){
		tit[i] = eval("document.all.tit" + i + ".clientWidth") + 10;
		listTd[i] = eval("document.all.listTd" + row + "_" + i + ".clientWidth") + 10;
		wid[i] = (tit[i] >  listTd[i])?tit[i]:listTd[i];
		if(wid[i]<50) wid[i]=50;
		if(i!=0){
			eval("document.all.tit" + i + ".width = wid[" + i + "]");
			eval("document.all.listTd" + row + "_" + i + ".width = wid[" + i + "]");
		}
		tw += wid[i];
	}
	tw += col*2;
	tw += 25;
	if(parseInt(tw)<Twidth) tw=Twidth;
	
	document.all.tt.width = tw;
	document.all.tl.width = tw;
}

/* --------------------------------------------------------------------------------------------------------
	Parrten 분류 (주민번호, 우편번호, 일자) 예) setParrten("구분자", "필드명");
------------------------------------------------------------------------------------------------------------ */
function setParrten(key,obj){
    var    i;
    var    str =  new String(obj.value);
	str = del_comma(obj);

    for(i=0;i<str.length;i++)
        if(!is_zipcode(str.charAt(i))){
            alert('숫자만 입력가능합니다.');
			obj.value = "";
            obj.focus();
            return;
        }
    
	if(obj.value!=""){
		if(key=='jumin'){
			offParrten(obj);
			obj.value=obj.value.substring(0,6)+"-"+obj.value.substring(6,13);
		}else if(key=='zipcode'){
			offParrten(obj);
			obj.value=obj.value.substring(0,3)+"-"+obj.value.substring(3,6);
		}else if(key=='day'){
			obj.value=obj.value.substring(0,4)+"-"+obj.value.substring(4,6)+"-"+obj.value.substring(6,8);
		}else if(key=='day2'){
			obj.value=obj.value.substring(0,4)+"-"+obj.value.substring(4,6);
		}
	}
}

/* --------------------------------------------------------------------------------------------------------
	Parrten 분류 (주민번호, 우편번호, 일자) 예) setParrten("구분자", "필드명"); (String)
------------------------------------------------------------------------------------------------------------ */
function setParrten2(key, str){

	if(key=='jumin'){
		offParrten1(str);
		str=str.substring(0,6)+"-"+str.substring(6,13);
	}else if(key=='zipcode'){
		offParrten1(str);
		str=str.substring(0,3)+"-"+str.substring(3,6);
	}else if(key=='day'){
		str=str.substring(0,4)+"-"+str.substring(4,6)+"-"+str.substring(6,8);
	}else if(key=='day2'){
		str=str.substring(0,4)+"-"+str.substring(4,6);
	}

	return str;
}

function onfocusAllSel(obj){
	obj.select();
}


/* --------------------------------------------------------------------------------------------------------
	주민번호 유효성체크 (추가 : 2006-01-05)
------------------------------------------------------------------------------------------------------------ */
function isJuminNum(aNum1, aNum2){
	var tot=0, result=0, re=0, se_arg=0;
	var chk_num="";
	var aNum = aNum1 + aNum2;

	 if (aNum.length != 13){
		 return false;
	 } else {
		 for (var i=0; i <12; i++){
			 if (isNaN(aNum.substr(i, 1)))
			 return false;
			 se_arg = i;

			//외국인 인 경우
			 if(i==6){
				 if (aNum.substr(i, 1) == 7 || aNum.substr(i, 1) == 8 ) 
					 return true
			}

			if (i >= 8) 
				se_arg = i - 8;
				tot = tot + Number(aNum.substr(i, 1)) * (se_arg + 2)
			}

			if (chk_num != "err"){
				re = tot % 11;
				result = 11 - re;
				if (result >= 10) result = result - 10;
				if (result != Number(aNum.substr(12, 1))) 
					return false;
				if ((Number(aNum.substr(6, 1)) < 1) || (Number(aNum.substr(6, 1)) > 4)) 
					return false;
				}
			}
	return true;
}


/* ************************************ DATE 관련 ************************************ */

/* --------------------------------------------------------------------------------------------------------
	날짜 및 주민번호 문자값 제거 ("-" or "-")
------------------------------------------------------------------------------------------------------------ */
function offParrten(obj){
		obj.value=obj.value.replace("-","");
		obj.value=obj.value.replace("-","");
}

/* --------------------------------------------------------------------------------------------------------
	일자 "-" 없이 표시(String)
------------------------------------------------------------------------------------------------------------ */
function offParrten1(str){
	str=str.replace("-","");
	str=str.replace("-","");
	return str;
}

/* --------------------------------------------------------------------------------------------------------
	일자 "-" 없이 표시(object)
------------------------------------------------------------------------------------------------------------ */
function offParrten2(obj){
	obj.value = obj.value.substring(0,4)+obj.value.substring(5,7)+obj.value.substring(8,10);
}

/* --------------------------------------------------------------------------------------------------------
	숫자인지체크 (Arg로 받은 값이 조건에 맞는지 하나씩 체크해야 함.)
------------------------------------------------------------------------------------------------------------ */
function is_int(value) {
    var   j;
    for(j=0;j<_intValue.length;j++)
        if(value == _intValue.charAt(j)) {
            return true;
        }
    return false;
}

/* --------------------------------------------------------------------------------------------------------
	날짜형식 체크
------------------------------------------------------------------------------------------------------------ */
function check_date(myform, myinput, mymsg)
{
	var str;
	str = mymsg;
	with (myform) {
		if (!check_date_body(myinput, "-")) {
			if (str.length == 0)
				alert("날자 입력형식이 틀렸습니다. 예) YYYY/MM/DD");
			else
				alert(str);
			myinput.focus();
			myinput.select();
			return false;
		}
		return true;
	}
}

function check_date_body(ctl_date, sep)
{
    var str=ctl_date.value;
    if (str.length == 0)
		return false;

    // Check for  10 characters in string.
    if (str.length != 10)
	return false;

    // Checks that characters are numbers or hyphens.
    for (var i = 0; i < str.length; i++)
    {
	var ch = str.substring(i, i + 1);
	if ((i==4)||(i==7)) {
		if (ch != "-") return false;
  	} else {
		if ((ch < "0")||(ch > "9")) return false;
	}
    }
    // Check out year value.
    if ( (str.substring(0, 4) < 1)  ||  (str.substring(0, 4) > 9999)  )
		return false;

    // Check out month value.
    if ( (str.substring(5, 7) < 1)  ||  (str.substring(5, 7) > 12)  )
		return false;

    // Check out day value.
    if ( (str.substring(8, 10) < 1)  ||  (str.substring(8, 10) > 31)  )
		return false;

    // Check out day value per each month value.
    // Febuary
    if ( (str.substring(5, 7) == 2 )  &&  (str.substring(8, 10) > 29)  )
		return false;

    // April
    if ( (str.substring(5, 7) == 4 )  &&  (str.substring(8, 10) > 30)  )
		return false;

    // June
    if ( (str.substring(5, 7) == 6 )  &&  (str.substring(8, 10) > 30)  )
		return false;

    // September
    if ( (str.substring(5, 7) == 9 )  &&  (str.substring(8, 10) > 30)  )
		return false;

    // November
    if ( (str.substring(5, 7) == 11 )  &&  (str.substring(8, 10) > 30)  )
		return false;

    new_str = str.substring(0, 4) + sep + str.substring(5, 7) + sep + str.substring(8, 10);

    ctl_date.value = new_str;

    return true;
}

//--------------------------------------------------------------------------------------------------
// 날자 타입의 '-' 문자를 제거하는 함수
//--------------------------------------------------------------------------------------------------
function del_minus(obj) {
	var str =  String(obj.value);

    if (str.length < 1) {
        return "";
    } else {
        var st = "";
        var sp = "-";
        for (var i = 0; i < str.length; i++) {
            if (sp.indexOf(str.substring(i, i + 1)) == -1) {
                st += str.substring(i, i + 1);
            }
        }
        return st;
    }
}

//-------------------------------------------------------------------
// 해당 년월의 마지막 날짜 구하는 함수
//-------------------------------------------------------------------
function lastday(calyear,calmonth)
{
    if (((calyear %4 == 0) && (calyear % 100 != 0))||(calyear % 400 == 0))
        dayOfMonth[1] = 29;
    else
        dayOfMonth[1] = 28;
    var nDays = dayOfMonth[calmonth-1];
    return nDays;
}

//-------------------------------------------------------------------
// 날자형식의 숫자열인지를 체크하는 함수
//-------------------------------------------------------------------
function check_date_digit(obj)
{
    var    i;
    var    str =  new String(del_minus(obj));
    for(i=0;i<str.length;i++)
        if(!is_int(str.charAt(i)))
        {
            obj.focus();
            return false;
        }
    return true;
}

/* --------------------------------------------------------------------------------------------------------
	날짜의 정확성 검사(년-월-일)
------------------------------------------------------------------------------------------------------------ */
function is_valid_date(obj){

	var t_date = new String(del_minus(obj));
    var t_year  = parseInt(t_date.substring(0,4),10);
    var t_month = parseInt(t_date.substring(4,6),10);
    var t_day   = parseInt(t_date.substring(6,8),10);

/*    if(obj.value.length == 0){
        obj.focus();
        return false;
    }*/
    if (check_date_digit(obj) == false){
        alert('날짜형식이 틀렸습니다.');
        obj.value='';
        obj.focus();
        return false;
    }
    if (t_date.length != 8 && obj.value.length != 0){
        alert('날짜의 입력이 틀렸습니다.');
        obj.focus();
        return false;
    }
    if (t_year < 1900 || t_year >2999){
        alert('날짜가 잘못 입력되었습니다. 년도는 1900년에서 2999년까지 입니다.');
        obj.focus();
        return false;
    }
    if (t_month <1 || t_month > 12){
        alert('날짜가 잘못 입력되었습니다. 달은 1월에서 12월까지 입니다.');
        obj.focus();
        return false;
    }
    if (t_day <1 || t_day > lastday(t_year, t_month)){
        alert('날짜가 잘못 입력되었습니다.'+t_month+'월에는 '+t_day+'일이 없습니다.');
        obj.focus();
        return false;
    }

	return true;
}

function is_valid_date_detail(obj, str){

	var t_date = new String(del_minus(obj));
    var t_year  = parseInt(t_date.substring(0,4),10);
    var t_month = parseInt(t_date.substring(4,6),10);
    var t_day   = parseInt(t_date.substring(6,8),10);

/*    if(obj.value.length == 0){
        obj.focus();
        return false;
    }*/
    if (check_date_digit(obj) == false){
        alert('날짜형식이 틀렸습니다.');
        obj.value='';
        obj.focus();
        return false;
    }
    if (t_date.length != 8 && obj.value.length != 0){
        alert('날짜의 입력이 틀렸습니다..\n['+str+']');
        obj.focus();
        return false;
    }
    if (t_year < 1900 || t_year >2999){
        alert('날짜가 잘못 입력되었습니다. 년도는 1900년에서 2999년까지 입니다..\n['+str+']');
        obj.focus();
        return false;
    }
    if (t_month <1 || t_month > 12){
        alert('날짜가 잘못 입력되었습니다. 달은 1월에서 12월까지 입니다..\n['+str+']');
        obj.focus();
        return false;
    }
    if (t_day <1 || t_day > lastday(t_year, t_month)){
        alert('날짜가 잘못 입력되었습니다.'+t_month+'월에는 '+t_day+'일이 없습니다..\n['+str+']');
        obj.focus();
        return false;
    }

	return true;
}

/* --------------------------------------------------------------------------------------------------------
	날짜의 정확성 검사(년, 월까지만)
------------------------------------------------------------------------------------------------------------ */
function is_valid_date2(obj){

    var t_date = new String(del_minus(obj));
    var t_year  = parseInt(t_date.substring(0,4),10);
    var t_month = parseInt(t_date.substring(4,6),10);

    if (obj.value.length == 0){
        obj.focus();
        return false;
    }
    if (check_date_digit(obj) == false){
        alert('날짜는 형식이 틀렸습니다.');
        obj.value='';
        obj.focus();
        return false;
    }
    if (t_date.length != 6){
        alert('날짜의 입력이 틀렸습니다.');
        obj.focus();
        return false;
    }
    if (t_year < 1900 || t_year >2999){
        alert('날짜가 잘못 입력되었습니다. 년도는 1900년에서 2999년까지 입니다.');
        obj.focus();
        return false;
    }
    if (t_month <1 || t_month > 12){
        alert('날짜가 잘못 입력되었습니다. 달은 1월에서 12월까지 입니다.');
        obj.focus();
        return false;
    }

    return true;
}


function getTimeStamp(obj) {
 
    var d = new Date(obj);
    var s =
 
        leadingZeros(d.getFullYear(), 4) + '-' +
 
        leadingZeros(d.getMonth() + 1, 2) + '-' +
 
        leadingZeros(d.getDate(), 2);
 
 
 
    return s;
 
}
 
 
 
function leadingZeros(n, digits) {
 
    var zero = '';
 
    n = n.toString();

    if (n.length < digits) {
 
        for (i = 0; i < digits - n.length; i++)
 
            zero += '0';
 
    }
 
    return zero + n;
 
}

/*	// 첫번째 요일 구하기
	function getFirstDay(year, month) {
		var tmpDate = new Date(); 
        tmpDate.setDate(1); 
        tmpDate.setMonth(month); 
        tmpDate.setFullYear(year); 

        return tmpDate.getDay(); 
	}

	// 마지막 요일 구하기
	function getLastDay(year, month) {
		var tmpDate = new Date(); 
        tmpDate.setDate( getDaysOfMonth(year, month) ); 
        tmpDate.setMonth(month); 
        tmpDate.setFullYear(year); 

        return tmpDate.getDay(); 
	}*/	
	
	function day2(d) {		// 2자리 숫자로 변경
		var str = new String();

		if (parseInt(d) < 10) {
			str = "0" + parseInt(d);
		} else {
			str = "" + parseInt(d);
		}
		return str;
	}
// 해당주의 시작일, 종료일구하기
function DateWeek_Start(year,mon,day,mods){
	var cur_date = new Date(year, mon-1,day);
	var cur_w = cur_date.getDay();//현재요일을구한다 0:일요일
	var sd = 0;
	var ed = 0;
	if(cur_w>0 && cur_w<7){
		sd = 1- cur_w;
		ed = 6- cur_w;
	}else if(cur_w==0){ // 현재요일이 일요일인경우
		
	}
	var ret_date;
	
	if(mods==1){// 시작일을 구하는경우
		ret_date = new Date(cur_date.getYear(),cur_date.getMonth(),cur_date.getDate()+sd);
	}else if(mods==2){//종료일을 구하는 경우
		ret_date = new Date(cur_date.getYear(),cur_date.getMonth(),cur_date.getDate()+ed);	
	}
	return 	ret_date.getYear()+"-"+(ret_date.getMonth()+1)+"-"+ret_date.getDate();
}


/* ************************************ 기타 ************************************ */

/* --------------------------------------------------------------------------------------------------------
	문자값 Trim
------------------------------------------------------------------------------------------------------------ */
function str_trim( arg_str )
{
	var rtn_str = "";
	var i=0;
	while( arg_str.charAt(i) != "" ) {
		if( arg_str.charAt(i)!=' ') {
			rtn_str += arg_str.charAt(i);
		}
		i++;
	}
	return rtn_str;
}

/* --------------------------------------------------------------------------------------------------------
	입력값에 있는 패턴값을 제거하는 함수. ('-', '/' 등) Object Type
------------------------------------------------------------------------------------------------------------ */
function remove_obj(obj,pattern)
{
	var sTmp = "";
	var sBuffer = "";
	var i = 0;

	for (i=0; i < obj.value.length; i++)
	{
		sTmp = obj.value.substring(i, i+1);
		if (sTmp != pattern)
			sBuffer += sTmp;
	}
	
	obj.value=sBuffer;
}

/* --------------------------------------------------------------------------------------------------------
	입력값에 있는 패턴값을 제거하는 함수. ('-', '/' 등) String Type
------------------------------------------------------------------------------------------------------------ */
function remove_str(obj,pattern)
{
	var sTmp = "";
	var sBuffer = "";
	var i = 0;

	for (i=0; i < obj.value.length; i++)
	{
		sTmp = obj.value.substring(i, i+1);
		if (sTmp != pattern)
			sBuffer += sTmp;
	}
	
	return sBuffer;
}

/* --------------------------------------------------------------------------------------------------------
	필드에서 포커스 이동시 날짜형식에 맞게 '-' 추가 (년-월-일 or 년-월)
------------------------------------------------------------------------------------------------------------ */

function add_dateFormat(obj){

	if(obj.value.length == 8)
		obj.value=obj.value.substring(0,4)+"-"+obj.value.substring(4,6)+"-"+obj.value.substring(6,8);

	if(obj.value.length == 6)
		obj.value=obj.value.substring(0,4)+"-"+obj.value.substring(4,6);
}

/* --------------------------------------------------------------------------------------------------------
	필드에서 포커스 이동시 날짜형식에 맞게 '-' 추가 (년월)
------------------------------------------------------------------------------------------------------------ */
function add_dateFormat2(obj){

	if(obj.value.length == 6)
		obj.value=obj.value.substring(0,4)+"-"+obj.value.substring(4,6);
}

function getDateFormat(val){

	if(val.length == 8)
		val=val.substring(0,4)+"-"+val.substring(4,6)+"-"+val.substring(6,8);

	if(val.length == 6)
		val=val.substring(0,4)+"-"+val.substring(4,6);
	
	return val;
}

/* --------------------------------------------------------------------------------------------------------
	필드에서 포커스 이동 시 '-' 제거 후 값선택
------------------------------------------------------------------------------------------------------------ */
function focusFormat(obj){
	remove_obj(obj,"-");
	obj.select();
}


/**
 * 입력값에 스페이스 이외의 의미있는 값이 있는지 체크
 * true 이면 공백이나 null이라는 의미
 */
function isEmpty(value) {
    if (value == null || value.replace(/ /gi,"") == "" || value == undefined ) {
        return true;
    }
    return false;
}

//공백체크////////////////////////////////////////////////////
function isSpace(strValue) {
  if (strValue.indexOf(" ")>=0) {
    return true;
  }else {
    return false;
  }
}

//사업자 등록번호 체크
function ischeckCompNmbr(strValue){
	var str = strValue;
 
	while (str.indexOf('-')!=-1){
		str = str.replace("-","");
	}

	if(isNaN(str)) { 
		alert("사업자 등록번호는 숫자로만 작성하셔야 합니다");
		return false;
	}

	if (str.length != 10) { 
		alert("사업자 등록번호의 자릿수가 올바르지 않습니다."); 
		return false;
	} 
         
	sumMod = 0; 
	sumMod += parseInt(str.substring(0,1)); 
	sumMod += parseInt(str.substring(1,2)) * 3 % 10; 
	sumMod += parseInt(str.substring(2,3)) * 7 % 10; 
	sumMod += parseInt(str.substring(3,4)) * 1 % 10; 
	sumMod += parseInt(str.substring(4,5)) * 3 % 10; 
	sumMod += parseInt(str.substring(5,6)) * 7 % 10; 
	sumMod += parseInt(str.substring(6,7)) * 1 % 10; 
	sumMod += parseInt(str.substring(7,8)) * 3 % 10; 
	sumMod += Math.floor(parseInt(str.substring(8,9)) * 5 / 10); 
	sumMod += parseInt(str.substring(8,9)) * 5 % 10; 
	sumMod += parseInt(str.substring(9,10)); 
 
	if (sumMod % 10 != 0) 
	{ 
		alert("사업자 등록번호가 올바르지 않습니다"); 
		

		return false; 
	}
 return true; 
}

// 스트링의 byte단위 길이를 리턴...
/*function getLength(str)
{
  return(str.length+(escape(str)+"%u").match(/%u/g).length-1);
}*/

function getLength(source_text) 
{
	var text_Length = 0;
	var tot_count = 0;
	var onechar;

	text_Length = source_text.length;			// 텍스트의 문자열 길이를 받습니다.

	for (i=0;i < text_Length;i++)				// 문자열 길이만큼 루프를 돌겠습니다.
	{
		onechar = source_text.charAt(i);		// 문자열 하나를 받습니다.

		if (escape(onechar).length > 4)			// escape 함수를 이용해 길이를 구해봅니다. (자바스크립트 함수표 참조)
		{
			tot_count += 2;						// 만약 한글이라면 2를 더하고
		}
		else if (onechar!='\r')					// 엔터가 아니라면
		{
		tot_count++;							// 1을 더한다.
		}
	}
	return tot_count;
	//alert(tot_count + " Byte 입니다.");
}


// byte 단위의 길이를 check하여 입력한 스트링의 길이가 입력가능 최대 길이보다 클 경우 띄워주는 alert 창.
// (예 : lenalert('대표자명',20) -> 		alert('\'대표자명\' 은(는) 한글 10자, 영문 20자까지 입력 가능합니다.');
function lenalert(item, len, mode)
{
	if(mode == 1){
		alert("\'" + item + "\' 은(는) 한글 " + parseInt((len/2)+"",10) + "자, 영문 " + len + "자까지 입력 가능합니다.");
	}else if(mode == 2){
		alert("\'" + item + "\' 은(는) " + len + "자까지 입력 가능합니다.");
	}else if(mode == 3){
		alert("\'" + item + "\' 은(는) " + len + "자만 입력 가능합니다.");
	}else if(mode == 4){
		alert("\'" + item + "\' 은(는) 한글 " + parseInt((len/2)+"",10) + "자까지 입력 가능합니다.");
	}
}

// 달력입력항목에 들어갈수있는값체크(숫자키와 화살표키 탭키만허용)
function chk_dateformat()
{
	//alert(event.keyCode);
	// insert(33~40),back space(8),delete,tab(9),오른쪽 숫자입력부분(96~105) 허용
    if(event.keyCode<48 || event.keyCode>57  ){
		if(event.keyCode==8 || event.keyCode==45 || event.keyCode==46 || (event.keyCode>=33 && event.keyCode<=40) || 
			event.keyCode==9 || (event.keyCode>=96 && event.keyCode<=105) ){
		  //alert("1");
          event.returnValue=true;
		}else{
		  //alert("2");
          event.returnValue=false;
		  
		}
	}else{
	  //alert("3");
	  event.returnValue=true;
	}
}


//한글체크////////////////////////////////////////////////////
function isHan(strValue) {
  for(i=0;i<strValue.length;i++) {
  var a=strValue.charCodeAt(i);
    if (a > 128) {
      
    }else{
      return true;
    }
  }
  return false;
}

function isNotHan(strValue) {
  for(i=0;i<strValue.length;i++) {
  var a=strValue.charCodeAt(i);
    if (a > 128) {
      return true;
    }else{
      
    }
  }
  return false;
}

// 숫자, 알파벳, 공백허용
function isAlNum(strValue) {
  for(var i=0; i<strValue.length;i ++) {
    var strCh = strValue.charAt(i).toUpperCase();
    if(strCh >="A" && strCh <="Z") continue;
    if(strCh >="0" && strCh <="9") continue;
    if(strCh  =" ") continue;
    return false;
  }
}

// 공백체크
function ChkSpace(strValue) {
    for (var i=0; i<strValue.length;i ++) {
        var strCh = strValue.charAt(i).toUpperCase();
        if (strCh  =" ") {
		    return true;
	    }
    }
    return false;
}

//URL체크
function isUrl(strValue) {
	/** 체크사항
    - .이 붙어서 나오는 경우
    - .이 맨처음에 나오는 경우
    - .이 맨마지막에 나오는 경우
    - https://www.naver.com
    - http://www.naver.com
    - https://www.naver.com/
    - http://www.naver.com/
    - www.naver.com
    - naver.com
    **/
	var check1 = /(\.\.)|(^\.)|(\.$)/; 
//	var check2 = /^(https?:\/\/)?((\w+)[.])+(asia|biz|cc|cn|com|de|eu|in|info|jobs|jp|kr|mobi|mx|name|net|nz|org|travel|tv|tw|uk|us)(\/(\w*))*$/i;
	var check2 = /^(https?:\/\/)?((\w+)[.])+(asia|biz|cc|cn|com|de|eu|in|info|jobs|jp|kr|mobi|mx|name|net|nz|org|travel|tv|tw|uk|us)(\/(\w*[.]\w*)?)*$/i
	if (strValue.length !="") { 
		if (check1.test(strValue)) {  //.벨리데이션 불일치
			return false;
		} else if (!check2.test(strValue)) {  //URL벨리데이션 불일치
			return false;
		} else {
			return true;
		}
	}else{
		return true;
	}
}

//이메일체크/////////////////////////////////////////
function isMail(strValue)
{
/** 체크사항 
    - @가 2개이상일 경우 
    - .이 붙어서 나오는 경우 
    -  @.나  .@이 존재하는 경우 
    - 맨처음이.인 경우 
    - @이전에 하나이상의 문자가 있어야 함 
    - @가 하나있어야 함 
    - Domain명에 .이 하나 이상 있어야 함 
    - Domain명의 마지막 문자는 영문자 2~4개이어야 함 **/ 
     
    var check1 = /(@.*@)|(\.\.)|(@\.)|(\.@)|(^\.)/; 

    var check2 = /^[a-zA-Z0-9\-\.\_]+\@[a-zA-Z0-9\-\.]+\.([a-zA-Z]{2,4})$/; 
    if( strValue.length !="") 
    { 
        if ( !check1.test(strValue) && check2.test(strValue) ) 
        { 
            return false; 
        } 
        else 
        { 

            return true; 
         } 
    }else{
		return true;
	}

}



/**
 * 유효한(존재하는) 월(月)인지 체크
 */
function isValidMonth(mm) {
    var m = parseInt(mm,10);
    return (m >= 1 && m <= 12);
}

/**
 * 유효한(존재하는) 일(日)인지 체크
 */
function isValidDay(yyyy, mm, dd) {
    var m = parseInt(mm,10) - 1;
    var d = parseInt(dd,10);

    var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
    if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
        end[1] = 29;
    }

    return (d >= 1 && d <= end[m]);
}

/**
 * 유효하는(존재하는) Date 인지 체크
 * ex) var date = form.date.value; //'20010230'
 *     if (!isValidDate(date)) {
 *         alert("올바른 날짜가 아닙니다.");
 *     }
 */
function isValidDate(date) {
    var year  = date.substring(0,4);
    var month = date.substring(4,6);
    var day   = date.substring(6,8);

    if (parseInt(year,10) >= 1900  && isValidMonth(month) &&
        isValidDay(year,month,day)) {
        return true;
    }
    return false;
}

/**
* Time 스트링을 자바스크립트 Date 객체로 변환
* parameter time: Time 형식의 String
*/
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1월=0,12월=11
    var day   = time.substr(6,2);
    var hour  = time.substr(8,2);
    var min   = time.substr(10,2);

    return new Date(year,month,day,hour,min);
}

/**
* 두 Time이 며칠 차이나는지 구함
* time1이 time2보다 크면(미래면) minus(-)
*/
function getDayInterval(time1,time2) {
    var date1 = toTimeObject(time1);
    var date2 = toTimeObject(time2);
    var day   = 1000 * 3600 * 24; //24시간

    return parseInt((date2 - date1) / day, 10);
}

/**
* 두 Time이 몇 시간 차이나는지 구함

* time1이 time2보다 크면(미래면) minus(-)
*/
function getHourInterval(time1,time2) {
    var date1 = toTimeObject(time1);
    var date2 = toTimeObject(time2);
    var hour  = 1000 * 3600; //1시간

    return parseInt((date2 - date1) / hour, 10);
}

//실제로 날수의 차이를 구하는 함수
function dayDiff(d1,d2){ 
    var year  = d1.substring(0,4);
    var month = d1.substring(4,6);
    var day   = d1.substring(6,8);
	    var date1 = new Date(year,month,day);
    year  = d2.substring(0,4);
    month = d2.substring(4,6);
    day   = d2.substring(6,8);
	    var date2 = new Date(year,month,day);
		return Math.ceil((date2 - date1) / 1000 / 24 / 60 / 60); 
}


// 허용하는 문자가 아니면 true
function containsCharsOnly(value,chars) {
    for (var inx = 0; inx < value.length; inx++) {
       if (chars.indexOf(value.charAt(inx)) == -1)
           return true;
    }
    return false;
}

// 해당하는 문자가 있으면 true
function isNotAllowStr(value, str){
    for (var inx = 0; inx < value.length; inx++) {
       if (value.charAt(inx)  == str)
           return true;
    }
    return false;

}

// 입력값이 알파벳,숫자,공백허용인지체크
function isAlphaNumspace(value) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ";
    return containsCharsOnly(value,chars);
}

// 입력값이 알파벳,숫자,공백불가인지체크
function isAlphaNum(value) {
    var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    return containsCharsOnly(value,chars);
}

// 입력값이 숫자인지체크
function isNum(value) {
    var chars = "0123456789";
    return containsCharsOnly(value,chars);
}

// 입력값이 숫자,하이픈인지체크
function isNumhip(value) {
    var chars = "-0123456789";
    return containsCharsOnly(value,chars);
}

// 해당하는 데이터를 전부 readonly로 변경및 해제
function all_Readonly(arr_objstr,mode){
	// readonly로
	if(mode == 1){
		for(r=0;r<arr_objstr.length;r++){
			if(document.getElementsByName(arr_objstr[r]).length > 1){
				for(p=0;p<document.getElementsByName(arr_objstr[r]).length;p++){
					document.getElementsByName(arr_objstr[r])[p].className		= "input_05";
					document.getElementsByName(arr_objstr[r])[p].readOnly		= true;
				}
			}else{
				document.getElementsByName(arr_objstr[r])[0].className		= "input_05";
				document.getElementsByName(arr_objstr[r])[0].readOnly		= true;
			}
		}
	// 해제
	}else if(mode==2){
		for(r=0;r<arr_objstr.length;r++){
			if(document.getElementsByName(arr_objstr[r]).length > 1){
				for(p=0;p<document.getElementsByName(arr_objstr[r]).length;p++){
					document.getElementsByName(arr_objstr[r])[p].className		= "input_01";
					document.getElementsByName(arr_objstr[r])[p].readOnly		= false;
				}
			}else{
				document.getElementsByName(arr_objstr[r])[0].className		= "input_01";
				document.getElementsByName(arr_objstr[r])[0].readOnly		= false;
			}
		}

	}
}

function remove_allstr(str,pattern)
{
	var sTmp = "";
	var sBuffer = "";
	var i = 0;

	for (i=0; i < str.length; i++)
	{
		sTmp = str.substring(i, i+1);
		if (sTmp != pattern)
			sBuffer += sTmp;
	}
	
	return sBuffer;
}


function junminlen(formobj1, formobj2){
	if(formobj1.value.length == 6){
		formobj2.focus();
	}
}

function docu_innerhtml(ele_name, str){
	document.getElementById(ele_name).innerHTML = str;

}

function WinOpen(strUrl, wsize, hsize){
	window.open(strUrl,"","width="+wsize+", height="+hsize+",top=20, left=20,resizable=yes,toolbar=yes,menubar=yes, scrollbars=yes,location=yes,status=yes");
}


/* ---------------------------------------------------------------------
	iframe의 height를 body의 내용만큼 자동으로 늘림
------------------------------------------------------------------------- */
var ifrContentsTimer;
var ifrContents;


function resizeFrame(name,uwidth,uheight){

        var oBody = document.body;
        var oFrame = document.getElementById(name);
		ifrContents = oFrame;
        var min_height = 300; //iframe의 최소높이(너무 작아지는 걸 막기위함, 픽셀단위, 편집가능)
        var min_width = 500; //iframe의 최소너비
		var i_height = oBody.scrollHeight + 10;              
        var i_width = oBody.scrollWidth + (oBody.offsetWidth-oBody.clientWidth);

        if(i_height < min_height) i_height = min_height;
        if(i_width < min_width) i_width = min_width;
        /*
        alert("i_height=" + i_height
            + "oBody.offsetHeight=" + oBody.offsetHeight
            + "oBody.clientHeight=" + oBody.clientHeight);
        */ 
        
		if(uwidth != 0){
			oFrame.style.width = uwidth+ 'px';
		}

		if(uheight != 0){
			oFrame.style.height = uheight+ 'px';
		}else{
			oFrame.style.height = i_height+ 'px';
		}
        //oFrame.style.width = i_width;

        //parent.scrollTo(1,1); //부모문서의 스크롤 위치를 1, 1로 옮긴다.(오감도님이 지적해주셨어요~^^)

		ifrContentsTimer = setInterval("resizeFrame('"+name+"',"+uwidth+","+uheight+")",100);
}


function resizeIF(Id)
{
        var obj = document.getElementById(Id);
        var Body;
        var H, Min;

        // 최소 높이 설정 (너무 작아지는 것을 방지)
        Min = 100;

        // DOM 객체 할당
        try
        {
				//alert("1");
                if (!document.all && obj.contentWindow.document.location.href == 'about:blank') {
                        setTimeout("resizeIF('"+Id+"')", 10);
                        return;
                }

                Body = obj.contentWindow.document.getElementsByTagName('BODY');
                Body = Body[0];

                //if (this.Location != obj.contentWindow.document.location.href) {
                        H = Body.scrollHeight + 30;
						//alert(H);
                        obj.style.height =  (H<Min?Min:H) + 'px';

                        this.Location = obj.contentWindow.document.location.href;
                //}
        }
        catch(e)
        {
				//alert("2");
                setTimeout("resizeIF('"+Id+"')", 10);
                return;
        }

        setTimeout("resizeIF('"+Id+"')", 100);
}



// 셀렉트박스를 readonly효과를 발생한다
/*	사용예
	<select name="link_target" onfocus="readOnly_SelectBox()" onDblClick="javascript:readOnly_SelectBox()" >
		  <option value="RND_IMAIN">RND_IMAIN</option>
		  <option value="RND_MAIN">RND_MAIN</option>
	</select>
	<script>
			document.getElementsByName("link_target")[0].readOnly = true;
		    document.getElementsByName("link_target")[0].className = "input_05";
 	</script>
*/
function readOnly_SelectBox(){
			
	self.window.focus();

	//alert("11");

}

// 사업자 등록번호 체크
function checkCompNmbr(formobj, label){
	var str = formobj.value;
 
	while (str.indexOf('-')!=-1){
		str = str.replace("-","");
	}

	if(isNaN(str)) { 
		alert(label+"은(는) 숫자로만 작성하셔야 합니다");
		formobj.value="";
		formobj.focus();
		return true;
	}

	if (str.length != 10) { 
		alert(label + "의 자릿수가 올바르지 않습니다."); 
		formobj.focus();
		return true; 
	} 
         
	sumMod = 0; 
	sumMod += parseInt(str.substring(0,1)); 
	sumMod += parseInt(str.substring(1,2)) * 3 % 10; 
	sumMod += parseInt(str.substring(2,3)) * 7 % 10; 
	sumMod += parseInt(str.substring(3,4)) * 1 % 10; 
	sumMod += parseInt(str.substring(4,5)) * 3 % 10; 
	sumMod += parseInt(str.substring(5,6)) * 7 % 10; 
	sumMod += parseInt(str.substring(6,7)) * 1 % 10; 
	sumMod += parseInt(str.substring(7,8)) * 3 % 10; 
	sumMod += Math.floor(parseInt(str.substring(8,9)) * 5 / 10); 
	sumMod += parseInt(str.substring(8,9)) * 5 % 10; 
	sumMod += parseInt(str.substring(9,10)); 
 
	if (sumMod % 10 != 0) 
	{ 
		alert(str + "은(는) 올바른 " + label + "가 아닙니다"); 
		formobj.focus();

		return true; 
	}
 return false; 
}

// 카렌다를 보여주는 메소드
function calendar_disp(obj,divname,framename){
	//otargetobj = eval(obj);
	var evt = event.srcElement ? event.srcElement : event.target;
	//alert(obj.name);
	//otargetobj = (obj!=null && obj!=undefined) ? obj : evt;
	otargetobj = (evt!=null && evt!=undefined) ? evt : obj;
	//alert(otargetobj);
	//if(otargetobj.readOnly == false){
		docuobj = getHtmlInfo();
		otargetdiv = document.getElementById(divname);
		otarfrname = document.getElementById(framename);
		//alert(otarfrname.name);
		
		//alert(getRealOffsetLeft(evt)+"::"+(docuobj.scrollWidth-205));
		if(getRealOffsetLeft(otargetobj) >= docuobj.scrollWidth-205){
			otargetdiv.style.left = docuobj.scrollWidth-205+"px";
			//alert('1');
		}else{
			//alert('11:'+getRealOffsetLeft(otargetobj)+"::"+otargetobj.offsetWidth);
			otargetdiv.style.left = (getRealOffsetLeft(otargetobj)+otargetobj.offsetWidth)+"px";
		}

		if(getRealOffsetTop(otargetobj) >= docuobj.scrollHeight-170){
			//alert('2');
			otargetdiv.style.top = docuobj.scrollHeight-170+"px";
		}else{
			//alert('22:'+getRealOffsetTop(evt)+"::");
			otargetdiv.style.top = getRealOffsetTop(otargetobj)+"px";
		}
		//alert(otargetdiv.style.top+":"+otargetdiv.style.left);

		otargetdiv.style.display= 'inline';
		if(otarfrname.contentWindow != null && otarfrname.contentWindow != undefined){
			otarfrname.contentWindow.tarobj = otargetobj;
			otarfrname.contentWindow.divname = divname;
			//alert('21wsfsdda');
			otarfrname.contentWindow.MiniCal(otarfrname.contentWindow.document.getElementById('calval'));
			//otarfrname.MiniCal(otarfrname.getElementById('calval'));
		}else{
			otarfrname.tarobj = otargetobj;
			otarfrname.divname = divname;			
			otarfrname.MiniCal(otarfrname.getElementById('calval'));
		}

	//}

}


x_pos=0;
y_pos=0;
function getX(obj){ 
	if(obj.offsetParent.tagName != 'BODY'){
	x_pos += obj.offsetParent.offsetLeft;
	getX(obj.offsetParent); // BODY 객체에 이르기까지 재귀호출하여 offsetLeft값을 누적
	}
	return x_pos;
}

function getY(obj){ 
	if(obj.offsetParent.tagName != 'BODY'){
	y_pos += obj.offsetParent.offsetTop;
	getY(obj.offsetParent); // BODY 객체에 이르기까지 재귀호출하여 offsetTop값을 누적
	}
	return y_pos;
}

function get_x(obj){
	result=getX(obj)+obj.offsetLeft; // 상위객체의 offsetLeft의 총합 + 자신의 offsetLeft
	x_pos=0; // 초기화
	return result;
}

function get_y(obj){
	result=getY(obj)+obj.offsetTop; // 상위객체의 offsetTop의 총합 + 자신의 offsetTop
	y_pos=0; // 초기화
	return result;
}

// 해당객체의 top위치를 찾는다
function getRealOffsetTop(o)
{
	return o ? o.offsetTop + getRealOffsetTop(o.offsetParent) : 0;
}

// 해당객체의 left위치를 찾는다
function getRealOffsetLeft(o)
{
	return o ? o.offsetLeft + getRealOffsetLeft(o.offsetParent) : 0;
}

function flash_object_innerHTML(objname ,path, width, height){
  flash_string = "<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,29,0' width='"+width+"' height='"+height+"'><param name='movie' value='"+path+"'><param name='quality' value='high'><param name='wmode' value='transparent'><embed src='"+path+"' quality='high' pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' width='"+width+"' height='"+height+"'></embed></object>";
  document.getElementById(objname).innerHTML = flash_string;
}

// path에 바로 변수 넘길경우 약 2000byte밖에 안넘어간다
function flashWrite(objname, path,w,h,id,bg,win)
{
	// 플래시 코드 출력
	var flashStr=
	"<div id='__"+id+"__' style='background-color:"+bg+";width:"+w+"px;'>"+
	"<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+
	"<param name='allowScriptAccess' value='sameDomain' />"+
	"<param name='movie' value='"+path+"' />"+
	"<param name='wmode' value='"+win+"' />"+
	"<param name='menu' value='false' />"+
	"<param name='quality' value='high' />"+
	"<param name='bgcolor' value='"+bg+"' />"+
	"<embed src='"+path+"' wmode='"+win+"' menu='false' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object></div>";
	document.getElementById(objname).innerHTML = flashStr;
}

// path에 변수로 하지 않고 FlashVars param으로 넘길경우 약 64k의 데이터를 넘길수 있다
function flashWrite2(objname, path, flashvar ,w,h,id,bg,win)
{
	// 플래시 코드 출력
	var flashStr=
	"<div id='__"+id+"__' style='background-color:"+bg+";width:"+w+"px;'>"+
	"<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+w+"' height='"+h+"' id='"+id+"' align='middle'>"+
	"<param name='allowScriptAccess' value='sameDomain' />"+
	"<param name='movie' value='"+path+"' />"+
	"<param name='FlashVars' value='"+flashvar+"' />"+
	"<param name='wmode' value='"+win+"' />"+
	"<param name='menu' value='false' />"+
	"<param name='quality' value='high' />"+
	"<param name='bgcolor' value='"+bg+"' />"+
	"<embed src='"+path+"' wmode='"+win+"' menu='false' quality='high' bgcolor='"+bg+"' width='"+w+"' height='"+h+"' name='"+id+"' align='middle' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />"+
	"</object></div>";
	document.getElementById(objname).innerHTML = flashStr;
}

function Go_print(){
	window.print();
}

function Rolov_bg(obj,overbg,outbg){
	if(overbg == ""){
		obj.style.backgroundColor=outbg;
	}else if(outbg == ""){
		obj.style.backgroundColor=overbg;
	}

}

function Rolov_class(obj,overclass,outclass){
	//alert(obj+":"+overclass+":"+outclass);
	if(overclass == ""){
		obj.className=outclass;
	}else if(outclass == ""){
		obj.className=overclass;
	}

}

/* ----------------------------------------------------
	문자열 전체 바꾸기 예) replaceAll("", "");
------------------------------------------------------ */
function StrreplaceAll (orgstr, str1, str2){
	temp_str = "";

	if (orgstr != "" && str1 != str2) {
		temp_str = orgstr;

		while (temp_str.indexOf(str1) > -1){
			temp_str = temp_str.replace(str1, str2);
		}
	}

	return temp_str;
}

function popupwintype(check, page, name, w, h, scroll) {
	var win= null;
	var winl = (screen.width-w)/2; 
	var wint = (screen.height-h)/3;
	var settings = '';
	if ( check == 'modal') {
		settings ='dialogHeight: '+h+'px;'; 
		settings +='dialogWidth: '+w+'px;'; 
		settings +='dialogTop: '+wint+'px;'; 
		settings +='dialogLeft: '+winl+'px;'; 
		settings +='scroll: '+scroll+';'; 
		settings +='resizable: no;'; 
		settings +='status: no; help: no'; 
		showModalDialog(page,name,settings);
	} else {
		settings ='height='+h+','; 
		settings +='width='+w+','; 
		settings +='top='+wint+','; 
		settings +='left='+winl+','; 
		settings +='scrollbars='+scroll+','; 
		settings +='resizable=no,'; 
		settings +='status=no'; 
		win=window.open(page,name,settings); 
		if(parseInt(navigator.appVersion) >= 4) win.window.focus();
		}
}

// 업로드 파일 확장자 체크
function extLimitAttach(fileval) {
	extArray = new Array(".gif", ".jpg", ".bmp");

		while (fileval.indexOf("\\") != -1){
			fileval = fileval.slice(fileval.indexOf("\\") + 1);
		}
		
		ext = fileval.slice(fileval.indexOf(".")).toLowerCase();
		
		for (var i = 0; i < extArray.length; i++) {
			if (extArray[i] == ext) { return false; }
		}
		return true;

}

// 업로드 파일 확장자 체크
function extLimitAttachonly(fileval, extchk) {

		while (fileval.indexOf("\\") != -1){
			fileval = fileval.slice(fileval.indexOf("\\") + 1);
		}
		
		ext = fileval.slice(fileval.indexOf(".")).toLowerCase();

		if ("."+extchk == ext) { return false; }

		return true;

}

//**************************************
// 드림위버에서 제공하는 함수라이브러리
//**************************************

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i>a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i>d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}

function MM_showHideLayers() { //v3.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v='hide')?'hidden':v; }
    obj.visibility=v; }
}

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

MM_reloadPage(true);

//**************************************
// 드림위버에서 제공하는 함수라이브러리
//**************************************


/* ----------------------------------------------------
	문자가 2바이트문자인지를 리턴하는함수
-------------------------------------------------------- */
function chr_byte(chr){
	if(escape(chr).length > 4){
		return 2;
	}else{
		return 1;
	}
}

/* ----------------------------------------------------
	길이(byte)에 따라 문자열 자르기
-------------------------------------------------------- */
function cutStr(str,limit){
	var tmpStr = str;
	var byte_count = 0;
	var len = str.length;
	var dot = "";

	for(i=0; i<len; i++){
		byte_count += chr_byte(str.charAt(i)); 
		if(byte_count == limit-1){
			if(chr_byte(str.charAt(i+1)) == 2){
				tmpStr = str.substring(0,i+1);
				dot = "...";
			}else {
				if(i+2 != len) dot = "...";
				tmpStr = str.substring(0,i+2);
			}
			break;
		}else if(byte_count == limit){
			if(i+1 != len) dot = "...";
			tmpStr = str.substring(0,i+1);
			break;
		}
	}

return tmpStr+dot;
}

// 입력된 숫자를 가지고 kb또는 Mb로표현
function file_sizestr(size){
    var sizeStr = "";    
    if( size < 1024 ) sizeStr = size + "b";
    else if( size < 1024*1024 ) sizeStr = Math.ceil( size/1024 ) + "KB";
    else sizeStr = Math.ceil( size/(1024*1024) ) + "MB";
	return sizeStr;
}

/**
 * 한글 한글자를 2byte로 인식하여, IE든 Netscape든
 * 제대로 byte길이를 구해 줍니다.
 */
function getByteLength(s){
   var len = 0;
   if ( s == null ) return 0;
   for(var i=0;i<s.length;i++){
      var c = escape(s.charAt(i));
      if ( c.length == 1 ) len ++;
      else if ( c.indexOf("%u") != -1 ) len += 2;
      else if ( c.indexOf("%") != -1 ) len += c.length/3;
   }
   return len;
}

function getHtmlInfo()
 
{
 
	var obj = {
 
		clientHeight : 0, 
 
		clientWidth : 0,  
 
		scrollHeight : 0, 
 
		scrollWidth : 0,  
 
		scrollLeft : 0,   
 
		scrollTop : 0,    
 
		offsetHeight : 0, 
 
		offsetWidth : 0 ,
 
		screenX:0,
 
		screenY:0
 
	};
 



	if (document.documentElement){
 
		obj.clientHeight	 = parseInt(document.documentElement.clientHeight);
 
		obj.clientWidth		 = parseInt(document.documentElement.clientWidth);
 
		obj.scrollHeight	 = parseInt(document.documentElement.scrollHeight);
 
		obj.scrollWidth		 = parseInt(document.documentElement.scrollWidth);
 



		if(navigator.userAgent.indexOf("Chrome")  != -1) {
 
			obj.scrollLeft		 = parseInt(document.body.scrollLeft);	
 
			obj.scrollTop		 = parseInt(document.body.scrollTop);		
 
		} else {
 
			obj.scrollLeft		 = parseInt(document.documentElement.scrollLeft);	
 
			obj.scrollTop		 = parseInt(document.documentElement.scrollTop);		
 
		}
 
		

		if(navigator.appName=="Netscape"){ 		

			if(navigator.userAgent.indexOf("Chrome")  != -1) {
 
				obj.offsetHeight	 = parseInt(document.body.scrollTop);
 
				obj.offsetWidth	 = parseInt(document.body.scrollLeft);
 
			} else {
 
				obj.offsetHeight	 = parseInt(document.documentElement.clientHeight);
 
				obj.offsetWidth	 = parseInt(document.documentElement.clientWidth);
 
			}
 
		} 
 
		if(navigator.appName.indexOf("Microsoft") != -1) {
 
			obj.offsetHeight	 = parseInt(document.documentElement.offsetHeight);
 
			obj.offsetWidth	 = parseInt(document.documentElement.offsetWidth);
 
		}	
 
		//if(document.body.offsetHeight) obj.offsetHeight	 = parseInt(document.documentElement.offsetHeight);
 
		//else obj.offsetHeight	 = parseInt(document.documentElement.clientHeight);
 
		

		//if(document.body.offsetWidth) obj.offsetWidth	 = parseInt(document.documentElement.offsetWidth);
 
		//else obj.offsetWidth	 = parseInt(document.documentElement.clientWidth);
 



		obj.screenX			 = parseInt(screen.width);
 
		//alert(screen.height);
 
		obj.screenY			 = parseInt(screen.height);
 
		//alert("HEIGHT : " + document.documentElement.clientHeight);
 
	} else if (document.body){	
 
		obj.clientHeight	 = parseInt(document.body.clientHeight);
 
		obj.clientWidth		 = parseInt(document.body.clientWidth);
 
		obj.scrollHeight	 = parseInt(document.body.scrollHeight);
 
		obj.scrollWidth		 = parseInt(document.body.scrollWidth);
 
		obj.scrollLeft		 = parseInt(document.body.scrollLeft);	
 
		obj.scrollTop		 = parseInt(document.body.scrollTop);
 



		obj.offsetHeight	 = parseInt(document.body.offsetHeight);
 
		obj.offsetWidth		 = parseInt(document.body.offsetWidth);		
 
		obj.screenX			 = parseInt(screen.width);
 
		obj.screenY			 = parseInt(screen.height);
 



	}else{
 
		//[Netscape stuff]
 
	}
 



	return obj;
 
}

function maskHp(obj) { 
    var str = obj.value; 
    if ( str ) { 
        //var pattern = /[^(ㄱ-?)]|[-/\s]/g; 
        var RegNotNum  = /[\D]/g; 
        var pattern = ""; 
        var format  = ""; 

        // delete not number ㅋ 
        str = str.replace(RegNotNum,''); 

        //if( str.length < 4 ) return str; 
        if( str.length < 4 ) { 
            if( str.length == 3 ) { 
                format = "$1"; 
                pattern = /(^01[\d]{0,1})/; 
            } else { 
                format = "$1"; 
                pattern = /(^0[1]?[\d]{0,1})/; 
            } 
        } else if( str.length > 3 && str.length < 7 ) { 
            format = "$1-$2"; 
            pattern = /(^01[\d]{1})([\d]+)/; 
        } else if(str.length == 7 ) { 
            format = "$1-$2"; 
            pattern = /(^01[\d]{1})([\d]{4})/; 
        } else { 
            format = "$1-$2-$3"; 
            pattern = /(^01[\d]{1})([\d]{4})([\d]+)/; 
        } 

        //while( pattern.test(str) ) { 
        if ( pattern.test(str) ) { 
            obj.value = str.replace(pattern, format); 
        } else { 
            obj.value = ""; 
        } 
    } 
} 


function maskHp(obj) { 
    var str = obj.value; 
    if ( str ) { 
        //var pattern = /[^(ㄱ-힣)]|[-/\s]/g; 
        var RegNotNum  = /[\D]/g; 
        var pattern = ""; 
        var format  = ""; 

        // delete not number ㅋ 
        str = str.replace(RegNotNum,''); 

        //if( str.length < 4 ) return str; 
        if( str.length < 4 ) { 
            if( str.length == 3 ) { 
                format = "$1"; 
                pattern = /(^01[\d]{0,1})/; 
            } else { 
                format = "$1"; 
                pattern = /(^0[1]?[\d]{0,1})/; 
            } 
        } else if( str.length > 3 && str.length < 7 ) { 
            format = "$1-$2"; 
            pattern = /(^01[\d]{1})([\d]+)/; 
        } else if(str.length == 7 ) { 
            format = "$1-$2"; 
            pattern = /(^01[\d]{1})([\d]{4})/; 
        } else { 
            format = "$1-$2-$3"; 
            pattern = /(^01[\d]{1})([\d]{4})([\d]+)/; 
        } 

        //while( pattern.test(str) ) { 
        if ( pattern.test(str) ) { 
            obj.value = str.replace(pattern, format); 
        } else { 
            obj.value = ""; 
        } 
    } 
} 


function maskTel(obj) { 
	var str = obj.value;
	
	if ( str ) { 
		//var pattern = /[^(ㄱ-?)]|[-/\s]/g; 
		var RegNotNum  = /[\D]/g; 
		var pattern = ""; 
		var format  = ""; 

		// delete not number ㅋ 
		str = str.replace(RegNotNum,''); 

		//if( str.length < 4 ) return str; 
		if( str.length < 4 ) { 
			if( str.length == 3 ) { 
				format = "$1"; 
				pattern = /(^0[\d]{0,1})/; 
			} else { 
				format = "$1"; 
				pattern = /(^0[1]?[\d]{0,1})/; 
			} 
		} else if( str.length > 3 && str.length < 7 ) {
			format = "$1-$2"; 
			if (str.substring(0,2) == '02') {
				pattern = /(^[\d]{1})([\d]+)/;
			} else {
				pattern = /(^[\d]{3})([\d]+)/;
			}
		} else if(str.length == 7 ) {
			format = "$1-$2";
			if (str.substring(0,2) == '02') {
				pattern = /(^[\d]{2})([\d]{4})/;
			} else {
				pattern = /(^[\d]{3})([\d]{4})/;
			}
		} else { 
			format = "$1-$2-$3";
			if (str.substring(0,2) == '02') {
				pattern = /(^[\d]{2})([\d]{4})([\d]+)/;
			} else {
				pattern = /(^[\d]{3})([\d]{4})([\d]+)/;
			}
		} 

		//while( pattern.test(str) ) { 
		if ( pattern.test(str) ) { 
			obj.value = str.replace(pattern, format); 
		} else { 
			obj.value = ""; 
		} 
	} 
} 

function isHpFormat(objval) {
  var str = objval;
  //alert ( str );
        var pattern = "";
        str = str.replace(/[\D]/g,'');
        if( str.length < 4 ) {
            if( str.length == 3 ) pattern = /(^01[\d]{1})/;
            else                  pattern = /(^0[1]?[\d]{0,1})/;
        } else if( str.length > 3 && str.length < 7 ) {
            pattern = /(^01[\d]{1})([\d]+)$/;
        } else if(str.length == 7 ) {
            pattern = /(^01[\d]{1})([\d]{4})/;
        } else {
            pattern = /(^01[\d]{1})([\d]{4})([\d]+)/;
        }
        if ( pattern.test(str) ) {
            return true;
        } else {
            return false;
        }

}

function isHpFormat2(objval){
	var rgEx = /[01](0|1|6|7|8|9)[-](\d{4}|\d{3})[-]\d{4}$/g;
	var OK = rgEx.exec(objval);
	return OK;
}

// 날짜(년월) FORMAT 처리
function maskCalYm(evt) {
	var keyCode = evt.which?evt.which:event.keyCode;
	// 특정키 이벤트 발생시 무시
   	if ((keyCode == 8 ||							//BackSpace
   		 keyCode == 46 ||							//Delete
   		 keyCode == 9 ||							//Tab
   		 keyCode == 13 ||							//Enter
   		 (keyCode >= 37 && keyCode <= 40)	//Direction Key
   		)) {
		return false;
	}
	obj = event.srcElement ? event.srcElement : event.target;
	var str = removeChar(obj.value,'-');

	// 숫자만 허용
	/*if(is_int(str)) {
		obj.value	= obj.value.substring(0, obj.value.length - 1);
		//alert(str);
		return false;
	}*/
	//alert('1');
	if (str.length == 4) {
			obj.value = str + "-";
	}
	else if (str.length == 6) {
		obj.value = str.substring(0, 4) + "-" + str.substring(4,6);
	}	
	else if (str.length >= 6) {
		obj.value = str.substring(0, 4) + "-" + str.substring(4,6);
	}

}

    // 날짜(년월일) FORMAT 처리
    function maskCal(evt) {
    	
    	var keyCode;
    	if(window.event!=null && window.event!=undefined ){
    		keyCode = window.event.keyCode;
    		//alert('aa');
    	}else{
    		keyCode = evt.which;
    		//alert('bb');
    	}
    	
    	// 특정키 이벤트 발생시 무시
       	if ((keyCode == 8 ||							//BackSpace
       		 keyCode == 46 ||							//Delete
       		 keyCode == 9 ||							//Tab
       		 keyCode == 13 ||							//Enter
       		 (keyCode >= 37 && keyCode <= 40)	//Direction Key
       		)) {
			return false;
		}
		obj = event.srcElement ? event.srcElement : event.target;
    	var str = removeChar(obj.value,'-');

		// 숫자만 허용
		/*if(is_int(str)) {
			obj.value	= obj.value.substring(0, obj.value.length - 1);
			//alert(str);
			return false;
		}*/
		//alert('1');
		if (str.length == 4) {
				obj.value = str + "-";
		}
		else if (str.length == 6) {
			obj.value = str.substring(0, 4) + "-" + str.substring(4,6) + "-";
		}
		else if (str.length >= 8) {
			obj.value = str.substring(0, 4) + "-" + str.substring(4,6) + "-" + str.substring(6, 8);
		}
    }
	
    // 특정문자를 삭제한 값을 리턴
    function removeChar(srcString, strchar) {
    	var convString ='';
    	for (z=0;z<srcString.length;z++) {
    		if (srcString.charAt(z) != strchar)
    			convString = convString + srcString.charAt(z);
    	}
    	return convString;
    }
	
	// input 항목에 커서가 위치한 위치를 표시한다
	// 한글지원안됨
	function doGetCaretPosition (ctrl) {
	
		var CaretPos = 0;
		// IE Support
		if (document.selection) {
	
			ctrl.focus ();
			var Sel = document.selection.createRange ();
	
			Sel.moveStart ('character', -ctrl.value.length);
	
			CaretPos = Sel.text.length;
		}
		// Firefox support
		else if (ctrl.selectionStart || ctrl.selectionStart == '0')
			CaretPos = ctrl.selectionStart;
	
		return (CaretPos);
	
	}	
		
	// 파이어 이벤트를 적용되게
	function fireEvent(element,event){
	    if (document.createEventObject){
	        // dispatch for IE
	        var evt = document.createEventObject();
	        return element.fireEvent('on'+event,evt)
	    }
	    else{
	        // dispatch for firefox + others
	        var evt = document.createEvent("HTMLEvents");
	        evt.initEvent(event, true, true ); // event type,bubbling,cancelable
	        return !element.dispatchEvent(evt);
	    }
	}
		
	//기술교육자료 플레이
	function selectShowMovie( title, url, idx ) {
	
		//alert(document.getElementById('MediaPlayer1'));
		document.getElementById('MediaPlayer1').stop();
		document.getElementById('mdTitleObj').innerHTML = title;
		document.getElementById('mdSubTitleObj').innerHTML = title;
		document.getElementById('mdSubDetailText').innerHTML = document.getElementById('mdSubDetailText'+idx).innerHTML;
		document.getElementById('mdSubDetailText').scrollTop = 0;
		document.getElementById('MediaPlayer1').FileName = url;
	}


	//이미지 사이즈 맞게 팝업 띄우기
	function preview_Image(imageURL,alt) 
		{ 
		  imageHandle=open("","popupForImage","toolbar=no,location=no,status=no,manubar=no,scrollbars=yes,resizable=no,width=100,height=100,top=100,left=50"); 
		  imageHandle.document.write("<title>통합관리시스템<\/title>\n"); 
		  imageHandle.document.write("<style rel='stylesheet' type='text\/css'>\n"); 
		  imageHandle.document.write("*{margin:0;padding:0;border:0;}\n"); 
		  imageHandle.document.write("<\/style>\n"); 
 
			  imageHandle.document.write("<body >\n"); 
		  imageHandle.document.write("<img id=\"prev_img_id\" src=\""+imageURL+"\" alt=\""+alt+"\" onclick=\"self.close();\" style=\"cursor:hand;\" title=\"클릭하면 닫힙니다.\" \/>\n");
		  imageHandle.document.write("<script type='text\/javascript'>\n"); 
		  imageHandle.document.write(" \/\/<![CDATA[ \n"); 
		  imageHandle.document.write(" function onloadimg(){  \n");
		  //imageHandle.document.write(" alert(document.getElementById(\"prev_img_id\").width);\n");
		  imageHandle.document.write(" window.resizeTo(document.getElementById(\"prev_img_id\").width+40,document.getElementById(\"prev_img_id\").height+70);\n ");
		  imageHandle.document.write(" } \n");
		  
		  imageHandle.document.write(" setTimeout('onloadimg()',500*1);  \n");			  
		  imageHandle.document.write(" \/\/]]> \n"); 
		  imageHandle.document.write("<\/script>\n");			  
		  imageHandle.document.write("<\/body>\n");
		}	

		function char_chk(oFrm){
		
			   var m_Sp = /[$\\\#%\&\*\[\]\+\_\{\}\`\~\=\|\<\>]/;
			   var m_val = oFrm.value;
			   var strLen = m_val.length;
			   var m_char = m_val.charAt((strLen) - 1);
			   if(m_char.search(m_Sp) != -1) {
			      alert("특수문자는 사용할수없습니다.");
				  oFrm.value = "" ;
			      return;
			   }
		}
		
		//그리드 에서 EDIT를 사용하기 위한 함수 
		/*  사용 방법 (그리드 onSelectRow 에 작성
		 * ,onSelectRow: function(id) {
		 *	editRow(id);
		 *
		 *	}
		 */
		function editRow(id,grid) {
			var grid = $(grid);
			var lastSelection="";
		    if (id && id !== lastSelection) {
		        grid.jqGrid('restoreRow',lastSelection);
		        grid.jqGrid('editRow',id, {keys:true, focusField: 4});
		        lastSelection = id;
		    }
		}
		
		
		//Grid 데이터 json 데이터로 반환
		function setJSONDataList(jqGrid) {
			var colModel = $("#"+jqGrid).jqGrid('getGridParam','colModel');
			var arrObj = new Array();
			var ids = jQuery("#"+jqGrid).jqGrid('getDataIDs');
		    for ( var i=0; i<ids.length; i++ ) {
		        var vo = new Object();  
		        for(var j=1;j<colModel.length;j++){
		        	if(colModel[j].name!=""){
		        		var keyVal = jQuery("#"+jqGrid).jqGrid('getCell', ids[i], colModel[j].name);
		        		eval("vo."+colModel[j].name+"='"+keyVal+"';");
		        		//vo.key = colModel[j].name;
		        		//vo.value = jQuery("#"+jqGrid).jqGrid('getCell', ids[i], colModel[j].name);
		        	}
		        }
		        arrObj.push(vo);   
		    }
		    return JSON.stringify(arrObj)
		   // $("#JSONDataList").val(JSON.stringify(arrObj));
		}
		
		//Grid 데이터 json 데이터로 반환
		function getJSONDataList(jqGrid) {
			var colModel = $("#"+jqGrid).jqGrid('getGridParam','colModel');
			var arrObj = new Array();
			var ids = jQuery("#"+jqGrid).jqGrid('getDataIDs');
			var _value ="";
			var _type ="";
			var field = getColumnsInfo(jqGrid,"name");
			
		    for ( var i=0; i<ids.length; i++ ) {
		        var vo = new Object();  
		        for(var j=1;j<colModel.length;j++){
		        	if(colModel[j].name!=""){
			        		_value = $("#"+jqGrid+" :input[name="+field[j-1]+"]:eq("+i+")").val();
			        		_type = $("#"+jqGrid+" :input[name="+field[j-1]+"]:eq("+i+")").attr("type");
		        		if(_type=="radio"){
		        			if($("#"+jqGrid+" input:radio[name="+field[j-1]+"]").is(":checked")){
		        				_value = "Y"
		        				eval("vo."+colModel[j].name+"=\""+_value+"\"");
		        			}else{
		        				_value = "N"
		        				eval("vo."+colModel[j].name+"=\""+_value+"\"");
		        			}
		        		}if(_type=="checkbox"){
		        			if($("#"+jqGrid+" input:checkbox[name="+field[j-1]+"]:eq("+i+")").is(":checked")){
		        				_value = "Y"
		        				eval("vo."+colModel[j].name+"=\""+_value+"\"");
		        			}else{
		        				_value = "N"
		        				eval("vo."+colModel[j].name+"=\""+_value+"\"");
		        			}
		        		}else{
			        		if(_value==undefined){
			        			eval("vo."+colModel[j].name+"=\"\"");	
			        		}else{
			        			eval("vo."+colModel[j].name+"=\""+_value+"\"");
			        		}
			        		
			        	
		        		}
		        	}
		        }
		        arrObj.push(vo);   
		    }
		    return JSON.stringify(arrObj);
		}
 		
		//jqplot 차트 를 이미지로 보여주기위한 함수  
		/*  사용 방법 
		 * createChartimage(이미지생성할 chart id,이미지 생성후 보여줄 영역 id)
		 *
		 */
		function createChartimage(chartid,graphd) {
			  var divGraph = $('#'+chartid).jqplotToImageStr({});
			  var divElem  = $('<img/>').attr('src', divGraph);
			  $('#'+graphd).html() =="";
			  $('#'+graphd).html(divElem);
			  open(divGraph.toDataURL("image/png"));
		}
		
		//combobox를 생성하는 함수  
		/*  사용 방법
		 *  div 안에 select 를 생성후 사용 
		 *   <div id="??">  
         *   <select name="?" id="?" onchange="getLevoptionGroup($(this), 1)" >
         *   <option value=''>--선택--</option>
         *   
         *   </select>
         *   </div>  
		 *
		 */
		function getLevoptionGroup($this, lev){
		    var param = "";
		    var combobox="";
		    var val=$this.val();
		    var id =$($this).attr('name');
			var combolength = "";
		    	combobox = $("#"+$("#"+id).parent().attr('id'));	
				//select id로 크기를 가져와서 더큰놈은 다지우기   	
		    	combolength = $("select[name^='"+id+"']").length;
			    	for(var i=combolength;lev<i;i--){
			    		$("#"+id+Number(i-1)).remove();
					}
			    $("#pstate").val("CODE");
			    var params = jQuery('form').serialize();
			    params += "&code="+val+"&lev="+lev;
		    if	($this.val() != ''){
						 $.ajax({
				             type: "post",
				             url: "/cmsajax.do",
				             data:params,
				             async: false,
				             dataType:"json",
				             success: function(data){
				               if(data.optionlist!= ""){
				           		    combobox.append("<select name='"+id+"' id='"+(id+lev)+"' onchange='getLevoptionGroup($(this), "+Number(lev+1)+")'> <option value=''>선택없음</option> </select>");
				           		    combobox = $("#"+id+lev);
				                	combobox.append(data.optionlist);
				               }
				             }
				      });
		    	}
		}
		
		//특수문자에 대해서 HTML 코드에서 인지하도록 변환한다.
		function textToHtml(textVal) {
			var strtmp = new RegExp();
			var retString = "";

			strtmp = /[&]/gi;
			retString =  textVal.replace(strtmp, "&amp;");
			strtmp = /[<]/gi;
			retString =  retString.replace(strtmp, "&lt;");
			strtmp = /[>]/gi;
			retString =  retString.replace(strtmp, "&gt;");
			strtmp = /[\r\n]/gi;
			retString =  retString.replace(strtmp, "<br />");			
			strtmp = /[\n]/gi;
			retString =  retString.replace(strtmp, "<br />");
			strtmp = /["]/gi;
			retString =  retString.replace(strtmp, '&quot;');
			strtmp = /[']/gi;
			retString =  retString.replace(strtmp, "'");
			strtmp = /[ ]/gi;
			retString =  retString.replace(strtmp, "&nbsp;");

			return retString;
		}
		
		
		/**
		 * HTML 특수문자를 태그문자로 변환한다. - by
		 * @param value 
		 * @return '&lt;b&gt;test&lt;/b&gt;' --> '<b>test</b>' 
		 */
		function htmlSpclCharsDecode(value){	
			var result = value;
			var pattern = /(&quot;|&amp;|&apos;|&lt;|&gt;|&#034;|&#039;)/gi;
			try {//value 값에 특수문자의 존재여부를 확인하여 변환처리 함수를 호출한다.
				if(pattern.test(value)) {
					result = $('<div/>').html(value).text();
				} 
			} catch(e) {
				//do nothing
			}
			return result; 
		}
		
		/**
		 * HTML <br /> 텍스트area 개행문자로 변환한다. - by
		 * @param value 
		 * @return '<br />' --> '\r\n' 
		 */
		function htmlTextAreaBr(value){	
			var strtmp = new RegExp('<br />','gi');

			retString =  value.replace(strtmp, "\r\n");

			return retString;
		}
		
		/**
		 * HTML 특수문자를 태그문자로 변환한다. - by
		 * @param value 
		 * @return '&lt;b&gt;test&lt;/b&gt;' --> '<b>test</b>' 
		 */
		function htmlTextAreaGridDecode(textVal){	
			var retString = "";

			retString =  StrreplaceAll(textVal,"&nbsp;"," ");	
			retString =  StrreplaceAll(retString,"&lt;","<");
			retString =  StrreplaceAll(retString,"&gt;",">");
			retString =  StrreplaceAll(retString,"&quot;",'"');


			return retString;
		}		
		
		/**
		 * HTML <br /> 텍스트area 특수문자를 그리드textarea에 맞게 변환 - by
		 * @param value 
		 * @return '<br />' --> '\r\n' 
		 */
		function htmlTextAreaGridBr(textVal){	

			var retString = "";

			if( textVal==undefined || textVal=="undefined" || textVal == null || "null"==textVal ){
			
			}else{
				retString =  StrreplaceAll(textVal,"&nbsp;"," ");	
				retString =  StrreplaceAll(retString,"<br />","\r\n");
				retString =  StrreplaceAll(retString,"&lt;","<");
				retString =  StrreplaceAll(retString,"&gt;",">");
				retString =  StrreplaceAll(retString,"&quot;",'"');
				retString =  retString.replace(/&amp;/gi,'&');				
			}


			return retString;
		}		
		
		/**
		 * form 필수 체크 로직. 
		 * @param  
		 * @return return boolean
		 */
		function validation(formId,checkboxId){
			var formdata =  $("#"+formId).serializeArray();
			var fieldName = "";
			var check = true;
			var maxlength ="";
			var _type ="";
			var dcheck ="";
			$.each(formdata,function(i,d){
				fieldName = $("#"+d.name).parent("td").prev().text();
				
				if(fieldName==""){
				fieldName = $("#"+d.name).parent("div").parent("td").prev().text();	
				//작동오류
				/*	dcheck = $("#"+d.name).parent("div").parent("td").children("div").children("input:eq(0)").val();
					if(dcheck==undefined){
						dcheck ="";
					}*/
				}
				maxlength = $("#"+d.name).attr("maxlength");
				_type = $("#"+d.name).attr("type");
				if (fieldName.indexOf("*") != -1){
					// 숨겨진상태일경우 체크하지않는다
					if($("#"+d.name).is(":visible")){
						if(_type=="text"){
							//if(dcheck==""){
							if($("#"+d.name).chkForm({name:fieldName, type:"text", nullCheck:true})){ check=false; return false;}; //text 체크
							//}
						}else{
							if(maxlength!=undefined){
								if($("#"+d.name).chkForm({name:fieldName, type:"text", nullCheck:true})){check=false; return false;}; //text 체크
							}else{
								if($("#"+d.name).chkForm({name:fieldName, type:"selectbox", nullCheck:true})){check=false; return false;}; //select box체크	
							}
						}						
					}

				}
				if(maxlength!=undefined){
					 if($("#"+d.name).chkForm({name:fieldName, length:maxlength, type:"text", nullCheck:false})){check=false; return false;}; 
		         }
				if(checkboxId!=undefined){
					for(var i=0;i<checkboxId.length;i++){
						if($("input:checkbox[id="+checkboxId[i]+"]").is(":checked")==false){
							fieldName= $("input:checkbox[id="+checkboxId[i]+"]").parent("td").prev().text();
							if($("input:checkbox[id="+checkboxId[i]+"]").chkForm({name:fieldName, type:"checkbox", nullCheck:true})){check=false; return false;};
						}
					}
				}
				/*checkbox 구현부분 
				 * 	//
				 * 
				 * */
			});
			
			return check;
		}
	
		/**
		 * grid 필수 체크 로직. 
		 * @param  
		 * @return return boolean
		 */
		/*function gridValidation(gridId,checkelement){
			var _fieldName ="";
			var ids = jQuery("#"+gridId).jqGrid('getDataIDs');
			var _value ="";
			var _type ="";
			var check = true;
			var radioField = new Array();
			var radioText = new Array();
			var checkboxField = new Array();
			var checkboxText = new Array();
			var maxlength = "";
		    for ( var i=0; i<ids.length; i++ ) {
		    	
		        for(var j=0;j<checkelement.length;j++){
		        		_fieldName = $("#jqgh_"+gridId+"_"+checkelement[j]).text();
		        		_value = $("#"+gridId+" :input[name="+checkelement[j]+"]:eq("+i+")").val();
		        		_type = $("#"+gridId+" :input[name="+checkelement[j]+"]:eq("+i+")").attr("type");
		        		maxlength = $("#"+gridId+" :input[name="+checkelement[j]+"]:eq("+i+")").attr("maxlength");
		      			if(_type=="text"){
		        			if($("#"+gridId+" :input[name="+checkelement[j]+"]:eq("+i+")").chkForm({name:_fieldName, type:"text", nullCheck:true})){ check=false; return false;}; //text 체크	
		        		}else if(_type=="radio"){
		        			if(i==0){
		        			radioField.push(checkelement[j]);
		        			radioText.push($("#jqgh_jqGrid_"+checkelement[j]).text());
		        			}
		        		}else if(_type=="checkbox"){
		        			if(i==0){
		        				checkboxField.push(checkelement[j]);
		        				checkboxText.push($("#jqgh_jqGrid_"+checkelement[j]).text());
			        			}
			        	}else{
		        			if($("#"+gridId+" :input[name="+checkelement[j]+"]:eq("+i+")").chkForm({name:_fieldName, type:"selectbox", nullCheck:true})){check=false; return false;}; //select box체크
		        		}
						if(maxlength!=undefined){
							if($("#"+gridId+" :input[name="+checkelement[j]+"]:eq("+i+")").chkForm({name:_fieldName, length:maxlength, type:"text", nullCheck:false})){check=false; return false;}; 
				         }
		      			
		        	}
		        }	
				for(var i=0;i<radioField.length;i++){
						if($("#"+gridId+" input:radio[name="+radioField[i]+"]").is(":checked")==false){
							if($("#"+gridId+" input:radio[name="+radioField[i]+"]").chkForm({name:radioText[i], type:"radio", nullCheck:true})){check=false; return false;};
						}
				}
				for(var i=0;i<checkboxField.length;i++){
					if($("#"+gridId+" input:radio[name="+checkboxField[i]+"]").is(":checked")==false){
						if($("#"+gridId+" input:checkbox[name="+checkboxField[i]+"]").chkForm({name:checkboxText[i], type:"checkbox", nullCheck:true})){check=false; return false;};
				}
			}			
			return check;
		}*/
		
		/**
		 * grid 필수 체크 로직. 
		 * @param  
		 * @return return boolean
		 */
		function gridValidation(gridId,checkelement){
			var _fieldName ="";
			var ids = jQuery("#"+gridId).jqGrid('getDataIDs');
			var _value ="";
			var _type ="";
			var check = true;
			var radioField = new Array();
			var radioText = new Array();
			var checkboxField = new Array();
			var checkboxText = new Array();
			var maxlength = "";
		    for ( var i=0; i<ids.length; i++ ) {
		    	
		        for(var j=0;j<checkelement.length;j++){
		        		_fieldName = $("#jqgh_"+gridId+"_"+checkelement[j]).text();
		        		_value = $("#"+checkelement[j]+ids[i]).val();
		        		_type  = $("#"+checkelement[j]+ids[i]).attr("type"); 
		        		maxlength = $("#"+checkelement[j]+ids[i]).attr("maxlength");
		        		//console.log("_fieldName::="+_fieldName+"_value::="+_value+"_type::="+_type);
		        		//console.log("gridId::="+gridId+"checkelement[j]::="+checkelement[j]+"_type::="+_type);
		        		
		      			if(_type=="text"){
		        			if($("#"+checkelement[j]+ids[i]).chkForm({name:_fieldName, type:"text", nullCheck:true})){ check=false; return false;}; //text 체크	
		        		}else if(_type=="radio"){
		        			if(i==0){
		        			radioField.push(checkelement[j]);
		        			radioText.push($("#jqgh_jqGrid_"+checkelement[j]).text());
		        			}
		        		}else if(_type=="checkbox"){
		        			if(i==0){
		        				checkboxField.push(checkelement[j]);
		        				checkboxText.push($("#jqgh_jqGrid_"+checkelement[j]).text());
			        			}
			        	}else{
		        			if($("#"+checkelement[j]+ids[i]).chkForm({name:_fieldName, type:"selectbox", nullCheck:true})){check=false; return false;}; //select box체크
		        		}
		      			
						if(maxlength!=undefined){
							if($("#"+checkelement[j]+ids[i]).chkForm({name:_fieldName, length:maxlength, type:"text", nullCheck:false})){check=false; return false;}; 
				         }
		      			
		        	}
		        }	
				for(var i=0;i<radioField.length;i++){
						if($("#"+gridId+" input:radio[name="+radioField[i]+"]").is(":checked")==false){
							if($("#"+gridId+" input:radio[name="+radioField[i]+"]").chkForm({name:radioText[i], type:"radio", nullCheck:true})){check=false; return false;};
						}
				}
				for(var i=0;i<checkboxField.length;i++){
					if($("#"+gridId+" input:radio[name="+checkboxField[i]+"]").is(":checked")==false){
						if($("#"+gridId+" input:checkbox[name="+checkboxField[i]+"]").chkForm({name:checkboxText[i], type:"checkbox", nullCheck:true})){check=false; return false;};
				}
			}			
			return check;
		}		
		
		
		/**
		 * grid 필수 체크 로직. 버전2 
		 * 컬럼명에 '*'가 붙은 컬럼명을 필수체크항목으로 인식하여 Validation 체크
		 * @author mrkim 2015-05-14 
		 * @param  
		 * @return return boolean
		 */
		function gridChkValidation(gridId, gridNm){
			var _fieldName ="";
			var ids = jQuery("#"+gridId).jqGrid('getDataIDs');
			var _value ="";
			var _type ="";
			var check = true;
			var radioField = new Array();
			var radioText = new Array();
			var checkboxField = new Array();
			var checkboxText = new Array();
			var maxlength = "";
			
			var checkelement = getCheckField(gridId);
			

			if(ids.length==0){
				alert(gridNm+" 정보를 입력하십시오. ");
				return false;
			}

		    for ( var i=0; i<ids.length; i++ ) {
		        for(var j=0;j<checkelement.length;j++){
		        		_fieldName = (i+1)+"번째 줄 : "+$("#jqgh_"+gridId+"_"+checkelement[j]).text();
		        		_value = $("#"+gridId+" :input[name="+checkelement[j]+ids[i]+"]").val();
		        		_type = $("#"+gridId+" :input[name="+checkelement[j]+ids[i]+"]").attr("type");
		        		maxlength = $("#"+gridId+" :input[name="+checkelement[j]+ids[i]+"]").attr("maxlength");
	        		
//		        		console.log("_fieldName::="+_fieldName+"_value::="+_value+"_type::="+_type);
//		        		console.log("gridId::="+gridId+"checkelement[j]::="+checkelement[j]+"_type::="+_type);
		        		
//		        		alert(checkelement[j]+ids[i]+" : "+_value);
		      			if(_type=="text"){
		      				if($("#"+gridId+" :input[name="+checkelement[j]+ids[i]+"]").chkForm({name:_fieldName, type:"text", nullCheck:true})){ check=false; return false;}; //text 체크	
		        		}else if(_type=="radio"){
		        			if(i==0){
		        			radioField.push(checkelement[j]);
		        			radioText.push($("#jqgh_jqGrid_"+checkelement[j]).text());
		        			}
		        		}else if(_type=="checkbox"){
		        			if(i==0){
		        				checkboxField.push(checkelement[j]);
		        				checkboxText.push($("#jqgh_jqGrid_"+checkelement[j]).text());
			        			}
			        	}else{
		        			if($("#"+gridId+" :input[name="+checkelement[j]+ids[i]+"]").chkForm({name:_fieldName, type:"selectbox", nullCheck:true})){check=false; return false;}; //select box체크
		        		}
		      			
						if(maxlength!=undefined){
							if($("#"+gridId+" :input[name="+checkelement[j]+ids[i]+"]").chkForm({name:_fieldName, length:maxlength, type:"text", nullCheck:false})){check=false; return false;}; 
				         }
		      			
		        	}
		        }	
				for(var i=0;i<radioField.length;i++){
						if($("#"+gridId+" input:radio[name="+radioField[i]+"]").is(":checked")==false){
							if($("#"+gridId+" input:radio[name="+radioField[i]+"]").chkForm({name:radioText[i], type:"radio", nullCheck:true})){check=false; return false;};
						}
				}
				for(var i=0;i<checkboxField.length;i++){
					if($("#"+gridId+" input:radio[name="+checkboxField[i]+"]").is(":checked")==false){
						if($("#"+gridId+" input:checkbox[name="+checkboxField[i]+"]").chkForm({name:checkboxText[i], type:"checkbox", nullCheck:true})){check=false; return false;};
				}
			}			
			return check;
		}	
		
		
		
		
		/**
		 * null를 ""으로 변환한다.
		 * @param str
		 * @returns {String}
		 */
		function nullToEmpty(str){
			if( str==undefined || str=="undefined" || str == null || "null"==str ){
		    	str = "";
		    }

		    return str;
		}
		
		function nullToDefault(str, val){
			if( str==undefined || str=="undefined" || str == null || "null"==str ){
		    	str = val;
		    }

		    return str;
		}
		
		
		//오늘날짜를 yyyy-mm-dd형태로 리턴하는 함수
		function getDateStr(type, term) {

		    var now = new Date();
		    var yr = now.getFullYear();
		    var mName = now.getMonth() + 1;
		    var dName = now.getDate();
		    		    
		    if(type=="y" || type=="Y"){
		    	ysr=yr+term;
		    }else if(type=="m" || type=="M"){
		    	mName=mName+term;
		    }else if(type=="d" || type=="D"){
		    	dName=dName+term;
		    }

		    if (yr < 100)
		        year=("19"+yr).toString();
		    else
		        year=yr.toString();

		    if (mName <10)
		        month=("0"+mName).toString();
		    else
		        month=mName.toString();

		    if (dName <10)
		        day=("0"+dName).toString();
		    else
		        day=dName.toString();

		    return year+"-"+month+"-"+day;
		}
		
		
		
		function addDate(pInterval, pAddVal, pYyyymmdd, pDelimiter){
			 var yyyy;
			 var mm;
			 var dd;
			 var cDate;
			 var oDate;
			 var cYear, cMonth, cDay;
			 
			 if (pDelimiter != "") {
			  pYyyymmdd = pYyyymmdd.replace(eval("/\\" + pDelimiter + "/g"), "");
			 }
			 
			 
			 yyyy = pYyyymmdd.substr(0, 4);
			 mm  = pYyyymmdd.substr(4, 2);
			 dd  = pYyyymmdd.substr(6, 2);
			 
			 if (pInterval == "yyyy") {
			  yyyy = (yyyy * 1) + (pAddVal * 1); 
			 } else if (pInterval == "m") {
			  mm  = (mm * 1) + (pAddVal * 1);
			 } else if (pInterval == "d") {
			  dd  = (dd * 1) + (pAddVal * 1);
			 }
			 
			 
			 cDate = new Date(yyyy, mm - 1, dd); // 12월, 31일을 초과하는 입력값에 대해 자동으로 계산된 날짜가 만들어짐.
			 cYear = cDate.getFullYear();
			 cMonth = cDate.getMonth() + 1;
			 cDay = cDate.getDate();
			 
			 cMonth = cMonth < 10 ? "0" + cMonth : cMonth;
			 cDay = cDay < 10 ? "0" + cDay : cDay;
			 
			 
			 
			 if (pDelimiter != "") {
			  return cYear + pDelimiter + cMonth + pDelimiter + cDay;
			 } else {
			  return cYear + cMonth + cDay;
			 }
		 
		}
		

		/**
		 *대상데이타가 지정된 배열에 포함되어 있는지 비교 판단 -mr317.kim (2015/05/22)
		 * 있으면 true, 없으면 false를 반환 
		 */
		function isTargetValInArray(targetVal, valArr){
			var checkFlag = false;
			var targetVal = str_trim(targetVal);

			if(!isEmpty(targetVal)){
			    for (var i = 0; i < valArr.length; i++){
//			    	alert(targetVal.toUpperCase()+" == "+ str_trim(valArr[i]).toUpperCase());
			    	if(targetVal.toUpperCase()==str_trim(valArr[i]).toUpperCase()){
			    		checkFlag = true;
			    		break;
			    	}
			    }
			}
		  return checkFlag;
		}
		
		
		//폼 초기화 -mr317.kim (2015/04/01)
		function formReset(form){
			form.each(function(){
				this.reset();
			});
		}
		
		//배열내 max값 반환 -mr317.kim (2015/07/06)
		function getMaxValInArr(valArr){
			if(!valArr.length>1){				
				return valArr[0];
			}
			
			var arrLength = valArr.length-1;
			var standardVal = valArr[0]; 
			
			for (var i = 0; i < arrLength ; i++){
		    	if(Number(standardVal)<Number(valArr[i+1])){
		    		standardVal = valArr[i+1];
		    	}
		    }
			return standardVal;
		}
		
function getByteLenChk(s,len){
	var b;
	var i;
	var c;
	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
	//for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?3:c>>7?2:1);
	//alert(b);
	if(b>len){
		return false;
	}else{
		return true;
	}
 }

function byteleftString(cont, c){
	var s='';
	var i=0;
	for(var k=0;k<cont.length;k++){
		if(escape(cont.charAt(k)).length>4 ){
			i +=2;
		}else{
			i++;
		}
		
		if(i<=c){
			s +=escape(cont.charAt(k));
		}else{
			return unescape(s);
		}
	}
	return unescape(s);
}

function bytesubString(str, st, cnt){
	var lim = 0;
	var pos = 0;
	var beg = 0;
	var minus = 0;
	var len = getLength(str);
	var i=0;
	// 시작위치까지 skip
	for(i=0;pos<st;i++){
		pos += (str.charCodeAt(i) > 128)?2:1;
	}
	beg = i;
	// 시작위치에서 길이만큼 잘라냄
	for(i=beg;i<len;i++){
		//console.log(str.charCodeAt(i));
		lim += (str.charCodeAt(i) > 128)?2:1;
		if(lim > cnt){
			return str.substring(beg,i);
		}
	}	
	
}

//브라우저 정보
function getBrowser(){
	var r = { name : "???", version : -1, realVersion : -1 }; //브라우저정보
	var nav = navigator;
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
		r.version = getInternetExplorerVersion(nav);
		r.realVersion = getInternetExplorerVersion(nav);
	}else{
		//추후 필요시 추가...
	}
	
	return r;
}

function getInternetExplorerVersion (nav){
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

//로딩 보이기 com.js 함수 참조
function CmopenLoading(){
	
	var browser_arr = getBrowser();
	//alert($("body").height()+"::"+$(document).height());
	if(browser_arr[0]=="Internet Explorer" &&  parseInt(browser_arr[1],10)<=8){
		
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		//$("#pageDisable").css({"width":"100%","height":$("body").prop("scrollHeight")+"px","filter": "alpha(opacity=50)","background-color":"#000000","background-position":"center"});
		//$("#pageDisable").css({"width":"100%","height":($("body").height()+20) +"px","filter": "alpha(opacity=50)","background-color":"#000000","background-image": "url("+context_root+"/images/loading.gif)","background-repeat":"no-repeat","background-color":"#000000","background-position":"center"});
		$("#pageDisable").css({"width":"100%","height":($(document).height()+20) +"px","filter": "alpha(opacity=50)","background-color":"#000000","background-image": "url("+context_root+"/images/loading.gif)","background-repeat":"no-repeat","background-color":"#000000","background-position":"center"});
		
	}else{
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		//$("#pageDisable").css({"width":"100%","height":$("body").prop("scrollHeight")+"px","background": "rgba(0, 0, 0, 0.5)"});
		$("#pageDisable").css({"width":"100%","height":($(document).height()+20)+"px","background": "url("+context_root+"/images/loading.gif) no-repeat center rgba(0, 0, 0, 0.5)"});
	}
	$("#pageDisable").show();	

}

//로딩 보이기
function CmcloseLoading(){
	var browser_arr = getBrowser();
	
	if(browser_arr[0]=="Internet Explorer" &&  parseInt(browser_arr[1],10)<=8){
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"0px","height":"0px","filter": "alpha(opacity=0)"});
		
	}else{
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"0px","height":"0px","background": ""});
	}
	//console.log("2222");
	$("#pageDisable").hide();
	//document.getElementById("pageLoading").style.display="none";
}	

function CmLoadingChg_Zindex(zindex){
	$("#pageDisable").css({"z-index":zindex});
}


//TODO : CmopenpageDisable
//로딩 보이기 com.js 함수 참조
function CmopenpageDisable(){
	
	var browser_arr = com.util.getBrowser();
	
	if(browser_arr[0]=="Internet Explorer" &&  parseInt(browser_arr[1],10)<=8){
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		//$("#pageDisable").css({"width":"100%","height":$("body").prop("scrollHeight")+"px","filter": "alpha(opacity=50)","background-color":"#000000","background-position":"center"});
		$("#pageDisable").css({"width":"100%","height":($(document).height()+20) +"px","filter": "alpha(opacity=50)","background-color":"#000000","background-position":"center"});
	}else{
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		//$("#pageDisable").css({"width":"100%","height":$("body").prop("scrollHeight")+"px","background": "rgba(0, 0, 0, 0.5)"});
		$("#pageDisable").css({"width":"100%","height":($(document).height()+20)+"px","background": "rgba(0, 0, 0, 0.5)"});
	}
	$("#pageDisable").show();

}
//TODO : CmclospageDisable
//로딩 보이기
function CmclospageDisable(){
	var browser_arr = com.util.getBrowser();
	//console.log("CmclospageDisable");
	
	if(browser_arr[0]=="Internet Explorer" &&  parseInt(browser_arr[1],10)<=8){
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"0px","height":"0px","filter": "alpha(opacity=0)"});
		
	}else{
		//console.log("111111"+com.util.getBrowser().name+":==:"+com.util.getBrowser().version);
		$("#pageDisable").css({"width":"0px","height":"0px","background": ""});
	}
	//console.log("2222");
	$("#pageDisable").hide();
	//document.getElementById("pageLoading").style.display="none";
}
var context_root = "/KomipoWwg";

/* ----------------------------------------------------
숫자3자리 단위마다 콤마찍기
------------------------------------------------------ */
function numberWithCommas(x){
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

/* ----------------------------------------------------
같은 값의 열 병합

$("tableID").rowspan(colIdx);
------------------------------------------------------ */
$.fn.rowspan = function (colIdx, isStats){
	return this.each(function(){
		var that;
		
		$("tr", this).each(function(row){
			$("td:eq("+colIdx+")", this).filter(":visible").each(function(col){
				
				if ( $(this).html()==$(that).html()
				  && ( !isStats
					|| $(this).prev().html()==$(that).prev().html())		  
				){
					rowspan = $(that).attr("rowspan")||1;
					rowspan = Number(rowspan)+1;
					
					$(that).attr("rowspan", rowspan);
					
					$(this).hide();
				} else {
					that = this;
				}
				
				that = (that==null ? this : that);
				
			});  //end for
		}); //end for
	});  //end for
}

/* ----------------------------------------------------
같은 값의 행 병합

$("tableID").colspan(rowIdx);
------------------------------------------------------ */
$.fn.colspan = function (rowIdx, isStats){
	return this.each(function(i){
		var that;
		
		$("tr", this).each(function(col){
			$("td:eq("+rowIdx+")", this).filter(":visible").each(function(row){
				
				if ( $(this).html()==$(that).html()
				  && ( !isStats
				    || $(this).prev().html()==$(that).prev().html())		  
				){
					colspan = $(that).attr("colspan")||1;
					colspan = Number(colspan)+1;
					
					$(that).attr("colspan", colspan);
					
					$(this).hide();
				} else {
					that = this;
				}
				
				that = (that==null ? this : that);
				
			});  //end for
		}); //end for
	});  //end for
}

/* ----------------------------------------------------
날짜사이의 일수구하기
getDateDiff("시작일자", "종료일자")
------------------------------------------------------ */
function getDateDiff(strDay, endDay){
	
	var strArr = strDay.split("-");
	var endArr = endDay.split("-");
	
	var strDate = new Date(strArr[0], strArr[1]-1, strArr[2]);
    var endDate = new Date(endArr[0], endArr[1]-1, endArr[2]);
    
    var dayNumber = (endDate.getTime()-strDate.getTime()) / (1000*60*60*24);

	return dayNumber;
	
}

// lpad("A",2,0) ==> 0A    rpad("A",2,0) ==> A0
function lpad(str, padLength, padString){
	while(str.length < padLength)
		str = padString+s;
	return str;
}
function rpad(str, padLength, padString){
	while(str.length < padLength)
		str += padString;
	return str;
}

//마스킹함수 : 앞뒤 한글자를 제외하고 *로 마스킹한다
function masking_name(name){
	var mask = "";
	if(name.length > 2){
		mask = name.substr(0,1)+rpad('*',name.length-2,'*')+name.substr(name.length-1,1);
	}else{	//이름이 2자이하인 경우
		mask = name.substr(0,1)+rpad('*',name.length-2,'*');
	}
	return mask;
}



