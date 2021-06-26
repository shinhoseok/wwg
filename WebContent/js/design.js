$(function() {	
	/* 메인슬라이드 */
	/*if($('.graph_list')!=undefined){
		var slider = $('.graph_list').bxSlider({
			infiniteLoop: false,
			touchEnabled: false,
			maxSlides: 5,
			maxSlides: 5,
			slideWidth: 212,
			slideMargin: 0,
			moveSlides: 1,
			pager: false,
			responsive: [
				{breakpoint: 1200,
					setting: {
						touchEnabled: true,
						maxSlides: 3,
						maxSlides: 3,
						slideWidth: 212,
						slideMargin: 0,
					}
				}
			]
		});
	}*/
	

	$('.btnn').click(function(){
		slider.goToNextSlide();
		return false;
	  });
  
	  $('.btnp').click(function(){
		slider.goToPrevSlide();
		return false;
	  });
	
		/*$windowWid = window.innerWidth;

		/*main_02
		var over_width = $('.slide_banner').width(); //overflow width
		var item_width = $('.slide_banner li').width(); //항목 width
		var obj_n = $('.slide_banner li').length; //오브젝트 갯수
		var max_length = item_width * obj_n; //전체길이
		
		var count_l = over_width - max_length; //왼쪽 이동 제한
		
		$('.slide_banner ul').width(max_length); //슬라이드의 길이를 전체길이로 바꿔줍니다.
		
		/*pc
		function btnp_pc(){
			var off_width = $('.slide_banner ul').offset(); //슬라이드 오프셋
			var off_left = off_width.left + 8.5; //슬라이드 오프셋 왼쪽좌표 +8.5는 스크롤바 크기 모바일에서는 이 값이 버그를 만듬 ㅠㅠ
			var off_reset = ($windowWid - over_width) / 2; //슬라이드 오프셋 고정 값
			var ctm = off_left - off_reset; //슬라이드 오프셋 비교 기준 
			var move_r = ctm + item_width; //오른쪽 이동
			if( ctm < 0 ){
				$('.slide_banner ul').stop().animate({'left':move_r},100);
			}
		};
		
		function btnn_pc(){
			var off_width = $('.slide_banner ul').offset(); //슬라이드 오프셋
			var off_left = off_width.left + 8.5; //슬라이드 오프셋 왼쪽좌표
			var off_reset = ($windowWid - over_width) / 2; //슬라이드 오프셋 고정 값
			var ctm = off_left - off_reset; //슬라이드 오프셋 비교 기준
			var move_l = ctm - item_width; //왼쪽 이동
			if( ctm > count_l ){
				$('.slide_banner ul').stop().animate({'left':move_l},100);
			}
		};
		
		/*mobile
		function btnp_mo(){
			var off_width = $('.slide_banner ul').offset(); //슬라이드 오프셋
			var off_left = off_width.left; //슬라이드 오프셋 왼쪽좌표
			var off_reset = ($windowWid - over_width) / 2; //슬라이드 오프셋 고정 값
			var ctm = off_left - off_reset; //슬라이드 오프셋 비교 기준 
			var move_r = ctm + item_width; //오른쪽 이동
			if( ctm < 0 ){
				$('.slide_banner ul').stop().animate({'left':move_r},100);
			}
		};
		
		function btnn_mo(){
			var off_width = $('.slide_banner ul').offset(); //슬라이드 오프셋
			var off_left = off_width.left; //슬라이드 오프셋 왼쪽좌표
			var off_reset = ($windowWid - over_width) / 2; //슬라이드 오프셋 고정 값
			var ctm = off_left - off_reset; //슬라이드 오프셋 비교 기준
			var move_l = ctm - item_width; //왼쪽 이동
			if( ctm > count_l ){
				$('.slide_banner ul').stop().animate({'left':move_l},100);
			}
		};
		
		$('.btnp').click(function(e){
								  
			if(!navigator.userAgent.match(/Android/i) && !navigator.userAgent.match(/iPhone/i) && !navigator.userAgent.match(/iPad/i)){
				btnp_pc();	
			} else if(navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
				btnp_mo();
			}					  
			
		});	
		
		$('.btnn').click(function(e){
			
			if(!navigator.userAgent.match(/Android/i) && !navigator.userAgent.match(/iPhone/i) && !navigator.userAgent.match(/iPad/i)){
				btnn_pc();	
			} else if(navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
				btnn_mo();
			}	
			
		});
		main_02*/

		/*graph_list 마우스오버*/
		$(".graph_list li a").mouseenter(function(event) {
		var j = $(".graph_list li a").index(this); // 존재하는 모든 버튼을 기준으로 index
		if(j==0){
		$(".graph_list li:nth-child(1) img").attr('src', '/images/common/g_01_over.gif');
		}if(j==1){
		$(".graph_list li:nth-child(2) img").attr('src', '/images/common/g_02_over.gif');
		}if(j==2){
		$(".graph_list li:nth-child(3) img").attr('src', '/images/common/g_03_over.gif');
		}if(j==3){
		$(".graph_list li:nth-child(4) img").attr('src', '/images/common/g_04_over.gif');
		}if(j==4){
		$(".graph_list li:nth-child(5) img").attr('src', '/images/common/g_05_over.gif');
		}if(j==5){
		$(".graph_list li:nth-child(6) img").attr('src', '/images/common/g_06_over.gif');
		}if(j==6){
		$(".graph_list li:nth-child(7) img").attr('src', '/images/common/g_07_over.gif');
		}if(j==7){
		$(".graph_list li:nth-child(8) img").attr('src', '/images/common/g_08_over.gif')
		}
		});
		$(".graph_list li a").mouseleave(function(event) {
		var j = $(".graph_list li a").index(this); // 존재하는 모든 버튼을 기준으로 index
		if(j==0){
		$(".graph_list li:nth-child(1) img").attr('src', '/images/common/g_01.gif');
		}if(j==1){
		$(".graph_list li:nth-child(2) img").attr('src', '/images/common/g_02.gif');
		}if(j==2){
		$(".graph_list li:nth-child(3) img").attr('src', '/images/common/g_03.gif');
		}if(j==3){
		$(".graph_list li:nth-child(4) img").attr('src', '/images/common/g_04.gif');
		}if(j==4){
		$(".graph_list li:nth-child(5) img").attr('src', '/images/common/g_05.gif');
		}if(j==5){
		$(".graph_list li:nth-child(6) img").attr('src', '/images/common/g_06.gif');
		}if(j==6){
		$(".graph_list li:nth-child(7) img").attr('src', '/images/common/g_07.gif');
		}if(j==7){
		$(".graph_list li:nth-child(8) img").attr('src', '/images/common/g_08.gif');
		}
		});
		
		/*gnb - pc*/
		/*gnb 기본동작 : 페이지 고정 없음*/
		$('.hit').mouseenter(function(){ //gnb 마우스오버
			if($windowWid > 900){
				$('.sub_menu').stop().animate({'top':130},200);
				$('#blank_layer').css('z-index','2');
				$('#blank_layer').show();
			}	
		});
		$('.main_menu a').focus(function(){ //gnb focus
			if($windowWid > 900){
				$('.sub_menu').stop().animate({'top':130},200);
				$('#blank_layer').css('z-index','2');
				$('#blank_layer').show();
			}	
		});
		$('.hit').mouseleave(function(){ //gnb 마우스아웃
			if($windowWid > 900){									  
				$('.sub_menu').stop().animate({'top':-200},200);
				$('#blank_layer').hide();
				$('#blank_layer').css('z-index','13');
				
			}
		});
		$('#container a').focus(function(){ //gnb 마우스아웃
			if($windowWid > 900){									  
				$('.sub_menu').stop().animate({'top':-200},200);
				$('#blank_layer').hide();
				$('#blank_layer').css('z-index','13');
			}
		});
		
		$('.pos_0').mouseover(function(){
			$('.sub_menu .pos_0').addClass('over');
			$('.main_menu .pos_0').addClass('over');
		});
		$('.pos_0').mouseleave(function(){
			$('.sub_menu .pos_0').removeClass('over');
			$('.main_menu .pos_0').removeClass('over');
		});
		$('.pos_1').mouseover(function(){
			$('.sub_menu .pos_1').addClass('over');
			$('.main_menu .pos_1').addClass('over');
		});
		$('.pos_1').mouseleave(function(){
			$('.sub_menu .pos_1').removeClass('over');
			$('.main_menu .pos_1').removeClass('over');
		});
		$('.pos_2').mouseover(function(){
			$('.sub_menu .pos_2').addClass('over');
			$('.main_menu .pos_2').addClass('over');
		});
		$('.pos_2').mouseleave(function(){
			$('.sub_menu .pos_2').removeClass('over');
			$('.main_menu .pos_2').removeClass('over');
		});
		$('.pos_3').mouseover(function(){
			$('.sub_menu .pos_3').addClass('over');
			$('.main_menu .pos_3').addClass('over');
		});
		$('.pos_3').mouseleave(function(){
			$('.sub_menu .pos_3').removeClass('over');
			$('.main_menu .pos_3').removeClass('over');
		});
		$('.pos_4').mouseover(function(){
			$('.sub_menu .pos_4').addClass('over');
			$('.main_menu .pos_4').addClass('over');
		});
		$('.pos_4').mouseleave(function(){
			$('.sub_menu .pos_4').removeClass('over');
			$('.main_menu .pos_4').removeClass('over');
		});
		$('.pos_5').mouseover(function(){
			$('.sub_menu .pos_5').addClass('over');
			$('.main_menu .pos_5').addClass('over');
		});
		$('.pos_5').mouseleave(function(){
			$('.sub_menu .pos_5').removeClass('over');
			$('.main_menu .pos_5').removeClass('over');
		});
		/*//gnb - pc*/
		
		/*gnb - mobile*/
		/*gnb open*/
		$('.gnb_open').click(function(e){
			e.preventDefault();						  
			gnbOpen();
			$('#blank_layer').click(function(){
				$('.gnb_close').trigger('click');
			});
		});
		$('.gnb_close').click(function(e){
			e.preventDefault();
			gnbClose();
		});
		
		
		
		function gnbOpen(){
			$('body').addClass('no_scroll');
			$('#blank_layer').show();
			$('#gnb').stop().animate({'right':0},250);
		};
		function gnbClose(){
			$('body').removeClass('no_scroll');
			$('#blank_layer').hide();
			$('#gnb').stop().animate({'right':-900},250);
			$('#gnb .depth2').stop().slideUp(100);
			$('#gnb .depth1').removeClass('active');
		};
		
		/*gnb click*/
		$('#gnb .depth1').click(function(){
			if($windowWid < 900){
				if($(this).hasClass('active')) {
					$(this).removeClass('active');	
				} else {
					$('#gnb .depth1').removeClass('active');
					$(this).addClass('active');
					$('#gnb .depth1 .depth2').parent().not(this).find('.depth2').stop().slideUp(250);
					$(this).find('.depth2').stop().slideDown(250);
				}
			}
		});
		$('#gnb .depth1 > span').click(function(){
			if($windowWid < 900){									
				$('#gnb .depth2').stop().slideUp(250);
			}
		});
		/*//gnb - mobile*/
		
		/*lnb*/
		/*
		function lnbdep1(){
			if($('#lnb .depth1').hasClass('active')) {
				$('#lnb .depth1').removeClass('active');	
				$('#lnb .depth1').find('.plus').removeClass('minus');
				$('#lnb .depth1').find('ul').stop().slideUp(250);
			} else {
				$('#lnb .depth1').addClass('active');	
				$('#lnb .depth1').find('.plus').addClass('minus');
				$('#lnb .depth1').find('ul').stop().slideDown(250);
				$('#lnb .depth2').removeClass('active');	
				$('#lnb .depth2').find('.plus').removeClass('minus');
				$('#lnb .depth2').find('ul').stop().slideUp(250);
			}
		};	
		function lnbdep2(){
			if($('#lnb .depth2').hasClass('active')) {
				$('#lnb .depth2').removeClass('active');	
				$('#lnb .depth2').find('.plus').removeClass('minus');
				$('#lnb .depth2').find('ul').stop().slideUp(250);
			} else {
				$('#lnb .depth2').addClass('active');	
				$('#lnb .depth2').find('.plus').addClass('minus');
				$('#lnb .depth2').find('ul').stop().slideDown(250);
				$('#lnb .depth1').removeClass('active');	
				$('#lnb .depth1').find('.plus').removeClass('minus');
				$('#lnb .depth1').find('ul').stop().slideUp(250);
			}
		};	
		
		$('#lnb .depth1 .current').click(function(e){
			if($windowWid > 900){
				e.preventDefault();	
				lnbdep1();
			}													  
		});
		
		$('#lnb .depth2 .current').click(function(e){								  
			e.preventDefault();	
			lnbdep2();
		})
		*/
		
		/*lnb 트리*/
		/*$("#lnb .current").click(function(e){
			e.preventDefault();
			if($(this).hasClass('active')) {
				$(this).removeClass('active');
				$(this).parent().find("ul").slideUp(100);
				$("#lnb .current").find("span").removeClass('minus');
			} else {
				$("#lnb .current").removeClass('active');
				$("#lnb .current").find("span").removeClass('minus');
				$(this).find("span").addClass('minus');
				$(this).addClass('active');
				$("#lnb .current").parent().not(this).find("ul").slideUp(100);
				$(this).parent().find("ul").slideToggle(100);
			}
			
		});*/
		
		$("#lnb .drop_nav").mouseover(function(){
			$(this).find("span").addClass('minus');
			$(this).find("ul").stop().slideDown(100);
		});
		$('#lnb .drop_nav').mouseleave(function(){
			$(this).find("span").removeClass('minus');								   
			$(this).parent().find("ul").stop().slideUp(100);
		});
		
		/*//lnb*/
		
		/*reset*/
		function reset_pc(){
			$('body').removeClass('no_scroll');
			$('#blank_layer').hide();
			$('#gnb .depth1').removeClass('active');
			$('#gnb .depth2').stop().slideDown(100);
			$('#gnb .depth2').css('display','inline-block');
			$('#lnb .depth1').removeClass('active');	
			$('#lnb .depth1').find('.plus').removeClass('minus');
			$('#lnb .depth1').find('ul').stop().slideUp(0);
			$('#lnb .depth2').removeClass('active');	
			$('#lnb .depth2').find('.plus').removeClass('minus');
			$('#lnb .depth2').find('ul').stop().slideUp(0);
			$('.password_layer').removeClass('on');
		};
		function reset_mobile(){
			$('body').removeClass('no_scroll');
			$('#blank_layer').hide();
			$('#gnb').stop().animate({'right':-1500},0);
			$('#gnb .depth2').stop().slideUp(100);
			$('#gnb .depth2').css('display','none');
			$('#lnb .depth1').removeClass('active');	
			$('#lnb .depth1').find('.plus').removeClass('minus');
			$('#lnb .depth1').find('ul').stop().slideUp(0);
			$('#lnb .depth2').removeClass('active');	
			$('#lnb .depth2').find('.plus').removeClass('minus');
			$('#lnb .depth2').find('ul').stop().slideUp(0);
			$('.site_map_close').trigger('click');
			$('.password_layer').removeClass('on');
		};

		$(window).resize(function(){
			$windowWid = window.innerWidth;					  
			if($windowWid > 900 && !navigator.userAgent.match(/iPhone/i) && !navigator.userAgent.match(/iPad/i)){
				reset_pc();
			} else if($windowWid < 900 && !navigator.userAgent.match(/iPhone/i) && !navigator.userAgent.match(/iPad/i)) {
				reset_mobile();
			}
		});
		
		//아이폰계열
		$( window ).on( 'orientationchange', function(){
			$windowWid = window.innerWidth;
			if($windowWid > 900 && !navigator.userAgent.match(/Android/i)){
				reset_pc();
			} else if($windowWid < 900 && !navigator.userAgent.match(/Android/i)) {
				reset_mobile();
			}
		});
		/*//reset*/
		
		/*scroll_event*/
		$(window).scroll(function(e){
			$windowWid = window.innerWidth;					  
			var sctop = $(this).scrollTop();
			if(sctop > 70 && $windowWid > 900){
				$('#header').addClass('fix');
				//$('.content').addClass('fix');
			}else if (sctop < 70 && $windowWid > 900){
				$('#header').removeClass('fix');	
				//$('.content').removeClass('fix');
			}
			/*if (sctop > 300 && $windowWid > 900){
				$('.company_ani1').animate({'opacity':1,'top':0},500);
			}*/
			
		});
		
		$(document).ready(function() { /*크롬 새로고침*/
			$windowWid = window.innerWidth;					  
			var sctop = $(this).scrollTop();
			if(sctop > 70 && $windowWid > 900){
				$('#header').addClass('fix');
			}else if (sctop < 70 && $windowWid > 900){
				$('#header').removeClass('fix');	
			}
		});						   
		/*//scroll_event*/
		
		
		/*accordion*/
		$(".accordion > dl").click(function(e){
			e.preventDefault();
			if($(this).hasClass('active')) {
				$(this).removeClass('active');
				$(this).find("dd").slideUp(100);
				$(".accordion i").removeClass('on');
			} else {
				$(".accordion > dl").removeClass('active');
				$(".accordion i").removeClass('on');
				$(this).find("i").addClass('on');
				$(this).addClass('active');
				$(".accordion > dl > dd").parent().not(this).find("dd").slideUp(100);
				$(this).find("dd").slideToggle(100);
			}
		});
		/*//accordion*/
		
		
		/*epl_height*/
		/*var epl_height = $('.ep_link').height();
		if($windowWid > 900){
			//alert (epl_height);
			$('.ep_spot_wrap').css('height', epl_height);
		}*/	
		/*//epl_height*/
		
		
		/*전력데이터 트리*/
		$(".epl_single .epl_tit").click(function(e){
			e.preventDefault();
			$(this).parent().find("ul").slideToggle(100);
			if($(this).hasClass('active')) {
				$(this).removeClass('active');
				$(this).find("span").removeClass('plus');
			} else {
				$(this).removeClass('active');
				$(this).addClass('active');
				$(this).find("span").addClass('plus')
			}
			
		});
		$(".a_open").click(function(e){
			e.preventDefault();
			$('.epl_single .epl_tit').removeClass('active');
			$('.epl_single ul').slideDown(100);
			$('.epl_single .epl_tit .minus').removeClass('plus');
		});
		$(".a_close").click(function(e){
			e.preventDefault();
			$('.epl_single .epl_tit').addClass('active');
			$('.epl_single ul').slideUp(100);
			$('.epl_single .epl_tit .minus').addClass('plus');
		});
		/*//전력데이터 트리*/
		
		/*재생*/
		/*$('.renew_map .pw_icon').mouseenter(function(){
			$(this).parent().parent().find(".txt_bubble").addClass('on');
		});
		$('.renew_map .pw_icon').mouseleave(function(){ 
			$(this).parent().parent().find(".txt_bubble").removeClass('on');
		});*/
		/*//재생*/
		
		
		/*전력통계 맵*/
		$('#map_se').mouseenter(function(){ 
			$('#national_map').addClass('map_se');
		});
		$('#map_se').mouseleave(function(){ 
			$('#national_map').removeClass('map_se');
		});
		
		$('#map_ic').mouseenter(function(){ 
			$('#national_map').addClass('map_ic');
		});
		$('#map_ic').mouseleave(function(){ 
			$('#national_map').removeClass('map_ic');
		});
		
		$('#map_dj').mouseenter(function(){ 
			$('#national_map').addClass('map_dj');
		});
		$('#map_dj').mouseleave(function(){ 
			$('#national_map').removeClass('map_dj');
		});
		
		$('#map_dg').mouseenter(function(){ 
			$('#national_map').addClass('map_dg');
		});
		$('#map_dg').mouseleave(function(){ 
			$('#national_map').removeClass('map_dg');
		});
		
		$('#map_us').mouseenter(function(){ 
			$('#national_map').addClass('map_us');
		});
		$('#map_us').mouseleave(function(){ 
			$('#national_map').removeClass('map_us');
		});
		
		$('#map_bs').mouseenter(function(){ 
			$('#national_map').addClass('map_bs');
		});
		$('#map_bs').mouseleave(function(){ 
			$('#national_map').removeClass('map_bs');
		});
		
		$('#map_gj').mouseenter(function(){ 
			$('#national_map').addClass('map_gj');
		});
		$('#map_gj').mouseleave(function(){ 
			$('#national_map').removeClass('map_gj');
		});
		
		$('#map_gg').mouseenter(function(){ 
			$('#national_map').addClass('map_gg');
		});
		$('#map_gg').mouseleave(function(){ 
			$('#national_map').removeClass('map_gg');
		});
		
		$('#map_gw').mouseenter(function(){ 
			$('#national_map').addClass('map_gw');
		});
		$('#map_gw').mouseleave(function(){ 
			$('#national_map').removeClass('map_gw');
		});
		
		$('#map_cb').mouseenter(function(){ 
			$('#national_map').addClass('map_cb');
		});
		$('#map_cb').mouseleave(function(){ 
			$('#national_map').removeClass('map_cb');
		});
		
		$('#map_cn').mouseenter(function(){ 
			$('#national_map').addClass('map_cn');
		});
		$('#map_cn').mouseleave(function(){ 
			$('#national_map').removeClass('map_cn');
		});
		
		$('#map_gb').mouseenter(function(){ 
			$('#national_map').addClass('map_gb');
		});
		$('#map_gb').mouseleave(function(){ 
			$('#national_map').removeClass('map_gb');
		});
		
		$('#map_gn').mouseenter(function(){ 
			$('#national_map').addClass('map_gn');
		});
		$('#map_gn').mouseleave(function(){ 
			$('#national_map').removeClass('map_gn');
		});
		
		$('#map_jb').mouseenter(function(){ 
			$('#national_map').addClass('map_jb');
		});
		$('#map_jb').mouseleave(function(){ 
			$('#national_map').removeClass('map_jb');
		});
		
		$('#map_jn').mouseenter(function(){ 
			$('#national_map').addClass('map_jn');
		});
		$('#map_jn').mouseleave(function(){ 
			$('#national_map').removeClass('map_jn');
		});
		
		$('#map_ul').mouseenter(function(){ 
			$('#national_map').addClass('map_ul');
		});
		$('#map_ul').mouseleave(function(){ 
			$('#national_map').removeClass('map_ul');
		});
		
		$('#map_dd').mouseenter(function(){ 
			$('#national_map').addClass('map_dd');
		});
		$('#map_dd').mouseleave(function(){ 
			$('#national_map').removeClass('map_dd');
		});
		
		$('#map_je').mouseenter(function(){ 
			$('#national_map').addClass('map_je');
		});
		$('#map_je').mouseleave(function(){ 
			$('#national_map').removeClass('map_je');
		});
		
		$('#map_sj').mouseenter(function(){ 
			$('#national_map').addClass('map_sj');
		});
		$('#map_sj').mouseleave(function(){ 
			$('#national_map').removeClass('map_sj');
		});
		/*//전력통계 맵*/
		
		/*사이트 맵*/
			$('.site_map_btn').click(function(){
				$('body').css('overflow','hidden');							  	
				$('.site_map_move').addClass('on');
				$('.site_map_move2').addClass('on');
				$('.site_map_move3').addClass('on');
				$('.site_map_move span').animate({width:'4000px' , height:'4000px' , left:'-1000' , top:'-1000'},700);
				$('.site_map_move2 span').animate({width:'4000px' , height:'4000px' , left:'-1000' , top:'-1000'},900);
				$('.site_map_move3 span').animate({width:'4000px' , height:'4000px' , left:'-1000' , top:'-1000'},1000);
				setTimeout (function() {
					$('.site_map').addClass('on');
					$('.site_map_inner').animate({opacity:'1'},500);
					$('.site_map').animate({opacity:'1'},500);
				}, 500);
				
			});
			$('.site_map_close').click(function(){							
				$('.site_map').animate({opacity:'0'},300)
				$('.site_map_inner').animate({opacity:'0'},300);						  	
				$('.site_map_move3 span').animate({width:'0' , height:'0', left:'0' , top:'120%'},700);
				$('.site_map_move2 span').animate({width:'0' , height:'0', left:'0' , top:'-1000'},900);
				$('.site_map_move span').animate({width:'0' , height:'0', left:'50%' , top:'-700'},1000);
				setTimeout (function() {
					$('.site_map').removeClass('on');				 	
					$('.site_map_move').removeClass('on');
					$('.site_map_move2').removeClass('on');
					$('.site_map_move3').removeClass('on');
				}, 1000);
				
				setTimeout (function() {
					$('body').css('overflow','auto');	
				}, 700);
				
			});
			/*//사이트 맵*/
		
		
		
		/*게시판 비밀번호*/
		/*
		$('.secret .subject a').click(function(){						  	
			$('.password_layer').addClass('on');
			$('body').addClass('no_scroll');
			$('#blank_layer').show();
		});
		*/
		$('.password_close').click(function(){
			$('.password_layer').removeClass('on');
			$('.password_layer2').removeClass('on');
			$('body').removeClass('no_scroll');
			$('#blank_layer').hide();
			$("#rqester_password").val("");
			
			$("#before_password").val("");
			$("#after_password").val("");
			$("#after_password_confirm").val("");
		});
		/*//게시판 비밀번호*/
		
		/*마우스오버*/
		var li_status;
		$("#main_03 .banner_area li a").mouseenter(function(){
			li_status = $("#main_03 .banner_area li a").hasClass();
			if(li_status == false){
				$("#main_03 .banner_area li a").removeClass("on");
				$(this).addClass("on");
			}else{
				$("#main_03 .banner_area li a").removeClass("on");
			}
		});
		$("#main_03 .banner_area li a").mouseleave(function(){
			$("#main_03 .banner_area li a").removeClass("on");
		});
		

});

//로딩이미지 open
function loadingOpen(){
	$('#loadingarea').show();
};

//로딩이미지 close
function loadingClose(){
	$('#loadingarea').hide();
};