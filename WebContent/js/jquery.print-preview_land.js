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
	var print_modal_width;
	// CmCommon.js함수 호출
	var browser_info = getBrowser();
	// Initialization
	$.fn.printPreview = function(obj_nm, obj_zoom, obj_width) {
		print_obj_nm = obj_nm;
		print_zoom = obj_zoom;
		print_modal_width = obj_width;
		this.each(function() {
			$(this).bind('click', function(e) {
			    e.preventDefault();
			    if (!$('#print-modal').length) {
			        $.printPreview.loadPrintPreview();
			    }
			});
		});
		return this;
	};
    
    // Private functions
    var mask, size, print_modal, print_controls;
    $.printPreview = {
        loadPrintPreview: function() {
            // Declare DOM objects
            print_modal = $('<div id="print-modal"></div>');
            print_controls = $('<div id="print-modal-controls">' + 
                                    '<a href="#" class="print_go" title="Print page">Print page</a>' +
                                    '<a href="#" class="print_close" title="Close print preview">Close</a>').hide();
            var print_frame = $('<iframe id="print-modal-content" scrolling="no" frameborder="0" name="print-frame" />');

            // Raise print preview window from the dead, zooooooombies
            print_modal
                .hide()
                .append(print_controls)
                .append(print_frame)
                .appendTo('body');

            //alert(print_modal_width);
            $("#print-modal").css('width',print_modal_width+'px');
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
                '<body></body>' +
                '</html>');
            print_frame_ref.close();
            
            // Grab contents and apply stylesheet
           // var $iframe_head = $('head link[media*=print], head link[media=all]').clone(),
            var $iframe_head = $("head link").clone(),
                $iframe_body = $(''+print_obj_nm+' > *:not(#print-modal):not(script)').clone();
			
            //var $iframe_head = $('head link').clone(),
            //    $iframe_body = $(''+print_obj_nm+' > *:not(#print-modal):not(script)').clone();	
			
            //var $iframe_head = $('head').clone();
            //var $iframe_body = $(print_obj_nm+' > *:not(#print-modal):not(script)').clone();
			
            $iframe_head.each(function() {
                $(this).attr('media', 'all');
            });
			
			var add_obj_nm = "";
			if(print_obj_nm.indexOf(".") > -1){
				add_obj_nm = " class='"+print_obj_nm.substring(print_obj_nm.indexOf(".")+1,print_obj_nm.length)+"' ";
			}else if(print_obj_nm.indexOf("#")  > -1){
				add_obj_nm = " id='"+print_obj_nm.substring(print_obj_nm.indexOf("#")+1,print_obj_nm.length)+"' ";
			}
			
			//alert(browser_info.name+"::"+browser_info.version);
            if (!browser_info.name=="Internet Explorer" && !(browser_info.version < 7) ) {
				//alert(1);
				//return;
                $('head', print_frame_ref).append($iframe_head);
				$('body', print_frame_ref).append("<div "+add_obj_nm+"></div>");
                $('body '+print_obj_nm, print_frame_ref).append($iframe_body);
				
            }else {
				//alert(2);
				$('body', print_frame_ref).append("<div "+add_obj_nm+"></div>");
                $(''+print_obj_nm+' > *:not(#print-modal):not(script)').clone().each(function() {
                    $('body '+print_obj_nm, print_frame_ref).append(this.outerHTML);
                });
                $('head link').each(function() {
                    $('head', print_frame_ref).append($(this).clone().attr('media', 'all')[0].outerHTML);
                });
            }
			
			
			//return;
            
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
            $('body').css({overflowY: 'hidden', height: '80%'});
            $('img', print_frame_ref).load(function() {
                print_frame.height($('body', print_frame.contents())[0].scrollHeight);
            });
            
            // Position modal            
            starting_position = $(window).height() + $(window).scrollTop();
            var css = {
                    top:         0,
                    height:      '80%',
                    overflowY:   'auto',
                    zIndex:      10000,
                    display:     'block'
                }
            print_modal
                .css(css)
                .animate({ top: 70}, 400, 'linear', function() {
                    print_controls.fadeIn('slow').focus();
                });
            //print_frame.height($('body', print_frame.contents())[0].scrollHeight);
            print_frame.height($(print_obj_nm).prop('scrollHeight')+50);
            //console.log($(print_obj_nm).prop('scrollHeight'));
			
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
	            		var iframe_id = document.getElementById("print-modal-content");
	            		var iframe_action = iframe_id.contentWindow || iframe_id.contentDocument;
	            		//document.getElementById("print-modal-content").contentWindow.iframe_inner_print();
	            		//iframe_action.iframe_inner_print();
	            		iframe_action.focus();
	            		iframe_action.print();   
                	}else{
    					document.getElementById("print-modal-content").contentWindow.focus();
    					document.getElementById("print-modal-content").contentWindow.print();                		
                	}

					//alert(document.frames['print-frame'].innerHTML);
				}else { 
					$.printPreview.distroyPrintPreview();
					printCloseFocus();
				}
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