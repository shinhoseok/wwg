/**================================================================================
 * @name: javascript 공통 package - hwp plugin
 * @author: jhlee
 * @demo: 
 * @version: 0.1.0
 * @charset: utf-8
 ================================================================================*/
if(!com){ 
	alert('com 이 없습니다. com 아래에 적용바랍니다..');
}else{
	com = (function(com){
		var _hwp = null; //한글 Object
		//상수
		var c = {
			hwp : {
				id : '#HwpCtrl' //기본 한글Object ID
			}
		};
		//기본설정
//		var def = {
//		};
		//제공함수
		var f = {
			hwp : {
				//hwp plugin 전용 상수를 가져온다.
				getConst : function(constPath){
					var r = eval('c.hwp.'+constPath);
					return r;
				}
				//한글 Object를 별도 설정한다
				,setHwp : function(id){
					_hwp = ($(id).length>0)?$(id)[0]:_hwp;
					return _hwp;
				}
				//hwp 액션실행 공통 함수
				,run : function (actName, paramObj){
					if(paramObj){
						var dact = _hwp.CreateAction(actName);
						var dset = dact.CreateSet();
						dact.GetDefault(dset);
						for(var k in paramObj){
							if(typeof paramObj[k]==='object'){ //object일경우 subtype으로 처리
								var sub = ''; 
								for(var _s in paramObj[k]){ //subtype mapping은 1:1이므로 첫번째 속성만 처리
									sub = _s; break;
								}
								var subset = dset.CreateItemSet(k,sub);
								dact.GetDefault(subset);
								for(var _s in paramObj[k][sub]){
									subset.SetItem(_s,paramObj[k][sub][_s]);
								}
							}else{
								dset.SetItem(k,paramObj[k]);
							}
						}
						dact.Execute(dset);
					}else{
						_hwp.Run(actName);
					}
				}
				//mm to HWPUNIT (mm단위를 HWPUNIT로 변경한다.)
				,m2h : function (num){
					return Math.floor(num * 283.465); // 1mm = 283.465 HWPUNIT
				}
				//inch to HWPUNIT
				,i2h : function (num){
					return Math.floor(num * 7200); // 1 inch = 7200 HWPUNIT, 1 inch = 25.4 mm
				}
				//point to HWPUNIT
				,p2h : function (num){
					return this.i2h(num * 0.01389); // 1 PostScript point = 0.0138888889 inch
				}
				//폰트설정 - 글꼴&폰트 일반설정 자동추가
				,setFont : function (paramObj){
					if(paramObj){
						if(typeof paramObj._FontName === 'string'){ // FontName
							var v = paramObj._FontName;
							$.extend(paramObj,{
								'FaceNameUser': v		//글꼴 이름 (사용자)
								,'FaceNameSymbol': v	//글꼴 이름 (심벌)
								,'FaceNameOther': v		//글꼴 이름 (기타)
								,'FaceNameJapanese': v	//글꼴 이름 (일본어)
								,'FaceNameHanja': v		//글꼴 이름 (한자)
								,'FaceNameLatin': v		//글꼴 이름 (영어)
								,'FaceNameHangul': v	//글꼴 이름 (한글)
								,'FontTypeUser': 1		//폰트 종류 (사용자) : 0 = don't care, 1 = TTF, 2 = HFT
								,'FontTypeSymbol': 1	//폰트 종류 (심벌) : 0 = don't care, 1 = TTF, 2 = HFT
								,'FontTypeOther': 1		//폰트 종류 (기타) : 0 = don't care, 1 = TTF, 2 = HFT
								,'FontTypeJapanese': 1	//폰트 종류 (일본어) : 0 = don't care, 1 = TTF, 2 = HFT
								,'FontTypeHanja': 1		//폰트 종류 (한자) : 0 = don't care, 1 = TTF, 2 = HFT
								,'FontTypeLatin': 1		//폰트 종류 (영문) : 0 = don't care, 1 = TTF, 2 = HFT
								,'FontTypeHangul': 1	//폰트 종류 (한글) : 0 = don't care, 1 = TTF, 2 = HFT
							});
						}
						this.run('CharShape',paramObj);
					}else{
						alert('hwpSetFont :: 파라미터값이 없습니다.');
					}
				}
				//지정한 크기로 테이블을 생성한다.
				//FirstCellName : 표의 첫번째행, 첫번째열(0,0)의 셀의 이름.(나중에 이 표를 다시 찾을 때 사용)
				//ColWidthArray : 표의 열 크기를 mm단위 배열로 넣어준다.
				//RowHeightArray : 표의 행 크기를 mm단위 배열로 넣어준다. (만약 배열에 지정된 크기가 바탕쪽 스타일의 글자의 높이보다 작으면 바탕쪽 높이가 사용된다.)
				//ex) 	com.hwp.tableCreate('Table1', new Array(20,40,100), new Array(0, 0, 0)); //3x3표를 생성
				,tableCreate : function (FirstCellName, ColWidthArray, RowHeightArray){
					var dact = _hwp.CreateAction('TableCreate');
					var dset = dact.CreateSet();
					var darrayset;
					var i;
					var size;
					
					dset.SetItem('Rows', RowHeightArray.length);
					dset.SetItem('Cols', ColWidthArray.length);
					
					dset.SetItem('WidthType', 2);
					dset.SetItem('HeightType', 1);
					
					dset.CreateItemSet('TableProperties', 'Table'); //내부 작업을 위해 비어있는 set이라도 만들어줘야 한다.
					size = RowHeightArray.length;
					darrayset = dset.CreateItemArray('RowHeight', size);
					for (i = 0;i < size; i++){
						darrayset.setItem(i, this.m2h(RowHeightArray[i]));
					}
					
					size = ColWidthArray.length;
					darrayset = dset.CreateItemArray('ColWidth', size);
					for (i = 0;i < size; i++){
						darrayset.setItem(i, this.m2h(ColWidthArray[i]));
					}
					
					dact.Execute(dset);
					
					_hwp.SetCurFieldName(FirstCellName, 1, 0, 0);
				}
				//현재 커서위치부터 행의 마지막까지 text를 추가한다.
				//ColumnArray : 삽입할 text배열
				,tableColumnContents : function (ColumnArray){
					if (_hwp.ParentCtrl.CtrlID == 'tbl') // 테이블 내에 커서가 있는가?
					{
						var i;
						var size;
						var dact = _hwp.CreateAction('InsertText');
						var dset = dact.CreateSet();
						size = ColumnArray.length;
						for (i = 0;i < size; i++)
						{
							dset.SetItem('Text', ColumnArray[i]);
							dact.Execute(dset);
							this.run('TableRightCell');
						}
						return true;
					}
					else
					{
						//if (_DEBUG)
						alert('현재 커서의 위치가 표의 내부가 아님.');
						return false;
					}
				}
				//표에 마지막 행을 추가하고, 내용을 채운다.
				,tableAppendRowContents : function (FirstCellName, ColumnArray){
					if(this.tableAppendRow(FirstCellName)){
						this.tableColumnContents(ColumnArray);
					}
				}
				//해당 테이블의 마지막 행에 이어서 행을 추가한다.
				//FirstCellName : 표의 첫번째 행, 첫번째 열의 셀필드 명.
				,tableAppendRow : function (FirstCellName){
					if (_hwp.MoveToField(FirstCellName, false, false, false)){
						this.run('TableCellBlock');
						this.run('TableColPageDown');
						this.run('Cancel');
						this.run('TableAppendRow');
						return true;
					}else{
						//if (_DEBUG)
						alert('셀필드(' + FirstCellName +')가 존재하지 않습니다.');
						return false;
					}
				}
				
			}
		};
		
		var _init = function(){
			f.hwp.setHwp(c.hwp.id); //한글 Object
		}; 
		
		$(function(){
			_init();
		});
		
		var rto = $.extend(true,{},com,f);
		return rto;
	})(com);
}