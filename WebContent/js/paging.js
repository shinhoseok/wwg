(function($) {
		
		var _default	=	{PaginationInfo	:	null
								 //,CallFunc		:	null
		};
		
		$.fn.fnPaging = function(_option){
			
			this.each(function() {
				
				$.extend(_default, _option);
					
					var firstPageNo 				= _default.PaginationInfo.firstPageNo;
					var firstPageNoOnPageList 		= _default.PaginationInfo.firstPageNoOnPageList;
					var totalPageCount 				= _default.PaginationInfo.totalPageCount;
					var pageSize 					= _default.PaginationInfo.pageSize;
					var lastPageNoOnPageList 		= _default.PaginationInfo.lastPageNoOnPageList;
					var currentPageNo 				= _default.PaginationInfo.currentPageNo;
					var lastPageNo 					= _default.PaginationInfo.lastPageNo;
					
					var arrHtml	=	[];
					if(typeof _default.PaginationInfo !='undefined' || _default.PaginationInfo != null){
						if(totalPageCount > pageSize){
							if(firstPageNoOnPageList > pageSize){
								arrHtml.push("<a href='#' class='boxFirst' onclick=\"goPage('"+firstPageNo+"');return false;\">처음 페이지 이동<span></span></a>");
								arrHtml.push("<a href='#' class='boxPrev' onclick=\"goPage('"+(firstPageNoOnPageList-1)+"');return false;\">이전 페이지 이동</a>");
							}else{
								arrHtml.push("<a href='#' class='boxFirst' onclick=\"goPage('"+firstPageNo+"');return false;\">처음 페이지 이동<span></span></a>");
								arrHtml.push("<a href='#' class='boxPrev' onclick=\"goPage('"+firstPageNo+"');return false;\">이전 페이지 이동</a>");
							}
						}
						
						for(var i = firstPageNoOnPageList; i<= lastPageNoOnPageList ;i++){
							if(i == currentPageNo){
								arrHtml.push("<a href='#' class='boxnow'>"+i+"</a>");
							}else{
								arrHtml.push("<a href='#' onclick=\"goPage('"+i+"');return false;\">"+i+"</a>");
							}
						}
						
						if(totalPageCount > pageSize){
							if(lastPageNoOnPageList < totalPageCount){
								arrHtml.push("<a href='#' class='boxNext' onclick=\"goPage('"+(firstPageNoOnPageList+pageSize)+"');return false;\">다음 페이지 이동</a>");
								arrHtml.push("<a href='#' class='boxLast' onclick=\"goPage('"+lastPageNo+"');return false;\">마지막 페이지 이동<span></span></a>");
							}else{
								arrHtml.push("<a href='#' class='boxNext' onclick=\"goPage('"+lastPageNo+"');return false;\">다음 페이지 이동</a>");
								arrHtml.push("<a href='#' class='boxLast' onclick=\"goPage('"+lastPageNo+"');return false;\">마지막 페이지 이동<span></span></a>");
							}
						}
						
						$(this).append(arrHtml.join(""));
					}
			});
			
		}/*,
		$.fn.fnFirst = function(){
		},
		$.fn.fnPrev = function(){
		},
		$.fn.fnNext = function(){
		},
		$.fn.fnLast = function(){
		}*/
	})(jQuery);