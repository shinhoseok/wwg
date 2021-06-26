<%--
/*=================================================================================*/
/* 시스템            : JRCMS 시스템 SYSTEM
/* 프로그램 아이디   : /WEB-INF/jsp/contents/S01/starategy/location.jsp
/* 프로그램 이름     : location    
/* 소스파일 이름     : location.jsp
/* 설명              : 동반성장전략 > 찾아오시는 길 
/* 버전              : 1.0.0
/* 최초 작성자       : lky
/* 최초 작성일자     : 2019-06-27
/* 최근 수정자       : lky
/* 최근 수정일시     : 2019-06-27
/* 최종 수정내용     : 최초작성
/*=================================================================================*/
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@include file="/WEB-INF/jsp/cm/CmCommon.jsp"%>

                <div class="cts_mid">
                    <div class="prg">
                        <img src="<%=con_root %>/images/project_img/common/map.jpg" alt="한국중부발전 본사위치" />
                        <div class="locationInfo">
                            <p class="address"><span>주소</span>충청남도 보령시 보령북로 160, 7층</p>
                            <p class="telNum "><span>전화</span>070-7511-1740~1746</p>
                        </div>
                    </div>
                    <div class="prg">
                        <h4 class="titleM">한국중부발전 본사 오시는 방법</h4>
                        <div class="traffic">
                            <div class="car">
                                <h5>자동차</h5>
                                <div class="listbg">
                                    <p>서울에서 서서울TG 서해안고속도로 진입하여 대천IC로 나오기</p>
                                    <p>대천IC로 부터 본사까지(5km) 약 18분 소요</p>
                                    <p>서울에서 3시간 정도 소요됩니다.</p>
                                </div>
                            </div>
                            <div class="bus">
                                <h5>버스</h5>
                                <div class="listbg">
                                    <p>서울(센트럴시티 터미널) 호남선 보령행 탑승</p>
                                    <p>보령버스터미널에서 본사까지(3km) 택시로 약 10분 소요</p>
                                    <p>서울에서 2시간 30분~3시간 가량 소요됩니다.</p>
                                </div>
                            </div>
                            <div class="train">
                                <h5>기차</h5>
                                <div class="listbg">
                                    <p>서울(용산역, 영등포역) 장항선 익산행 열차(새마을호, 무궁화호) 탑승</p>
                                    <p>대천역에서 본사까지(3km) 택시로 약 10분 소요</p>
                                    <p>서울에서 2시간 40분 가량(무궁화호 기준) 소요됩니다.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
<script type='text/javascript'>
//<![CDATA[
           
$(function() {
	// 스타일 추가
	//$('input[name=DATA_IPNS]').parent('td').prev('th').addClass('essential');
	$('#contents').parent('div').addClass('location');
});	


//]]>           
</script>  
