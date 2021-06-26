package com.ji.util;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class JSONManager {
	private static final Log logger = LogFactory.getLog(JSONManager.class);
	
	public static final int INDENT_FACTOR = 2;
	
	/**
	 * JSONArray문자열을 지정된 클래스 타입의 List 로 변환
	 *  
	 * @param <T>
	 * @param jsonArrayString
	 * @param voClass
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> List<T> convertJsonToList(String jsonArrayString, Class<T> voClass) {
		ArrayList<T> beans = new ArrayList<T>();
		
		try {
	        JSONArray jsonArray = JSONArray.fromObject(jsonArrayString);
	        for (int i = 0; i < jsonArray.size(); i++) {
	            beans.add((T) JSONObject.toBean(jsonArray.getJSONObject(i), voClass));
	        }    
		} catch(JSONException e) {
			logger.error("Happened JSONException At JSONManager.convertJsonToList");
		}
        return beans;
    }
	
	/**
	 * JSONArray문자열을 String 클래스 타입의 List 로 변환
	 * 
	 * @param jsonArrayString
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List<String> convertJsonToList(String jsonArrayString) {
		
		JSONArray jsonArray = JSONArray.fromObject(jsonArrayString);
		
		return (List<String>) JSONArray.toCollection(jsonArray);
	}
	
	/**
	 * JSONArray문자열을 String 클래스 타입의 배열로 변환
	 * 
	 * @param jsonArrayString
	 * @return
	 */
	public static String[] convertJsonToArray(String jsonArrayString) {
		
		List<String> list = convertJsonToList(jsonArrayString);
		
		return list.toArray(new String[list.size()]);
	}
	
	/**
	 * List 객체를 JSONArray문자열로 변환한다.  
	 * @param <T>
	 * @param voList 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T extends List> String convertListToString(T voList) {
		JSONArray jsonArray = JSONArray.fromObject(voList);
		return jsonArray.toString(INDENT_FACTOR);
	}
	
	/**
	 * VO 객체를 JSONObject 문자열로 변환한다. - 
	 * @param <T>
	 * @param vo
	 * @return
	 */
	public static <T extends BaseVO> String convertBeanToString(T voBean) {
		JSONObject jsonObj = JSONObject.fromObject(voBean);
		return jsonObj.toString(INDENT_FACTOR);
	}
	
	/**
	 * 전달 맵 데이터를 JSON 타입의 문자열로 반환한다.
	 * @param resultMap
	 * @param isArrType
	 * @return
	 * @throws Exception
	 */
	public static String convertMapToString(Map<String, Object> resultMap, boolean isArrType) throws Exception {
		String resultStr = null;
		try {
			if(isArrType) {
				resultStr = JSONManager.convertMapToJSONArray(resultMap).toString(INDENT_FACTOR);
			} else {
				resultStr = JSONManager.convertMapToJSONObject(resultMap).toString(INDENT_FACTOR);
			}
		}catch(NullPointerException e){
			throw e;
			
		}catch(ArrayIndexOutOfBoundsException e){	
			throw e;	
		} catch(Exception e) {
			throw e;
		}
		return resultStr;
	}
	
	/**
	 * 전달 맵 데이터를 JSONObject 객체로 변환하여 반환한다.
	 * @param resultMap
	 * @return
	 * @throws Exception
	 */
	public static JSONObject convertMapToJSONObject(Map<String, Object> resultMap) throws Exception {
		JSONObject jsonObj; 
		try {			
			jsonObj = new JSONObject();
			for(Iterator<String> iter = resultMap.keySet().iterator(); iter.hasNext(); ) {
				String key = iter.next();
				jsonObj.put(key, resultMap.get(key));
			}
		}catch(NullPointerException e){
			logger.error("convertMapToJSONObject ERROR");
			throw e;
			
		}catch(ArrayIndexOutOfBoundsException e){	
			logger.error("convertMapToJSONObject ERROR");
			throw e;
		} catch(Exception e) {
			logger.error("convertMapToJSONObject ERROR");
			throw e;
		}
		return jsonObj;
	}
	
	/**
	 * 전달 맵 데이터를 JSONArray 객체로 변환하여 반환한다.
	 * @param resultMap
	 * @return
	 * @throws Exception
	 */
	public static JSONArray convertMapToJSONArray(Map<String, Object> resultMap) throws Exception {
		JSONArray jsonArray = new JSONArray();
		try {			
			JSONObject jsonObj = null;
			for(Iterator<String> iter = resultMap.keySet().iterator(); iter.hasNext(); ) {
				jsonObj = new JSONObject() ;
				String key = iter.next();
				jsonObj.put(key, resultMap.get(key));
				jsonArray.add(jsonObj);
			}
		}catch(NullPointerException e){
			logger.error("convertMapToJSONArray ERROR");
			throw e;
			
		}catch(ArrayIndexOutOfBoundsException e){	
			logger.error("convertMapToJSONArray ERROR");
			throw e;	
		} catch(Exception e) {
			logger.error("convertMapToJSONArray ERROR");
			throw e;
		}
		return jsonArray;
	}
	
	/**
	 * Bean(Value Object)을 Map 형태로 변환시켜 반환한다.
	 * 
	 * @param <T>
	 * @param obj
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static <T> Map<String, T> convertBeanToMap(Object vo) throws Exception {
		
		JSONObject jsonObj = JSONObject.fromObject(vo);
		
		return (Map<String, T>) JSONObject.toBean(jsonObj, Map.class);
	}
}
