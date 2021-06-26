<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/sitemap/sitemap.jsp
/* 프로그램 이름     : sys_law_1    
/* 소스파일 이름     : sys_law_1.jsp
/* 설명              : ETC > 사이트맵
/* 버전              : 1.0.0
/* 최초 작성자       : 이금용
/* 최초 작성일자     : 2017-02-02
/* 최근 수정자       : 이금용
/* 최근 수정일시     : 2017-02-02
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>

            <!--0620 사이트맵추가-->
            <div class="siteMap">
                <div class="wrap" >
                    <ul id="sitemap_data">
 
                    </ul>
                </div>
            </div>
            <!--0620 사이트맵추가-->

<%
js_treelist_nm = "listtreeval";
%>

<script type='text/javascript'>
//<![CDATA[
        
$(function() {
	/*사이트맵*/		
	sitemapInit();
	
}); 


function sitemapInit(){
	
	var prev_i = 0;
	var depth1_ord = 1;
	
	// 트리의 값을 셋팅한다
	/*[0];//' M_CODE	[1];//' M_NM	[2];//' M_UP_CODE	[3];//' DEPTH_NO	[4];//' ORDER_NO	[5];//' LINK_TY
	[6];//' M_CODES
	[7];//' LV
	*/

	// 현재 선택된 메뉴의 1단계 메뉴코드를 확인한다
	for(i=0;i<<%=js_treelist_nm%>.length;i++){
		var tmp_innerhtml_str = "";

			for(j=0;j<<%=js_treelist_nm%>[i].length;j++){

				// 1단계 메뉴는 시스템 명임
				if(i==0){
				
				// 2단계 메뉴
				}else if(i==1){
					tmp_innerhtml_str = "<li id=\"sitemap_0"+(j+1)+"\">\r\n";
					tmp_innerhtml_str = tmp_innerhtml_str + "<a href=\"#\" id=\"site"+(i+1)+"menu_"+<%=js_treelist_nm%>[i][j][0]+"\" onclick=\"Go_SubmenuTop("+i+",'"+<%=js_treelist_nm%>[i][j][0]+"','"+<%=js_treelist_nm%>[i][j][2]+"','Y');return false;\" >"+<%=js_treelist_nm%>[i][j][1].replace(/&amp;/gi,"&")+"</a>\r\n";
					tmp_innerhtml_str = tmp_innerhtml_str + "<ul id=\""+<%=js_treelist_nm%>[i][j][0]+"\" class=\"dep"+(i+1)+"\"></ul>\r\n";
					tmp_innerhtml_str = tmp_innerhtml_str + "</li>\r\n";
					if(j<5){
						$("#sitemap_data").append(tmp_innerhtml_str);
					}
					
					
				// 3단계이상 메뉴
				}else if(i>1){

					tmp_innerhtml_str = "<li>\r\n";
					tmp_innerhtml_str = tmp_innerhtml_str + "<a href=\"#\" id=\"site"+(i+1)+"menu_"+<%=js_treelist_nm%>[i][j][0]+"\" onclick=\"Go_SubmenuTop("+i+",'"+<%=js_treelist_nm%>[i][j][0]+"','"+<%=js_treelist_nm%>[i][j][2]+"','Y');return false;\" >"+<%=js_treelist_nm%>[i][j][1].replace(/&amp;/gi,"&")+"</a>\r\n";
					tmp_innerhtml_str = tmp_innerhtml_str + "<ul id=\""+<%=js_treelist_nm%>[i][j][0]+"\" class=\"depth"+(i+1)+"\"></ul>\r\n";
					tmp_innerhtml_str = tmp_innerhtml_str + "</li>\r\n";
					$("#site"+(i)+"menu_"+<%=js_treelist_nm%>[i][j][2]).attr('onclick', '').unbind('click');
					$("#site"+(i)+"menu_"+<%=js_treelist_nm%>[i][j][2]).addClass("more");
					$("#"+<%=js_treelist_nm%>[i][j][2]).append(tmp_innerhtml_str);
					
				}
				
			
			}// for문 종료			

		
	}// for문 종료

	//////////////////////////////////////퍼블리싱쪽에서 정의한 common.js정의된 sitemap 메뉴관련 스크립트 이동
    //사이트맵
    $('.sitemap .openSite').on({
        click: function(){
            $(this).hide();
            $('.sitemap .closeSite').show();
            $('.siteMap').stop().slideDown(250);
            $('.shadow').show();
        }
    });

    $('.sitemap .closeSite').on({
        click: function(){
            $(this).hide();
            $('.sitemap .openSite').show();
            $('.siteMap').stop().slideUp(250);
            $('.shadow').hide();
        }
    });

    $('.siteMap .dep2>li>a.more').on({
        click: function(){
            dep2_status = $(this).hasClass('open');
            if(dep2_status == false){
                $('.siteMap .dep2>li>a.more').removeClass('open');
                $(this).addClass('open');
                $('.siteMap .depth3').stop().slideUp(250);
                $(this).next('.siteMap .depth3').stop().slideDown(250);
            }else{
                $(this).removeClass('open');
                $(this).next('.siteMap .depth3').stop().slideUp(250);    
            }
            
        }
    });
	//////////////////////////////////////퍼블리싱쪽에서 정의한 common.js정의된 sitemap 메뉴관련 스크립트 이동
}



//]]>           
</script>