/*===================================================================================
 * System             : Jrinfo Library �����
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.HtmlTag.java
 * Description        : HtmlTag泥�━��愿�����ㅼ���湲곕�����났��� �대���
 * Author             : �닿���
 * Version            : 1.0.0
 * File name related  :
 * Class Name related :
 * Created Date       : 2011-03-18
 * Updated Date       : 2011-03-18
 * Last modifier      : �닿���
 * Updated content    : �⑦�吏�� 蹂�꼍
 * License            : 
 *==================================================================================*/
package com.ji.common;

/**
 * @author �닿���
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class HtmlTag {
	
	protected static Logger log = Logger.getLogger(HtmlTag.class); //현재 클래스 이름을 Logger에 등록
	
	public static String getDescription(String desc){
 		// TODO getDescription			
		String description = "";

		if(desc!= null){
			description = desc.trim();
			/*
			StringTokenizer st	= new StringTokenizer(desc);
			StringBuffer buffer	= new StringBuffer();

			while (st.hasMoreTokens()) {
				buffer.append(st.nextToken("\r"));
				buffer.append("<br>");
			}
			*/
		}

		return description;
	}

	/**
	* 而щ�/������곗�������������� 臾몄��댁� 由ы����..
	* <br>
	* �����NUNERIC��寃쎌� NUMERIC(10,6) <br>
	* �ㅻⅨ �����寃쎌� CHAR(10)濡�異�����<br>
	*
	* @param type �곗��고���
	* @param presnLen ���湲몄�
	* @param scaleLen ���湲몄�
	* @return String �곗������������대� 臾몄���
	*/
	public static String getColumnType(String type, long presnLen, long scaleLen){
 		// TODO getColumnType		
		String colType = "";

		colType = type+"("+presnLen+","+scaleLen+")";

		return colType;
	}


	/**
	* yn��媛�� �곕� ratio踰����checked 媛�� 由ы����.
	* <br>
	* yn��1��寃쎌� check
	* <br>
	*
	* @return String
	*/
 	public static String getRadioChecked(String yn){
 		// TODO getRadioChecked	 		
 		String ynstr = "";

         if("1".equals(yn)) ynstr = "checked";

 		return ynstr;
 	}

	public static String getRadioChecked(String yn,String parm ){
 		// TODO getRadioChecked		
 		String ynstr = "";
         if(yn == null) return ynstr;

         if(parm.equals(yn)) ynstr = "checked";

 		return ynstr;
 	}


	/**
	* yn��媛�� �곕� Y/N 臾몄��댁� 由ы����.
	* <br>
	* yn��1��寃쎌� Y<br>
	* 0��寃쎌� N<br>
	* <br>
	*
	* @param	yn Y/N �щ�
	* @return	String yn�������� 臾몄���
	*/
	public static String getYn(String yn){
 		// TODO getYn 		
		String ynstr = "";

		if("0".equals(yn)) ynstr = "N";
		else if("1".equals(yn)) ynstr = "Y";

		return ynstr;
	}




	/**
    * Form��Select媛�껜瑜�援ъ���� Option ��렇瑜�異�����.
	* <br>
    * - Vector��� SelectItem��異����� Option媛�껜瑜�援ъ����.<br>
	* <br>
	* @param     list SelectItem 紐⑸�
    * @return    String <option>��렇
    */

    public static String getOptionTag(Vector list){
 		// TODO getOptionTag      	
        String html="";

        if(list==null) return "";
        else{
            SelectItem item = null;
            for(int i=0;i<list.size();i++){
                item = (SelectItem)list.elementAt(i);
                html+="/t<option value=\""+item.getValue()+"\">"+item.getName()+"</option>\n";
	        }
        }
        return html;
    }

	/**
    * Form��Select媛�껜瑜�援ъ���� Option ��렇瑜�異�����.
	* <br>
    * - Vector��� SelectItem��異����� Option媛�껜瑜�援ъ����.<br>
	* <br>
	* @param     list SelectItem 紐⑸�
    * @return    String <option>��렇
    */

    public static String getOptionTagScript(Vector list){
 		// TODO getOptionTagScript      	
        String html="";

        if(list==null) return "";
        else{
            SelectItem item = null;
            for(int i=0;i<list.size();i++){
                item = (SelectItem)list.elementAt(i);
                html+="\t+\"<option value="+item.getValue()+">"+item.getName()+"</option>\"\n";
	        }
        }
        return html;
    }

	/**
    * Form��Select媛�껜瑜�援ъ���� Option ��렇瑜�異�����.
	* <br>
    * - Vector��� SelectItem��異����� Option媛�껜瑜�援ъ����.<br>
    * SelectItem��value媛�parameter value�������꼍��<br>
	* Option�������selected濡��ㅼ����.<br>
	* <br>
	*
	* @param     list SelectItem 紐⑸�
	* @param     value Option�����瑜�selected濡��ㅼ�����ぉ
    * @return    String <option>��렇
    */
    public static String getOptionTag(Vector list, String value){
 		// TODO getOptionTag       	
        String html="";

        if(list==null) return "";
        if(value==null) return getOptionTag(list);
        else{
            value=value.trim();
            SelectItem item = null;
            for(int i=0;i<list.size();i++){
                item = (SelectItem)list.elementAt(i);
	            if(item.getValue().equals(value))
                    html+="\t<option value=\""+item.getValue()+"\" selected>"+item.getName()+"</option>\n";
	            else
                    html+="\t<option value=\""+item.getValue()+"\">"+item.getName()+"</option>\n";
	        }
        }
        return html;
    }

	/**
     * Form��Select媛�껜瑜�援ъ���� Option ��렇瑜�異�����.
 	* <br>
     * - Vector��� SelectItem��異����� Option媛�껜瑜�援ъ����.<br>
 	* <br>
 	* @param     list SelectItem 紐⑸�
     * @return    String <option>��렇
     */

     public static String getOptionTagMap(List list,String Type){
  		// TODO getOptionTagMap       	 
         String html="";
         if(list==null) return "";
         else{
             for(int i=0;i<list.size();i++){
             	 Map rowval = (Map)list.get(i);
             	 if(Type.equals("KOR")){
             		 html+="/t<option value=\""+rowval.get("CODE")+"\">"+rowval.get("CODE_FN")+"</option>\n";
             	 }else{
             		html+="/t<option value=\""+rowval.get("CODE")+"\">"+rowval.get("CODE_ENG_FN")+"</option>\n";
             	 }
             }
         }
         return html;
     }
     
     public static String getOptionTagMap(Map list_map,String Type,String value){
   		// TODO getOptionTagMap  
    	 log.debug("============== getOptionTagMap(Map list_map,String Type,String value) : START ==============");
          String html="";
          List list = null;
          String tmp_code = "";
          if(list_map==null) return "";
          else{
        	  
        	  list = (List)list_map.get("SELECT");
        	  
        	  if(list == null){return "";}
        	  
        	  if(list.size() < 1){return "";}
              value=value.trim();
              for(int i=0;i<list.size();i++){
              	Map rowval = (Map)list.get(i);
              	tmp_code = ((String)rowval.get("CODE")).trim();
            	 if("KOR".equals(Type)){
            		if(tmp_code.equals(value))
            			html+="\t<option value=\""+tmp_code+"\" selected>"+rowval.get("CODE_FN")+"</option>\n";
            		else
            			html+="\t<option value=\""+tmp_code+"\">"+rowval.get("CODE_FN")+"</option>\n";
            	 }else{
            		 if(tmp_code.equals(value))
            			 html+="\t<option value=\""+tmp_code+"\" selected>"+rowval.get("CODE_ENG_FN")+"</option>\n";
            		 else
            			 html+="\t<option value=\""+tmp_code+"\">"+rowval.get("CODE_ENG_FN")+"</option>\n";
            	 }
                  
  	          }
          }
          log.debug("============== getOptionTagMap(Map list_map,String Type,String value) : END ==============");
          return html;
      }  
     
     public static String getOptionTagDeptMap(Map list_map,String value){
    		// TODO getOptionTagDeptMap  
     	 log.debug("============== getOptionTagDeptMap(Map list_map,String value) : START ==============");
           String html="";
           List list = null;
           String tmp_code = "";
           if(list_map==null) return "";
           else{
         	  
         	  list = (List)list_map.get("SELECT");
         	  
         	  if(list == null){return "";}
         	  
         	  if(list.size() < 1){return "";}
               value=value.trim();
               for(int i=0;i<list.size();i++){
               	Map rowval = (Map)list.get(i);
               	tmp_code = ((String)rowval.get("DEPT_C")).trim();
             		if(tmp_code.equals(value)){
             			html+="\t<option value=\""+tmp_code+"\" selected>"+rowval.get("TITLE_FN")+"</option>\n";
             		}else{
             			html+="\t<option value=\""+tmp_code+"\">"+rowval.get("TITLE_FN")+"</option>\n";
             		}
                  
   	          }
           }
           log.debug("============== getOptionTagDeptMap(Map list_map,String value) : END ==============");
           return html;
       }      
     
     public static String getOptionTagMap(List list,String Type, int cut_size){
  		// TODO getOptionTagMap       	 
        String html="";
        if(list==null) return "";
        else{
            for(int i=cut_size;i<list.size();i++){
            	 Map rowval = (Map)list.get(i);                 
            	 if("KOR".equals(Type)){
             		 html+="/t<option value=\""+rowval.get("CODE")+"\">"+rowval.get("CODE_FN")+"</option>\n";
             	 }else{
             		html+="/t<option value=\""+rowval.get("CODE")+"\">"+rowval.get("CODE_ENG_FN")+"</option>\n";
             	 }
	         }
        }
        return html;
     }
     
	/**
     * Form��Select媛�껜瑜�援ъ���� Option ��렇瑜�異�����.
 	* <br>
     * - Vector��� SelectItem��異����� Option媛�껜瑜�援ъ����.<br>
     * SelectItem��value媛�parameter value�������꼍��<br>
 	* Option�������selected濡��ㅼ����.<br>
 	* <br>
 	*
 	* @param     list SelectItem 紐⑸�
 	* @param     value Option�����瑜�selected濡��ㅼ�����ぉ
     * @return    String <option>��렇
     */
     public static String getOptionTagMap(List list, String Type, String value){
  		// TODO getOptionTagMap       	 
         String html="";

         if(list==null) return "";
         if(value==null) return getOptionTagMap(list, Type);
         else{
             value=value.trim();
             for(int i=0;i<list.size();i++){
             	Map rowval = (Map)list.get(i);
           	 if("KOR".equals(Type)){
           		if(((String)rowval.get("CODE")).trim().equals(value))
                    html+="\t<option value=\""+rowval.get("CODE")+"\" selected>"+rowval.get("CODE_FN")+"</option>\n";
	            else
                    html+="\t<option value=\""+rowval.get("CODE")+"\">"+rowval.get("CODE_FN")+"</option>\n";
         	 }else{
         		if(((String)rowval.get("CODE")).trim().equals(value))
                    html+="\t<option value=\""+rowval.get("CODE")+"\" selected>"+rowval.get("CODE_ENG_FN")+"</option>\n";
	            else
                    html+="\t<option value=\""+rowval.get("CODE")+"\">"+rowval.get("CODE_ENG_FN")+"</option>\n";
           	 }
                 
 	        }
         }
         return html;
     }
     
     public static String getOptionTagMap(List list, String Type, String value, String chg_str){
 		// TODO getOptionTagMap    	 
        String html="";

        if(list==null) return "";
        if(value==null) return getOptionTagMap(list, Type);
        else{
            value=value.trim();
            for(int i=0;i<list.size();i++){
            	Map rowval = (Map)list.get(i);
          	 if("KOR".equals(Type)){
          		if(((String)rowval.get("CODE")).trim().equals(value))
                   html+="\t<option value=\""+chg_str+rowval.get("CODE")+"\" selected>"+rowval.get("CODE_FN")+"</option>\n";
	            else
                   html+="\t<option value=\""+chg_str+rowval.get("CODE")+"\">"+rowval.get("CODE_FN")+"</option>\n";
        	 }else{
        		if(((String)rowval.get("CODE")).trim().equals(value))
                   html+="\t<option value=\""+chg_str+rowval.get("CODE")+"\" selected>"+rowval.get("CODE_ENG_FN")+"</option>\n";
	            else
                   html+="\t<option value=\""+chg_str+rowval.get("CODE")+"\">"+rowval.get("CODE_ENG_FN")+"</option>\n";
          	 }
                
	        }
        }
        return html;
    }
     
	/**
    * Form��Select媛�껜瑜�援ъ���� Option ��렇瑜�異�����.
	* <br>
    * - Vector��� SelectItem��異����� Option媛�껜瑜�援ъ����.<br>
    * SelectItem��value媛�parameter id�������꼍��<br>
	* Option�������selected濡��ㅼ����.<br>
	* <br>
	*
	* @param     list SelectItem 紐⑸�
	* @param     id Option�����瑜�selected濡��ㅼ�����ぉ
    * @return    String <option>��렇
    */

    public static String getOptionTag(Vector list, long id) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception {
		// TODO getOptionTag      	
        String value = null;
        try{
           value = String.valueOf(id);
        }catch(NullPointerException q){
        	value = null;		
		}catch(ArrayIndexOutOfBoundsException q){
			value = null;		
		}catch(Exception e){
          value = null;
        }

        return getOptionTag(list,value);
    }


	/**
    * request媛�껜濡�遺�� key��value瑜�異����� Form��異�����.
	* <br>
	* form紐�� formName, form object 紐�� key紐�type��hidden�쇰� ������.<br>
	* <br>
	* - form name=formName <br>
	* - input type=hidden name=key value=value<br>
	* <br>
	* @param     req Form��援ъ���Request媛�껜
	* @param     formName Form name
	* @return    String Html Form��렇
    */

    public static String getForm(HttpServletRequest req, String formName){
		// TODO getForm    	
        String formTag ="<form name='"+formName+"' method='post'>";
		Enumeration e =req.getParameterNames();
        String name=null;
        String value=null;
        while(e.hasMoreElements()){
            name = (String)e.nextElement();
        	value = (req.getParameter(name));
			formTag+="<input type='hidden' name='"+name+"' value='"+value+"' title='"+name+"' />";
        }
        return formTag+"</form>";
    }


	/**
    * request媛�껜濡�遺�� key��value瑜�異����� Form��援ъ���� Object瑜�異�����.
	* <br>
	* form ��렇��������, form object 紐�� key紐�type��hidden�쇰� ������.<br>
	* request媛�껜��key媛����exObj[]��媛�낵 ������ㅻ� ��렇��� ��굅���.<br>
	* <br>
	* - input type=hidden name=page value=1<br>
	* <br>
	* @param     req Form��援ъ���Request媛�껜
	* @return    String Html Form��렇
    */

	public static String getFormObject(HttpServletRequest req, String[] exObj){
		// TODO getFormObject
         String formTag ="";
         Enumeration e =req.getParameterNames();
         String name=null;
         String value=null;
		 Map param = Param.setParameter(exObj);

         while(e.hasMoreElements()){
            name = (String)e.nextElement();
         	value = (req.getParameter(name));
			if(param.get(name)==null)
 				formTag+="<input type='hidden' name='"+name+"' value='"+value+"' title='"+name+"' />";
         }

         return formTag;
     }


	/**
	* @deprecated
    * @see #getFormObject(HttpServletRequest req, String exObj[],String[] inObj) getFormObject(HttpServletRequest req, String exObj[],String[] inObj)
    */

	public static String getFormObject(HttpServletRequest req, String[] exObj, String inObj){
		// TODO getFormObject
		return getFormObject(req, exObj, new String[]{inObj});
	}


	/**
    * request媛�껜濡�遺�� key��value瑜�異����� Form��援ъ���� Object瑜�異�����.
	* <br>
	* form ��렇��������, form object 紐�� key紐�type��hidden�쇰� ������.<br>
	* request媛�껜��key媛����exObj[]��媛�낵 ������ㅻ� ��렇��� ��굅���.<br>
	* inObj[]瑜�form object��異�����.<br>
	* <br>
	* - input type=hidden name=page value=1<br>
	* <br>
	* @param     req Form��援ъ���Request媛�껜
	* @return    String Html Form��렇
    */

	public static String getFormObject(HttpServletRequest req, String exObj[],String[] inObj){
		// TODO getFormObject
		String formTag ="";
		Map param = Param.setParameter(req);
		Iterator ir  = param.keySet().iterator();
        String name=null;
        String value=null;
		Map exParam = Param.setParameter(exObj);

		while(ir.hasNext()){
			name = (String)(String)ir.next();
        	value = (String)param.get(name);
			if(exParam.get(name)==null)
 				formTag+="<input type='hidden' name='"+name+"' value='"+value+"' title='"+name+"' />";
        }

        if(inObj==null) return formTag;

		for(int i=0;i<inObj.length;i++){
			if(param.get(inObj[i])==null)
				formTag+="<input type='hidden' name='"+inObj[i]+"' value='' title='"+name+"' />";
		}

        return formTag;
    }
	
	/**
	    * request媛�껜濡�遺�� key��value瑜�異����� Form��援ъ���� Object瑜�異�����.
		* <br>
		* form ��렇��������, form object 紐�� key紐�type��hidden�쇰� ������.<br>
		* request媛�껜��key媛����exObj[]��媛�낵 ������ㅻ� ��렇��� ��굅���.<br>
		* inObj[]瑜�form object��異�����.<br>
		* <br>
		* - input type=hidden name=page value=1<br>
		* <br>
		* @param     req Form��援ъ���Request媛�껜
		* @return    String Html Form��렇
	    */

		public static String getFormObject(HttpServletRequest req, String exObj[],String[] inObj,String[] inObjval){
			// TODO getFormObject
			String formTag ="";
			Map param = Param.setParameter(req);
			Iterator ir  = param.keySet().iterator();
	        String name=null;
	        String value=null;
			Map exParam = Param.setParameter(exObj);

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
    * ���吏�� ��� request媛�껜濡�遺�� key��value瑜�異����� paging Form��異�����.
	* <br>
	* form紐�� paging, form object 紐�� key紐�type��hidden�쇰� ������.<br>
	* key媛����page媛���� 寃쎌� page object瑜�異�����.<br>
	* <br>
	* - form name=paging <br>
	* - input type=hidden name=page value=1<br>
	* <br>
	* @param     req Form��援ъ���Request媛�껜
	* @return    String Html Form��렇
    */

    public static String getPagingForm(HttpServletRequest req){
    	// TODO getPagingForm
        String formTag ="<form name='paging' method='post'>";
		String page="1";
		Enumeration e =req.getParameterNames();
        String name=null;
        String value=null;
        while(e.hasMoreElements()){
            name = (String)e.nextElement();
        	value = (req.getParameter(name));
			if(name.equals("page")) page=value;
			else formTag+="<input type='hidden' name='"+name+"' value='"+value+"' />";
        }

		formTag+="<input type='hidden' name='page' value='"+page+"' />";
        return formTag+"</form>";
    }


	/**
    * ���吏�� ��� request媛�껜濡�遺�� key��value瑜�異����� Form��援ъ���� Object瑜�異�����.
	* <br>
	*  form ��렇��������, form object 紐�� key紐�type��hidden�쇰� ������.<br>
	* key媛����page媛���� 寃쎌� page object瑜�異�����.<br>
	* <br>
	* - input type=hidden name=page value=1<br>
	* <br>
	* @param     req Form��援ъ���Request媛�껜
	* @return    String Html Form��렇
    */

    public static String getPagingObject(HttpServletRequest req){
    	// TODO getPagingObject
        String formTag="";
		String page="1";
        Enumeration e =req.getParameterNames();
        String name=null;
        String value=null;
        while(e.hasMoreElements()){
            name = (String)e.nextElement();
        	value = (req.getParameter(name));
			if(name.equals("page")) page=value;
			else formTag+="<input type='hidden' name='"+name+"' value='"+value+"' />";
        }

        formTag+="<input type='hidden' name='page' value='"+page+"' />";
        return formTag;
    }

	/**
    * ���吏�� ��� request媛�껜濡�遺�� key��value瑜�異����� Form��援ъ���� Object瑜�異�����.
	* <br>
	* form ��렇��������, form object 紐�� key紐�type��hidden�쇰� ������.<br>
	* request媛�껜��key媛����exObj[]��媛�낵 ������ㅻ� ��렇��� ��굅���.<br>
	* key媛����page媛���� 寃쎌� page object瑜�異�����.<br>
	* <br>
	* - input type=hidden name=page value=1<br>
	* <br>
	* @param     req Form��援ъ���Request媛�껜
	* @param     exObj ��굅��� form Object紐�
	* @return    String Html Form��렇
    */

 	public static String getPagingObject(HttpServletRequest req, String[] exObj){
 		// TODO getPagingObject
        String formTag ="";
        Enumeration e =req.getParameterNames();
        String name=null;
        String value=null;
		Map exParam = Param.setParameter(exObj);

         while(e.hasMoreElements()){
            name = (String)e.nextElement();
         	value = (req.getParameter(name));
			if(exParam.get(name)==null)
 				formTag+="<input type='hidden' name='"+name+"' value='"+value+"' />";
         }

         return formTag;
     }


	/**
	* @deprecated
    * @see #getPagingObject(HttpServletRequest req, String[] exObj) getPagingObject(HttpServletRequest req, String[] exObj)
    */

 	public static String getPagingObject(HttpServletRequest req, String exObj){
 		// TODO getPagingObject
         String formTag ="";
         Enumeration e =req.getParameterNames();
         String name=null;
         String value=null;
         while(e.hasMoreElements()){
            name = (String)e.nextElement();
         	value = (req.getParameter(name));
			if(!name.equals(exObj))
 				formTag+="<input type='hidden' name='"+name+"' value='"+value+"' />";
         }

         return formTag;
     }


	/**
    * HttpServletRequest 媛�껜濡�遺�� key��value瑜�異����� QueryString��������.
	* <br>
	* @param     req HttpServletRequest 媛�껜
	* @return    String QueryString
    */

	public static String getQueryString(HttpServletRequest req){
		// TODO getQueryString
		String query = "?";
		Enumeration e = req.getParameterNames();
		String name=null;
		String value=null;
		while(e.hasMoreElements()){
			name = (String)e.nextElement();
			value = (req.getParameter(name));
			////log.debug(name+" : "+value);
			query+=name+"="+value+"&amp;";
		}

		return query;
	}


	/**
    * HttpServletRequest 媛�껜濡�遺�� key��value瑜�異����� QueryString��������.
	* <br>
	* request媛�껜��key媛����exObj[]��媛�낵 ������ㅻ� ��렇��� ��굅���.<br>
	* <br>
	* @param     req HttpServletRequest 媛�껜
	* @param     exObj ��굅��� name紐�
	* @return    String QueryString
    */

 	public static String getQueryString(HttpServletRequest req, String[] exObj){
 		// TODO getQueryString
		String query = "?";
        Enumeration e =req.getParameterNames();
        String name=null;
        String value=null;
		Map exParam = Param.setParameter(exObj);

		while(e.hasMoreElements()){
            name = (String)e.nextElement();
         	value = (req.getParameter(name));
			if(exParam.get(name)==null)
				query+=name+"="+value+"&amp;";
        }


        return query;
     }



	/**
    * HttpServletRequest 媛�껜濡�遺�� key��value瑜�異����� QueryString��������.
	* <br>
	* request媛�껜��key媛����exObj[]��媛�낵 ������ㅻ� ��렇��� ��굅���.<br>
	* inObj[]瑜�QueryString��異�����.<br>
	* <br>
	* @param     req HttpServletRequest 媛�껜
	* @param     exObj ��굅��� name紐�
	* @param     inObj 異����� name紐�
	* @return    String QueryString
    */

 	public static String getQueryString(HttpServletRequest req, String[] exObj, String[] inObj){
 		// TODO getQueryString
		String query = "?";
		Map param = Param.setParameter(req);
        Enumeration e =req.getParameterNames();
        String name=null;
        String value=null;
		Map exParam = Param.setParameter(exObj);

		while(e.hasMoreElements()){
            name = (String)e.nextElement();
         	value = (req.getParameter(name));
			////log.debug(name+" : "+java.net.URLDecoder.decode(value));

			if(exParam.get(name)==null)
				query+=name+"="+value+"&amp;";
        }

        if(inObj==null) return query;

		for(int i=0;i<inObj.length;i++){
			if(param.get(inObj[i])==null)
				query+=inObj[i]+"=&amp;";
		}

        return query;
    }

    //DB �곗���<  > 湲고�議댁���泥�━
    public static String getnotation(String str){
    	// TODO getnotationCovt
            if(str == null)return "";
            for(int i=0; i<str.length();i++){
               if(str.charAt(i)=='>' ||str.charAt(i)=='<'){
                  if(i==0)str ="/t" + str.substring(i,str.length());
                  else str = str.substring(0,i-1)+ "/t" + str.substring(i,str.length());
                  i+=2;
               }
            }
            return str;
    }
	
	//DB �곗���< > 議댁� 泥�━
	public static String getnotationCovt(String str){
		// TODO getnotationCovt
	    if(str == null)return "";
	    for(int i=0; i<str.length();i++){
	       if(str.charAt(i)=='>'){
			    if(i==0)str ="&lt;" + str.substring(i+1,str.length());
			    else str = str.substring(0,i)+ "&lt;" + str.substring(i+1,str.length());
				i+=3;
	       }else if(str.charAt(i)=='<'){
				if(i==0)str ="&gt;" + str.substring(i+1,str.length());
				else str = str.substring(0,i)+ "&gt;" + str.substring(i+1,str.length());
				i+=3;
	       }
	    }
	    return str;
	}


    public static String returnString(String str){
    	// TODO returnString
      if(str == null) return "";
      return str;
    }
    
    public static String returnString(String str,String replace){
    	// TODO returnString
   	 if (str == null || str.equals("")) 
   	 	return replace; 
   	 else 
   	 	return str;
    }
    
    // start by chan 2006-01-12
	public static boolean isNull(Object obj)
	{   // TODO isNull
		if( trim(obj).length() == 0 || trim(obj).equals("&nbsp;") ) return true;
		return false;
	}
	
	public static String trim(Object obj)
	{   // TODO trim
		if( obj != null ) return obj.toString().trim();
		return "";
	}
	
	public static String Null2Space(Object obj)
	{   // TODO Null2Space
		return Null2Space(obj, "&nbsp;");
	}

	public static String Null2Space(Object obj, Object dflt)
	{   // TODO Null2Space
		if( isNull(obj) ) return trim(dflt);
		else return trim(obj);
	}    
    
	/**
	 *	�レ���Comma(,) 泥�━ ���.
	 */
	public static String returnStrNumFmt(String sSrc)
	{   // TODO returnStrNumFmt
		return returnStrNumFmt(sSrc, "#,###");
	}
	
	public static String returnStrNumFmt(String sSrc, String sFmt)
	{   // TODO returnStrNumFmt
		if( isNull(sSrc) ) return Null2Space(sSrc);

        try {
            DecimalFormat sdf = (DecimalFormat) DecimalFormat.getInstance();
            if( !isNull(sFmt) ) sdf.applyPattern(sFmt);
            return sdf.format(Double.parseDouble(sSrc));
        } catch (NumberFormatException nfe) {
        	log.debug("NumberFormatException");
            return sSrc;
        }
	}  
	
	/**
	 *	�����(/) 泥�━ ���.
	 */	
	public static String returnStrDateFmt(String sSrc) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception
	{   // TODO returnStrDateFmt
		if( isNull(sSrc) ) return Null2Space(sSrc);

		sSrc = trim(sSrc);
		
		try{
			if( sSrc.length() == 6 )
			{				
					return returnStrDateFmt(sSrc, "yyyyMM", "yyyy/MM");
			}
			else if( sSrc.length() == 8 )
			{
				return returnStrDateFmt(sSrc, "yyyyMMdd", "yyyy/MM/dd");
			}
			else
			{
				return sSrc;
			}
		}catch(NullPointerException e){
			return sSrc;	
		}catch(ArrayIndexOutOfBoundsException e){
			return sSrc;
		}
		catch (Exception e) { return sSrc; }
	}

	public static String returnStrDateFmt(String sSrc, String sOldFmt, String sNewFmt) throws NullPointerException, ArrayIndexOutOfBoundsException, Exception
	{   // TODO returnStrDateFmt
		if( isNull(sSrc) ) return Null2Space(sSrc);

		sSrc = trim(sSrc);

		try
		{
			SimpleDateFormat sdf = (SimpleDateFormat) SimpleDateFormat.getInstance();
			sdf.applyPattern(sOldFmt);
			Date date = sdf.parse(sSrc);
			sdf.applyPattern(sNewFmt);
			return sdf.format(date);
		}catch(NullPointerException e){
			return sSrc;	
		}catch(ArrayIndexOutOfBoundsException v){
			return sSrc;
		}
		catch (Exception e) { return sSrc; }
	}	
	
	public static String returnCookie(Cookie[] cookies, String cname){
		// TODO returnCookie
		String re_value = "";
		if(cookies != null){
			 for( int i = 0; i < cookies.length; i++ ){
				   Cookie thisCookie =  cookies[i];
				   if(thisCookie.getName().equals(cname)){
					   re_value = thisCookie.getValue();
				   }
				   //out.println(thisCookie.getName() + " => " );
				   //out.println(thisCookie.getValue() + "<br>" );
			 }
		}
		return re_value;
	}
	
	/**
	 * 
	 * @param TotalCount
	 * @param show_rows
	 * @param TotalPageCount
	 * @param curr_page
	 * @param formname
	 * @param action
	 * @return
	 */
	public static String Pageindex(int TotalCount, String show_rows,
			int TotalPageCount, String curr_page, String formname, String action,
			String formele, String imgcon_root){
		// TODO Pageindex
		StringBuffer pagestr = new StringBuffer();
		int reapAmount= 10;
		int indexSize = 10;		
		int currs_page = Integer.parseInt(curr_page,10);
		//pagestr.append("<table border='0'  cellpadding='0' cellspacing='0'  >"
		//				+"\n<tbody>"
		//				+"\n<tr>"
		//				+"\n<td>");

	       int fromPage= ((currs_page) - ((currs_page - 1) % indexSize));
	       int toPage = TotalPageCount;
	       if (toPage > (fromPage + indexSize - 1)){
	  	       toPage = (fromPage + indexSize - 1);
	  	   }    
        
	      int prevPage =0;
	      int reapPrevPage =0;
	      boolean prevDisabled = false; 
	      boolean reapPrevDisabled = false; 
	      if(0<(currs_page-1)){
	         prevPage = currs_page-1;
	      }else{
	         prevDisabled = true;
	      }
	      if(0<(currs_page-reapAmount)){
	         reapPrevPage = currs_page-reapAmount;
	      }else{
	         reapPrevDisabled = true;
	      }
	      /*if(!reapPrevDisabled){     
	    	  pagestr.append("<img src='"+con_root+"/images/common/prev2.jpg' border='0'   "
	    			  		+" onClick=\"goPagination('"+formname+"','"+action+"','"+reapPrevPage+"','"+formele+"')\" "
	    			  		+" style='cursor:hand;' align='absmiddle'>&nbsp;");
	      }else{
	    	  pagestr.append("<img src='"+con_root+"/images/common/prev2.jpg' border='0'   align='absmiddle'>&nbsp;");
	      }*/ 
	      
	      pagestr.append("<img src='"+imgcon_root+"/board_first.gif' alt='泥�����吏� border='0' "
	    		  +" onClick=\"goPagination('"+formname+"','"+action+"','1','"+formele+"')\" "
	    		  + "onmouseover=this.src='"+imgcon_root+"/board_first.gif' "
	    		  + "onmouseout=this.src='"+imgcon_root+"/board_first.gif' align='absmiddle' />&nbsp;");
	      
	      if(!prevDisabled){  
	    	  pagestr.append("<img src='"+imgcon_root+"/board_prev.gif' alt='�댁����吏� border='0'   "
			  		+" onClick=\"goPagination('"+formname+"','"+action+"','"+prevPage+"','"+formele+"')\" "
			  		+ "onmouseover=this.src='"+imgcon_root+"/board_prev.gif' "
		    		+ "onmouseout=this.src='"+imgcon_root+"/board_prev.gif' align='absmiddle' />&nbsp;");
	      }else{
	    	  pagestr.append("<img src='"+imgcon_root+"/board_prev.gif' border='0' alt='�댁����吏�   align='absmiddle' />&nbsp;");	    	  
	      }
	      //pagestr.append("\n<TD colSpan='"+toPage+"' align='center'>");
		  	
	      for(int k=fromPage;k<=toPage;k++){ 
	    	  int index = k;
	    	  boolean isCurrentPage = (index == currs_page);  
			
	    	  if(isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"')\" class='A:link'><strong>"+index+"</strong></a>");
	    	  }
	  
	    	  if(!isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"')\" class='A:link'>"+index+"</a>");
	    	  }
	    	  
	    	  if(k!=toPage){
	    		  pagestr.append("&nbsp;/&nbsp;");
	    	  }
	      }
	      //pagestr.append("\n</td>");
	  

	      int nextPage =0;
	      int reapNextPage =0;
	      boolean nextDisabled = false; 
	      boolean reapNextDisabled = false; 
	      if(currs_page < Integer.MAX_VALUE){
	    	  if((currs_page+1) > 0){
			      if((currs_page+1)<=TotalPageCount){
				         nextPage = currs_page+1;
				  }else{
				         nextDisabled = true;
				  }	    		  
	    	  }else{
	    		  nextDisabled = true;
	    	  }
	    	  
	      }else{
	    	  nextDisabled = true;
	      }

	      if(currs_page < Integer.MAX_VALUE && (Long.valueOf(currs_page)+Long.valueOf(reapAmount)) < Long.valueOf(Integer.MAX_VALUE)){
	    	  if((currs_page+reapAmount) > 0){
			      if((currs_page+reapAmount)<=TotalPageCount){
				         reapNextPage = currs_page+reapAmount;
				  }else{
				         reapNextDisabled = true;
				  }	    		  
	    	  }else{
	    		  reapNextDisabled = true;
	    	  }
	    	  
	      }else{
	    	  reapNextDisabled = true;
	      }

	      if(!nextDisabled){  
	    	  pagestr.append("&nbsp;<img src='"+imgcon_root+"/board_next.gif' alt='�ㅼ����吏� border='0'   "
				  		+" onClick=\"goPagination('"+formname+"','"+action+"','"+nextPage+"','"+formele+"')\" "
				  		+ "onmouseover=this.src='"+imgcon_root+"/board_next.gif' "
			    		+ "onmouseout=this.src='"+imgcon_root+"/board_next.gif'  align='absmiddle' />&nbsp;");
	    	  
	      }else{
		      pagestr.append("\n&nbsp;<img src='"+imgcon_root+"/board_next.gif' alt='�ㅼ����吏� border='0' align='absmiddle' />&nbsp;"); 
	      }
	      
	      pagestr.append("<img src='"+imgcon_root+"/board_last.gif' alt='留��留���댁�' border='0' "
	    		  +" onClick=\"goPagination('"+formname+"','"+action+"','"+TotalPageCount+"','"+formele+"')\" "
	    		  + "onmouseover=this.src='"+imgcon_root+"/board_last.gif' "
	    		  + "onmouseout=this.src='"+imgcon_root+"/board_last.gif' align='absmiddle' />");	      
	      /*
	      if(!reapNextDisabled){
		      pagestr.append("<img src='"+con_root+"/images/common/next2.jpg' border='0' "
		    		  	+" onClick=\"goPagination('"+formname+"','"+action+"','"+reapNextPage+"','"+formele+"')\" " 
		    		  	+" style='cursor:hand;' align='absmiddle'>");	    	  
	      }else{
		      pagestr.append("<img src='"+con_root+"/images/common/next2.jpg' border='0' align='absmiddle' >"); 
	      }*/
	      //pagestr.append("\n</td></tr>"
	    	//	  +"\n</TBODY>"
	    	//	  +"\n</table>");		
		return pagestr.toString();
	}
	
	/**
	 * 
	 * @param TotalCount
	 * @param show_rows
	 * @param TotalPageCount
	 * @param curr_page
	 * @param formname
	 * @param action
	 * @return
	 */
	public static String Pageindex2(int TotalCount, String show_rows,
			int TotalPageCount, String curr_page, String formname, String action,
			String formele, String con_root){
		// TODO Pageindex
		StringBuffer pagestr = new StringBuffer();
		int reapAmount= 10;
		int indexSize = 10;		
		int currs_page = Integer.parseInt(curr_page,10);
		pagestr.append("<table border='0'  cellpadding='0' cellspacing='0'  >"
						+"\n<tbody>"
						+"\n<tr>"
						+"\n<td>");

	       int fromPage= ((currs_page) - ((currs_page - 1) % indexSize));
	       int toPage = TotalPageCount;
	       if (toPage > (fromPage + indexSize - 1)){
	  	       toPage = (fromPage + indexSize - 1);
	  	   }    
        
	      int prevPage =0;
	      int reapPrevPage =0;
	      boolean prevDisabled = false; 
	      boolean reapPrevDisabled = false; 
	      if(0<(currs_page-1)){
	         prevPage = currs_page-1;
	      }else{
	         prevDisabled = true;
	      }
	      if(0<(currs_page-reapAmount)){
	         reapPrevPage = currs_page-reapAmount;
	      }else{
	         reapPrevDisabled = true;
	      }
	      /*if(!reapPrevDisabled){     
	    	  pagestr.append("<img src='"+con_root+"/images/common/prev2.jpg' border='0'   "
	    			  		+" onClick=\"goPagination('"+formname+"','"+action+"','"+reapPrevPage+"','"+formele+"')\" "
	    			  		+" style='cursor:hand;' align='absmiddle'>&nbsp;");
	      }else{
	    	  pagestr.append("<img src='"+con_root+"/images/common/prev2.jpg' border='0'   align='absmiddle'>&nbsp;");
	      }*/ 
	      
	      if(!prevDisabled){  
	    	  pagestr.append("<img src='"+con_root+"/img/duty/icon_02.jpg' border='0'   "
			  		+" onClick=\"goPagination('"+formname+"','"+action+"','"+prevPage+"','"+formele+"')\" "
			  		+" style='cursor:hand;' align='absmiddle' />&nbsp;");
	      }else{
	    	  pagestr.append("<img src='"+con_root+"/img/duty/icon_02.jpg' border='0'    align='absmiddle' />&nbsp;");	    	  
	      }
	      //pagestr.append("\n<TD colSpan='"+toPage+"' align='center'>");
		  	
	      for(int k=fromPage;k<=toPage;k++){ 
	    	  int index = k;
	    	  boolean isCurrentPage = (index == currs_page);  
			
	    	  if(isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"')\" class='03_history A:link'><strong>"+index+"</strong></a>");
	    	  }
	  
	    	  if(!isCurrentPage){
	    		  pagestr.append("\n<a href=\"#\" onclick=\"goPagination('"+formname+"','"+action+"','"+index+"','"+formele+"')\" class='03_history A:link'>"+index+"</a>");
	    	  }
	    	  
	    	  if(k!=toPage){
	    		  pagestr.append("&nbsp;/&nbsp;");
	    	  }
	      }
	      //pagestr.append("\n</td>");
	  

	      int nextPage =0;
	      int reapNextPage =0;
	      boolean nextDisabled = false; 
	      boolean reapNextDisabled = false; 
	      
	      if(currs_page < Integer.MAX_VALUE){
	    	  if((currs_page+1) > 0){
			      if((currs_page+1)<=TotalPageCount){
				         nextPage = currs_page+1;
				  }else{
				         nextDisabled = true;
				  }	    		  
	    	  }else{
	    		  nextDisabled = true;
	    	  }
	    	  
	      }else{
	    	  nextDisabled = true;
	      }

	      if(currs_page < Integer.MAX_VALUE && (Long.valueOf(currs_page)+Long.valueOf(reapAmount)) < Long.valueOf(Integer.MAX_VALUE)){
	    	  if((currs_page+reapAmount) > 0){
			      if((currs_page+reapAmount)<=TotalPageCount){
				         reapNextPage = currs_page+reapAmount;
				  }else{
				         reapNextDisabled = true;
				  }	    		  
	    	  }else{
	    		  reapNextDisabled = true;
	    	  }
	    	  
	      }else{
	    	  reapNextDisabled = true;
	      }
	      


	      if(!nextDisabled){    
		      pagestr.append("\n&nbsp;<img src='"+con_root+"/img/duty/icon_01.jpg' border='0' "
		    		  	+" onClick=\"goPagination('"+formname+"','"+action+"','"+nextPage+"','"+formele+"')\" " 
		    		  	+" style='cursor:hand;' align='absmiddle' />&nbsp;"); 
	      }else{
		      pagestr.append("\n&nbsp;<img src='"+con_root+"/img/duty/icon_01.jpg' border='0' align='absmiddle' />&nbsp;"); 
	      }
	      /*
	      if(!reapNextDisabled){
		      pagestr.append("<img src='"+con_root+"/images/common/next2.jpg' border='0' "
		    		  	+" onClick=\"goPagination('"+formname+"','"+action+"','"+reapNextPage+"','"+formele+"')\" " 
		    		  	+" style='cursor:hand;' align='absmiddle'>");	    	  
	      }else{
		      pagestr.append("<img src='"+con_root+"/images/common/next2.jpg' border='0' align='absmiddle' >"); 
	      }*/
	      pagestr.append("\n</td></tr>"
	    		  +"\n</TBODY>"
	    		  +"\n</table>");		
		return pagestr.toString();
	}	
	
	
//	 硫��吏�� 異����� �댁����吏�� ���媛�� �⑥�
	public static String getPopup_msg(String msg) {
		// TODO getPopup_msg
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
	          		+"\n//<![CDATA["
	          		+"\nalert('"+msg+"');"
	          		+"\nhistory.back();"
	          		+"\n//]]>"   
	          		+"\n</script>";
		return rtn_str;
	}

	
	//	 硫��吏�� 異��留�����⑥�	
	public static String getPopup_msg_only(String msg) {
		// TODO getPopup_msg_only
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
					+"\n//<![CDATA["
	          		+"\nalert('"+msg+"');"
	          		+"\n//]]>"   
	          		+"\n</script>";
		return rtn_str;
	}

	//	 硫��吏�� 異����� 李쎈����⑥�
	public static String getPopup_msg_close(String msg) {
		// TODO getPopup_msg_close
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
					+"\n//<![CDATA["
	          		+"\nalert('"+msg+"');"
	          		+"\nself.close();"
	          		+"\n//]]>"   
	          		+"\n</script>";
		return rtn_str;
	}

	//	 硫��吏�� 異����� 遺�え李쎌� 由ы������� ���李쎈����⑥�
	public static String getPopup_msg_reload(String msg) {
		// TODO getPopup_msg_reload
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
	          		+"\n//<![CDATA["
	          		+"\nalert('"+msg+"');"
	          		+"\nopener.location.reload(true);"
	          		+"\nself.close();"
	          		+"\n//]]>"      
	          		+"\n</script>";
		return rtn_str;		
	}
	
	//	 硫��吏�� 異����� �����由ы������� ���李쎈����⑥�
	public static String getPopup_msg_reloadT(String target,String msg) {
		// TODO getPopup_msg_reload
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
	          		+"\n //<![CDATA["
	          		+"\n alert('"+msg+"');";
		if(!target.equals("")){
			rtn_str = rtn_str+"\n "+target+".location.reload(true);";
		}else{
			rtn_str = rtn_str+"\n location.reload(true);";
		}
		
		rtn_str = rtn_str+"\n //]]>"      
	          		+"\n </script>";
		return rtn_str;		
	}	

	//	 硫��吏�� 異����� �대� url濡��대� �⑥�
	public static String getPopup_msg_gourl(String url, String msg) {
		// TODO getPopup_msg_gourl
		
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
	          		+"\n//<![CDATA["
	          		+"\nalert('"+msg+"');"
	          		+"\nlocation.href='"+StripStrInXssUrl(url)+"';"
	          		+"alert("+StripStrInXssUrl(url)+");"
	          		+"\n//]]>"      
	          		+"\n</script>";
		return rtn_str;			
	}
	//	 硫��吏�� 異����� �대������� �대� url濡��대� �⑥�
	public static String getPopup_msg_gourl(String target, String url, String msg) {
		// TODO getPopup_msg_gourl
		
		String rtn_str = "";
		rtn_str = "<script type=\"text/javascript\" language=\"javascript\">" 
			+"\n//<![CDATA[";
		if(!msg.equals("")){
			rtn_str = rtn_str+"\nalert('"+msg+"');";
		}
			rtn_str = rtn_str+"\n"+target+".location.href='"+StripStrInXssUrl(url)+"';"
					+"\n//]]>"   
					+"alert("+StripStrInXssUrl(url)+");"
	          		+"\n</script>";
		return rtn_str;			
	}	
	
	//	 臾몄��댁� �ы���html��렇瑜���굅��� 硫����
	public static String StripStrInHtml(String orgString) {
		// TODO StripStrInHtml
		if(orgString == null){
			orgString = "";
		}
		orgString = orgString.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
		return orgString;			
	}	
	
	//	 臾몄��댁� �ы���Script��렇瑜���굅��� 硫����
	public static String StripStrInScripts (String orgString) {
		// TODO StripStrInHtml
		if(orgString == null){
			orgString = "";
		}
		orgString = orgString.replaceAll("<(no)?script[^>]*>.*?</(no)?script>", "");
		return orgString;			
	}	
	
	//	 臾몄��댁� �ы���Style��렇瑜���굅��� 硫����
	public static String StripStrInStyle (String orgString) {
		// TODO StripStrInHtml
		if(orgString == null){
			orgString = "";
		}
		orgString = orgString.replaceAll("<style[^>]*>.*</style>", "");
		return orgString;			
	}
	
	//	TODO StripStrInSqlInj  臾몄��댁� �ы���sql�몄�������댁�����굅��� 硫����
	public static String StripStrInSqlInj (String orgString) {
		if(orgString == null){
			orgString = "";
		}else{
			if(orgString.length() > 6){
				orgString = orgString.replaceAll("(?i);", "");
				orgString = orgString.replaceAll("(?i)'", "''");
				orgString = orgString.replaceAll("(?i)@variable", "");
				orgString = orgString.replaceAll("(?i)/+", "");
				orgString = orgString.replaceAll("(?i) print", "");
				orgString = orgString.replaceAll("(?i)print ", "");
				orgString = orgString.replaceAll("(?i) set", "");
				orgString = orgString.replaceAll("(?i)set ", "");
				orgString = orgString.replaceAll("(?i)%", "");
				orgString = orgString.replaceAll("(?i)script", "");
				orgString = orgString.replaceAll("(?i) or", "");
				orgString = orgString.replaceAll("(?i)or ", "");
				orgString = orgString.replaceAll("(?i) union", "");
				orgString = orgString.replaceAll("(?i)union ", "");
				orgString = orgString.replaceAll("(?i) and", "");
				orgString = orgString.replaceAll("(?i)and ", "");
				orgString = orgString.replaceAll("(?i)insert ", "");
				orgString = orgString.replaceAll("(?i) insert", "");
				orgString = orgString.replaceAll("(?i) openrowset", "");
				orgString = orgString.replaceAll("(?i)openrowset ", "");
				orgString = orgString.replaceAll("(?i)xp_ ", "");
				orgString = orgString.replaceAll("(?i) decare", "");
				orgString = orgString.replaceAll("(?i)decare ", "");
				orgString = orgString.replaceAll("(?i) select", "");
				orgString = orgString.replaceAll("(?i)select ", "");
				orgString = orgString.replaceAll("(?i) update", "");
				orgString = orgString.replaceAll("(?i)update ", "");
				orgString = orgString.replaceAll("(?i) delete", "");
				orgString = orgString.replaceAll("(?i)delete ", "");
				orgString = orgString.replaceAll("(?i)shutdown", "");
				orgString = orgString.replaceAll("(?i) drop", "");
				orgString = orgString.replaceAll("(?i)drop ", "");
				orgString = orgString.replaceAll("(?i)--", "");
				orgString = orgString.replaceAll("(?i)/*/", "");
				orgString = orgString.replaceAll("(?i)eval ", "");
				orgString = orgString.replaceAll("(?i)source", "");
				orgString = orgString.replaceAll("(?i)expression", "");
			}
		}
		return orgString;			
	}	
	
	//	TODO StripStrInXss  xss 방어
	public static String StripStrInXss (String orgString) {
		if(orgString == null){
			orgString = "";
		}else{
			if(orgString.length() > 6){
				orgString = orgString.replaceAll("(?i)&", "&amp;");
				orgString = orgString.replaceAll("(?i)<xmp", "<x-xmo");
				orgString = orgString.replaceAll("(?i)javascript", "<x-javascript");
				orgString = orgString.replaceAll("(?i)script", "<x-script");
				orgString = orgString.replaceAll("(?i)iframe", "<x-iframe");
				orgString = orgString.replaceAll("(?i)document", "<x-document");
				orgString = orgString.replaceAll("(?i)vbscript", "<x-vbscript");
				orgString = orgString.replaceAll("(?i)applet", "<x-applet");
				orgString = orgString.replaceAll("(?i)embed", "<x-embed");
				orgString = orgString.replaceAll("(?i)object", "<x-object");
				orgString = orgString.replaceAll("(?i)frame", "<x-frame");
				orgString = orgString.replaceAll("(?i)grameset", "<x-grameset");
				orgString = orgString.replaceAll("(?i)layer", "<x-layer");
				orgString = orgString.replaceAll("(?i)bgsound", "<x-bgsound");
				orgString = orgString.replaceAll("(?i)alert", "<x-alert");
				orgString = orgString.replaceAll("(?i)onblur", "<x-onblur");
				orgString = orgString.replaceAll("(?i)onchange", "<x-onchange");
				orgString = orgString.replaceAll("(?i)onclick", "<x-onclick");
				orgString = orgString.replaceAll("(?i)ondblclick", "<x-ondblclick");
				orgString = orgString.replaceAll("(?i)onerror", "<x-onerror");
				orgString = orgString.replaceAll("(?i)onfocus", "<x-onfocus");
				orgString = orgString.replaceAll("(?i)onload", "<x-onload");
				orgString = orgString.replaceAll("(?i)onmouse", "<x-onmouse");
				orgString = orgString.replaceAll("(?i)onscroll", "<x-onscroll");
				orgString = orgString.replaceAll("(?i)onsubmit", "<x-onsubmit");
				orgString = orgString.replaceAll("(?i)onunload", "<x-onunload");
				orgString = orgString.replaceAll("(?i)<", "&lt;");
				orgString = orgString.replaceAll("(?i)>", "&gt;");
				orgString = orgString.replaceAll("(?i)eval ", "");
				orgString = orgString.replaceAll("(?i)source", "");
				orgString = orgString.replaceAll("(?i)expression", "");
	
			}
		}
		return orgString;			
	}
	
//	TODO StripStrInXss  xss 방어
	public static String StripStrOutXss (String orgString) {
		if(orgString == null){
			orgString = "";
		}else{
			if(orgString.length() > 6){
//				orgString = orgString.replaceAll("<x-xmo", "<xmp");
//				orgString = orgString.replaceAll("<x-javascript", "javascript");
//				orgString = orgString.replaceAll("<x-script", "script");
//				orgString = orgString.replaceAll("<x-iframe", "iframe");
//				orgString = orgString.replaceAll("<x-document", "document");
//				orgString = orgString.replaceAll("<x-vbscript", "vbscript");
//				orgString = orgString.replaceAll("<x-applet", "applet");
//				orgString = orgString.replaceAll("<x-embed", "embed");
//				orgString = orgString.replaceAll("<x-object", "object");
//				orgString = orgString.replaceAll("<x-frame", "frame");
//				orgString = orgString.replaceAll("<x-grameset", "grameset");
//				orgString = orgString.replaceAll("<x-layer", "layer");
//				orgString = orgString.replaceAll("<x-bgsound", "bgsound");
//				orgString = orgString.replaceAll("<x-alert", "alert");
//				orgString = orgString.replaceAll("<x-onblur", "onblur");
//				orgString = orgString.replaceAll("<x-onchange", "onchange");
//				orgString = orgString.replaceAll("<x-onclick", "onclick");
//				orgString = orgString.replaceAll("<x-ondblclick", "ondblclick");
//				orgString = orgString.replaceAll("<x-onerror", "onerror");
//				orgString = orgString.replaceAll("<x-onfocus", "onfocus");
//				orgString = orgString.replaceAll("<x-onload", "onload");
//				orgString = orgString.replaceAll("<x-onmouse", "onmouse");
//				orgString = orgString.replaceAll("<x-onscroll", "onscroll");
//				orgString = orgString.replaceAll("<x-onsubmit", "onsubmit");
//				orgString = orgString.replaceAll("<x-onunload", "onunload");
				orgString = orgString.replaceAll("&amp;", "&");
				orgString = orgString.replaceAll("&lt;", "<");
				orgString = orgString.replaceAll("&gt;", ">");
				orgString = orgString.replaceAll("&amp;", "&");
				orgString = orgString.replaceAll("&nbsp;", " ");
	
			}
		}
		return orgString;			
	}
	
	public static String StripStrInXssUrl (String orgString) {
		if(orgString == null){
			orgString = "";
		}else{
			if(orgString.length() > 6){
				orgString = orgString.replaceAll("(?i)<xmp", "<x-xmo");
				orgString = orgString.replaceAll("(?i)javascript", "<x-javascript");
				orgString = orgString.replaceAll("(?i)script", "<x-script");
				orgString = orgString.replaceAll("(?i)iframe", "<x-iframe");
				orgString = orgString.replaceAll("(?i)document", "<x-document");
				orgString = orgString.replaceAll("(?i)vbscript", "<x-vbscript");
				orgString = orgString.replaceAll("(?i)applet", "<x-applet");
				orgString = orgString.replaceAll("(?i)embed", "<x-embed");
				orgString = orgString.replaceAll("(?i)object", "<x-object");
				orgString = orgString.replaceAll("(?i)frame", "<x-frame");
				orgString = orgString.replaceAll("(?i)grameset", "<x-grameset");
				orgString = orgString.replaceAll("(?i)layer", "<x-layer");
				orgString = orgString.replaceAll("(?i)bgsound", "<x-bgsound");
				orgString = orgString.replaceAll("(?i)alert", "<x-alert");
				orgString = orgString.replaceAll("(?i)onblur", "<x-onblur");
				orgString = orgString.replaceAll("(?i)onchange", "<x-onchange");
				orgString = orgString.replaceAll("(?i)onclick", "<x-onclick");
				orgString = orgString.replaceAll("(?i)ondblclick", "<x-ondblclick");
				orgString = orgString.replaceAll("(?i)onerror", "<x-onerror");
				orgString = orgString.replaceAll("(?i)onfocus", "<x-onfocus");
				orgString = orgString.replaceAll("(?i)onload", "<x-onload");
				orgString = orgString.replaceAll("(?i)onmouse", "<x-onmouse");
				orgString = orgString.replaceAll("(?i)onscroll", "<x-onscroll");
				orgString = orgString.replaceAll("(?i)onsubmit", "<x-onsubmit");
				orgString = orgString.replaceAll("(?i)onunload", "<x-onunload");
				orgString = orgString.replaceAll("(?i)<", "&lt;");
				orgString = orgString.replaceAll("(?i)>", "&gt;");
				orgString = orgString.replaceAll("(?i)eval ", "");
				orgString = orgString.replaceAll("(?i)source", "");
				orgString = orgString.replaceAll("(?i)expression", ""); 
				orgString = orgString.replaceAll("(?i)window", ""); 
				orgString = orgString.replaceAll("(?i)location", ""); 
			}
		}
		return orgString;			
	}
	
	//	TODO StripStrArrInXss  xss 방어
	public static String [] StripStrArrInXss (String [] orgStringArr) {
		int i = 0;
		String tmp_str = "";
		String [] rtn_str_arr = new String[orgStringArr.length];
		if(orgStringArr != null){
			for(i=0;i<orgStringArr.length;i++){
				tmp_str = orgStringArr[i];
				if(tmp_str.length() > 6){
					tmp_str = tmp_str.replaceAll("(?i)&", "&amp;");
					tmp_str = tmp_str.replaceAll("(?i)<xmp", "<x-xmo");
					tmp_str = tmp_str.replaceAll("(?i)javascript", "<x-javascript");
					tmp_str = tmp_str.replaceAll("(?i)script", "<x-script");
					tmp_str = tmp_str.replaceAll("(?i)iframe", "<x-iframe");
					tmp_str = tmp_str.replaceAll("(?i)document", "<x-document");
					tmp_str = tmp_str.replaceAll("(?i)vbscript", "<x-vbscript");
					tmp_str = tmp_str.replaceAll("(?i)applet", "<x-applet");
					tmp_str = tmp_str.replaceAll("(?i)embed", "<x-embed");
					tmp_str = tmp_str.replaceAll("(?i)object", "<x-object");
					tmp_str = tmp_str.replaceAll("(?i)frame", "<x-frame");
					tmp_str = tmp_str.replaceAll("(?i)grameset", "<x-grameset");
					tmp_str = tmp_str.replaceAll("(?i)layer", "<x-layer");
					tmp_str = tmp_str.replaceAll("(?i)bgsound", "<x-bgsound");
					tmp_str = tmp_str.replaceAll("(?i)alert", "<x-alert");
					tmp_str = tmp_str.replaceAll("(?i)onblur", "<x-onblur");
					tmp_str = tmp_str.replaceAll("(?i)onchange", "<x-onchange");
					tmp_str = tmp_str.replaceAll("(?i)onclick", "<x-onclick");
					tmp_str = tmp_str.replaceAll("(?i)ondblclick", "<x-ondblclick");
					tmp_str = tmp_str.replaceAll("(?i)onerror", "<x-onerror");
					tmp_str = tmp_str.replaceAll("(?i)onfocus", "<x-onfocus");
					tmp_str = tmp_str.replaceAll("(?i)onload", "<x-onload");
					tmp_str = tmp_str.replaceAll("(?i)onmouse", "<x-onmouse");
					tmp_str = tmp_str.replaceAll("(?i)onscroll", "<x-onscroll");
					tmp_str = tmp_str.replaceAll("(?i)onsubmit", "<x-onsubmit");
					tmp_str = tmp_str.replaceAll("(?i)onunload", "<x-onunload");
					tmp_str = tmp_str.replaceAll("(?i)<", "&lt;");
					tmp_str = tmp_str.replaceAll("(?i)>", "&gt;");
					tmp_str = tmp_str.replaceAll("(?i)eval ", "");
					tmp_str = tmp_str.replaceAll("(?i)source", "");
					tmp_str = tmp_str.replaceAll("(?i)expression", "");					
		
				}
				
				orgStringArr[i] = tmp_str;
			}
		}

		return rtn_str_arr;			
	}	
}
