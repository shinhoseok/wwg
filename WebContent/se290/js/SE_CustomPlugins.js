﻿// 에디터의 HTML 탭 확장 prototype
nhn.husky.SE_EditingArea_HTMLSrc.prototype.$ON_REGISTER_CONVERTERS = function() {
	this.oApp.exec("ADD_CONVERTER", ["HTMLSrc_TO_IR", jindo.$Fn(this.convertIr, this).bind()]);
};
// 에디터 HTML 탭에서 Editor나 TEXT 탭으로 이동할 경우 내용에 XSS 처리를 해준다.
nhn.husky.SE_EditingArea_HTMLSrc.prototype.convertIr = function(sIR) {
	var html = sIR;
	if (html != null) {
		//이 부분에 replace 처리를 해준다.
		//html = html.replace(/onerror/gi, '')
	}
	return html;
};
function SE_RegisterCustomPlugins(oEditor, elAppContainer, htParams) {
	if (htParams.isImage) oEditor.registerPlugin(new nhn.husky.SE_Image(elAppContainer));
	if (htParams.isMovie && _ISMOVIE == "true" && JSV.browser.msie) oEditor.registerPlugin(new nhn.husky.SE_Movie(elAppContainer));
}

/**
 * Image Upload Plugin
 */
nhn.husky.SE_Image = $Class({
	name : "SE_Image",

	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},

	_assignHTMLObjects : function(elAppContainer) {
		this.oImageButton = jindo.$$.getSingle("li.husky_seditor_ui_image", elAppContainer);
		this.oDropdownLayer = jindo.$$.getSingle("DIV.husky_seditor_image_layer", this.oImageButton);
		
		this.oLimitText = jindo.$$.getSingle("SPAN.help_text", this.oDropdownLayer);
		this.oUploadBtn = jindo.$$.getSingle("SPAN.upload_btn", this.oDropdownLayer);
		this.oFileList = jindo.$$.getSingle("UL.file_list", this.oDropdownLayer);
		
		this.oBtnConfirm = jindo.$$.getSingle("BUTTON.confirm", this.oDropdownLayer);
		this.oBtnCancel = jindo.$$.getSingle("BUTTON.cancel", this.oDropdownLayer);
		this.oCloseButton = jindo.$$.getSingle("BUTTON.close", this.oDropdownLayer);
		
		jindo.$$.getSingle("LI.image", elAppContainer).style.display = 'block';
	},
	
	$ON_MSG_APP_READY : function() {
		this.isFiles = false;
		
		this.oApp.registerBrowserEvent(this.oBtnConfirm, "mousedown", "APPLY_IMAGE");
		this.oApp.registerBrowserEvent(this.oBtnCancel, "mousedown", "CLOSE_IMAGE_LAYER");
		this.oApp.registerBrowserEvent(this.oCloseButton, "mousedown", "CLOSE_IMAGE_LAYER");
		this.currentSelection = null;

		this.oApp.exec("REGISTER_UI_EVENT", ["image", "click", "TOGGLE_IMAGE_LAYER"]);
		
		jQuery(this.oLimitText).html(_IMGLIMITTEXT);
		this.useFlash = jQuery.browser.flash;
		
		if (JSV.supportFileAPI) {
			// HTML5 FILE API 
			this._loadHTML5FileUploader(); 
		} else if (this.useFlash) {
			// SWFUPLOADER
			this._loadSwfFileUploadController();
		} else {
			// IFRAME FILE UPLOAD
			this._loadIfameFileUploadController();
		}
	},
	
	$ON_SHOW_ACTIVE_LAYER : function() {
		this.oApp.exec("CLOSE_IMAGE_LAYER", []);
	},
	
	$ON_TOGGLE_IMAGE_LAYER : function() {
		// IE 이미지 삽입 시 커서위치를 잃어버리는 버그 관련 수정
		// 2017.06.26 이정훈
		if(JSV.browser.msieEqualOrOver9) {
			this.currentSelection = this.oApp.getSelection().cloneRange();
		}
		if (this.oDropdownLayer.style.display == "none") {
			this.oApp.exec("SHOW_IMAGE_LAYER");
			//투명도 css 추가 css파일에 하거나 fileInput을 만들때 해당css를 주면 ie8에서 스마트에디터 높이가 0으로되는버그가있다.
			if (!(this.useFlash) && !(JSV.supportFileAPI)) {
				jQuery(this.fileInput).css({'filter':'alpha(opacity=0)', 'opacity':'0', 'position':'absolute'});
			}
		} else {
			this.oApp.exec("CLOSE_IMAGE_LAYER");
		}
	},
	
	$ON_SHOW_IMAGE_LAYER : function() {
		this.oApp.exec("HIDE_CURRENT_ACTIVE_LAYER", []);
		this.oDropdownLayer.style.display = "block";
		this.oApp.exec("POSITION_TOOLBAR_LAYER", [this.oDropdownLayer]);
		
		// IE 10이상, HTML5 사용 시 이미지 드래그 영역 출력
		if (JSV.browser.msieEqualOrOver10 || JSV.supportFileAPI) {
			this.statusDefault.show();
			this.listArea.hide();
		}
	},
	
	$ON_CLOSE_IMAGE_LAYER : function() {
		if (this.isFiles) {
			if (JSV.browser.msie) {
				if (confirm(_CLOSE_MSG)) 
					this._clearFiles();
			} else {
				this._clearFiles();
			}
		}
		this.oDropdownLayer.style.display = "none";
	},
	
	$ON_APPLY_IMAGE : function() {
		var _this = this;
		if (JSV.supportFileAPI) {
			var currIdx = 1;
			var resultImage = '';
			var resultFlag = false;
			jQuery.each(this.uploadFiles, function(idx, val) {
				var file = this;
				var progressDiv = jQuery('#' + idx +'-progress');
				progressDiv.parent().show();
				var fileItem = {'method':'editor', 'type':1, 'path':'com.kcube.jsv.file.', 'filename':'KCUBECONTENTIMAGEHIDDEN'+file.name, 'size':file.size};
				var formData = new FormData();
				formData.append('upload', JSV.toJSON(fileItem));
				formData.append('com.kcube.jsv.file.', file);
				jQuery.ajax({
					xhr: function() {
						var xhrobj = jQuery.ajaxSettings.xhr();
						if (xhrobj.upload) {
							xhrobj.upload.addEventListener('progress', function(e) {
								var nPerc = 0;
								var position = e.loaded || e.position;
								var total = e.total;
								if (e.lengthComputable) {
									nPerc = Math.ceil(position / total * 100);
								}
								progressDiv.width(nPerc);
							}, false);
						}
						return xhrobj;
					},
					url: _CONTEXT_PATH + '/jsl/UploadAction.DoUpload.jsl',
					dataType: 'html',
					data: formData,
					async: false,
					context: this,
					contentType: false,
					processData: false,
					type: 'POST',
					success: function (data) {
						if (!data) return;
						var key = '';
						var type = '';
						var id = '';
						var results = data.split('|');
						for (var i = 0; i < results.length; i++) {
							if (i == 0) {
								type = results[i];
							} else if (i == 1) {
								id = results[i];
							} else if (i == 2) {
								key = results[i];
							}
						}
						if (data) {
							var imgSrc = _CONTEXT_PATH + '/jsl/inline/ImageAction.Download/?key=' + key;							
							var images = _this._insertImageFileToEditor(imgSrc, type, id, file.name);
							progressDiv.width('100%');
						} else {
							alert(data.message);
						}

						_this.oApp.exec("FOCUS", []);
						_this.oSelection = _this.oApp.getSelection();
						
						 resultImage += images;
						 resultFlag = true;
						if (currIdx++ == _this.currCount) {
							_this._clearFiles();
							_this.oApp.exec("CLOSE_IMAGE_LAYER");
						}
					},
					error: function() {
						alert(_UNKNOWN);
						delete _this.uploadFiles[idx];
					}
				});
			});
			if(resultFlag) {
				// IE 이미지 삽입 시 커서위치를 잃어버리는 버그 관련 수정
				// 2017.06.26 이정훈
				if(JSV.browser.msieEqualOrOver9) {
					_this.currentSelection.pasteHTML(resultImage);
				} else {
					_this.oSelection.pasteHTML(resultImage);
				}
			}
		} else if (this.useFlash) {
			this.swfUploader.startUpload();
		} else {
			if (this.preCount > 0) {
				this.onIframeQueueComplete();
			}
		}
	},
	
	_clearFiles : function() {
		if (JSV.supportFileAPI) {
			this.uploadFiles = {};
			this.currCount = 0;
			jQuery('body').find('ul.file_list').empty();
		} else if (this.useFlash) {
			for (var i=0; i < this.swfUploader.preCount; i++) {
				this.swfUploader.cancelUpload();
			}
			this.swfUploader.preCount = 0;
			jQuery(this.swfUploader.fileListArea).empty();
		} else {
			this.preCount = 0;
			jQuery(this.fileListArea).empty();
			
			//첨부파일 업로드 후 취소 눌렀을 시 해당 데이터 초기화
			this.sImages = "";
			this.arr = [];
		}
		this.isFiles = false;
	},

	_loadHTML5FileUploader : function() {
		var btnObjectId = this.oApp.elPlaceHolder.id + '_fileUpload';
		var oTmp = document.createElement('SPAN');
		oTmp.id = btnObjectId;
		this.oUploadBtn.appendChild(oTmp);
		this.dropNum = 0;

		var _this = this;
	    this.currCount = 0;
		this.seq = 0;
		this.uploadFiles = {};
		var inputStyle = {'accept':'image/*', 'type':'file', 'multiple':'multiple'};
		var fileInput = jQuery('<input>').attr(inputStyle).appendTo(oTmp).hide();
		var uploadBtn = new KButton(document.getElementById('upload_btn'), {'text':_BTNTEXT, 'title':_BTNTEXT, 'className':'H24'});
		uploadBtn.onclick = function() {
			_this.isAlert = false;
			fileInput.val('').click();
		}
		fileInput.change(function(e) {
			var selectFiles = e.target.files;
			for (var i = 0; i < selectFiles.length; i++) {
				var file = selectFiles[i];
				var filename = file['name'];
				var ext = (filename.lastIndexOf('.') > -1) ? filename.substring(filename.lastIndexOf('.') + 1).toLowerCase() : null;
				var allowFileExt = 'gif,jpg,jpeg,bmp,png,ico';
				if (!allowFileExt.find(ext)) {
					alert('[' + file['name'] + '] \n' + _INVALID_FILETYPE);
					return ;
				}
				if (file['size'] == 0) {
					alert(_ZERO_BYTE_FILE);
					return ;
				}
				if (_IMGFILESIZE * 1024 < file['size']) {
					alert('[' + file['name'] + '] \n' + _FILE_EXCEEDS_SIZE_LIMIT);
					return ;
				}
				_this.onSelect(file);
				_this.isFiles = true;
			}
		});
		
		// IE10 이상 & HTML5 사용 시 이미지 기존 이미지 삽입 박스를 숨기고 드래그 영역을 출력한다.
		if (JSV.browser.msieEqualOrOver10 || JSV.supportFileAPI) {
			this.statusDefault = jQuery('body').find('div.statusDefault');
			this.listArea = jQuery('body').find('div.list_area');
			this.listArea.hide();
			
			function ignoreDrag(e) {
				e.preventDefault();	
			}
			function stopPropagation(e){
			    if(e.stopPropagation){
			        e.stopPropagation();
			    }else{
			        e.cancelBubble = true;
			    }
			}
			// 이미지 드래그 영역 클릭 시 파일업로드 실행
			this.statusOn = jQuery('body').find('div.statusOn').first();
			jQuery(this.statusOn).on('click', this, function(e) {			
				if(JSV.supportFileAPI) {
					_this.isAlert = false;
					fileInput.val('').click();
				}
			});
			// 이미지 영역 내에 드래그 진입 시 드래그 표시영역 출력
			this.statusDrag = jQuery('body').find('div.statusDrag');
			jQuery(this.statusDefault).on('dragenter', this, function(e) {
				if(e.data.statusDefault.css('display') == 'block') {
					e.data.statusDrag.show();
					e.data.statusDefault.hide();
					ignoreDrag(e);
					stopPropagation(e);
				}
			});
			// 이미지 영역 내에 드래그 나올시 드래그 표시영역 원복
			jQuery(this.statusDrag).on('dragleave', this, function(e){
				if(e.data.statusDefault.css('display') == 'none') {
					e.data.statusDrag.hide();
					e.data.statusDefault.show();
					ignoreDrag(e);
					stopPropagation(e);
				}
			});
			// 드래그 표시영역에 파일 드랍 시 파일업로드 처리 및 드래그 표시영역 숨김 처리
			jQuery(this.statusDrag).on('dragover', ignoreDrag).on('drop', this, function(e) {
				if(e.data.statusDefault.css('display') == 'none') {
					_this.isAlert = false;
					_this.selectHandler(e.originalEvent.files || e.originalEvent.dataTransfer.files);
					stopPropagation(e);
					ignoreDrag(e);
					// 최초 드래그앤드랍이 실패할 시(파일갯수 0) 드래그영역을 출력
					if(e.data.currCount == 0) { 
						e.data.statusDefault.show();
						stopPropagation(e);
						ignoreDrag(e);
					}
					e.data.statusDrag.hide();
					// Drop을 했는지 여부를 true값 부여
					_this.isDrop = true;
					_this.dropNum++;
				}
				stopPropagation(e);
				ignoreDrag(e);
			});
			// IE10 이상 & HTML5 사용 시 웹에디터 이미지 삽입박스 내 드래그앤드랍으로 이미지를 업로드
			jQuery(this.oFileList).on({'dragover':ignoreDrag}).on('drop', this, function(e) {
				ignoreDrag(e);
				_this.isAlert = false;
				_this.selectHandler(e.originalEvent.files || e.originalEvent.dataTransfer.files);
			});
		}
		
		// 이미지 삽입 영역 내 마우스오버 이벤트 처리
		jQuery(this.statusDefault).on('mouseenter', this, function(e){ // 마우스 진입 시
			// IE 전용
			if(_this.dropNum > 0 && JSV.browser.msie) {
				jQuery(this).hide().next().show();
				_this.dropNum = 0;
				return ;
			}
			// 크롬 전용
			if(_this.dropNum == 1 && !JSV.browser.msie) {
				jQuery(this).show();
				_this.isDrop = false;
			}
			// 크롬 전용
			if(_this.dropNum > 1 && !JSV.browser.msie) {
				jQuery(this).show();
				_this.dropNum = 1;
				_this.isDrop = false;
				return false ;
			}
			
			if (!_this.isDrop) {
				jQuery(this).hide().next().show();
			}
			_this.isDrop = false;
		}).next().on('mouseleave', this, function(e){			 	// 마우스 나갈 시
			jQuery(this).hide();
			if(e.data.currCount == 0) {
				jQuery(this).prev().show();
				ignoreDrag(e);
			}
		});
		// 드래그앤드랍으로 이미지 업로드 시 파일의 확장자, 사이즈, 업로드 갯수를 체크한다.
		this.selectHandler = function(files) {
			if (files) {
				for (var i = 0; i < files.length; i++) {
					var file = files[i];
					var filename = file['name'];
					var ext = (filename.lastIndexOf('.') > -1) ? filename.substring(filename.lastIndexOf('.') + 1).toLowerCase() : null;
					var allowFileExt = 'gif,jpg,jpeg,bmp,png,ico';
					if (!allowFileExt.find(ext)) {
						alert('[' + file['name'] + '] \n' + _INVALID_FILETYPE);
						return ;
					}
					if (file['size'] == 0) {
						alert(_ZERO_BYTE_FILE);
						return ;
					}
					if (_IMGFILESIZE * 1024 < file['size']) {
						alert('[' + file['name'] + '] \n' + _FILE_EXCEEDS_SIZE_LIMIT);
						return ;
					}
					_this.onSelect(file);
					_this.isFiles = true;
				}
			}
		}

		this.onSelect = function(file) {
			var oldCount = this.getEditorInstImgCnt();
			if ((oldCount + (++this.currCount)) > (_IMGCOUNT)) {
				if (!this.isAlert) {
					alert(_FILECOUNTLIMIT_MSG);
				}
				this.currCount--;
				this.isAlert = true;
				return false;
			}

			var itemId = this.oApp.elPlaceHolder.id + '_HTML5_' + this.seq++;
			var li = document.createElement("LI");
			li.id = "file-" + itemId;
	
			var filename = file["name"];
			var charlength = filename.length;
			var maxLength = 30;
			
			for (var j = 0; j < filename.length; j++) {
				if (filename.substr(j,1).charCodeAt() >= 256) {
					charlength++;
					maxLength--;
				}
			}
			if (charlength > maxLength) filename = filename.substr(0, maxLength) + '..';
	
			var divLeft = document.createElement("DIV");
			divLeft.innerHTML = filename;
			divLeft.className = "div_left";
			li.appendChild(divLeft);
	
			var span = document.createElement("SPAN");
			span.className = "capacity";
			var sizes = ['B', 'KB', 'MB', 'GB'];
			var size = file["size"];
			var i = 0;
			while (size >= 1024 && i + 1 < sizes.length) {
			    i++;
			    size = size / 1024;
			}
			span.innerHTML = '(' + Math.ceil(size) + sizes[i] + ')';
			divLeft.appendChild(span);
			
			var div = document.createElement("DIV");
			div.id = 'file-' + itemId + '-option';
			div.className = 'cancel_button';
			li.appendChild(div);
			
			var anchor = document.createElement("A");
			anchor.href ='#';
			anchor.innerHTML = 'Cancel';
			anchor.onclick = function() {
				jQuery('<span>').text('FILE CANCELLED').appendTo(div);
				delete _this.uploadFiles[jQuery(this).closest('li').attr('id')];
				_this.currCount--;
				jQuery(this).remove();
				return false;
			}
			div.appendChild(anchor);
	
			var graphdiv = document.createElement("DIV");
			graphdiv.className = 'graph';
			graphdiv.style.display = 'none';
			li.appendChild(graphdiv);
			
			var progressDiv = document.createElement('DIV');
			progressDiv.id = 'file-' + itemId + '-progress';
			graphdiv.appendChild(progressDiv);
	
			var img = document.createElement('IMG');
			img.src = _CONTEXT_PATH + '/lib/com/kcube/jsv/editors/se290/img/multifile_fill.gif';
			img.alt = 'Upload Complete';
			progressDiv.appendChild(img);
			
			jQuery('body').find('ul.file_list').append(li);
			this.uploadFiles['file-' + itemId] = file;
			
			// 이미지업로드 성공 후 드래그 영역 숨김 처리 및 파일리스트 영역 출력
			if (JSV.browser.msieEqualOrOver10 || JSV.supportFileAPI) {
				jQuery('body').find('div.statusDefault').hide();
				jQuery('body').find('div.list_area').show();
			}
		}

		this.getEditorInstImgCnt = function() {
			var cnt = 0;
			var images = this.oApp.getWYSIWYGDocument().getElementsByTagName('img');
			jQuery(images).each(function() {
				var method = jQuery(this).attr('method');
				if (method && method.indexOf('KC_IMAGE') > -1) {
					cnt++;
				}
			});
			return cnt;
		}
	},

	_loadSwfFileUploadController : function() {
		var btnObjectId = this.oApp.elPlaceHolder.id + '_fileUpload';
		var oTmp = document.createElement('SPAN');
		oTmp.id = btnObjectId;
		this.oUploadBtn.appendChild(oTmp);
		
		// EditorSkin.en.jsp, EditorSkin.ko.jsp 다국어 처리를 위해서 기존 SPAN 태그에 id 와 title 추가
		var upload_btn = document.getElementById('upload_btn').getAttribute('title');
		
		var settings = {
			flash_url : _CONTEXT_PATH + "/sys/jsv/swfupload/Flash/swfupload.swf",
			flash9_url : _CONTEXT_PATH + "/sys/jsv/swfupload/Flash/swfupload_fp9.swf",
			upload_url: this.oApp.cstmParams["uploadTarget"],
			file_post_name : "com.kcube.jsv.file.",
			file_types : "*.gif;*.jpg;*.jpeg;*.bmp;*.png;*.ico;",
			file_types_description : "Images",
			file_upload_limit : 0,
			file_size_limit : (_IMGFILESIZE > 0) ? _IMGFILESIZE : 0,
			debug: false,
			
			//Button settings
			button_placeholder_id: btnObjectId,
			button_image_url: _CONTEXT_PATH + "/img/btn/doc/btn25_swf.gif",
			button_width: "70",
			button_height: "25",
			button_text_left_padding: "0",
			button_text_top_padding: "4",
			button_text: '<span class="theFont">' + upload_btn +'</span>',
			button_cursor: -2,
			button_text_style: ".theFont {text-align:center;font-size:12px;font-family:dotum,Arial;padding:0px 12px;letter-spacing:-1px;box-sizing:border-box;font-weight:bold;color:#565960;}",
			
			//The event handler
			// The event handler functions are defined in handlers.js
			swfupload_loaded_handler : this._fileUploadListener.onReady, 
			file_dialog_start_handler : this._fileUploadListener.onSelectStart, 
			file_queued_handler : this._fileUploadListener.onSelect,
			file_queue_error_handler : this._fileUploadListener.onSelectError,
			file_dialog_complete_handler : this._fileUploadListener.onSelectComplete,
			upload_start_handler : this._fileUploadListener.onUploadStart,
			upload_progress_handler : this._fileUploadListener.onProgress,
			upload_error_handler : this._fileUploadListener.onUploadError,
			upload_success_handler : this._fileUploadListener.onSuccess,
			upload_complete_handler : this._fileUploadListener.onComplete,
			queue_complete_handler : this._fileUploadListener.onQueueComplete
		};
		
		this.swfUploader = new SWFUpload(settings);
		jQuery.data(this.swfUploader, 'component', this);
	},
	
	_loadIfameFileUploadController : function(){
		var btnObjectId = this.oApp.elPlaceHolder.id+'_fileUpload';
		var oTmp = document.createElement('SPAN');
		oTmp.id = btnObjectId;
		this.oUploadBtn.appendChild(oTmp);
		
		// iframe의 name이자, form의 target
	    this.target_name = 'iframe_upload';
	    this.filesItem;
	    this.fileids;
	    this.idcount = 0;
	    var uploadAction = _CONTEXT_PATH + '/jsl/UploadAction.DoUpload.jsl';

	    //nobr, div, form, input 생성
		this.nobr = jQuery('<nobr>').addClass('nobrform').attr('id', 'nobrform').appendTo(jQuery('#'+btnObjectId));
		this.inputArea = jQuery('<div>').addClass('uploadInputArea').appendTo(this.nobr);
    	this.$form = jQuery('<form name="uploadfile" id="uploadfile" action="'+ uploadAction +'" method="POST" enctype="multipart/form-data" target="'+ this.target_name +'">\
							</form>').appendTo(this.inputArea);
    	this.fileInput = jQuery('<input>').addClass('upfile').attr({type:'file', enctype:'multipart/form-data', id:'upfile',  name:'com.kcube.jsv.file.'}).appendTo(this.$form);
    	this.fileBtn = jQuery('<input>').addClass('fileBtn').attr({type:'button', value:jQuery('#upload_btn').attr('title')}).appendTo(this.inputArea);

    	this.onIfameReady = function(){
			this.fileListArea = this.oFileList;
			if (this.arr == undefined)
				this.arr =[];
			this.sImages = "";
			this.preCount = 0;
		}
    	
    	this.onIframeSelectStart = function(file){
			this.totalFileCount = 0;
			var itemid = this.oApp.elPlaceHolder.id + "_" + file["id"];
			var oldCount = 0;
			if (this.preCount == undefined)
				this.preCount = 0;
			this.preCount++;
			
			var images = this.oApp.getWYSIWYGDocument().getElementsByTagName('img');
			jQuery(images).each(function() {
				var method = jQuery(this).attr('method');
				if (method && method.indexOf('KC_IMAGE') > -1) {
					oldCount++;
				}
			});
			this.totalFileCount = oldCount + this.preCount;
		}
		
    	this.onIframeSelect = function(file){
			var itemid = this.oApp.elPlaceHolder.id + "_" + file["id"];
			
			var li = document.createElement("LI");
			li.id = "file_" + itemid;
	
			var filename = file["name"];
			var charlength = filename.length;
			var maxLength = 30;
			
			for (var j = 0; j < filename.length; j++){
				if (filename.substr(j,1).charCodeAt() >= 256) {
					charlength++;
					maxLength--;
				}
			}
			if (charlength > maxLength) filename = filename.substr(0, maxLength) + '..';
	
			var divLeft = document.createElement("DIV");
			divLeft.innerHTML = filename;
			divLeft.className = "div_left";
			li.appendChild(divLeft);
	
			var span = document.createElement("SPAN");
			span.className = "capacity";
			var sizes = ['B', 'KB', 'MB', 'GB'];
			var size = file["size"];
			var i = 0;
			while (size >= 1024 && i + 1 < sizes.length) {
			    i++;
			    size = size / 1024;
			}
			span.innerHTML = '(' + Math.ceil(size) + sizes[i] + ')';
			divLeft.appendChild(span);
			
			var div = document.createElement("DIV");
			div.id = 'file-' + itemid + '-option';
			div.className = 'cancel_button';
			li.appendChild(div);
			
			var anchor = document.createElement("A");
			anchor.href ='#';
			anchor.innerHTML = 'Cancel';
			anchor.component = this;
			anchor.onclick = function() {
				var index = jQuery('a').index(this);
				this.component.arr.splice(index-1, 1);
				this.component.preCount--;
				jQuery('#file_' + itemid).remove();
				return false;
			}
			div.appendChild(anchor);
	
			var graphdiv = document.createElement("DIV");
			graphdiv.className = 'graph';
			graphdiv.style.display = 'none';
			li.appendChild(graphdiv);
			
			var progressDiv = document.createElement('DIV');
			progressDiv.id = 'file-' + itemid + '-progress';
			graphdiv.appendChild(progressDiv);
	
			var img = document.createElement('IMG');
			img.src = _CONTEXT_PATH + '/lib/com/kcube/jsv/editors/se290/img/fileloadingbar.gif';
			img.alt = 'Upload Complete';
			progressDiv.appendChild(img);
			this.fileListArea.appendChild(li);
		}
    	
    	this.onIframeSelectError = function (file, errorCode, message) {
			try {
				var errorName = "";
				switch (errorCode) {
				case 'queue_limit_exceeded':
					errorName = _FILECOUNTLIMIT_MSG;
					break;
				case 'file_exceeds_size_limit':
					errorName = _FILE_EXCEEDS_SIZE_LIMIT;
					break;
				case 'zero_byte_file':
					errorName = _ZERO_BYTE_FILE;
					break;
				case 'invalid_filetype':
					errorName = _INVALID_FILETYPE;
					break;
				default:
					errorName = _UNKNOWN;
					break;
				}
				if (errorName != ""){
					alert(errorName);
				}
			} catch (ex) {
				log.error(ex);
			}
		}
		
    	this.getFileName = function(str) {
			if (str != null) {
				var i = str.lastIndexOf("\\");
				return (i < 0) ? str : str.substring(i + 1);
			}
			return null;
		},
		
		this.onIframeSuccess = function(file, serverData){
			var itemid = this.oApp.elPlaceHolder.id + "_" + file["id"];

			if (!serverData) return;
			var key = '';
			var type = '';
			var id = '';
			var size = '';
			var results = serverData.split('|');
			for (var i = 0; i < results.length; i++) {
				switch(i) {
					case 0 :
						type = results[i];
					case 1 :
						id = results[i];
					case 2 :
						key = results[i];
					case 3 :
						size = results[i];
				}
			}
			var imgSrc = _CONTEXT_PATH + '/jsl/inline/ImageAction.Download/?key=' + key;

			if (serverData) {
				this.arr.push(this._insertImageFileToEditor(imgSrc, type, id, file.name));
			} else {
				alert(data.message);
			}
		},
		
		this.onIframeQueueComplete = function(){
			if (!this.isError) {
				if (this.arr != undefined && this.arr != null){
					for (var i = 0; i < this.arr.length; i++) {
						this.sImages += this.arr[i];
					}					
				}
				this.oApp.exec("FOCUS", []);
				this.oSelection = this.oApp.getSelection();
				if (this.sImages != undefined && this.sImages != null)
					this.oSelection.pasteHTML(this.sImages);
				this.isFiles = true;
				
				this._clearFiles();
				this.sImages = "";
				this.arr = [];+
				this.oApp.exec("CLOSE_IMAGE_LAYER");
				
				setTimeout($Fn(function(){this.oSelection.select()}, this).bind(this), 0);
			}
		}
		
    	this.onIfameReady();
    	
    	//첨부파일이 바뀔때 일어나는 이벤트
    	this.fileInput.on('change', this, function(e) {
    		var iframe = jQuery('<iframe id="iframe" src="javascript:false;" name="'+ e.data.target_name +'" + style="display:none;"></iframe>');
    		jQuery('body').append(iframe);

    		e.data.fileids = "IFRAMEUpload_0_" + e.data.idcount++;
    		var filename = e.data.getFileName(e.target.value);
			var imageItem = {'method':'editor', 'type':1, 'path':'com.kcube.jsv.file.', 'filename':'KCUBECONTENTIMAGEHIDDEN'+filename};
			var noSupported = '/gif,jpg,jpeg,bmp,png,ico/';
			
			var lastdot = filename.lastIndexOf('.');
			var fileext = filename.substring(lastdot + 1, filename.length).toLowerCase();
			
			var fileObjs = new Object();
			fileObjs.id = e.data.fileids;
			fileObjs.name = filename;
			fileObjs.type = fileext;
			fileObjs.size = 0;

			e.data.onIframeSelectStart(fileObjs);
			var unitMaxSize = Math.ceil(_IMGFILESIZE * 1024);
			var form = e.data.$form.get(0);
			
			// 서버로 보내줄 제한값 파라미터를 배열에 담는다. 이벤트가 끝난뒤 해당배열에서 직접빼서 제거한다.(제거하지않으면 쌓인다)
			var parameter = [
			                 	jQuery('<input type="hidden" name="fileSizeLimit">').val(unitMaxSize).appendTo(form),
			                 	jQuery('<input type="hidden" name="upload">').val(JSV.toJSON(imageItem)).appendTo(form)
			                ];
			
			e.data.$form.target = e.data.target_name;
		
			//클라이언트 체크(확장자, 파일갯수)
			var submit = false; 
			if (noSupported.indexOf(fileext) < 0) {
				submit = false;
				--e.data.preCount;
				e.data.onIframeSelectError(fileObjs, 'invalid_filetype');
			}
			else if (_IMGCOUNT > 0 && e.data.totalFileCount > _IMGCOUNT) {
				submit = false;
				--e.data.preCount;
				e.data.onIframeSelectError(fileObjs, 'queue_limit_exceeded');
			}
			else {
				submit = true;
				e.data.onIframeSelect(fileObjs);
				jQuery('#file_' + e.data.oApp.elPlaceHolder.id + '_' + fileObjs["id"]).children('.graph').css({'background':'none', 'display':'block'});
    			jQuery('#file-' + e.data.oApp.elPlaceHolder.id + '_' + fileObjs["id"] + '-progress').width('100%');
    			jQuery('#file-' + e.data.oApp.elPlaceHolder.id + '_' + fileObjs["id"] + '-option').css('display', 'none');
			}
			
			if (submit) {
			//iframe로드
				iframe.on('load.fileUploadIframe', {component : e.data}, function(e) {
					//서버에서 돌려받은 리스폰스 데이터 결과값.
					var result = this.contentWindow.document.documentElement.innerText ? this.contentWindow.document.documentElement.innerText : this.contentWindow.document.body.innerText;
		        	
		        	//object 생성
		        	var results = result.split('|');
	        		var size = results[3];	//파일사이즈
	    			var filename = e.data.component.filesItem.name;
	    			var lastdot = filename.lastIndexOf('.');
	    			var fileext = filename.substring(lastdot, filename.length).toLowerCase();
					
	    			var fileObj = new Object();
						fileObj.id = e.data.component.filesItem.id;
						fileObj.type = fileext;
						fileObj.name = filename;
						fileObj.size = size;
	    			
					jQuery("#file_" + e.data.component.oApp.elPlaceHolder.id + "_" + fileObj["id"]).remove();
					
					//result 에러일 경우 error메세지를 띄워주며, 파일갯수-1, error가 아니고 레이어창이 열려있을때 이미지태그를만든다.
		        	if (result != null && result.indexOf("error") != -1) {
		        		//오류시 에러코드가지고 alert, 파일갯수 카운트 preCount--
		        		var errorCode = size > e.data.component.unitMaxSize ? 'file_exceeds_size_limit' : 'unknown' 
		        		e.data.component.onIframeSelectError(fileObj, errorCode);
		        		e.data.component.preCount--;
		        	} else if (jQuery('.husky_seditor_image_layer').css('display') == 'block') {
		        		e.data.component.onIframeSelect(fileObj);
		        		e.data.component.onIframeSuccess(fileObj, result);
		        		e.data.component.isFiles = true;
		        	}
		        	//submit 완료후 readonly 해제
		        	e.data.component.fileInput.removeProp('readonly');
					//submit 완료후 확인 버튼은 disabled 해제
					jQuery('.husky_seditor_image_layer').children('.btn_area').children('.confirm').removeAttr('disabled');
					iframe.remove();
				});
				
				e.data.filesItem = fileObjs;
				//submit 되는순간부터 파일 업로드 완료되기 전까지 input은 readonly처리
				e.data.fileInput.prop('readonly', true);
				//submit 되는순간부터 파일 업로드 완료되기 전까지 확인 버튼은 disabled처리
				jQuery('.husky_seditor_image_layer').children('.btn_area').children('.confirm').attr('disabled','disabled');
				//submit
				e.data.$form.submit();
			}
			else{
				iframe.remove();
			}
			
	    	// input 초기화 - 기존input의 이벤트까지 복사한다.
			e.data.fileInputClone = e.data.fileInput.clone(true);
	    	// input 초기화 - 기존 input제거
	    	e.data.fileInput.remove();
	    	// input 초기화 - $form에 input 추가
	    	e.data.fileInput = e.data.fileInputClone.appendTo(e.data.$form);

	    	// input 파라미터 제거
	    	for (var i = 0; i < parameter.length; i++) {
	    		parameter[i].remove();
			}
	    	
    	});

    	
	},
	
	_fileUploadListener : {
		onReady : function() {
			var component = jQuery.data(this, 'component');
			this.fileListArea = component.oFileList;
			this.preCount = 0;
		},
			
		onSelectStart : function() {
		},
		
		onSelect : function(file) {
			var component = jQuery.data(this, 'component');
			var itemid = component.oApp.elPlaceHolder.id + '_' + file['id'];
			var oldCount = 0;
			this.preCount++;
			
			var images = component.oApp.getWYSIWYGDocument().getElementsByTagName('img');
			jQuery(images).each(function() {
				var method = jQuery(this).attr('method');
				if (method && method.indexOf('KC_IMAGE') > -1) {
					oldCount++;
				}
			});
			
			if ((oldCount + this.preCount) > (_IMGCOUNT)) {
				if (!this.isAlert) {
					alert(_FILECOUNTLIMIT_MSG);
				}
				this.preCount--;
				this.isAlert = true;
				this.cancelUpload(file['id']);
				return false;
			}
			
			var li = document.createElement("LI");
			li.id = "file_" + itemid;
	
			var filename = file["name"];
			var charlength = filename.length;
			var maxLength = 30;
			
			for (var j = 0; j < filename.length; j++) {
				if (filename.substr(j,1).charCodeAt() >= 256) {
					charlength++;
					maxLength--;
				}
			}
			if (charlength > maxLength) filename = filename.substr(0, maxLength) + '..';
	
			var divLeft = document.createElement("DIV");
			divLeft.innerHTML = filename;
			divLeft.className = "div_left";
			li.appendChild(divLeft);
	
			var span = document.createElement("SPAN");
			span.className = "capacity";
			var sizes = ['B', 'KB', 'MB', 'GB'];
			var size = file["size"];
			var i = 0;
			while (size >= 1024 && i + 1 < sizes.length) {
			    i++;
			    size = size / 1024;
			}
			span.innerHTML = '(' + Math.ceil(size) + sizes[i] + ')';
			divLeft.appendChild(span);
			
			var div = document.createElement("DIV");
			div.id = 'file-' + itemid + '-option';
			div.className = 'cancel_button';
			li.appendChild(div);
			
			var anchor = document.createElement("A");
			anchor.href ='#';
			anchor.innerHTML = 'Cancel';
			anchor.onclick = function() {
				this.preCount--;
				component.swfUploader.cancelUpload(file['id']);
				return false;
			}
			div.appendChild(anchor);
	
			var graphdiv = document.createElement("DIV");
			graphdiv.className = 'graph';
			graphdiv.style.display = 'none';
			li.appendChild(graphdiv);
			
			var progressDiv = document.createElement('DIV');
			progressDiv.id = 'file-' + itemid + '-progress';
			graphdiv.appendChild(progressDiv);
	
			var img = document.createElement('IMG');
			img.src = _CONTEXT_PATH + '/lib/com/kcube/jsv/editors/se290/img/multifile_fill.gif';
			img.alt = 'Upload Complete';
			progressDiv.appendChild(img);
			
			this.fileListArea.appendChild(li);
		},
		
		onSelectError : function (file, errorCode, message) {
			try {
				var errorName = "";
				switch (errorCode) {
				case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
					errorName = _FILECOUNTLIMIT_MSG;
					break;
				case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
					errorName = _FILE_EXCEEDS_SIZE_LIMIT;
					break;
				case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
					errorName = _ZERO_BYTE_FILE;
					break;
				case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
					errorName = _INVALID_FILETYPE;
					break;
				default:
					errorName = _UNKNOWN;
					break;
				}
				if (errorName != "") {
					alert(errorName);
				}
			} catch (ex) {log.error(ex);}
		},
		
		onSelectComplete: function(selectedFiles, successFiles, totalFiles) {
			var component = jQuery.data(this, 'component');
			this.sImages = "";
			if (successFiles > 0) {
				component.isFiles = true;
			}
		},
		
		onUploadStart: function(file) {
			var component = jQuery.data(this, 'component');
			var itemid = component.oApp.elPlaceHolder.id + '_' + file['id'];
			
			$('file-' + itemid + '-progress').parentNode.style.display = 'block'
			$('file-' + itemid + '-option').style.display = 'none'
			var filename = 'KCUBECONTENTIMAGEHIDDEN'+file.name;
			var imageItem = '{"method":"editor", "type":1, "path":"com.kcube.jsv.file.", "filename":"' + filename + '", "size":"' + file.size + '"}';
			this.addPostParam('upload', imageItem);
		},
		
		onProgress: function(file, bytesLoaded, bytesTotal) {
			var component = jQuery.data(this, 'component');
			var itemid = component.oApp.elPlaceHolder.id + '_' + file['id'];
			
			var nPerc = bytesLoaded / bytesTotal * 100;
			$('file-' + itemid + '-progress').style.width = nPerc + '%';
		},
		
		onUploadError: function(file, errorCode, message) {
			if (errorCode != SWFUpload.UPLOAD_ERROR.FILE_CANCELLED)
				this.isError = true;
			try {
				var errorName = "";
				switch (errorCode) {
				case SWFUpload.UPLOAD_ERROR.HTTP_ERROR:
					errorName = "HTTP ERROR";
					break;
				case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
					errorName = "MISSING UPLOAD URL";
					break;
				case SWFUpload.UPLOAD_ERROR.IO_ERROR:
					errorName = "IO ERROR";
					break;
				case SWFUpload.UPLOAD_ERROR.SECURITY_ERROR:
					errorName = "SECURITY ERROR";
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
					errorName = "UPLOAD LIMIT EXCEEDED";
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_FAILED:
					errorName = "UPLOAD FAILED";
					break;
				case SWFUpload.UPLOAD_ERROR.SPECIFIED_FILE_ID_NOT_FOUND:
					errorName = "SPECIFIED FILE ID NOT FOUND";
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_VALIDATION_FAILED:
					errorName = "FILE VALIDATION FAILED";
					break;
				case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
					errorName = "FILE CANCELLED";
					break;
				case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
					errorName = "FILE STOPPED";
					break;
				default:
					errorName = "UNKNOWN";
					break;
				}
				
				var component = jQuery.data(this, 'component');
				var itemid = component.oApp.elPlaceHolder.id + '_' + file['id'];
				var div = $('file-' + itemid + '-option');
				if (!div) return ;
				div.style.display = "block"
				div.innerHTML = "";
				if ($('file-' + itemid + '-progress')) $('file-' + itemid + '-progress').parentNode.style.display ="none";
				var sError = document.createElement("SPAN");
				sError.className = 'error font-variation';
				sError.innerHTML = (errorName)? errorName:'Error';
				div.appendChild(sError);
				
			} catch (ex) {
				log.error(ex);
			}
			
		},
		
		onSuccess : function(file, serverData) {
			var component = jQuery.data(this, 'component');
			var itemid = component.oApp.elPlaceHolder.id + '_' + file['id'];
			
			if (!serverData) return;
			var key = '';
			var type = '';
			var id = '';
			var results = serverData.split('|');
			for (var i = 0; i < results.length; i++) {
				if (i == 0) {
					type = results[i];
				} else if (i == 1) {
					id = results[i];
				} else if (i == 2){
					key = results[i];
				}
			}
			var imgSrc = _CONTEXT_PATH + '/jsl/inline/ImageAction.Download/?key=' + key;
			if (serverData) {
				this.sImages += component._insertImageFileToEditor(imgSrc, type, id, file.name);
				$('file-' + itemid + '-progress').style.width = '100%';
			} else {
				alert(data.message);
			}
		},
		
		onQueueComplete : function(numFilesUploaded) {
			var component = jQuery.data(this, 'component');
			
			if (!this.isError) {
				component.oApp.exec("FOCUS", []);
				component.oSelection = component.oApp.getSelection();
				component.oSelection.pasteHTML(this.sImages);
				
				component._clearFiles();
				component.oApp.exec("CLOSE_IMAGE_LAYER");
				
				setTimeout($Fn(function() {component.oSelection.select()}, component).bind(component), 0);
			}
		}
	},
	
	_insertImageFileToEditor : function(filePath, type, id, alt) {
		return "<img src='" + filePath + "' type='" + type + "' alt='"+ alt +"' method='KC_IMAGE_UPLOAD' path='"+ id +"'/><p>&nbsp;</p>";
	}
});

/**
 * Movie Upload Plugin
 */ 
nhn.husky.SE_Movie = $Class({
		name : "SE_Movie",

		$init : function(elAppContainer) {
			this._assignHTMLObjects(elAppContainer);
		},
		
		_assignHTMLObjects : function(elAppContainer) {
			cssquery.getSingle("LI.movie", elAppContainer).style.display = 'block';
		},
		
		$ON_MSG_APP_READY : function() {
			this.oApp.exec("REGISTER_UI_EVENT", ["movie", "click", "SE_OPEN_MOVIE_POPUP"]);
		},
		
		$ON_SE_OPEN_MOVIE_POPUP : function() {
			var arg = null;
			var u = _CONTEXT_PATH + '/lib/com/kcube/movie/uploader/index.jsp?index=' + this.oApp.elPlaceHolder.id;
			var f = 'height=714px,width=461px,scroll=no,status=no,resizable=no';
			var n = 'kcube_movie_upload';
			var popup = window.open(u, n, f);
			if (popup.focus) popup.focus();
			return;
		}
	});