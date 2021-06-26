/**================================================================================
 * @name: javascript 공통 - jquery fn 추가 
 * @author: jhlee
 * @demo: 
 * @version: 0.1.0
 * @charset: utf-8
 ================================================================================*/
/*
 * jquery form에 있는 데이터을 json으로 리턴, serializeJSON 사용하게 추가
 * ex : $("#formId").serializeJSON();
 */
//(function($){
//	$.fn.serializeJSON=function() {
//		var json = {};
//		$.map($(this).serializeArray(), function(n, i){
//			json[n['name']] = n['value'];
//		});
//		return json;
//	};
//})(jQuery);

/*
 * jquery data 체크 사용하게 추가
 * text, textarea, password NULL 체크, 길이 체크 id 사용, trim 추가 
 * radio, checkbox 선택했는지 체크 name 사용
 * ex : if($("#hostAdminForm").find("#hostGroupName").chkForm({name:"그룹명", length:"60", type:"text", nullCheck:true})){return;};
 */
(function($){
	$.fn.chkForm=function(data) {
//		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE00 = '을(를) 입력하십시오.';
//		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE01 = '의 길이를';
//		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE02 = '이하로 입력하십시오.\r\n (한글 3byte  영문,숫자 1byte 사용가능) \r\n 현재';
//		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE03 = '은(는) 숫자로만 입력하십시오.';
//		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE04 = '을(를) 선택 하십시오.';
//		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE01 = '';
		
		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE00 = JI_CM_COMON_MSG_ALERT01;
		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE01 = JI_CM_COMON_MSG_ALERT02;
		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE02 = JI_CM_COMON_MSG_ALERT03;
		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE03 = JI_CM_COMON_MSG_ALERT04;
		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE04 = JI_CM_COMON_MSG_ALERT05;
		var MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE05 = 'byte';
		
		var gNumType			= /^\d+$/;
//		var gSignedNumType		= /^[+|-]?\d+$/;
//		var gTelNumType      = /^[-|+|\d]+$/;
//		var gEngType			= /^[a-zA-Z]+$/;
//		var gEngNumType			= /^[a-zA-Z0-9]+$/;
//		var gEmailType			= /^.+\@.+\..+$/;
//		var gUpperEngNumType	= /^[A-Z0-9]+$/;
//		var gLowerEngNumType	= /^[a-z0-9]+$/;
//		var gIntegerType		= /^\d?\d*\.?\d*$/;
		
		data.name = data.name.replace("*","");	
		if(data.type=="text"||data.type=="textarea"||data.type=="password"||data.type=="number"){

			//null default true
			if(data.nullCheck!=false){
				if($.trim($(this).val())==""||$(this).val().length<=0){
					//alert(data.name+"을(를) 입력하십시오.");
					//alert($(this).attr("id")+"::::"+data.name+" "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE00); // 을(를) 입력하십시오.
					alert(data.name+" "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE00); // 을(를) 입력하십시오.
					$(this).focus();
					return true;
				}
			}

			if(data.length!=undefined&&data.length!=""){
				//byte단위로 체크
				var len = 0;
				for(var i=0;i<$(this).val().length;i++){
					len += ($(this).val().charCodeAt(i) > 255 ? 2 : 1);
					if(len>data.length){
						//alert(data.name+"의 길이를 ("+data.length+ ") 이하로 입력하십시오. (한글 3byte  영문,숫자 1byte 사용)");
						//{0}의 길이를 {1} 이하로 입력하십시오. (한글 3byte  영문,숫자 1byte 사용)
						alert(data.name+" "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE01+" ("+data.length+ ") "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE02
								+len +MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE05); 
						$(this).val($(this).val().substring(0,i));
						$(this).focus();
						return true;
					}
				}
			}

			if(data.type=="number" && $(this).val().length>0){
				if(!gNumType.test($(this).val())) {
					//alert(data.name+"은(는) 숫자로만 입력하십시오.");
					alert(data.name+" "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE03); // 은(는) 숫자로만 입력하십시오.
					$(this).focus();
					return true;
				}
			}
		}else if(data.type=="radio"||data.type=="checkbox"){
			var flag = false;
			$(this).each(function(i, v){
				if($(v).attr("checked")=="checked"){
					flag = true;
				}
			});

			if(!flag){
				//alert(data.name+"을(를) 선택 하십시오.");
				alert(data.name+" "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE04); // 을(를) 선택 하십시오.
				return true;
			}
		} else if(data.type=="selectbox"){
			if($(this).val()==null||$(this).val()==""||$(this).val().length<=0){
				//alert(data.name+"을(를) 선택 하십시오.");
				alert(data.name+" "+MSGBUNDLE_COMMON_JQUERY_EXTEND_JS_MESSAGE04); // 을(를) 선택 하십시오.
				$(this).focus();
				return true;
			}
		}
	};
})(jQuery);
