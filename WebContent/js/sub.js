$(document).ready(function(){
    //온라인 직거래장터 - 뷰
    $('.product_img ul li').on('click', function(){
        $('.product_img ul li').removeClass('pic');
        $(this).addClass('pic');
    });
    //동반성장전략 - 동반성장 지원체계·역할 이미지 모바일
    var window_w = $(window).width();
    $(window).resize(function(){
        window_w = $(window).width();
        if(window_w < 501){
            $('.support img').attr('src','../../img/sub/supportImgM.jpg');
        }else{
            $('.support img').attr('src','../../img/sub/supportImg.jpg');
        }
    });
    //동반성장 문화확산 슬라이드
    $('.picSlide ul').slick({
        arrows: true,
        speed: 700,
        autoplay: true,
        autoplaySpeed: 4000,
		dots: false,
        draggable: false,
        pauseOnHover: false,
        slidesToShow: 3,
        slidesToScroll: 1,
        responsive: [
            {
              breakpoint: 701,
              settings: {
                slidesToShow: 2
              }
            },{
                breakpoint: 451,
                settings: {
                  slidesToShow: 1
                }
              }
        ]
    });
    
    //공유버튼
    $('.shareMenu>.snsShare').on({
        mouseenter: function(){
            $(this).addClass('open');
            $('.snsList').stop().slideDown(250);
        },
        mouseleave: function(){
            $(this).removeClass('open');
            $('.snsList').stop().slideUp(250);
        }
    });
    $('.shareMenu>.snsShare>a').on({
        click: function(){
            var sns_click = $(this).hasClass('open');
            if(sns_click == true){
                $(this).removeClass('open');
                $('.snsList').stop().slideUp(250);
            }else{
                $(this).addClass('open');
                $('.snsList').stop().slideDown(250);
            }
        },
    });
});