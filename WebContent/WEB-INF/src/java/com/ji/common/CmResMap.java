package com.ji.common;

import java.io.Reader;

@SuppressWarnings({ "unchecked", "rawtypes" })
public class CmResMap<K, V> extends CmMap{
	
	private static final long serialVersionUID = 1L;

	/**
	 * 
	 */
	@Override
	public Object put(Object key, Object value) {
		if (value instanceof oracle.sql.CLOB) {
			return map.put(key.toString().toLowerCase() , clobToString((oracle.sql.CLOB)value));
		} 
		else if (value instanceof java.lang.String) {
			return map.put(key.toString().toLowerCase() , ((String)value).replaceAll("\"", "&#034;"));
		}
		else {
			if(value == null){
				value = "";
			}
			return map.put(key.toString().toLowerCase() , value);
		}
	}
	
	/**
	 * 
	 * @param clob
	 * @return
	 */
	private String clobToString ( oracle.sql.CLOB clob ) {
		StringBuilder	sbf		= new StringBuilder();
		Reader			rd		= null;
		char[]			buf		= new char[1024];
		int				readCnt	= 0;
		
		try {
			rd	= clob.getCharacterStream(0l);
			while ((readCnt = rd.read(buf, 0, 1024)) != -1 ) {
				sbf.append(buf, 0, readCnt);
			}
		}catch(NullPointerException q){
			System.out.print("=== Exception === ");
			
		}catch(ArrayIndexOutOfBoundsException q){
			System.out.print("=== Exception === ");			
		} catch (Exception e) {
			System.out.print("=== Exception === ");
		} finally {
			try {
				if (rd != null){
					rd.close();
				}
			}catch(NullPointerException q){
				System.out.print("=== Exception === ");
				
			}catch(ArrayIndexOutOfBoundsException q){
				System.out.print("=== Exception === ");					
			} catch (Exception e) {
				System.out.print("=== Exception === ");
			}
		}
		
		return sbf.toString();
	}
}
