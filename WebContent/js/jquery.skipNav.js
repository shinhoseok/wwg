/*! ==========================================================================
 * 기본사용법	: jQuery(element).skip_navi();
 
 * 설정 가능한 옵션 ({})
 * focusContainer — id 컨테이너 영역에 포커스를 적용할지 여부를 결정 ( true | false )
 * 'focusContainer' : true || false
 
 * === 아래 설정은 별도의 스타일 시에 설정 ===
 * skipNavClass — 스킵내비게이션 요소에 설정할 클래스 이름 설정 (별도의 스타일 설정 시 필요)
 * 'skipNavClass'   : 'skip_navi' || (클래스 이름)
 * :focus 가상 클래스를 지원하지 않는 IE6,7 브라우저에서 포커스 상태의 클래스 이름 설정
 * 'focusClass'     : 'focused' || (클래스 이름)
 * :before, :after 가상 요소를 지원하지 않는 IE6,7 브라우저에서 가상 요소 텍스트, 클래스 설정
 * 'pseudoText'     : '➭ ' || (가상 요소 텍스트)
 * 'pseudoClass'	: 'before-element' || (클래스 이름)
 
 * =========================================================================== */

;(function($, window, undefined){

// 엄격 모드
"use strict";

// jQuery 의존성 체크
if ( !$ ) { return console.error('jQuery 라이브러리에 의존하는 플러그인입니다. jQuery 호출을 확인해보세요.'); }

// 골치 아픈 IE(6,7) 감지 변수 설정
var isMessyIE = $('html').hasClass('lt-ie8');

// Function.prototype.bind 메소드 미지원 시, 프로토타입 확장
if ( !Function.prototype.bind ) {
  Function.prototype.bind = function (oThis) {
    if ( typeof this !== "function" ) {
      throw new TypeError("bind 메소드는 함수 객체의 멤버입니다.");
    }
    var aArgs = Array.prototype.slice.call(arguments, 1),
    	_this = this,
		Fn    = function () {},
		oFn   = function () { return _this.apply(this instanceof Fn && oThis ? this : oThis, aArgs.concat(Array.prototype.slice.call(arguments))); };
    Fn.prototype  = this.prototype;
    oFn.prototype = new Fn();
    return oFn;
  };
}

/*	생성자 — 스킵 내비게이션
	========================================================================== */
$.SkipNavigation = function($el, options) {
	this.$el     = $el;
	this.options = options;
	return this._init();
};

// 옵션 초기 값
$.SkipNavigation.defaults = {
	'focusContainer' : true,
	'skipNavClass'   : 'skip_navi',
	'focusClass'     : 'focused',
	'pseudoText'     : '➭ ',
	'pseudoClass'	 : 'before-element'
};

/*	프로토타입 — 스킵 내비게이션
	========================================================================== */
$.SkipNavigation.prototype = {

	'version' : '0.2',

	// tabindex="0" 설정된 요소 참조 프로퍼티 설정
	'target_focus_el' : null,

	// 초기화 인스턴스 메소드
	'_init' : function() {
		
		// 인스턴스 객체 self 참조
		var self = this;
		
		// 옵션 오버리아딩(설정 객체 합치기)
		self.config = $.extend({}, $.SkipNavigation.defaults, self.options);

		// 골치 아픈 IE(6, 7) 브라우저일 경우, 문제 해결을 위한 메소드 호출
		if ( isMessyIE ) { self._fixMessyIE(); }
		
		self.$el
			// 스킵 내비게이션 객체 클래스 설정
			.addClass( self.config.skipNavClass )
			// 플러그인 객체 내부의 <a> 요소 추가
			.add( self.$el.find('a') )
			// WAI-ARIA 설정
			.attr('aria-hidden', true)
			.end()
			// 플러그인 이벤트 핸들링
			.on('click', 'a', function( evt ) {
				
				// <a> 브라우저 기본 동작 차단
				evt.preventDefault();
				
				// 포커스 이동 목적지 #id 설정 및 적용 대상 탐색
				var target_id = !isMessyIE ? this.getAttribute( 'href' ) : this.getAttribute( 'href' ).split('#')[1];
				
				// 현재 포커스 객체 참조
				self.target_focus_el = window.document.getElementById( target_id.replace(/#/, '') ); 
				
				// focusContainer 설정이 true 일 경우 동작
				if ( self.config.focusContainer ) {
					// 목적지 요소(id)에 0 설정
					self._setTabindex( self.target_focus_el, 0 );
					// 목적지 요소(id)에 포커스 설정
					self.target_focus_el.focus();
					// 목적지 요소(id) 블러 이벤트 발생 시, -1 설정
					self.target_focus_el.onblur = self._setTabindex.bind(self, self.target_focus_el, -1);

				} else { // focusContainer 설정이 false 일 경우 동작
					self._findFirstFocusElementandFocusing();
				}
			})
			// 포커스 상태에서 WAI-ARIA 설정
			.on('focus', 'a', function() {
				this.setAttribute('aria-hidden', false);
			})
			// 블러 상태에서 WAI-ARIA 설정
			.on('blur', 'a', function() {
				this.setAttribute('aria-hidden', true);
			});

		// 플러그인이 설정된 jQuery 객체 반환 (체이닝)
		return this.$el;
	},

	// 탭 인덱스 설정 인스턴스 메소드
	'_setTabindex' : function( target_el, value ) {
		target_el.setAttribute('tabindex', value);
		return this;
	},

	// 컨테이너 요소(id) 내부에서 첫번째 포커스 요소를 찾아 포커스를 설정하는 인스턴스 메소드
	'_findFirstFocusElementandFocusing' : function() {
		var $container            = $(this.target_focus_el),
			$container_child      = $container.find('*'),
			count                 = -1,
			container_child_count = $container_child.length;
		while( count++ < container_child_count-1 ) {
			if( $container_child.eq(count).focus().is(':focus') ) {
				return $container_child.eq(count);
			}
		}
		return this;
	},

	// !!!!!!!!!!!!! 골치 아픈 IE(6,7) 문제 해결을 위한 인스턴스 메소드 !!!!!!!!!!!!!
	'_fixMessyIE' : function() {
		// 인스턴스 객체 참조
		var self = this,
			$self_links = self.$el.find('a');

		// 포커스 컨테이너 설정 값이 true 일 경우 처리
		$.each($self_links, $.proxy( function(index, el) {
			var $link = $self_links.eq(index), target_id;
			$('<span/>').text( self.config.pseudoText ).addClass( self.config.pseudoClass ).prependTo($link);
			if( self.config.focusContainer ) {
				target_id = $link.attr('href');
				$( target_id ).attr('tabindex', -1);
			}
		}, $self_links ) );

		// lang 속성을 처리하기 위한 조건문
		if ( self.$el.is('[lang]') ) { self.$el.addClass( self.$el.attr('lang') ); }

		var focusClass = self.config.focusClass,
			reg = new RegExp( focusClass );

		self.$el.find('a').on({
			'focus' : function() {
				this.className += ' ' + focusClass;
			},
			'blur' : function() {
				if ( reg.test(this.className) ) {
					this.className = this.className.replace(reg, '');
					$.trim( this.className );
				}
			}
		});
	}
};

/*	플러그인 — 프로토타입 확장
	========================================================================== */
$.fn.skip_navi = function ( options ) {
	// 플러그인 적용 대상 객체 필터링 (첫번째 매칭 요소)
	var $first_el = this.first();
	// DOM 객체 — domElement 프로퍼티 참조
	$first_el.domElement = $first_el[0];
	// 생성자를 통해 인스턴스 객체 생성
	return new $.SkipNavigation( $first_el, options );
};

})(window.jQuery, window);