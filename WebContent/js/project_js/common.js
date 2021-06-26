
var window_w = $(window).width();
$(document).ready(function(){
    var window_w = $(window).width();
    $(window).resize(function(){
        window_w = $(window).width();
        if(window_w < 700){
            //테이블콜스판
            $('.noticeView .tableA thead tr:nth-child(2) th').attr('colspan','1');
        }else{
            $('.noticeView .tableA thead tr:nth-child(2) th').attr('colspan','4');
        }
    });
    



    //아이디, 비밀번호찾기 tab 메뉴 스타일
    $('.tabmenu ul li').click(function(){
		var tab_id = $(this).attr('data-tab');

		$('.tabmenu ul li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
		// 탭이있는 페이지에서 선택된 tab index값을 호출해준다
		try {
			//alert("tab_id:"+tab_id+"---"+$(this).index());
			TabEvtCallBak($(this).index());
		}catch(e){
			
		}		
		
	});
    //휴대폰번호, 메일로 찾기
    $("#phonesearch").on("click", function(){
		$(".phoneSearch").show();
		$(".mailSearch").hide();
	});
	$("#mailsearch").on("click", function(){
		$(".phoneSearch").hide();
		$(".mailSearch").show();
	});
    //패밀리사이트
    $('.familySite').on({
        mouseenter: function(){
            $(this).addClass('show');
            $('.familySite>ul').stop().slideDown(250);
        },
        focusin: function(){
            $(this).addClass('show');
            $('.familySite>ul').stop().slideDown(250);
        }, 
        mouseleave: function(){
            $(this).removeClass('show');
            $('.familySite>ul').stop().slideUp(250);
        },
        focusout: function(){
            $(this).removeClass('show');
            $('.familySite>ul').stop().slideUp(250);
        }
    });


});