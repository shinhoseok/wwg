package com.ji.common;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class MaskingTag extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String  gugun;
    private String  name;
    
    public int doEndTag() throws JspException {

		try {
			
		    JspWriter out = pageContext.getOut();
		    
		    String mask = "";
		    
	    	if(name.length() > 2){
	    		mask = StringUtil.substring(name,0,1)+StringUtil.rpad("*",name.length()-2,"*")+name.substring(name.length()-1,name.length());
	    	}else{	//이름이 2자이하인 경우
	    		mask = StringUtil.substring(name,0,1)+StringUtil.rpad("*",name.length()-2,"*");
	    	}
	    	
		    out.println(mask);
	
		    return EVAL_PAGE;
	
		} catch (IOException e) {
		    throw new JspException();
		}
    }

	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
    
    
}
