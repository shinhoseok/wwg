/** 
    validation 체크
    alt ==> title 로 바뀜 (alt 보다는 title 추천)
**/
var isNull = function(v){
	return (v == undefined || v == null || v == "") ? true : false;
}
// 빈값 체크
$.fn.emptyCheck = function() {
	var value = $.trim(this.val() + '');
	
    if (!value) {
        alert($(this).attr('title') + '는(은) 반드시 입력해 주세요.');
        $(this).select();
        return false;
    }
    return true;
};

//숫자 체크
$.fn.isNumberCheck = function() {
    if (! $(this).emptyCheck()) return false;
    if (isNaN($.trim(this.val() + ''))) {
        alert($(this).attr('title') + '은(는) 숫자만 입력 가능합니다.');
        $(this).select();
        return false;
    }
    return true;
};

//숫자 범위 체크
$.fn.batweenCheck = function(min, max) {
    if (! $(this).emptyCheck()) return false;
    if (! $(this).isNumberCheck()) return false;
     
    var value = Number($(this).val());

    if (min > value) {
        alert($(this).attr('title') + '은(는) ' + min + '이상 ' + max + '이하의 값만 입력 가능합니다.');
        $(this).select();
        return false;
    }

    if (max < value) {
        alert($(this).attr('title') + '은(는) ' + min + ' 이상 ' + max + ' 이하의 값만 입력 가능합니다.');
        $(this).select();
        return false;
    }
    
    return true;
};

//문자 길이 체크
$.fn.lengthCheck = function(max) {
    if (! $(this).emptyCheck()) return false;
    if (max < $.trim(this.val() + '').length) {
        alert($(this).attr('title') + '은(는) ' + max + ' 글자를 초과할 수 없습니다.');
        $(this).select();
        return false;
    }
    return true;
};

//문자 길이 체크
$.fn.lengthBetCheck = function(min, max) {
    if (! $(this).emptyCheck()) return false;
    if (max < $.trim(this.val() + '').length) {
        alert($(this).attr('title') + '은(는) '+ min + '이상 '  + max + ' 글자만 입력 가능합니다.');
        $(this).select();
        return false;
    }
    
    if (min > $.trim(this.val() + '').length) {
    	alert($(this).attr('title') + '은(는) '+ min + '이상 '  + max + ' 글자만 입력 가능합니다.');
        $(this).select();
        return false;
    }
    return true;
};

// 문자 바이트 체크
$.fn.byteCheck = function(str, max){
	var contents = str;
    var str_character;
    var int_char_count = 0;
    var int_contents_length = contents.length;
    
    for (var i = 0; i < int_contents_length; i++) {
    	str_character = contents.charAt(i);
    	
    	if (escape(str_character).length > 4) {
    		int_char_count +=2;
    	}else{
    		int_char_count++;
    	}
    }
    
    if(max < int_char_count){
    	alert($(this).attr('title') + '은(는) ' + max + ' Byte만 입력 가능합니다.');
    	$(this).select();
    	return false;
    }
    return true;
};

(function($){
	/*******************************************************************************
	* FUNCTION 명 : $.checkAll(name, condition)
	* FUNCTION 기능설명 : 체크박스 혹은 버튼 클릭시  name에 해당하는 체크박스를 모두 체크
	*******************************************************************************/
	$.fn.checkAll = function(name, condition) {
		this.click(function(){
			if(condition !== undefined){
				$("input[name='" + name + "']").attr("checked", condition);
			}
			else{
				if($(this).attr("type") === "checkbox"){
					$("input[name='" + name + "']").attr("checked", this.checked);
				}
				else{
					this.checked = this.checked && true;
					$("input[name='" + name + "']").attr("checked", !this.checked);
					this.checked = !this.checked;
				}
			}
		});
	};
})(jQuery);

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/gi, "");
};

/*******************************************************************************
 * FUNCTION 명 : validateNumber() FUNCTION 기능설명 : input Field 에 키를 입력 할때, Number만
 * 입력되로록 함
 ******************************************************************************/
function fnValidateNumber(evt) {
	
	//window.event = IE
	//evt.which  = 파폭 크롬등
	//jquery 쓰면 다 상관없음
	var code = evt.keyCode;
	
	if ((code > 34 && code < 41) || (code > 47 && code < 58)
			|| (code > 95 && code < 106) || code == 8 || code == 9
			|| code == 13 || code == 46) {
		return;
	}
	//window.event.returnValeu = false;
	evt.preventDefault();
};

/*******************************************************************************
 * FUNCTION 명 : 값의 타입을 체크
 * 사용 방법 : 
 * 	TypeChecker.number("1234"); --> true
 *  TypeChecker.number("abcd"); --> false
 ******************************************************************************/
TypeChecker = function() {
	var alpha = /[^a-zA-Z]/;
	var prgoramUrl = /[^a-zA-Z0-9.&=?\/]/;         
	var number = /^-?[0-9]+(,[0-9]+)?(\.[0-9]+)?$/;
	var email = /^(\w+)([-+.][\w]+)*@(\w[-\w]*\.){1,5}([A-Za-z]){2,4}$/;
	var url = /(((https?)|(ftp)):\/\/([\-\w]+\.)+\w{2,3}(\/[%\-\w]+(\.\w{2,})?)*(([\w\-\.\?\\\/+@&#;`~=%!]*)(\.\w{2,})?)*\/?)/i;
	var date = /^[0-9]{4}(-|\-)?[0-9]{2}(-|\-)?[0-3][0-9]$/;
	//var stdTm = /^[0-9]{4}(-|\.)?[0-9]{2}(-|\.)?[0-3][0-9].[0-2][0-9].[0-5][0-9]$/;
	var year = /^[0-9]{4}$/;
	var ipAddress = /^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$/;
	var alphanum = /[^a-zA-Z0-9]/;
	var roldeCode = /[^a-zA-Z0-9_]/;
	var phone = /^\d{3}-\d{3,4}-\d{4}$/;
	var usrid = /[^a-z0-9]/; //I
	var bannerUrl = /(((https?)|(ftp)):\/\/([\-\w]+\.)+\w{2,3}(\/[%\-\w]+(\.\w{2,})?)*(([\w\-\.\?\\\/+@&#;`~=%!]*)(\.\w{2,})?)*\/?)/i;
	var boardInfoId = /[^a-z]/;
	var korEng = /^[ㄱ-ㅎ|가-힣|a-z|A-Z]+$/;
	var programUrl = /^\/[\w]+\/[arwz]\/[tnm]\/[\w]+\.do$/;
	
	return {
		
		'usrid' : function(v) {
			if ($.trim(v) == "")
				return true;
			return !usrid.test(v);
		},
		'usridText' : "영문 소문자및, 숫자만 사용할 수 있습니다.",
		
		'prgoramUrl' : function(v) {
			if ($.trim(v) == "")
				return true;
			return !prgoramUrl.test(v);
		},
		'prgoramUrlText' : "개발 프로그램용 소스URL 형태만 가능합니다.\n(/변수명/권한/메뉴구분/*.do)",
		
		'roldeCode' : function(v) {
			if ($.trim(v) == "")
				return true;
			return !roldeCode.test(v);
		},
		'roldeCodeText' : "영문, 숫자 및 _기호만 가능합니다",
		
		'required' : function(v) {
			return $.trim(v) != "";
		},
		'requiredText' : "반드시 입력해야 합니다.",

		'email' : function(v) {
			if ($.trim(v) == "")
				return true;
			return email.test(v);
		},
		'emailText' : "Email 형식만 가능합니다. 예)user@example.com",
		'emailMask' : /[a-z0-9_\.\-@]/i,

		'url' : function(v) {
			if ($.trim(v) == "")
				return true;
			return url.test(v);
		},
		'urlText' : "URL 형식만 가능합니다. 예)http://www.example.com",

		'alpha' : function(v) {
			if ($.trim(v) == "")
				return true;
			return !alpha.test(v);
		},
		'alphaText' : "알파벳만 가능합니다.",
		'alphaMask' : /[a-z_]/i,

		'alphanum' : function(v) {
			if ($.trim(v) == "")
				return true;
			return !alphanum.test(v);
		},
		'alphanumText' : "알파벳과 숫자만 가능합니다.",
		'alphanumMask' : /[a-z0-9_]/i,

		'number' : function(v) {
			if ($.trim(v) == "")
				return true;
			return number.test(v);
		},
		'numberText' : "숫자만 가능합니다.",
		'numberMask' : /^-?[0-9]+,?[0-9]+\.?[0-9]+$/i,

		'date' : function(v) {
			if ($.trim(v) == "")
				return true;
			return date.test(v);
		},
		'dateText' : "날짜만 가능합니다. 예)2021-01-01",
		'dateMask' : /^[0-9]{4}(-|\-)?[0-9]{2}(-|\-)?[0-3][0-9]$/,

		'year' : function(v) {
			if ($.trim(v) == "")
				return true;
			return year.test(v);
		},
		'yearText' : "년도만 가능합니다. 예)2010",
		'yearMask' : /^[0-9]{4}$/,

		"ipAddress" : function(v) {
			if ($.trim(v) == "")
				return true;
			return ipAddress.test(v);
		},
		"ipText" : 'IP주소만 가능합니다.',
		"ipMask" : /[\d\.]/i,
		
		'phone' : function(v) {
			if ($.trim(v) == "")
				return true;
			return phone.test(v);
		},
		"phoneText" : '핸드폰 형식만 가능합니다.',
		
		'bannerUrl' : function(v) {
			if ($.trim(v) == "")
				return true;
			return bannerUrl.test(v);
		},
		'bannerUrlText' : "URL 형태만 가능합니다. 예)http://www.example.com",
		
		'boardInfoId' : function(v) {
			if ($.trim(v) == "")
				return true;
			return !boardInfoId.test(v);
		},
		'boardInfoIdText' : "영문소문자만 가능합니다.",
		
		'korEng' : function(v) {
			if ($.trim(v) == "")
				return true;
			return korEng.test(v);
		},
		'korEngText' : "한글 영문만 사용할 수 있습니다.",
		
		'programUrl' : function(v) {
			if($.trim(v) == "") {
				return true;
			}
			return programUrl.test(v);
		},
		'programUrlText' : "개발 프로그램용 소스URL 형태만 가능합니다.\n- /변수명/권한/메뉴구분/*.do\n- 변수명: 알파벳 및 숫자\n- 권한: a, r, w, z\n- 메뉴구분: m, n, t"
	};
}();

//비밀번호 체크  (숫자, 문자, 특수문자 1개 이상 반드시 포함 8자리 이상 20자리 이하)
fn_checkPass = function(objId){
	 var alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	 var number = "1234567890";
	 var sChar = "-_=+\|()*&^%$#@!~`?></;,.:'";
	 
	 var sChar_Count = 0;
	 var alphaCheck = false;
	 var numberCheck = false;
	 
	 var pw = $("#"+objId).val();
	 if(9 <= pw.length && pw.length <= 20){
	 	for(var i=0; i<pw.length; i++){
	   		if(sChar.indexOf(pw.charAt(i)) != -1){
	   			sChar_Count++;
	   		}
	   		if(alpha.indexOf(pw.charAt(i)) != -1){
	    		alphaCheck = true;
	   		}
	   		if(number.indexOf(pw.charAt(i)) != -1){
	    		numberCheck = true;
	   		}
	  	}//for
	 	
	  	if(sChar_Count < 1 || alphaCheck != true || numberCheck != true){
	  		$("#"+objId).val("");
	  		$("#"+objId).focus();
	   		alert("비밀번호는 영문,숫자,특수문자 1자이상(%,$,#,@,!)\n모두 포함하여 조합해주세요");
	   		return;
	  	}//if
	  
	 }else{
		 $("#"+objId).val("");
		 $("#"+objId).focus();
	  	alert("비밀번호는 9~20자로 조합해주세요");
	  	return;
	 }//else
	 return true;
};
