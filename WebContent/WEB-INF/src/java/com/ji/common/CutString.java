package com.ji.common;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;

public class CutString extends TagSupport {

    private static final long serialVersionUID = 1L;

    private String  contents;
    private Integer length;
    private String  word;
    
    private Integer defaultLength = 40;
    private String  defaultWord   = "...";

    public int doEndTag() throws JspException {

	try {

	    length = length != null ? length : defaultLength;
	    word   = word   != null ? word   : defaultWord;
	    
	    JspWriter out = pageContext.getOut();
	    
	    if(!"".equals(StringUtils.defaultString(contents)) && contents.length() > length) {
		contents = contents.substring(0, length) + word;
	    }
	    
	    out.println(contents);

	    return EVAL_PAGE;

	} catch (IOException e) {
	    throw new JspException();
	}
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }


}
