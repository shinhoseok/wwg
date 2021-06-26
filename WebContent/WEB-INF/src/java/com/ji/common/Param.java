/*===================================================================================
 * System             : Jrinfo Library 占시쏙옙占쏙옙
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.Param.java
 * Description        : 占식띰옙占쏙옙占시놂옙占쏙옙占�占쏙옙천占�占쌕쇽옙占쏙옙 占쏙옙占쏙옙占�占쏙옙占쏙옙占싹댐옙 클占쏙옙占쏙옙.
 * Author             : 占싱금울옙
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : 占싱금울옙
 * Updated content    : 占쏙옙키占쏙옙占쏙옙 占쏙옙占쏙옙
 * License            : 
 *==================================================================================*/
package com.ji.common;

/**
 * @author 占싱금울옙
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;

import com.ji.dao.cm.mnm.CmMnmDAO01;

//import com.oreilly.servlet.MultipartRequest;

public class Param {
	protected static Logger log = Logger.getLogger(Param.class); //현재 클래스 이름을 Logger에 등록
	/**
	    * HttpServletRequest 占쏙옙체占쏙옙 占쏙옙占쏙옙 key占쏙옙 value占쏙옙 占쏙옙占쏙옙占싹울옙 HashMap占쏙옙 占쏙옙占싼댐옙.
		* <br>
		* @param     req HttpServletRequest 占쏙옙체
		* @return    HashMap 
	    */

		public static Map setParameter(HttpServletRequest req){
			Map param = new HashMap();
			Enumeration e = req.getParameterNames();
			String name=null;
			String value=null;
			while(e.hasMoreElements()){
				name = (String)e.nextElement();
				value = (req.getParameter(name));
				param.put(name,value);
			}

			return param;
		}
		
		/**
		    * HttpServletRequest 占쏙옙체占쏙옙 占쏙옙占쏙옙 key占쏙옙 value占쏙옙 占쏙옙占쏙옙占싹울옙 HashMap占쏙옙 占쏙옙占싼댐옙.
			* <br>
			* @param     req HttpServletRequest 占쏙옙체
			* @return    HashMap 
		    */

			public static Map setParameters(HttpServletRequest req){
				Map param = new HashMap();
				Enumeration e = req.getParameterNames();
				String name=null;
				String [] values=null;
				String value=null;
				while(e.hasMoreElements()){
					name = (String)e.nextElement();
					values = req.getParameterValues(name);
					if(values.length==1){
						value = values[0];
						param.put(name,HtmlTag.StripStrInXss(value));
					}else{
						for(int i=0;i<values.length;i++){
							values[i] = HtmlTag.StripStrInXss(values[i]);
						}
						param.put(name,values);
					}					
				}

				return param;
			}		
		
		/**
		    * MultipartRequest 占쏙옙체占쏙옙 占쏙옙占쏙옙 key占쏙옙 value占쏙옙 占쏙옙占쏙옙占싹울옙 HashMap占쏙옙 占쏙옙占싼댐옙.
			* <br>
			* @param     multi MultipartRequest 占쏙옙체
			* @return    HashMap 
		 * @throws UnsupportedEncodingException 
		    */

			/*public static Map setMultiParameter(MultipartRequest multi){
				Map param = new HashMap();
				Enumeration e = multi.getParameterNames();
				String name=null;
				String value=null;
				while(e.hasMoreElements()){
					name = (String)e.nextElement();
					value = (multi.getParameter(name));
					param.put(name,value);
				}

				return param;
			}	*/	
		
		public static Map setMultiParameter(List<FileItem> fitems) throws UnsupportedEncodingException{
			Map param = new HashMap();
            for(int cnt=0; cnt<fitems.size(); cnt++){

                FileItem item = (FileItem)fitems.get(cnt);
                String name = item.getFieldName(); 
                
                if(item.isFormField()){ //������몄� 寃��

                    String value = "";

                    value = new String(item.getString().getBytes("utf-8")); //�대� item��value媛�� 媛���⑤�.

                    String[] values = (String[]) param.get(name); //HashMap���대� name(key)���대���� 媛�� ������.

                    if(values == null){//key媛�� �대���� 諛곗������硫�value媛�� 諛곗������.

                            values = new String[]{value};

                    }else{  //�대� 諛곗���議댁����硫� ��� fileItem��媛�� value濡�媛����.

                            String[] tempValues = new String[values.length+1];

                            System.arraycopy(values, 0, tempValues, 0, values.length); //

                            tempValues[tempValues.length-1] = value;

                            values = tempValues;

                    }

                    param.put(name,values); //parameter ���.

                }
            }

			return param;
		}		


		/**
	    * obj[]占쏙옙 占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙占싹울옙 HashMap 占쏙옙占싼댐옙.
		* <br>
		* HashMap占쏙옙 占쏙옙占쏙옙占�key占쏙옙 value占쏙옙占쏙옙 obj[]占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占싹댐옙.<br>
		* <br>
		* @param     req HttpServletRequest 占쏙옙체
		* @return    HashMap 
	    */

		public static Map setParameter(String[] obj){
			Map param = new HashMap();
			if(obj==null) return param;

			String name=null;
			for(int i=0;i<obj.length;i++){
				name = obj[i];
			    param.put(name,name);
			}

			return param;
		}

		public static void debugParam(Map param){
		    String name;
			String value;
			Iterator ir  = param.keySet().iterator();
			while(ir.hasNext()) {
				name = (String)ir.next();
				value = (String) param.get(name);
	            //SystemLog.log("model",name+" : "+value);
				//log.debug(name+" : "+value);
	        }
		}

		public static void debugParam(int ServiceName, Map param){
		    String name;
			String value;
			Iterator ir  = param.keySet().iterator();

			while(ir.hasNext()) {
				name = (String)ir.next();
				value = (String) param.get(name);
	            //SystemLog.log("model",name+" : "+value);
	        }
		}
		
		public static String WhereParam(String Param){
		    String rst="";
		    if(Param.length()>0){
		    	rst=" AND "+rst;		    	
		    }else{
		    	rst= " WHERE "+rst;
		    }

			return rst;
		}
		
		// edit by chan 2007-01-17
		public static int NumberChk(String Param){
		    int rtn=0;
		    if(Param != null && !Param.trim().equals("")){
		    	rtn=Integer.parseInt(RemoveComma(Param));		    	
		    }

			return rtn;
		}
		
		// insert by chan 2007-01-17 占쏙옙占쌘울옙占쏙옙 占쏙옙占�
		public static String RemoveComma(String Param){
		    String rstr="";
		    if(Param != null && !Param.trim().equals("")){
		    	rstr=Param.replaceAll(",", "");
		    }

			return rstr;
		}
		
		// insert by chan 2007-01-17 占쏙옙짜 占쏙옙占싹울옙占쏙옙 占쏙옙
		public static String RemovePattern(String Param){
		    String rstr="";
		    if(Param != null && !Param.trim().equals("")){
		    	rstr=Param.replaceAll("/", "");
		    	rstr=rstr.replaceAll("-", "");
		    }

			return rstr;
		}			
		
		public static double DoubleChk(String str){
		    double rtn=0;
		    if(str != null && !str.trim().equals("")){
		    	rtn=Double.parseDouble(str);		    	
		    }

			return rtn;
		}
		
		public static boolean conditionChk(String str){
		       boolean flag = false;
		       String strTrim = str.trim();
		       if(str != null) flag = true;
		       if(!strTrim.equals("")) flag = true;
		       
		       return flag;
		}
		
		public static String nulltoSpace(String str){
		       String result = "";
		       if(str != null)result = str.trim();
		       
		       return result;
		}
		
		/**
	     * 占쏙옙占싹울옙占쏙옙 확占쏙옙占쌘몌옙 占쏙옙占쏙옙占승댐옙.
	     * @param str
	     * @return
	     * @throws 
	     */    
		
		public static String getFileExtension( String str ) {
			return ( str.lastIndexOf( "." ) > 0 ) ? str.substring( str.lastIndexOf( "." ) ) : str;
		}
		
		/**
	     * 占쏙옙占쌘울옙占쏙옙 8859_1占쏙옙占쏙옙 utf-8占쏙옙 占쏙옙占쌘듸옙 占싼댐옙.
	     * @param str
	     * @return
	     * @throws UnsupportedEncodingException
	     */    
	
	    public static String encode( String str ) 
	    {
	        return encodeText( str, "8859_1", "utf-8" );
	    }
	    
	    /**
	     * 占쏙옙占쌘울옙占쏙옙 utf-8占쏙옙占쏙옙 8859_1占쏙옙 占쏙옙占쌘듸옙 占싼댐옙.
	     * 
	     * @param str
	     * @return
	     * @throws UnsupportedEncodingException
	     */
	    
	    public static String decode( String str ) 
	    {
	        return encodeText( str, "utf-8", "8859_1" ); 
	    }
	    
	    /**
	     * 占쏙옙占쌘울옙 占쌔댐옙占쌘듸옙占�占쏙옙환占싼댐옙..
	     * 
	     * @param str - String
	     * @param encode - String
	     * @param charsetName - String
	     * @return
	     * @throws UnsupportedEncodingException
	     */
	    private static String encodeText( String str, String encode, String charsetName )  {
	    	String result = null;
	    	
	    	try {
				result = (str==null) ? null : new String( str.getBytes( encode ), charsetName );
	    	} catch ( UnsupportedEncodingException e ) {
	    		throw new JSysException(e);
	    	}
	    	
	    	return result;
	    }
	    
		/**
		    * param占쏙옙체占쏙옙 占쏙옙占쏙옙 key占쏙옙 value占쏙옙 占쏙옙占쏙옙占싹울옙 Form占쏙옙 占쏙옙占쏙옙占싹댐옙 Object占쏙옙 占쏙옙占쏙옙磯占�
			* <br>
			* form 占승그댐옙 占쏙옙품占� form object 占쏙옙占쏙옙 key占쏙옙 type占쏙옙 hidden占쏙옙占쏙옙 占쏙옙占싼댐옙.<br>
			* param占쏙옙체占쏙옙 key占쏙옙占쏘데 exObj[]占쏙옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 키占쏙옙 占승그울옙占쏙옙 占쏙옙占신된댐옙.<br>
			* inObj[]占쏙옙 form object占쏙옙 占쌩곤옙占싼댐옙.<br>
			* <br>
			* - input type=hidden name=page value=1<br>
			* <br>
			* @param     req Form占쏙옙 占쏙옙占쏙옙占쏙옙 param占쏙옙체
			* @return    String Html Form占승깍옙
		    */

			public static String getFormObject(Map param, String exObj[],String[] inObj,String[] inObjval){
				// TODO getFormObject
				String formTag ="";
				Iterator ir  = param.keySet().iterator();
		        String name=null;
		        String value=null;
				Map exParam = Param.setParameter(exObj);// 占쏙옙占쌤듸옙 占식띰옙占쏙옙占�

				while(ir.hasNext()){
					name = (String)(String)ir.next();
		        	value = (String)param.get(name);
					if(exParam.get(name)==null)
		 				formTag+="<input type='hidden' name='"+name+"' value='"+value+"' title='"+name+"' />";
		        }

		        if(inObj==null) return formTag;

				for(int i=0;i<inObj.length;i++){
					if(param.get(inObj[i])==null)
						formTag+="<input type='hidden' name='"+inObj[i]+"' value='"+inObjval[i]+"' title='"+name+"' />";
				}

		        return formTag;
		    }
			
			/**
			    * param占쏙옙체占쏙옙 占쏙옙占쏙옙 key占쏙옙 value占쏙옙 占쏙옙占쏙옙占싹울옙 Form占쏙옙 占쏙옙占쏙옙占싹댐옙 Object占쏙옙 占쏙옙占쏙옙磯占�
				* <br>
				* form 占승그댐옙 占쏙옙품占� form object 占쏙옙占쏙옙 key占쏙옙 type占쏙옙 hidden占쏙옙占쏙옙 占쏙옙占싼댐옙.<br>
				* param占쏙옙체占쏙옙 key占쏙옙占쏘데 exObj[]占쏙옙 占쏙옙占쏙옙 占쌔댐옙풔째占쏙옙占�占쏙옙占시된댐옙.<br>
				* inObj[]占쏙옙 form object占쏙옙 占쌩곤옙占싼댐옙.<br>
				* <br>
				* - input type=hidden name=page value=1<br>
				* <br>
				* @param     req Form占쏙옙 占쏙옙占쏙옙占쏙옙 param占쏙옙체
				* @return    String Html Form占승깍옙
			    */

				public static String getFormObjectIn(Map param, String exObj[],String[] inObj,String[] inObjval) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
					// TODO getFormObjectIn
					String formTag ="";
					Iterator ir  = param.keySet().iterator();
			        String name=null;
			        String value=null;
					Map exParam = Param.setParameter(exObj);// 占쏙옙占쌤듸옙 占식띰옙占쏙옙占�
					boolean add_yn = false;
					
					try{
						while(ir.hasNext()){
							name = (String)ir.next();
							Object paramtype = param.get(name);
							// 占쏙옙占쏙옙占쏙옙체占싹곤옙占�String占쏙옙占쏙옙 占쏙옙환
							if (paramtype instanceof Integer || paramtype instanceof Short || paramtype instanceof Double
									|| paramtype instanceof Float || paramtype instanceof Long){
								//value = (String)param.get(name);
								value = String.valueOf(param.get(name));
								add_yn = true;
							}else if(paramtype instanceof String){
								value = (String)param.get(name);
								add_yn = true;
							// 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쌔쇽옙占쏙옙 占쏙옙체타占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占십댐옙 占쏙옙占쏙옙占싱므뤄옙 占쏙옙占쌤쏙옙킨占쏙옙
							}else{
								add_yn = false;
							}
							if(exParam.get(name)!=null && add_yn==true){
				 				formTag+="<input type='hidden' name='"+name+"' value='"+value+"' title='"+name+"' />";
							}
				        }
	
				        if(inObj==null) return formTag;
	
						for(int i=0;i<inObj.length;i++){
							if(param.get(inObj[i])==null){
								formTag+="<input type='hidden' name='"+inObj[i]+"' value='"+inObjval[i]+"' title='"+name+"' />";
							}
						}
						//log.debug("formTag: " + formTag);
					}catch(NullPointerException e){
						log.debug("getFormObjectIn: ");		
					}catch(ArrayIndexOutOfBoundsException e){
						log.debug("getFormObjectIn: ");		
					}catch(Exception e){
						log.debug("getFormObjectIn: ");						
					}

			        return formTag;
			    }	
				
				public static List getObjectNameIn(Map param,String[] inObjname) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
					// TODO getObjectNameIn
					List arrinobj = new ArrayList();
					Iterator ir  = param.keySet().iterator();
			        String name=null;
			        String value=null;
			        int addcnt = 0;
			        boolean add_yn = false;
					try{
						//log.debug("getObjectNameIn:param:"+param+"::: ");
						while(ir.hasNext()){
							name = (String)ir.next();
							
							Object paramtype = param.get(name);
							//log.debug("getObjectNameIn:name:"+name+"::paramtype: "+paramtype);
							// 占쏙옙占쏙옙占쏙옙체占싹곤옙占�String占쏙옙占쏙옙 占쏙옙환
							if (paramtype instanceof Integer || paramtype instanceof Short
									|| paramtype instanceof Double || paramtype instanceof Float || paramtype instanceof Long
									){
								value = String.valueOf(param.get(name));
								add_yn = true;
							/*}else if(paramtype instanceof Short){
								
							}else if(paramtype instanceof Double){
								
								
							}else if(paramtype instanceof Float){
								
								
							}else if(paramtype instanceof Long){*/

								
								
							}else if(paramtype instanceof String){
								value = (String)param.get(name);
								add_yn = true;
							// 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쌔쇽옙占쏙옙 占쏙옙체타占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占십댐옙 占쏙옙占쏙옙占싱므뤄옙 占쏙옙占쌤쏙옙킨占쏙옙
							}else{
								add_yn = false;
							}
				        	///log.debug("getObjectNameIn:name:"+name+"::: value:" + value);
							if(add_yn == true){
					        	for(int i=0;i<inObjname.length;i++){
					        		if(name.indexOf(inObjname[i]) > -1){
					        			arrinobj.add(name);
					        			addcnt++;
					        		}
					        	}
							}
	
				        }
					}catch(NullPointerException e){
						log.debug("getObjectNameIn: ");		
					}catch(ArrayIndexOutOfBoundsException e){
						log.debug("getObjectNameIn: ");		
					}catch(Exception e){
						log.debug("getObjectNameIn: ");
					}

			        return arrinobj;
			    }
				
				public static String[] getListToArr(List param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
					// TODO getListToArr
					String[] arrinobj = new String[param.size()];

			        int addcnt = 0;
					try{
						for(int i=0;i<param.size();i++){
							arrinobj[i]=(String)param.get(i);
				        	addcnt++;
				        }
					}catch(NullPointerException e){
						log.debug("getListToArr: ");	
					}catch(ArrayIndexOutOfBoundsException e){
						log.debug("getListToArr: ");		
					}catch(Exception e){
						log.debug("getListToArr: ");
					}

			        return arrinobj;
			    }	
				
				public static String getArrToString(String [] param) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
					// TODO getArrToString
					String arrinstr = "";

			        int addcnt = 0;
					try{
						for(int i=0;i<param.length;i++){
							arrinstr=arrinstr+"::"+(String)param[i];
				        	addcnt++;
				        }
					}catch(NullPointerException e){
						log.debug("getListToArr: ");	
					}catch(ArrayIndexOutOfBoundsException e){
						log.debug("getListToArr: ");		
					}catch(Exception e){
						log.debug("getListToArr: ");
					}

			        return arrinstr;
			    }				
		
		
}
