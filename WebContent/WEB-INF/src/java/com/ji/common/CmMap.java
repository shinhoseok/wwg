package com.ji.common;

import java.io.Serializable;
import java.util.Map;

import org.apache.commons.collections.FastHashMap;


@SuppressWarnings("rawtypes")
public class CmMap<K, V> extends FastHashMap implements Map, Serializable{
	
	private static final long serialVersionUID = 1L;	

	/**
	 * 
	 * @param key
	 * @return
	 */
	public int getInt(String key) {
		int result = 0;
		
		try {
			result = Integer.parseInt(String.valueOf(map.get(key)));
		}catch(NullPointerException q){
			result = 0; 
			
		}catch(ArrayIndexOutOfBoundsException q){
			result = 0; 	
		} catch (Exception e) {
			result = 0; 
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param key
	 * @param defaultValue
	 * @return
	 */
	public int getInt(String key, int defaultValue) {
		int result = 0;
		
		try {
			result = Integer.parseInt(String.valueOf(map.get(key)));
		}catch(NullPointerException q){
			result = defaultValue; 
			
		}catch(ArrayIndexOutOfBoundsException q){
			result = defaultValue; 	
		} catch (Exception e) {
			result = defaultValue; 
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param key
	 * @return
	 */
	public long getLong(String key) {
		long result = 0;
		
		try {
			result = Long.parseLong(String.valueOf(map.get(key)));
		}catch(NullPointerException q){
			result = 0; 
			
		}catch(ArrayIndexOutOfBoundsException q){
			result = 0; 			
		} catch (Exception e) {
			result = 0; 
		}
		return result;
	}
	
	public double getDouble(String key) {
		double result = 0;
		
		try {
			result = Double.parseDouble(String.valueOf(map.get(key)));
		}catch(NullPointerException q){
			result = 0; 
			
		}catch(ArrayIndexOutOfBoundsException q){
			result = 0; 			
		} catch (Exception e) {
			result = 0;
		}
		return result;
	}
	
	/**
	 * 
	 * @param key
	 * @return
	 */
	public String getString(String key) {
		String result = "";
		
		try {
			result = (map.get(key) == null ? "" : String.valueOf(map.get(key)));
		}catch(NullPointerException q){
			result = "";
			
		}catch(ArrayIndexOutOfBoundsException q){
			result = "";		
		} catch (Exception e) {
			result = "";
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param key
	 * @param defaultValue
	 * @return
	 */
	public String getString(String key, String defaultValue) {
		String result = "";
		
		try {
			result = (map.get(key) == null ? defaultValue : String.valueOf(map.get(key)));
		}catch(NullPointerException q){
			result = defaultValue;
			
		}catch(ArrayIndexOutOfBoundsException q){
			result = defaultValue;			
		} catch (Exception e) {
			result = defaultValue;
		}
		
		return result;
	}
	
	/**
	 * 
	 * @param key
	 * @return
	 */
	public String[] getStringArray(String key) {
		if (map.get(key) == null)
			return null;
		
		if (!map.get(key).getClass().isArray()) {
			return new String[] { (String)map.get(key) };
		}
		
		return (String[])map.get(key);
	}
	
	/**
	 * value1 빈값일 경우 value2 로 대체
	 * @param key
	 * @param value1
	 * @param value2
	 */
	public void putAnullB(String key, String value1, String value2) {
		String value = (value1 != null && !value1.equals("")) ? value1 : value2;
		this.put(key, value);
	}
}
