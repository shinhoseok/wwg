/*!
 * jQuery Print Previw Plugin v1.0.1
 *
 * Copyright 2011, Tim Connell
 * Licensed under the GPL Version 2 license
 * http://www.gnu.org/licenses/gpl-2.0.html
 *
 * Date: Wed Jan 25 00:00:00 2012 -000
 */
 
(function($) { 
    var print_obj_nm;   
	var print_zoom;
	var print_top_obj_nm;
	var print_remove_obj_nm;
	// CmCommon.js함수 호출
	var browser_info = getBrowser();
	// Initialization
	$.fn.printPreview = function(obj_nm, obj_zoom, top_obj_nm, remove_obj_nm) {
		print_obj_nm = obj_nm;
		print_zoom = obj_zoom;
		print_top_obj_nm = top_obj_nm;
		print_remove_obj_nm = remove_obj_nm;
		//alert(print_obj_nm);
		/*this.each(function() {
			$(this).bind('click', function(e) {
			    e.preventDefault();
			    if (!$('#print-modal').length) {
			        $.printPreview.loadPrintPreview();
			    }
			});
		});*/
		return this;
	};
    
    // Private functions
    var mask, size, print_modal, print_controls, print_org_obj;
    $.printPreview = {
        loadPrintPreview: function() {
            // Declare DOM objects
            print_modal = $('<div id="print-modal"></div>');
            print_controls = $('<div id="print-modal-controls">' + 
                                    '<a href="#" class="print_go" title="Print page">Print page</a>' +
                                    '<a href="#" class="print_close" title="Close print preview">Close</a>').hide();
            var print_frame = $('<iframe id="print-modal-content" scrolling="auto" frameborder="0" name="print-frame" />');
            print_org_obj = $(print_obj_nm);

            // Raise print preview window from the dead, zooooooombies
            print_modal
                .hide()
                .append(print_controls)
                .append(print_frame)
                .appendTo('body');

            // The frame lives
            for (var i=0; i < window.frames.length; i++) {
                if (window.frames[i].name == "print-frame") {    
                    var print_frame_ref = window.frames[i].document;
                    break;
                }
            }
            print_frame_ref.open();
            print_frame_ref.write('<!doctype html>' +
                '<html lang="ko">' + 
                '<head><title>' + document.title + '</title></head>' +
                '<script type="text/javascript">'+
            	' function iframe_inner_print(){' +
            	' self.focus();self.document.execCommand("print", false, null); ' +
        		' }' +
        		'</script>' +               
                //'<body><div id=\''+print_top_obj_nm+'\'></div></body>' +
                '</html>');
            print_frame_ref.close();
            
            // Grab contents and apply stylesheet
           // var $iframe_head = $('head link[media*=print], head link[media=all]').clone(),
            var $iframe_head = $("head link[media^='all']").clone(),
                //$iframe_body = $(''+print_obj_nm+' > *:not(#print-modal):not(script)').clone();
            	
            	$iframe_body = $("body").find(print_obj_nm).find(' > *:not(#print-modal):not(script)').clone();
			
            //var $iframe_head = $('head link').clone(),
            //    $iframe_body = $(''+print_obj_nm+' > *:not(#print-modal):not(script)').clone();	
			
            //var $iframe_head = $('head').clone();
            //var $iframe_body = $(print_obj_nm+' > *:not(#print-modal):not(script)').clone();
			
            $iframe_head.each(function() {
                $(this).attr('media', 'all');
            });
			
			var add_obj_nm = "";
			var add_obj_type_nm = "";
			//alert($(print_obj_nm).attr("class")+"::"+$(print_obj_nm).attr("id"));
			if($("body").find(print_obj_nm).attr("class")!=undefined){
				add_obj_nm = " class='"+$("body").find(print_obj_nm).attr("class")+"' ";
				add_obj_type_nm = "."+$("body").find(print_obj_nm).attr("class");
			}else if($("body").find(print_obj_nm).attr("id")!=undefined){
				add_obj_nm = " id='"+$("body").find(print_obj_nm).attr("id")+"' ";
				add_obj_type_nm = "#"+$("body").find(print_obj_nm).attr("class");
			}
			

			
			//alert(browser_info.name+"::"+browser_info.version);
            if (!browser_info.name=="Internet Explorer" && !(browser_info.version < 7) ) {
				//alert(1);
				//return;
                $('head', print_frame_ref).append($iframe_head);

            		
				//$("body #"+print_top_obj_nm, print_frame_ref).append("<div "+add_obj_nm+"></div>");
                $("body", print_frame_ref).append("<div "+add_obj_nm+" style='width:100%'></div>");
				
                //$("body #"+print_top_obj_nm+" "+add_obj_type_nm, print_frame_ref).append($iframe_body);
                $("body "+add_obj_type_nm, print_frame_ref).append($iframe_body);
                //$($("body").find(add_obj_type_nm), print_frame_ref).show();
                $(print_frame_ref).contents().find(add_obj_type_nm).show();
				
            }else {
				//alert(2);
				//$("body #"+print_top_obj_nm, print_frame_ref).append("<div "+add_obj_nm+"></div>");
            	$("body", print_frame_ref).append("<div "+add_obj_nm+" style='width:100%'></div>");
                //$(''+print_obj_nm+' > *:not(#print-modal):not(script)').clone().each(function() {
            	$("body").find(print_obj_nm).find(' > *:not(#print-modal):not(script)').clone().each(function() {
                	//alert(this.outerHTML);
                    //$("body #"+print_top_obj_nm+" "+add_obj_type_nm, print_frame_ref).append(this.outerHTML);
					$("body "+add_obj_type_nm, print_frame_ref).append(this.outerHTML);
                });
                $('head link').each(function() {
                    $('head', print_frame_ref).append($(this).clone().attr('media', 'all')[0].outerHTML);
                });
                //$($("body").find(add_obj_type_nm), print_frame_ref).show();
                //alert(add_obj_type_nm);
                $(print_frame_ref).contents().find(add_obj_type_nm).css("display","block");
            }
			
			
			//return;
            $(print_frame_ref).contents().find(""+print_remove_obj_nm).remove();
            
            // Disable all links
            $('a', print_frame_ref).bind('click.printPreview', function(e) {
                e.preventDefault();
            });
            
            // Introduce print styles
            $('head').append('<style type="text/css">' +
                '@media print {' +
                    '/* -- Print Preview --*/' +
                    '#print-modal-mask,' +
                    '#print-modal {' +
                        'display: none !important;' +
                    '}' +
                '}' +
                '</style>'
            );

            // Load mask
            $.printPreview.loadMask();

            // Disable scrolling
            $('body').css({overflowY: 'hidden', height: '92%'});
            $('img', print_frame_ref).load(function() {
                //print_frame.height($('body', print_frame.contents())[0].height);
            	//print_frame.height("100%");
            	print_frame.css("height","92%");
            });
            
            // Position modal            
            starting_position = $(window).height() + $(window).scrollTop();
            var css = {
                    top:         0,
                    height:      '92%',
                    overflowY:   'no',
                    zIndex:      10000,
                    display:     'block'
                }
            print_modal
                .css(css)
                .animate({ top: 0}, 400, 'linear', function() {
                //.animate({ top: $(window).scrollTop()}, 400, 'linear', function() {
                    print_controls.fadeIn('slow').focus();
                });
            //print_frame.height($('body', print_frame.contents())[0].scrollHeight);
            print_frame.css("height","92%");
            
			
            /*$('#print-modal-content').find('img').each(function() {
				var imgwidth = $(this).attr('width');
				if(imgwidth > 500){
					imgwidth = 500;
					$(this).attr('width',imgwidth);
				}
            });*/
			
			print_frame_ref.body.style.zoom=print_zoom;
			
            // Bind closure
            $('a', print_controls).bind('click', function(e) {
                e.preventDefault();
                if ($(this).hasClass('print_go')) { 
					//window.frames['print-frame'].focus(); 
                	if (browser_info.name=="Internet Explorer") {
                		/*var mywindow = window.open('', 'my div');
                		mywindow.document.write(document.getElementById("print-modal-content").contentWindow.document.innerHTML);
                		mywindow.document.close(); // IE >= 10에 필요
                		mywindow.focus(); // necessary for IE >= 10
                		mywindow.print();
                		mywindow.close();*/
                		var iframe_id = document.getElementById("print-modal-content");
                		var iframe_action = iframe_id.contentWindow || iframe_id.contentDocument;
                		//document.getElementById("print-modal-content").contentWindow.iframe_inner_print();
                		iframe_action.iframe_inner_print();
            		
                	}else{
    					document.getElementById("print-modal-content").contentWindow.focus();
    					document.getElementById("print-modal-content").contentWindow.print();
    					//window.frames["print-frame"].contentWindow.print();
    					//alert(document.frames['print-frame'].innerHTML);
                    	//print-modal  
    					/*var iframe = document.frames?document.frames['print-frame'] : document.getElementById('print-modal-content');
    					var frm = iframe.contentWindow || window;
    					// iframe.contentWindow 는 크롬용, window는 IE용.
    					iframe.focus();
    					frm.print();*/    					
                	}


					
				}else { $.printPreview.distroyPrintPreview(); }
            });
    	},
    	
    	distroyPrintPreview: function() {
    	    print_controls.fadeOut(100);
    	    /*print_modal.animate({ top: $(window).scrollTop() - $(window).height(), opacity: 1}, 400, 'linear', function(){
    	        print_modal.remove();
    	        $('body').css({overflowY: 'auto', height: 'auto'});
    	    });*/
    	    print_modal.animate({ top: 0, opacity: 1}, 400, 'linear', function(){
    	        print_modal.remove();
    	        $('body').css({overflowY: 'auto', height: 'auto'});
    	    });
    	    
    	    mask.fadeOut('slow', function()  {
    			mask.remove();
    		});				

    		$(document).unbind("keydown.printPreview.mask");
    		mask.unbind("click.printPreview.mask");
    		$(window).unbind("resize.printPreview.mask");
    		//alert($(""+print_obj_nm).offset().top+"::");
    		$('html, body').animate({scrollTop : $(""+print_obj_nm).offset().top}, 400);
	    },
	    
    	/* -- Mask Functions --*/
	    loadMask: function() {
	        size = $.printPreview.sizeUpMask();
	        //alert(850);
            mask = $('<div id="print-modal-mask" />').appendTo($('body'));
    	    mask.css({				
    			position:           'fixed', 
    			top:                0, 
    			left:               0,
    			width:              size[0],
    			height:             size[1],
    			display:            'none',
    			opacity:            0,					 		
    			zIndex:             9999,
    			backgroundColor:    '#000'
    		});
	
    		mask.css({display: 'block'}).fadeTo('400', 0.75);
    		
            $(window).bind("resize..printPreview.mask", function() {
				$.printPreview.updateMaskSize();
			});
			
			mask.bind("click.printPreview.mask", function(e)  {
				$.printPreview.distroyPrintPreview();
			});
			
			$(document).bind("keydown.printPreview.mask", function(e) {
			    if (e.keyCode == 27) {  $.printPreview.distroyPrintPreview(); }
			});
        },
    
        sizeUpMask: function() {
            if (browser_info.name=="Internet Explorer") {
            	// if there are no scrollbars then use window.height
            	var d = $(document).height(), w = $(window).height();
            	return [
            		window.innerWidth || 						// ie7+
            		document.documentElement.clientWidth || 	// ie6  
            		document.body.clientWidth, 					// ie6 quirks mode
            		d - w < 20 ? w : d
            	];
            } else { return [$(document).width(), $(document).height()]; }
        },
    
        updateMaskSize: function() {
    		var size = $.printPreview.sizeUpMask();
    		mask.css({width: size[0], height: size[1]});
        }
    }
})(jQuery);