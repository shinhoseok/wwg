/*===================================================================================
 * System             : Jrinfo Library �����
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.db.SQLResults.java
 * Description        : Result瑜� SQLResults����쇰� ������ �대���
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
package com.ji.common.db;


import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;
import java.math.BigDecimal;
import java.sql.*;



/**
 * SQLResult��SQL 議고���寃곌낵瑜�ArrayList�����濡�硫�え由ъ� �����ŉ, �대� 寃곌낵 Field瑜������린
 * ��� 硫����� ��났���.
 * 
 * ������ㅼ�怨�媛��.<br>
 * <pre>
 *   DBHelper dbHelper = new DBHelper();
 * 
 *   <b>SQLResults res = dbHelper.runQueryCloseCon("SELECT * FROM INV");
 *   String out = "";
 *   for (int row=0; row < res.getRowCount(); row++)
 *      out += res.getLong(row, "TEST_ID") + " " + res.getString(row, "NOTES") + " " +
 *             res.getDate(row, "TEST_DT") + " " + res.getDouble(row, "AMOUNT") + " " + 
 *             res.getString(row, "CODE") + "\n";</b> 
 *   System.out.println(out);
 * 
 *  // �ㅼ�怨�媛�� 諛⑸��쇰���SQLResults��寃곌낵瑜�媛�� �������.
 *   SQLResults res = dbHelper.runQueryCloseCon("SELECT FIRST_FIELD, SECOND_FIELD FROM INV");
 * 
 *   // 寃곌낵��泥ル�吏������� 泥ル�吏����瑜��살��⑤�.
 *   res.getLong(0, 0); 
 *   
 *   //寃곌낵��泥ル�吏������� ���吏����瑜��살��⑤�.
 *   res.getString(0, 1);
 * </pre>
 * 
 * @author Softtech. Jeff S Smith
 */
public class SQLResults
{
    /** ArrayList containing the results of the sql query */
    private ArrayList results = null;
    
    /** ArrayList containing the column names returned by the sql query */
    private ArrayList columnNames = null;
    
    /** number of columns returned by the sql query */
    private int columnCount = 0;
    
    /** database type (e.g. DatabaseType.ORACLE), needed for exception handling */
    private int dbType;
    
    /** formatted width of each field included in toString() */
    private int toStringFormatWidth = 12;  
    
    /**
     * 珥�린��
     * @param dbType
     * @param columnCount
     */
    public SQLResults(int dbType, int columnCount)
    {
        results = new ArrayList();
        columnNames = new ArrayList();
        this.dbType = dbType;
        this.columnCount = columnCount;
    }

    /**
     * Column��媛��瑜�Get
     * @return count Result set��Column 媛��
     */
    public int getColumnCount()
    {
        return(columnNames.size());
    }
    
    /**
     * SQL Column name瑜�Get
     * @return arraylist Column紐�� �댁� ArrayList 媛�껜
     */
    public ArrayList getColumnNames()
    {
    	ArrayList rlt = null;
    	
    	if(columnNames != null) {
    		rlt = new ArrayList();
    		
    		for(int i=0; i < columnNames.size(); i++) {
    			rlt = (ArrayList)columnNames.get(i);
    		}
    	}
    	return(rlt);
    }
    
    /**
     * List ���濡�SQLResult瑜�諛�����.
     * @return List
     */
    public List toList()
    {
    	ArrayList ret = null;
    	
    	if(results != null) {
    		ret = new ArrayList();
    		
    		for(int i=0; i < results.size(); i++) {
    			ret = (ArrayList)results.get(i);
    		}
    	}
    	return(ret);
    }
    
    public void setToStringFormatWidth(int toStringFormatWidth)
    {
        this.toStringFormatWidth = toStringFormatWidth;
    }
        
    /** 
     * SQL 寃곌낵 List��異����� Object 媛�� Add ���.
     * @param o
     */
    public boolean add(Object o)
    {
        return(results.add(o));
    }
    
    /**
     * Query����� 由ы���Row ��
     * @return number 
     */
    public int getRowCount()
    {
        int rowCnt = results.size() / columnCount;
        return(rowCnt);
    }
    
    /**
     * �뱀� �������낵 ��� �댁� index濡�寃곌낵媛�� Object ���濡�由ы����.
     * @param row
     * @param col
     * @return object
     */
    public Object getObject(int row, int col)
    {
        int index = (row * columnCount) + col;
        return(results.get(index));
    }
    
	/**
	 * Column 紐�� ����쇰� 異�� ���.
	 * @param columnName
	 */
    public void addColumnName(String columnName)
    {
        columnNames.add(columnName);        
    }
    
    private int getColumnIndex(String columnName)
    {
        int colIndex = -1;
        for (int i=0; i < columnNames.size(); i++)
        {
            String thisColumnName = (String)columnNames.get(i); 
            if (thisColumnName.equalsIgnoreCase(columnName))
            {
                colIndex = i;
                break;
            }
        }

        return(colIndex);
    }
    
    /**
     * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� int ���濡�get
     * @param row
     * @param columnName
     * @return int field ��媛�
     */
    public int getInt(int row, String columnName)
    {
        return(getInt(row, getColumnIndex(columnName)));
    }

    /**
     * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� int ���濡�get
     * @param row
     * @param col
     * @return int field ��媛�
     */
    public int getInt(int row, int col)
    {
        if (isNull(row, col))
            return(0);
            
        Object o = getObject(row, col);
        if (o instanceof Integer)
            return(((Integer)o).intValue());
        else    
            return(((BigDecimal)o).intValue());
    }

	/**
	 * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� long ���濡�get
	 * @param row
	 * @param columnName
	 * @return long field ��媛�
	 */
    public long getLong(int row, String columnName)
    {
        return(getLong(row, getColumnIndex(columnName)));
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� long ���濡�get
	 * @param row
	 * @param col
	 * @return int field ��媛�
	 */
    public long getLong(int row, int col)
    {
        if (isNull(row, col))
            return(0);
            
        Object o = getObject(row, col);
        if (o instanceof Long)
            return(((Long)o).longValue());
        else if (o instanceof Integer)    
            return(((Integer)o).longValue());
        else 
            return(((BigDecimal)o).longValue());
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� String ���濡�get
	 * @param row
	 * @param col
	 * @return String field ��媛�
	 */
    public String getString(int row, int col)
    {
        Object o = getObject(row, col);
        if (o instanceof BigDecimal)
        {
            BigDecimal b = (BigDecimal)o;
            return("" + getDouble(row, col)); 
        }
        else if (o instanceof Integer)
            return("" + getInt(row, col));
        else if ((o instanceof Date) || (o instanceof Timestamp))
            return("" + getDate(row, col));
        else 
        {
            String s = (String)o; 
            return(s);
        }
    }
    
	/**
	 * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� String ���濡�get
	 * @param row
	 * @param columnName
	 * @return String field ��媛�
	 */
    public String getString(int row, String columnName)
    {
        return(getString(row, getColumnIndex(columnName)));
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� boolean ���濡�get
	 * @param row
	 * @param col
	 * @return boolean field ��媛�
	 */
    public boolean getBoolean(int row, int col)
    {
        if (isNull(row, col))
            return(false);

        Object o = getObject(row, col);
        Boolean b = (Boolean)o; 
        return(b.booleanValue());
    }
    
	/**
	 * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� boolean ���濡�get
	 * @param row
	 * @param columnName
	 * @return boolean field ��媛�
	 */
    public boolean getBoolean(int row, String columnName)
    {
        return(getBoolean(row, getColumnIndex(columnName)));
    }

	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� Date ���濡�get
	 * @param row
	 * @param col
	 * @return Date field ��媛�
	 */
    public Date getDate(int row, int col)
    {
        if (isNull(row, col))
            return(null);

        Object o = getObject(row, col);
        if (o instanceof Timestamp)
        {
            Timestamp t = (Timestamp)o;
            Date d = new Date(t.getTime());
            return(d);
        }
        else
        {
            Date d = (Date)o; 
            return(d);
        }
    }
    
	/**
	 * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� Date ���濡�get
	 * @param row
	 * @param columnName
	 * @return Date field ��媛�
	 */
    public Date getDate(int row, String columnName)
    {
        return(getDate(row, getColumnIndex(columnName)));
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� java.sql.Time ���濡�get
	 * @param row
	 * @param col
	 * @return Time field ��媛�
	 */
    public Time getTime(int row, int col)
    {
        if (isNull(row, col))
            return(null);

        Object o = getObject(row, col);
        Time t = (Time)o; 
        return(t);
    }

	/**
	 * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� java.sql.Time ���濡�get
	 * @param row
	 * @param columnName
	 * @return java.sql.Time field ��媛�
	 */
    public Time getTime(int row, String columnName)
    {
        return(getTime(row, getColumnIndex(columnName)));
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� Timestamp ���濡�get
	 * @param row
	 * @param col
	 * @return Timestamp field ��媛�
	 */
    public Timestamp getTimestamp(int row, int col)
    {
        if (isNull(row, col))
            return(null);

        Object o = getObject(row, col);
        if (o instanceof Date)
        {
            Date d = (Date)o;
            Timestamp t = new Timestamp(d.getTime()); 
            return(t);
        }
        else
        {    
            Timestamp t = (Timestamp)o; 
            return(t);
        }
    }

	/**
	 * Query 寃곌낵����� �뱀� ������ ��� ColumnName�쇰� �대� 媛�� Timestamp ���濡�get
	 * @param row
	 * @param columnName
	 * @return Timestamp field ��媛�
	 */
    public Timestamp getTimestamp(int row, String columnName)
    {
        return(getTimestamp(row, getColumnIndex(columnName)));
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� double ���濡�get
	 * @param row
	 * @param col
	 * @return double field ��媛�
	 */
    public double getDouble(int row, int col)
    {
        if (isNull(row, col))
            return(0);
        
        Object o = getObject(row, col);
        if (o instanceof BigDecimal)
        {
            BigDecimal b = (BigDecimal)o;
            return(b.doubleValue()); 
        }
        else
        {
            Double d = (Double)o; 
            return(d.doubleValue());
        }
    }

	/**
	 * Query 寃곌낵 以��뱀� ������ ��� ColumnName�쇰� �대� 媛�� Timestamp ���濡�get
	 * @param row
	 * @param columnName
	 * @return Timestamp field ��媛�
	 */
    public double getDouble(int row, String columnName)
    {
        return(getDouble(row, getColumnIndex(columnName)));
    }
    
	/**
	 * Query 寃곌낵 以��뱀� ������ ��� index濡��대� 媛�� float ���濡�get
	 * @param row
	 * @param col
	 * @return float field ��媛�
	 */
    public float getFloat(int row, int col)
    {
        if (isNull(row, col))
            return(0);

        Object o = getObject(row, col);
        if (o instanceof BigDecimal)
        {
            BigDecimal b = (BigDecimal)o;
            return(b.floatValue()); 
        }
        else
        {
            Float f = (Float)o; 
            return(f.floatValue());
        }
    }

	/**
	 * Query 寃곌낵 以��뱀� ������ ��� ColumnName�쇰� �대� 媛�� float ���濡�get
	 * @param row
	 * @param columnName
	 * @return float field ��媛�
	 */
    public float getFloat(int row, String columnName)
    {
        return(getFloat(row, getColumnIndex(columnName)));
    }
    

    public String toString()
    {
        
            
        StringBuffer out = new StringBuffer("");
        if (columnCount < 1){ return(out.toString());}      
        for (int col=0; col < columnCount; col++)
        {
            String formattedColName = formatWithSpaces((String)columnNames.get(col));    
            out.append(formattedColName);
        }
        
        out.deleteCharAt(out.length()-2);    
        int len = out.length();
        out.append("\n");
        for (int i=0; i < len-1; i++)
            out.append("-");
        out.append("\n");         

        for (int row=0; row < getRowCount(); row++)
        {
            for (int col=0; col < columnCount; col++)
            {
                String formattedColName = null;    
                if (isNull(row, col))
                    formattedColName = formatWithSpaces("NULL");    
                else
                    formattedColName = formatWithSpaces(getString(row, col));    
                out.append(formattedColName);
            }
            out.deleteCharAt(out.length()-2);    
            out.append("\n");
        }
        
        return(out.toString());        
    }
    
    private String formatWithSpaces(String s)
    {
        StringBuffer sb = new StringBuffer(s);
        if (s.length() < toStringFormatWidth)
        {
            for (int i=0; i < toStringFormatWidth-s.length(); i++)
                sb.append(" ");
            return(sb.toString());    
        }
        else
        {
            return(sb.substring(0, toStringFormatWidth));
        }
    }
    
    /**
     * 荑쇰━ 寃곌낵 以��뱀� ������ ��� index��媛�� null�몄� ���
     * @param row
     * @param col
     * @return true if null
     */
    public boolean isNull(int row, int col)
    {
        Object o = getObject(row, col);
        return(o == null);    
    }
    
    /**
     * 寃곌낵 ������뱀� ColumnName��媛�� null�몄� ���
     * @param row
     * @param columnName
     * @return true if null
     */
    public boolean isNull(int row, String columnName)
    {
        return(isNull(row, getColumnIndex(columnName)));
    }
}
