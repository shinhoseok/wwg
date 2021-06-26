// JavaScript Document
$(function() {
		
		/// MENU
		
        $('#toggle').css('min-height', $(window).height() +'px');  
		$('#toggle a').css('min-height', 'inherit');  
        $('#lnbArea').css('min-height', $(document).height() +'px');
		//$('#lnb').css('min-height', $(window).height() +'px');	
		
	  	$('#tHide').click(function() {	  		
	  		 			
	  			$('#lnbArea').css("display","none");	  			
				
				//$('#lnb').css('min-height', 'inherit');			  		
				$('#toggle').css('min-height', $(window).height() +'px');
				$('#toggle a').css('display', 'block'); 
	  		    $('#toggle a').css('min-height', 'inherit');
				 $('#tShow').show();
				 $('#tHide').hide();
	  	});
		
		
		$('#tShow').click(function() {
	  		//$('#content').addClass("open");
			//$('#content').animate({left:185},500);
	  		$('#lnbArea').css("display","block");
	  		//$('#lnbArea').css('min-height', $(window).height() +'px');
			//$('#lnb').css('min-height', 'inherit');		  		
			$('#toggle').css('min-height', $(window).height() +'px');
			$('#toggle a').css('min-height', $(window).height() +'px');
			$('#tHide').show();
			$('#tShow').hide(); 
	  		
			
	  	});	
	});
	


//서브 트리메뉴 시작
$(document).ready(function(){

var treeBtn=$(".treeMenu a");
var treeLi=$(".treeMenu li");
var firstLi=$(".treeMenu>ul>li:first-child");
var lastLi=$(".treeMenu ul li:last-child");
var lastUl=lastLi.children("ul");

firstLi.addClass("first");
lastLi.addClass("last");
lastUl.addClass("last");

for(var i=0; i<treeLi.length; i++){
var thisLi=treeLi.eq(i);
var haveUl=thisLi.children("ul");
var haveUlNum=haveUl.length;
var thisbg=thisLi.attr("class");
thisLi.children("a").prepend("<input type='checkbox' /><img src='/images/tree/bul_page.gif' />");
	if(haveUlNum=="0"){
		if(thisbg=="first"){
			 thisLi.addClass("none_first");
		}else if(thisbg=="last"){
			thisLi.addClass("none_last");
		}else{
			thisLi.addClass("noneTree");
		}
	}else if(haveUlNum!="0"){
		thisLi.children("a").before("<img src='/images/tree/btn_plus.gif' alt='하위메뉴 보기' />");
	}
}

var treeBtn=$(".treeMenu li img");

treeBtn.click(function(){
	var thisNum=treeBtn.index(this);
	var thisBtn=treeBtn.eq(thisNum);
	var thisSubUl=thisBtn.parent().children("ul");

	if(thisSubUl.is(":visible")){
		thisBtn.attr("src",thisBtn.attr("src").replace("minus.gif","plus.gif"));
		thisSubUl.slideUp("500");
	}else{
		thisBtn.attr("src",thisBtn.attr("src").replace("plus.gif","minus.gif"));
		thisSubUl.slideDown("500");
	}


})
//트리메뉴 끝
})



///////////////////////////////////////////////

//checkbox style
function input_checked(obj,el_class){
    if(obj.is(':checked')==true){
       // obj.parent('label'+el_class).addClass('active');
		//thisLi.this("a").before("<img src='../images/tree/btn_plus.gif' alt='하위메뉴 보기' />");
		obj.parent('label'+el_class).addClass('active');
    }else{
        obj.parent('label'+el_class).removeClass('active');
    }
}
function checkbox_change(obj){
    if(obj=='load'){
        $('input[type=checkbox]').each(function(){
            input_checked($(this),'.checkboxArea');
        });
    }else{
        input_checked(obj,'.checkboxArea');
    }
}
$(document).ready(function(){
    $('input[type=checkbox]').change(function(){
        checkbox_change($(this));
    });
    checkbox_change('load');
});



//radio style
function radio_change(obj){
    if(obj=='load'){
        $('input[type=radio]').each(function(){
            input_checked($(this),'.radioArea');
        });
    }else{
        var radio_name = obj.attr('name');
        $('input[type=radio][name='+radio_name+']').parent('label.radioArea').removeClass('active');
        input_checked(obj,'.radioArea');
    }
}
$(document).ready(function(){
    $('input[type=radio]').change(function(){
        radio_change($(this));
    });
    radio_change('load');
});
