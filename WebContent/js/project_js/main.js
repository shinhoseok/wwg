$(document).ready(function(){
    //메인비주얼 슬라이드
    var visual_slide = $('.visual_slide').slick({
        arrows: false,
        speed: 700,
        autoplay: true,
        autoplaySpeed: 4000,
		dots: true,
        draggable: true,
        pauseOnHover: false
    });
	
	$('.mainVisual .pause').on('click', function() {
        visual_slide.slick('slickPause');
        $(this).hide();
        $('.mainVisual .play').show();
    });
    
    $('.mainVisual .play').on('click', function() {
        visual_slide.slick('slickPlay');
        $(this).hide();
        $('.mainVisual .pause').show();
    });

    $('.mainVisual ul.slick-dots li button').on('click', function(){
        visual_slide.slick('slickPause');
        $('.mainVisual .pause').hide();
        $('.mainVisual .play').show();
    });

    //메인 서비스 배너
    var serviceBanner = $('.serviceBanner ul').slick({
        arrows: false,
        speed: 700,
        autoplay: true,
        autoplaySpeed: 4000,
		dots: true,
        draggable: true,
        pauseOnHover: false
    });
	
	$('.serviceBanner .pause').on('click', function() {
        serviceBanner.slick('slickPause');
        $(this).hide();
        $('.serviceBanner .play').show();
    });
    
    $('.serviceBanner .play').on('click', function() {
        serviceBanner.slick('slickPlay');
        $(this).hide();
        $('.serviceBanner .pause').show();
    });

    $('.serviceBanner ul.slick-dots li button').on('click', function(){
        serviceBanner.slick('slickPause');
        $('.serviceBanner .pause').hide();
        $('.serviceBanner .play').show();
    });

    //온라인직거래장터 배너
    $('.market_slide').slick({
        arrows: true,
        speed: 700,
        autoplay: true,
        autoplaySpeed: 4000,
		dots: false,
        draggable: true,
        pauseOnHover: false
    });
    
});