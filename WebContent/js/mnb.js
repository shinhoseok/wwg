
$(function() {
	
	/*fix_nav*/
	$("#fix_open").click(function(e){
		e.preventDefault();						  
		fixnavOpen();
	});
	
	$("#fix_close").click(function(e){
		$('.fx_superior_sub').slideUp(300);
		$('.fx_qm_sub').slideUp(300);
		e.preventDefault();						  
		fixnavClose();
	});
	
	
	function fixnavOpen(){
		$("#fix_nav").stop().animate({"right":0},250,"easeInOutCubic");
		$("#fix_nav .fix_botm").css("width","200px");
		$(".fx_add").addClass("on");
		$(".fx_superior").addClass("on");
		$(".fx_qm").addClass("on");
		$(".fx_webzine").addClass("on");
		$(".fx_propose").addClass("on");
		$(".fx_expo").addClass("on");
		$("#fix_open").css("display","none");
		$("#fix_close").css("display","block");
	};
	
	
	function fixnavClose(){
	    var pot_low = $('#wrap').width();
		
		$("#fix_nav .fix_botm").css("width","60px");
		$(".fx_add").removeClass("on");
		$(".fx_superior").removeClass("on");
		$(".fx_qm").removeClass("on");
		$(".fx_webzine").removeClass("on");
		$(".fx_propose").removeClass("on");
		$(".fx_expo").removeClass("on");
		$("#fix_open").css("display","block");
		$("#fix_close").css("display","none");
		
		if(pot_low <= 1280){
		  $("#fix_nav").stop().animate({"right":-200},250,"easeInOutCubic");
		}else if(pot_low > 1280){
		  $("#fix_nav").stop().animate({"right":-140},250,"easeInOutCubic");
		};
	};
	
	$(window).resize(function() {
	    var pot_wdt = $('#wrap').width();
		
	    if(pot_wdt <= 1280){
		  $("#fix_nav").stop().animate({"right":-200},250,"easeInOutCubic");
		}else if(pot_wdt > 1280){
		  $("#fix_nav").stop().animate({"right":-140},250,"easeInOutCubic");
		};
	});
		
	/*quick_hover*/
	$('.fx_superior').click(function(e) {
		$('.fx_superior_sub').slideToggle(300);
		$('.fx_qm_sub').slideUp(300);
		e.preventDefault();						  
		fixnavOpen();
	});
	
	$('.fx_qm').click(function(e) {
		$('.fx_qm_sub').slideToggle(300);
		$('.fx_superior_sub').slideUp(300);
		e.preventDefault();						  
		fixnavOpen();
	});
	/*//fix_nav*/	   

	/*mnb*/
	$('#mnb, .mnb_bar').hover(
		function() {
			$('.depth2').stop().slideDown(200);
			$('.mnb_bar').stop().slideDown(200);
		},
		function() {
			$('.depth2').stop().slideUp(200);
			$('.mnb_bar').stop().slideUp(200);
		}
	);
	
	$('#mnb_01').hover(
		function() {
			$(".icon").addClass("vi_1");
			$(".icon").removeClass("vi_2");
			$(".icon").removeClass("vi_3");
			$(".icon").removeClass("vi_4");
			$(".icon").removeClass("vi_5");
			$(".icon").removeClass("vi_6");
		}
	);
	$('#mnb_02').hover(
		function() {
			$(".icon").addClass("vi_2");
			$(".icon").removeClass("vi_1");
			$(".icon").removeClass("vi_3");
			$(".icon").removeClass("vi_4");
			$(".icon").removeClass("vi_5");
			$(".icon").removeClass("vi_6");
		}
	);
	$('#mnb_03').hover(
		function() {
			$(".icon").addClass("vi_3");
			$(".icon").removeClass("vi_1");
			$(".icon").removeClass("vi_2");
			$(".icon").removeClass("vi_4");
			$(".icon").removeClass("vi_5");
			$(".icon").removeClass("vi_6");
		}
	);
	$('#mnb_04').hover(
		function() {
			$(".icon").addClass("vi_4");
			$(".icon").removeClass("vi_1");
			$(".icon").removeClass("vi_2");
			$(".icon").removeClass("vi_3");
			$(".icon").removeClass("vi_5");
			$(".icon").removeClass("vi_6");
		}
	);
	$('#mnb_05').hover(
		function() {
			$(".icon").addClass("vi_5");
			$(".icon").removeClass("vi_1");
			$(".icon").removeClass("vi_2");
			$(".icon").removeClass("vi_3");
			$(".icon").removeClass("vi_4");
			$(".icon").removeClass("vi_6");
		}
	);
	$('#mnb_06').hover(
		function() {
			$(".icon").addClass("vi_6");
			$(".icon").removeClass("vi_1");
			$(".icon").removeClass("vi_2");
			$(".icon").removeClass("vi_3");
			$(".icon").removeClass("vi_4");
			$(".icon").removeClass("vi_5s");
		}
	);
	/*//mnb*/
	
	/*lnb_sub*/
	$('#lnbOpen').click(
		function() {
			$('.lnd_depth2').stop().slideDown(200);
		}
	);
	$('.nav').mouseleave(
		function() {
			$('.lnd_depth2').stop().slideUp(200);
		}
	);
	$('.nav').mouseleave(
		function() {
			$('.lnd_depth2.on').stop().slideDown(200);
		}
	);
	/*//lnb_sub*/
		   
	/*select*/
	$(".select_area").click(function(e){
		e.preventDefault();						  
		selectType_a();
	});
	
	$(".select_n").click(function(e){
		e.preventDefault();						  
		selectType_b();
	});
	
	function selectType_a(){
		$(".cell_2").css("display","none");
		$(".cell_4").css("display","block");
		$(".alt1").css("display","none");
		$(".alt2").css("display","block");
	};
	
	function selectType_b(){
		$(".cell_4").css("display","none");
		$(".cell_2").css("display","block");
		$(".alt2").css("display","none");
		$(".alt1").css("display","block");
	};
	/*//select*/
	
	
	$("#subcOpen").click(function(e){
		e.preventDefault();						  
		subOpen();
	});
	
	$(".subcClose").click(function(e){
		e.preventDefault();						  
		subClose();
	});
	
	function subOpen(){
		$('#subcDetail').stop().animate({"height":1301},350,"easeInOutCubic");
		$("#subcOpen").css("display","none");
		$(".subcClose").css("display","block");
	};
	
	function subClose(){
		$('#subcDetail').stop().animate({"height":0},350,"easeInOutCubic");
		$("#subcOpen").css("display","block");
		$(".subcClose").css("display","none");
	};
	
	$(".his_tab > ul > li > a").click(function() {
		$(".his_tab > ul > li > a").removeClass("on");
		$(this).addClass("on");
	});
	
	$("#his_all").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2016").css("display", "block");
		$(".history_btn").css("display", "block");
		$(".btn_2015").css("display", "block");
		return false;
	});
	$("#his_2016").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2016").css("display", "block");
		return false;
	});
	$("#his_2015").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2015").css("display", "block");
		return false;
	});
	$("#his_2014").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2014").css("display", "block");
		return false;
	});
	$("#his_2013").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2013").css("display", "block");
		return false;
	});
	$("#his_2012").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2012").css("display", "block");
		return false;
	});
	$("#his_2011").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2011").css("display", "block");
		return false;
	});
	$("#his_2010").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2010").css("display", "block");
		return false;
	});
	$("#his_2009").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2009").css("display", "block");
		return false;
	});
	$("#his_2008").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2008").css("display", "block");
		return false;
	});
	$("#his_2007").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2007").css("display", "block");
		return false;
	});
	$("#his_2006").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2006").css("display", "block");
		return false;
	});
	$("#his_2005").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2005").css("display", "block");
		return false;
	});
	$("#his_2004").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2004").css("display", "block");
		return false;
	});
	$("#his_2003").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2003").css("display", "block");
		return false;
	});
	$("#his_2002").click(function() {
		$(".history > div").css("display", "none");
		$(".history_btn > span").css("display", "none");
		$(".year_2002").css("display", "block");
		return false;
	});
	
	
	$(".btn_2015").click(function(e){
		e.preventDefault();						  
		Open_2015();
	});
	$(".btn_2014").click(function(e){
		e.preventDefault();						  
		Open_2014();
	});
	$(".btn_2013").click(function(e){
		e.preventDefault();						  
		Open_2013();
	});
	$(".btn_2012").click(function(e){
		e.preventDefault();						  
		Open_2012();
	});
	$(".btn_2011").click(function(e){
		e.preventDefault();						  
		Open_2011();
	});
	$(".btn_2010").click(function(e){
		e.preventDefault();						  
		Open_2010();
	});
	$(".btn_2009").click(function(e){
		e.preventDefault();						  
		Open_2009();
	});
	$(".btn_2008").click(function(e){
		e.preventDefault();						  
		Open_2008();
	});
	$(".btn_2007").click(function(e){
		e.preventDefault();						  
		Open_2007();
	});
	$(".btn_2006").click(function(e){
		e.preventDefault();						  
		Open_2006();
	});
	$(".btn_2005").click(function(e){
		e.preventDefault();						  
		Open_2005();
	});
	$(".btn_2004").click(function(e){
		e.preventDefault();						  
		Open_2004();
	});
	$(".btn_2003").click(function(e){
		e.preventDefault();						  
		Open_2003();
	});
	$(".btn_2002").click(function(e){
		e.preventDefault();						  
		Open_2002();
	});
	
	
	function Open_2015(){
		$('.year_2015').slideDown(300);
		$('.year_2016').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2015").css("display","none");
		$(".btn_2014").css("display","block");
	};
	function Open_2014(){
		$('.year_2014').slideDown(300);
		$('.year_2015').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2014").css("display","none");
		$(".btn_2013").css("display","block");
	};
	function Open_2013(){
		$('.year_2013').slideDown(300);
		$('.year_2014').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2013").css("display","none");
		$(".btn_2012").css("display","block");
	};
	function Open_2012(){
		$('.year_2012').slideDown(300);
		$('.year_2013').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2012").css("display","none");
		$(".btn_2011").css("display","block");
	};
	function Open_2011(){
		$('.year_2011').slideDown(300);
		$('.year_2012').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2011").css("display","none");
		$(".btn_2010").css("display","block");
	};
	function Open_2010(){
		$('.year_2010').slideDown(300);
		$('.year_2011').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2010").css("display","none");
		$(".btn_2009").css("display","block");
	};
	function Open_2009(){
		$('.year_2009').slideDown(300);
		$('.year_2010').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2009").css("display","none");
		$(".btn_2008").css("display","block");
	};
	function Open_2008(){
		$('.year_2008').slideDown(300);
		$('.year_2009').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2008").css("display","none");
		$(".btn_2007").css("display","block");
	};
	function Open_2007(){
		$('.year_2007').slideDown(300);
		$('.year_2008').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2007").css("display","none");
		$(".btn_2006").css("display","block");
	};
	function Open_2006(){
		$('.year_2006').slideDown(300);
		$('.year_2007').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2006").css("display","none");
		$(".btn_2005").css("display","block");
	};
	function Open_2005(){
		$('.year_2005').slideDown(300);
		$('.year_2006').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2005").css("display","none");
		$(".btn_2004").css("display","block");
	};
	function Open_2004(){
		$('.year_2004').slideDown(300);
		$('.year_2005').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2004").css("display","none");
		$(".btn_2003").css("display","block");
	};
	function Open_2003(){
		$('.year_2003').slideDown(300);
		$('.year_2004').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2003").css("display","none");
		$(".btn_2002").css("display","block");
	};
	function Open_2002(){
		$('.year_2002').slideDown(300);
		$('.year_2003').stop().animate({"margin-bottom":50},350,"easeInOutCubic");
		$(".btn_2002").css("display","none");
	};
	
	
	$('.mask > .alt > .in_mask1 ').hover(
		function() {
			$('.mask > .alt2 > .in_mask1').stop().animate({"top":0},300,"easeInOutCubic");
		},
		function() {
			$('.mask > .alt2 > .in_mask1').stop().animate({"top":161},300,"easeInOutCubic");
		}
	);
	$('.mask > .alt > .in_mask2 ').hover(
		function() {
			$('.mask > .alt2 > .in_mask2').stop().animate({"top":0},300,"easeInOutCubic");
		},
		function() {
			$('.mask > .alt2 > .in_mask2').stop().animate({"top":161},300,"easeInOutCubic");
		}
	);
	$('.mask > .alt > .in_mask3 ').hover(
		function() {
			$('.mask > .alt2 > .in_mask3').stop().animate({"top":0},300,"easeInOutCubic");
		},
		function() {
			$('.mask > .alt2 > .in_mask3').stop().animate({"top":161},300,"easeInOutCubic");
		}
	);
	
	
	$(".calendar > span , .view_popup").click(function(e){
		e.preventDefault();						  
		popOpen();
	});
	$("#blank_layer, .pop_close").click(function(e){
		e.preventDefault();						  
		popClose();
	});
	function popOpen(){
		$("#blank_layer").css("display","block");
		$(".popup").css("display","block");
		$("body").addClass("no_scroll");
	};
	function popClose(){
		$("#blank_layer").css("display","none");
		$(".popup").css("display","none");
		$("body").removeClass("no_scroll");
	};
	
	
	/*slide*/
	$(".slide_1_btn").click(function(e){
		e.preventDefault();						  
		moveSlide_1();
	});
	
	$(".slide_2_btn").click(function(e){
		e.preventDefault();						  
		moveSlide_2();
	});
	
	$(".slide_3_btn").click(function(e){
		e.preventDefault();						  
		moveSlide_3();
	});
	
	
	function moveSlide_1(){
		$(".slide_mask > ul").stop().animate({"left":0},250,"easeInOutCubic");
		$(".slide_1_btn").addClass("on");
		$(".slide_2_btn").removeClass("on");
		$(".slide_3_btn").removeClass("on");
	};
	
	function moveSlide_2(){
		$(".slide_mask > ul").stop().animate({"left":-560},250,"easeInOutCubic");
		$(".slide_2_btn").addClass("on");
		$(".slide_1_btn").removeClass("on");
		$(".slide_3_btn").removeClass("on");
	};
	
	function moveSlide_3(){
		$(".slide_mask > ul").stop().animate({"left":-1120},250,"easeInOutCubic");
		$(".slide_3_btn").addClass("on");
		$(".slide_1_btn").removeClass("on");
		$(".slide_2_btn").removeClass("on");
	};
	
	/* organization */
	$('.depth05').click(
		function() {
			$('.depth05').removeClass('on');
			$(this).addClass('on');
		}
	);
	$('#office02, #office03, #office04, #office05, #office06').css('display', 'none')
	$('.depth05.dep01').click(
		function() {
			$('#office01').css('display', 'block');
			$('#office02, #office03, #office04, #office05, #office06').css('display', 'none');
		}
	);
	$('.depth05.dep02').click(
		function() {
			$('#office02').css('display', 'block');
			$('#office01, #office03, #office04, #office05, #office06').css('display', 'none');
		}
	);
	$('.depth05.dep03').click(
		function() {
			$('#office03').css('display', 'block');
			$('#office01, #office02, #office04, #office05, #office06').css('display', 'none');
		}
	);
	$('.depth05.dep04').click(
		function() {
			$('#office04').css('display', 'block');
			$('#office01, #office02, #office03, #office05, #office06').css('display', 'none');
		}
	);
	$('.depth05.dep05').click(
		function() {
			$('#office05').css('display', 'block');
			$('#office01, #office02, #office03, #office04, #office06').css('display', 'none');
		}
	);
	$('.depth05.dep06').click(
		function() {
			$('#office06').css('display', 'block');
			$('#office01, #office02, #office03, #office04, #office05').css('display', 'none');
		}
	);
	
	
	/* open_box */
    $('.sec_open').click(
		function(e) {
			$(this).parent().find('.sec_box').slideToggle(100);
			e.preventDefault();
		}
	);
	$('.sec_close').click(
		function(e) {
			$(this).parent().parent().parent().find('.sec_box').slideUp(100);
			e.preventDefault();
		}
	);
	
	
	/* webzine */
	$('.webzine_list li').click(function(e) {
		$('.thumbnail').removeClass('on');
		$(this).children().find('.thumbnail').addClass('on');
		$('.webzine_box').css('display', 'none');
		e.preventDefault();
	})
	
	$('#webzine10').click(function(e) {
		$('.webzine_box.wz10').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine9').click(function(e) {
		$('.webzine_box.wz9').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine8').click(function(e) {
		$('.webzine_box.wz8').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine7').click(function(e) {
		$('.webzine_box.wz7').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine6').click(function(e) {
		$('.webzine_box.wz6').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine5').click(function(e) {
		$('.webzine_box.wz5').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine4').click(function(e) {
		$('.webzine_box.wz4').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine3').click(function(e) {
		$('.webzine_box.wz3').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine2').click(function(e) {
		$('.webzine_box.wz2').fadeIn(300);
		e.preventDefault();
	})
	$('#webzine1').click(function(e) {
		$('.webzine_box.wz1').fadeIn(300);
		e.preventDefault();
	})
	
});


