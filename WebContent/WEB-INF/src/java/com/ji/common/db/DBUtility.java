/*===================================================================================
 * System             : Jrinfo Library �����
 * Program Id         : 
 * Program Name       :
 * Source File Name   : com.ji.common.db.DBUtility.java
 * Description        : �곗��곕��댁���愿�����ㅼ���湲곕�����났��� �대���
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

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.*;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ji.common.JSysException;

//import oracle.jdbc.driver.OracleTypes;
import oracle.jdbc.internal.OracleResultSet;
import oracle.sql.CHAR;
import oracle.sql.CLOB;

public class DBUtility {
	/**
	 * ��� �대��ㅼ� ��� 濡�렇瑜�泥�━��� 蹂��
	 *
	 * @see org.apache.commons.logging.Log
	 * @see org.apache.commons.logging.LogFactory
	 */
	private static Log log = LogFactory.getLog(DBUtility.class);	
    /** DataBase Connnection */
    private Connection con = null;

    /** SELECT 援щЦ ��� ��由ы���� 理�� Rows ��*/
    private int maxRows = 0;

    /** SQL parameter瑜������� ArrayList */
    private ArrayList params = null;

    /** ArrayList which stores whether SQL parameters are stored proc Out parameters */
    private ArrayList isStoredProcOutParam = null;

    /** DataBase Type (for example, DatabaseType.ORACLE) */
    private static int dbType;

    /** timeout interval for long running queries */
    private int timeoutInSec = 0;  //0 = no timeout

    /** prepared statement used in calls to runQuery() and runQueryKeepConnOpen() */
    private PreparedStatement prepStatement = null;

    /** remember the last SQL statement (so we don't re-prepare a statement if SQL doesn't change */
    private String lastSQL = null;

    /** number of rows updated in last runQuery() */
    private int numRecordsUpdated = 0;
	
    public final static int UNKNOWN = 0;
    public final static int ORACLE = 1;
    public final static int MYSQL = 2;
    public final static int UNISQL = 3;
    public final static int MSSQL = 4;
    
    public final static String ORACLE_NAME = "ORACLE";
    public final static String MYSQL_NAME = "MYSQL";
    public final static String UNISQL_NAME = "UNISQL";
    public final static String MSSQL_NAME = "MSSQL";
    
	/**
	 * ��껜 ConnectionPool 媛�껜瑜��댁���� ��� 寃쎌� �����
	 * @throws JSysException 
	 */
	public DBUtility(Connection dsConnection) throws JSysException
	{
		params = new ArrayList();
		isStoredProcOutParam = new ArrayList();
		con = dsConnection;
		dbType = getDbType(con);
	}    
    

    /** Connection���살� �⑤�.
     * @return Connection
     */
    public Connection getConnection()
    {
        return(con);
    }

    public int getdbType()
    {
    	return(dbType);
    }
    
    /**
     * Parses the connection info to determine the database type 
     * @param con Connection
     * @return int type of database (e.g. ORACLE)
     * @throws JSysException 
     */
    static int getDbType(Connection con) throws JSysException
    {
        String dbName = null;
        int dbType = 0;
        
        try
        {
            dbName = con.getMetaData().getDatabaseProductName();
            
            
            if (dbName.equalsIgnoreCase("ORACLE"))
                dbType = ORACLE;
            else if (dbName.equalsIgnoreCase("MYSQL"))
                dbType = MYSQL;
            else if (dbName.equalsIgnoreCase("UNISQL"))
            	dbType = UNISQL;
            else if (dbName.equalsIgnoreCase("MSSQL"))
            	dbType = MSSQL;            
        }
        catch (SQLException e)
        {
        	throw new JSysException("Exception: unknown database:");
        }
        return (dbType);
    }
    
    /**
     * Parses the driver name to determine the database type
     * @param driverName String
     * @return int type of database (e.g. ORACLE)
     */
    static int getDbType(String driverName)
    {
        int dbType = 0;
        
        if (driverName.toUpperCase().indexOf(ORACLE_NAME) > -1)
            dbType = ORACLE;
        else if (driverName.toUpperCase().indexOf(MYSQL_NAME) > -1)
            dbType = MYSQL;
        else if (driverName.toUpperCase().indexOf(UNISQL_NAME) > -1)
            dbType = UNISQL;
        else if (driverName.toUpperCase().indexOf(MSSQL_NAME) > -1)
            dbType = MSSQL;        
        
        return(dbType);                    
    }
    
    /**
     * QUERY��Parameter list瑜�������.
     */
    public void clearParams()
    {
        params.clear();
        isStoredProcOutParam.clear();
    }

    /**
     * QUERY���ㅼ���Parameter瑜��ㅼ����.
     */
	public void setParams(Collection alreadyParams)
	{
		params.addAll(alreadyParams);
	}

	/**
	 * �ㅼ���Parameter ��낫瑜��살��⑤�.
	 */
	public ArrayList getParams()
	{
		ArrayList ret = null;
    	
    	if(params != null) {
    		ret = new ArrayList();
    		
    		for(int i=0; i < params.size(); i++) {
    			ret = (ArrayList)params.get(i);
    		}
    	}
    	return(ret);
	}

    /**
     * Query��Parameter List����Object ��Parameter瑜�異�� ���.
     * @param param list��異����parameter
     */
    public void addParam(Object param)
    {
        params.add(param);
        isStoredProcOutParam.add(Boolean.FALSE);
    }

    /** Query��Parameter List����int ��Parameter瑜�異�� ���.
     * @param param list��異����parameter
     */
    public void addParam(int param)
    {
        addParam(new Integer(param));
    }

    /** Query��Parameter List����long ��Parameter瑜�異�� ���.
     * @param param list��異����parameter
     */
    public void addParam(long param)
    {
        addParam(new Long(param));
    }

    /** Query��Parameter List����double ��Parameter瑜�異�� ���.
     * @param param list��異����parameter
     */
    public void addParam(double param)
    {
        addParam(new Double(param));
    }

    /** Query��Parameter List����boolean ��Parameter瑜�異�� ���.
     * @param param list��異����parameter
     */
    public void addParam(boolean param)
    {
        addParam(new Boolean(param));
    }

    /** Query��Parameter List����float ��Parameter瑜�異�� ���.
     * @param param param list��異����parameter
     */
    public void addParam(float param)
    {
        addParam(new Float(param));
    }

    /** Query��Parameter List����short ��Parameter瑜�異�� ���.
     * @param param param list��異����parameter
     */
    public void addParam(short param)
    {
        addParam(new Short(param));
    }

    public void addStoredProcOutParam(Object param)
    {
        params.add(param);
        isStoredProcOutParam.add(Boolean.TRUE);
    }

    /** Query��Parameter List��size瑜�諛�����.
     * @return int
     */
    public int getCountParams()
    {
        return(params.size());
    }
    
	/** Stored Procedure瑜�������.
	 * @return SQLResults
	 * @throws JSysException 
	 */
    public SQLResults runStoredProc(String spName) throws JSysException
    {
        SQLResults results = new SQLResults(dbType, params.size());

        StringBuffer sql = new StringBuffer("{call " + spName + "(");
        
        CallableStatement cs = null;

        for (int i=0; i < params.size(); i++)
        {
            sql.append("?");
            if (i < (params.size()-1))
                sql.append(",");
        }
        sql.append(")}");

        try
        {
            cs = con.prepareCall(sql.toString());

            for (int i=0; i < params.size(); i++)
            {
                Object param = params.get(i);
                boolean isOutParam = ((Boolean)isStoredProcOutParam.get(i)).booleanValue();

                if (param instanceof Integer)
                {

                    int value = ((Integer)param).intValue();
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.INTEGER);
                    else
                        cs.setInt(i+1, value);
                }
                else if (param instanceof Short)
                {
                    short sh = ((Short)param).shortValue();
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.SMALLINT);
                    else
                        cs.setShort(i+1, sh);
                }
                else if (param instanceof String)
                {
                    String s = (String)param;

	                    if (isOutParam)
	                        cs.registerOutParameter(i+1, java.sql.Types.VARCHAR);
	                    else
	                        cs.setString(i+1, s);
                }
                else if (param instanceof Double)
                {
                    double d = ((Double)param).doubleValue();
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.DOUBLE);
                    else
                        cs.setDouble(i+1, d);
                }
                else if (param instanceof Float)
                {
                    float f = ((Float)param).floatValue();

                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.FLOAT);
                    else
                        cs.setFloat(i+1, f);
                }
                else if (param instanceof Long)
                {
                    long l = ((Long)param).longValue();

                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.BIGINT);
                    else
                        cs.setFloat(i+1, l);
                }
                else if (param instanceof Boolean)
                {
                    boolean b = ((Boolean)param).booleanValue();

                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.BIT);
                    else
                        cs.setBoolean(i+1, b);
                }
                else if (param instanceof java.sql.Date)
                {
                    java.sql.Date d = (java.sql.Date)param;
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.DATE);
                    else
                        cs.setDate(i+1, (java.sql.Date)param);
                }
                else {
                    
                }
            }

            cs.executeUpdate();  //run the stored procedure

            for (int i=0; i < params.size(); i++)
            {
                    //add column names to ResultSet object
                String colName = "" + (i+1);
                results.addColumnName(colName);

                boolean isOutParam = ((Boolean)isStoredProcOutParam.get(i)).booleanValue();
                if (isOutParam)
                    results.add(cs.getObject(i+1));  //add output parameter value to ResultSet object
                else
                    results.add("null");
            }

            
        }
        catch (SQLException e)
        {
        	throw new JSysException("Exception: runStoredProc :");
        }
        finally
        {

            clearParams();
            try{
            	if(cs!=null)cs.close();
            }catch (SQLException e){
            	throw new JSysException("Exception: runStoredProc :");
            }
            
        }

        return(results);
    }

	/** Stored Procedure瑜���� ��� Connection���댁� ���.
	 * @return SQLResults
	 * @throws JSysException 
	 */
    public SQLResults runStoredProcCloseCon(String spName) throws JSysException
    {
        try
        {
            return(runStoredProc(spName));
        }
        finally
        {
        	closeConnection();
        }
    } 
    
    public SQLResults runStoredFunc(String spName) throws JSysException
    {
        SQLResults results = new SQLResults(dbType, params.size());

        StringBuffer sql = new StringBuffer("{? = call " + spName + "(");

        CallableStatement cs = null;
        for (int i=0; i < params.size()-1; i++)
        {
            sql.append("?");
            if (i < (params.size()-2))
                sql.append(",");
        }
        sql.append(")}");

        try 
        {
            cs = con.prepareCall(sql.toString());

            for (int i=0; i < params.size(); i++)
            {
                Object param = params.get(i);
                boolean isOutParam = ((Boolean)isStoredProcOutParam.get(i)).booleanValue();

                if (param instanceof Integer)
                {

                    int value = ((Integer)param).intValue();
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.INTEGER);
                    else
                        cs.setInt(i+1, value);
                }
                else if (param instanceof Short)
                {
                    short sh = ((Short)param).shortValue();
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.SMALLINT);
                    else
                        cs.setShort(i+1, sh);
                }
                else if (param instanceof String)
                {
                    String s = (String)param;

                            if (isOutParam)
                                cs.registerOutParameter(i+1, java.sql.Types.VARCHAR);
                            else
                                cs.setString(i+1, s);
                }
                else if (param instanceof Double)
                {
                    double d = ((Double)param).doubleValue();
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.DOUBLE);
                    else
                        cs.setDouble(i+1, d);
                }
                else if (param instanceof Float)
                {
                    float f = ((Float)param).floatValue();

                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.FLOAT);
                    else
                        cs.setFloat(i+1, f);
                }
                else if (param instanceof Long)
                {
                    long l = ((Long)param).longValue();

                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.BIGINT);
                    else
                        cs.setFloat(i+1, l);
                }
                else if (param instanceof Boolean)
                {
                    boolean b = ((Boolean)param).booleanValue();

                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.BIT);
                    else
                        cs.setBoolean(i+1, b);
                }
                else if (param instanceof java.sql.Date)
                {
                    java.sql.Date d = (java.sql.Date)param;
                    if (isOutParam)
                        cs.registerOutParameter(i+1, java.sql.Types.DATE);
                    else
                        cs.setDate(i+1, (java.sql.Date)param);
                }
                else {

                }
            }

            cs.executeUpdate();  //run the stored procedure

            for (int i=0; i < params.size(); i++)
            {
                    //add column names to ResultSet object
                String colName = "" + (i+1);
                results.addColumnName(colName);

                boolean isOutParam = ((Boolean)isStoredProcOutParam.get(i)).booleanValue();
                if (isOutParam)
                    results.add(cs.getObject(i+1));  //add output parameter value to ResultSet object
                else
                    results.add("null");
            }

            
        }
        catch (SQLException e)
        {
        	throw new JSysException("Exception: runStoredFunc :");
        }
        finally
        {

            clearParams();
            try{
            	if(cs!=null)cs.close();
            }catch (SQLException e){
            	throw new JSysException("Exception: runStoredFunc :");
            }            
        }

        return(results);
    }

        /** Stored Function瑜���� ��� Connection���댁� ���.
         * @return SQLResults
         * @throws JSysException 
         */
    public SQLResults runStoredFuncCloseCon(String spName) throws JSysException
    {
        try
        {
            return(runStoredFunc(spName));
        }
        finally
        {
                //2005-01-24 ConnectionPool��吏����以�寃쎌� �몄�
            //conPool.closeConnection(con, dbType);

            closeConnection();
        }
    }

        private void setPrepStatementParameters() throws SQLException
        {
            for (int i=0; i < params.size(); i++)
            {
                Object param = params.get(i);

                if (param instanceof Integer)
                {
                    int value = ((Integer)param).intValue();
                    prepStatement.setInt(i+1, value);
                }
                else if (param instanceof Short)
                {
                    short sh = ((Short)param).shortValue();
                    prepStatement.setShort(i+1, sh);
                }
                else if (param instanceof String)
                {
                    String s = (String)param;
                    prepStatement.setString(i+1, s);
                }
                else if (param instanceof Double)
                {
                    double d = ((Double)param).doubleValue();
                    prepStatement.setDouble(i+1, d);
                }
                else if (param instanceof Float)
                {
                    float f = ((Float)param).floatValue();
                    prepStatement.setFloat(i+1, f);
                }
                else if (param instanceof Long)
                {
                    long l = ((Long)param).longValue();
                    prepStatement.setFloat(i+1, l);
                }
                else if (param instanceof Boolean)
                {
                    boolean b = ((Boolean)param).booleanValue();
                    prepStatement.setBoolean(i+1, b);
                }
                else if (param instanceof java.sql.Date)
                {
                    java.sql.Date d = (java.sql.Date)param;
                    prepStatement.setDate(i+1, d);
                }
    			else if (param instanceof oracle.sql.CLOB)
    			{
    				oracle.sql.CLOB cl = (oracle.sql.CLOB)param;
    				prepStatement.setObject(i+1, cl);
    			}
    			else if (param instanceof ClobClass)
    			{
    				ClobClass clobclass = (ClobClass)param;
    				StringReader sr = clobclass.getCont_sr();
    				int cloblen = clobclass.getContlen();
    				log.debug("cloblen:" + cloblen);
					prepStatement.setCharacterStream(i+1, sr, cloblen);
    			}                
    			else if (param == null) {

    				 // Customizing 2005-10-10
   					prepStatement.setString(i + 1, "");

    			} else {
    				clearParams();
                    closeConnection();
                }
            }
        }

        /**
         * SQL 瑜������� Connection��close ��� �����
         * @param sql ����댁� ��SQL
         * @return SQLResults 議고��대㈃ Return��ŉ 洹몃�吏����硫�null��由ы����.
         * @throws JSysException 
         */
        public SQLResults runQuery(String sql) throws JSysException
        {
            SQLResults results = null;
            ResultSet rs = null;
            numRecordsUpdated = 0;

            try
            {
                if ((sql.equalsIgnoreCase(lastSQL) == false) || (prepStatement == null)) {
                	 prepStatement = con.prepareStatement(sql);
                }

                lastSQL = sql;

                setPrepStatementParameters();

                boolean isSelectStatement = isSelectStatement(sql);

                if ((dbType != ORACLE) && (isSelectStatement == false))
                {

                    prepStatement.setMaxRows(maxRows);

                    numRecordsUpdated = prepStatement.executeUpdate();

                }
                else
                {
                    if (timeoutInSec > 0)
                        prepStatement.setQueryTimeout(timeoutInSec);

                    if (isSelectStatement(sql))
                    {
                        prepStatement.setMaxRows(maxRows);
                        rs = prepStatement.executeQuery();
                    }
                    else
                    {
                       numRecordsUpdated = prepStatement.executeUpdate();
                    }
                }

                if (isSelectStatement(sql))
                {
                        //SELECT statement, so get results
                	if(rs!=null){
                        ResultSetMetaData rsmd = rs.getMetaData();
                        if(rsmd!=null){
                            int columnCount = rsmd.getColumnCount();
                            results = new SQLResults(dbType, columnCount);

                                //add field values to ResultSet object
                            while (rs.next())
                            {
                            	if(columnCount > 0){
                                    for (int i = 0; i < columnCount; i++)
                                        results.add(rs.getObject(i+1));                            		
                            	}

                            }
                                //add column names to ResultSet object
                            if(columnCount > 0){
                                for (int i = 0; i < columnCount; i++)
                                    results.addColumnName(rsmd.getColumnName(i+1));                             	
                            }
                        	
                        }
               		
                	}

                }
            }
            catch (SQLException e)
            {
             	// run ��� ��� ��� ��Connection Close ���.
            	closeConnection();
            	throw new JSysException("Exception: runQuery :"+"\n:sql:"+sql);
            }
            finally
            {
                clearParams();
                
					try {
						if(rs!=null)rs.close();
					} catch (SQLException e) {
						log.debug("Exception: runQuery rs.close() ");
					}
            }

            return(results);
        }

        /**
         * ��� JDBC ResultSet瑜�由ы����. SQL�������� Connection��close��� ����� <br>
         * �곕��� �대� 硫����� ��� ��finally ��� close
         *
         * @param sql ����댁� ��SQL
         * @return ResultSet 議고��대㈃ Return��ŉ 洹몃�吏����硫�null��由ы����.
         * @throws JSysException 
         */
        public ResultSet runQueryStreamResults(String sql) throws JSysException
        {
            ResultSet rs = null;
            numRecordsUpdated = 0;

            try
            {
                if ((sql.equalsIgnoreCase(lastSQL) == false) || (prepStatement == null))  //if sql has changed, then prepare stmt
                    prepStatement = con.prepareStatement(sql);
                lastSQL = sql;

                setPrepStatementParameters();

                boolean isSelectStatement = isSelectStatement(sql);

                if ((dbType != ORACLE) && (isSelectStatement == false))
                {
                    prepStatement.setMaxRows(maxRows);
                    numRecordsUpdated = prepStatement.executeUpdate();
                }
                else
                {
                    if (timeoutInSec > 0)
                        prepStatement.setQueryTimeout(timeoutInSec);

                    if (isSelectStatement(sql))
                    {
                        prepStatement.setMaxRows(maxRows);
                        rs = prepStatement.executeQuery();
                    }
                    else
                    {
                        numRecordsUpdated = prepStatement.executeUpdate();
                    }
                }

                if (timeoutInSec > 0)
                    prepStatement.setQueryTimeout(timeoutInSec);

                if (isSelectStatement)
                {
                    prepStatement.setMaxRows(maxRows);
                    rs = prepStatement.executeQuery();
                }
                else
                {
                    numRecordsUpdated = prepStatement.executeUpdate();
                }
            }
            catch (SQLException e)
            {
    			// run ��� ��� ��� ��Connection Close ���.
    			closeConnection();
    			throw new JSysException("Exception: runQueryStreamResults :");
            }
            finally
            {
                clearParams();
            }

            return(rs);
        }

    	/**
    	* SQL 議고� ��寃곌낵瑜�HashMap�쇰� �댁� List 濡�由ы����.
    	* @param sql sql command to run
    	* @return List 寃곌낵 List瑜��닿� ���
    	 * @throws JSysException 
    	*/
       public List runQueryIntoHashMap(String sql) throws JSysException
       {
    	   ResultSet rs = null;

    	   List rsList = new ArrayList();

    	   try
    	   {
    		   if ((sql.equalsIgnoreCase(lastSQL) == false) || (prepStatement == null))  //if sql has changed, then prepare stmt
    		   {
    			   prepStatement = con.prepareStatement(sql);
    		   }


    		   lastSQL = sql;

    		   setPrepStatementParameters();

    		   boolean isSelectStatement = isSelectStatement(sql);

    		   if (timeoutInSec > 0)
    			   prepStatement.setQueryTimeout(timeoutInSec);

    		   if (isSelectStatement)
    		   {
    			   prepStatement.setMaxRows(maxRows);

    			   rs = prepStatement.executeQuery();
    		   }

    		   if(rs!=null){
    			   rsList = createRecordListIntoHashMap(rs);
    		   }else{
    			   rsList = new ArrayList();
    		   }
    			

    	   }
    	   catch (SQLException e)
    	   {
    			// run ��� ��� ��� ��Connection Close ���.
    			closeConnection();
    			throw new JSysException("Exception: runQueryIntoHashMap :"+"\n "+sql);
    	   }
    	   catch (Exception ee)
    	   {
    		   closeConnection();
    		   throw new JSysException("Exception: runQueryIntoHashMap :"+"\n "+sql);
    	   }
    	   finally
    	   {
    		   clearParams();
				try {
					if(rs!=null)rs.close();
				} catch (SQLException e) {
					log.debug("Exception: runQuery rs.close() ");
				}    		   
    	   }

    	   return(rsList);
       }



    	/**
    	 * SQL�������� ��� ������쇰� Connection��close ���.
    	 * @param sql ��� �댁� ��SQL
    	 * @return List 寃곌낵 List瑜��닿� ���
    	 * @throws JSysException 
    	 */
    	public List runQueryIntoHashMapCloseCon(String sql) throws JSysException
    	{
    		try
    		{
    			return(runQueryIntoHashMap(sql));
    		}
    		finally
    		{
    			//2005-01-24 ConnectionPool��吏����以�寃쎌� �몄�
    			//conPool.closeConnection(con, dbType);

    			closeConnection();
    		}
    	}

    	private List createRecordListIntoHashMap(ResultSet rs) throws SQLException {

    		List recordList = new ArrayList();

    		ResultSetMetaData rsmd = rs.getMetaData();
    		Reader rd = null;
            StringBuffer sb = null;

    		int columnCount = rsmd.getColumnCount();
    		while (rs.next()) {
    			Map item = new HashMap(columnCount);
    			for (int i = 1; i <= columnCount; i++) {
    				final String columnName = rsmd.getColumnName(i);
    				String columnValue = "";
    				if(rsmd.getColumnTypeName(i).equals("CLOB")){
    					
    					try {
    						if(rs.getCharacterStream(columnName)!=null){
    							StringBuffer content = new StringBuffer();
    							Reader reader = rs.getCharacterStream(columnName);
    							char[] buffer = new char[1024];
    							int read = 0;
    			        
    							while( (read=reader.read(buffer, 0, 1024) ) != -1 ){
							        content.append(buffer, 0, read);
    							}
    							reader.close();
    							columnValue = content.toString();
    						}else{
    							columnValue = "";
    						}
						} catch (IOException e) {
							// TODO Auto-generated catch block
							log.debug("createRecordListIntoHashMap IOException");
						}
    				
    				}else{
    					columnValue = rs.getString(i);
    				}
    				

    				if(columnValue==null){
    					columnValue="";
    				}
    				item.put(columnName, columnValue);
    			}

    			recordList.add(item);
    		}

    		return recordList;
    	}


    	/**
    	* SQL ������ ������濡�Connection��close ���.
    	* @param sql ����댁� ��SQL
    	* @return SQLResults
    	 * @throws JSysException 
    	*/
        public SQLResults runQueryCloseCon(String sql) throws JSysException
        {
            try
            {
                return(runQuery(sql));
            }
            finally
            {
    			closeConnection();
            }
        }

        /**
         * Is this SQL statement a select statement (returns rows?)
         * @param sql String
         * @return boolean
         */
        private boolean isSelectStatement(String sql)
        {
            StringBuffer sb = new StringBuffer(sql.trim());
            String s = (sb.substring(0, 6));
            return(s.equalsIgnoreCase("SELECT"));
        }

    	/**
    	* Connection��AutoCommit �щ�瑜�由ы����. 蹂����Transaction Manager(�� EJB �ъ�) 媛���� 寃쎌� �ъ����.
    	* @return boolean
    	*/
        public boolean getAutoCommit()
        {
                try {
					return(con.getAutoCommit());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					log.debug("getAutoCommit SQLException");
					return false;
				}
 
        }

    	/**
    	* Connection��AutoCommit �щ�瑜��ㅼ����. 蹂����Transaction Manager(�� EJB �ъ�) 媛���� 寃쎌� �ъ����.
    	* @return boolean
    	*/
        public void setAutoCommit(boolean autoCommit)
        {
 
                try {
					con.setAutoCommit(autoCommit);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					log.debug("setAutoCommit SQLException");
				}
        }

    	/**
    	* Transaction IsolatoinLevel���ㅼ����.
    	*/
        public void setTransactionIsolation(int level)
        {
                try {
					con.setTransactionIsolation(level);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					log.debug("setTransactionIsolation SQLException:");
				}
        }

    	/**
    	* �대� Connection �������Transaction����� Commit ��������.
    	*/
        public void commitTrans()
        {
               try {
				con.commit();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				log.debug("commitTrans SQLException:");
			}
        }

    	/**
    	* �대� Connection �������Transaction����� Rollback ��������.
    	*/
        public void rollbackTrans()
        {
 
                try {
					con.rollback();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					log.debug("rollbackTrans SQLException:");
				}
        }

    	/**
    	* �대� Connection���듯� DBMS Optimzie濡�Read Only Mode ��� �ㅼ����.
    	*/
        public void setReadOnly(boolean readOnly)
        {
                 try {
					con.setReadOnly(readOnly);
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					log.debug("setReadOnly SQLException:");
				}
 
        }

    	/**
    	* �대� Connection��Read Only Mode �щ�瑜�������.
    	*/
        public boolean isReadOnly()
        {

                try {
					return(con.isReadOnly());
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					log.debug("isReadOnly SQLException:");
					return false;
				}
 
        }

    	/**
    	* 理�� Rows瑜��ㅼ����.
    	*/
        public void setMaxRows(int maxRows)
        {
            this.maxRows = maxRows;
        }

    	/**
    	* 理�� Rows瑜��살��⑤�.
    	*/
        public int getMaxRows()
        {
            return(maxRows);
        }

        /**
         * Closes this connection.
         */

        /* 2005-01-24 Modify
        public void closeConnection()
        {
            conPool.closeConnection(con, dbType);
        }
        */
    	/**
    	 * PreparedStatement Instance瑜�Close ��� Connection��Close ���.
    	 */
    	public void closeConnection()
    	{
    		try
    		{
    			if (con != null) {con.close();}
    		}
    		catch (SQLException e)
    		{
    			log.debug("closeConnection SQLException:");
    		}finally{
    		
    			try {
    				if (con != null) {con.close();}
				} catch (SQLException e) {
					log.debug("closeConnection SQLException:");
				}
    		}
    	}

    	/**
    	 * String��oracle.sql.CLOB 媛�껜濡������� 諛�� ���. <br>
    	 *
    	 * ��: queryHelper.addParam(makeClob(contents));
    	 *
    	 */
    	public synchronized  ClobClass makeClob(String contents)
    	{
    		ClobClass clobclass = new ClobClass();
    		StringReader tempClob = new StringReader(contents);
    		clobclass.setContlen(contents.length());
    		clobclass.setCont_sr(tempClob);
    		return clobclass;

    	}    	
 
    	/**
    	* Clob����� �곗���� String�쇰� 蹂�����二쇰� 硫����
    	* @param rs - ResultSet 媛�껜
    	* @param columnIndex - rs媛�껜��� ��� Clob�������� �몃���
    	* @return String - Clob媛�껜���댁���java媛��몄���� String �쇰� 由ы�
    	*/
    	public synchronized String getCLOB(ResultSet rs, int columnIndex){

    			Reader reader = null;
    			StringBuffer str = new StringBuffer();
    			try{
    				Clob clob = rs.getClob(columnIndex);

    				reader = clob.getCharacterStream();

    				char[] buffer = new char[1024];

    				int read = 0;
    				while ((read = reader.read(buffer, 0, 1024)) != -1) {
    					for (int i=0; i<read; i++)
    					{
    						str.append(buffer[i]);
    					}

    				}

    			}catch(IOException ie){
    				log.debug("getCLOB IOException:");
    			}catch(SQLException se){
    				log.debug("getCLOB SQLException:");
    			}finally{
    				try{
    					if(reader != null) reader.close();
    				}catch(IOException e){
    					log.debug("getCLOB IOException:");
    				}
    			}

    			return str.toString();
    	}

    	/**
    	* Clob����� �곗���� String�쇰� 蹂�����二쇰� 硫����
    	* @param rs - ResultSet 媛�껜
    	* @param columnName - rs媛�껜��� ��� Clob��� 紐�
    	* @return String - Clob媛�껜���댁���java媛��몄���� String �쇰� 由ы�
    	*/
    	public synchronized String getCLOB(ResultSet rs, String columnName){

    			Reader reader = null;
    			StringBuffer str = new StringBuffer();

    			try{


    				Clob clob = rs.getClob(columnName);

    				reader = clob.getCharacterStream();

    				char[] buffer = new char[1024];

    				int read = 0;
    				while ((read = reader.read(buffer, 0, 1024)) != -1) {
    					for (int i=0; i<read; i++)
    					{
    						str.append(buffer[i]);
    					}

    				}

    			}catch(IOException ie){
    				log.debug("getCLOB IOException:");
    			}catch(SQLException se){
    				log.debug("getCLOB SQLException:");
    			}finally{
    				try{
    					if(reader != null) reader.close();
    				}catch(IOException e){
    					log.debug("getCLOB IOException:");
    				}
    			}

    			return str.toString();
    	}
    	
    	private String logSQLExecution(String sql) {

    	  StringBuffer sb = new StringBuffer();

    	  Object paramsObj = null;
    	  String nextToken = null;

    	  StringTokenizer aaa = new StringTokenizer(sql, "?");

    	  sb.append("Execute Query[ \n");

    	  int paramInd = 0;

    	  while (aaa.hasMoreTokens() && paramInd < params.size()) {

    		nextToken = aaa.nextToken();

    		paramsObj = params.get(paramInd);

    	  	if (paramsObj instanceof String || paramsObj instanceof CHAR )
    	  	{
    			sb.append(nextToken + "'" + paramsObj + "' ");
    	  	} else {
    			sb.append(nextToken + paramsObj);
    	  	}

    		paramInd++;

    	  }

    	  if (aaa.hasMoreElements()) {
    		nextToken = aaa.nextToken();

    		if (nextToken != null)
    		 {
    		   sb.append(nextToken);
    		 }

    	  }

    	  sb.append("\n ]");

    	  return sb.toString();

        }    
    	

    	  /**
    	   * PageUtil 瑜��댁��������寃곌낵媛�異������� ��������
    	   *
    	   * @param originQuery Pagination �������린 ��� Orign 荑쇰━
    	   * @param queryParam Query����� parameter binding����� parameters
    	   * @param curr_page ��� ���吏�
    	   * @param show_rows 蹂댁�二쇱��쇳� row 媛��
    	   *
    	   * @return DTOList
    	 * @throws JSysException 
    	   */
    	  public Map runPageQuery(String originQuery, ArrayList queryParam,
    	                              int curr_page, int show_rows) throws SQLException, NullPointerException, ArrayIndexOutOfBoundsException, JSysException {

    		HashMap pageMap = new HashMap();

    	    HashMap countMap = new HashMap();

    	    SQLResults sRes = null;
    	    ResultSet res = null;

    	    String SELECT_COUNT = "SELECT COUNT(*) NUM_OF_ROWS FROM (   \n" +
    	        originQuery + " \n)";
    	    String RESULT_META = " SELECT * FROM (  \n" + originQuery +
    	        "\n ) WHERE ROWNUM < 1 ";
    	    String PAGE_QUERY = "";
    	    java.util.List result = null;

    	    try {

    	      setParams(queryParam);

    	      sRes = runQuery(SELECT_COUNT);
    	     
    	      long totalCount = 0;

    	      for (int row = 0; row < sRes.getRowCount(); row++) {
    	        totalCount = sRes.getLong(row, "NUM_OF_ROWS");
    	      }


    	      if (totalCount > 0) {

    	    	setParams(queryParam);

    	        res = runQueryStreamResults(RESULT_META);

    	        ResultSetMetaData rsmd = res.getMetaData();

    	        PAGE_QUERY = makeQuery(rsmd, originQuery, curr_page, show_rows);
    	      }

    	      setParams(queryParam);

    	      
    	      if(!PAGE_QUERY.equals("")){
    	    	  result = runQueryIntoHashMap(PAGE_QUERY);
    	      }

    	      int totalPages =
    	          (int) Math.ceil( (double) totalCount / ( (double) show_rows));

    	      if (totalPages == 0) {
    	        totalPages = 1;
    	      }

    	      pageMap.put("setList",result);
    	      pageMap.put("setTotalCount",Long.toString(totalCount));
    	      pageMap.put("setPageSize",Integer.toString(show_rows));
    	      pageMap.put("setTotalPageCount",Integer.toString(totalPages));
    	      pageMap.put("setCurrentPage",Integer.toString(curr_page));
    	      pageMap.put("TRS_MSG","");

    	    }catch(SQLException e){
    			log.error("SQLException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQuery :");
    		}catch(NullPointerException e){
    			log.error("NullPointerException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQuery :");	
    		}catch(ArrayIndexOutOfBoundsException e){
    			log.error("ArrayIndexOutOfBoundsException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQuery :");
    		}catch (Exception e) {
    	    	log.error("Exception:");
    	    	closeConnection();
    	    	throw new JSysException("Exception: runPageQuery :");
    	    	//throw new JSysException(e);
    	    }finally{
    	    	clearParams();
    	    }
    	    
        	    

    	    return pageMap;
    	  }


    	  private String makeQuery(ResultSetMetaData rsmd, String sql, int curPage,
    	                           int showRows) throws SQLException, NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
    	    String columnName = "";
    	    String query = "";
    	    try {

    	      int firstRow = (curPage * showRows) - showRows;
    	      int endRow = curPage * showRows;
    	      int numCount = rsmd.getColumnCount();

    	      for (int i = 1; i <= numCount; i++) {
    	        columnName += rsmd.getColumnLabel(i) + " , \n";
    	      }
    	      query = " SELECT " + columnName + " NUM_OF_ROWS from ( select \n " +
    	          columnName + " ROWNUM NUM_OF_ROWS from ( \n " + sql +
    	          "\n  ) ) where NUM_OF_ROWS > " + firstRow + " and NUM_OF_ROWS <= " +
    	          endRow;
    	      
    	    }catch(SQLException e){
    			log.debug("SQLException:");
    			throw new JSysException(e);		
    		}catch(NullPointerException e){
    			log.debug("NullPointerException:");
    			throw new JSysException(e);		
    		}catch(ArrayIndexOutOfBoundsException e){
    			log.debug("ArrayIndexOutOfBoundsException:");
    			throw new JSysException(e);		
    		}
    	    catch (Exception e) {
    	    	throw new JSysException(e);
    	    }
    	    return query;
    	  }
    	  
    	  /**
    	   * PageUtil 瑜��댁��������寃곌낵媛�異������� ��������
    	   *
    	   * @param originQuery Pagination �������린 ��� Orign 荑쇰━
    	   * @param queryParam Query����� parameter binding����� parameters
    	   * @param curr_page ��� ���吏�
    	   * @param show_rows 蹂댁�二쇱��쇳� row 媛��
    	   *
    	   * @return DTOList
    	 * @throws JSysException 
    	   */
    	  public Map runPageQueryMysql(String originQuery, ArrayList queryParam,
    	                              int curr_page, int show_rows) throws SQLException, NullPointerException, ArrayIndexOutOfBoundsException, JSysException {

    		HashMap pageMap = new HashMap();

    	    HashMap countMap = new HashMap();

    	    SQLResults sRes = null;
    	    ResultSet res = null;
    	    
    	    String TAB_ALIAS = "RPA";

    	    String SELECT_COUNT = "SELECT COUNT(*) NUM_OF_ROWS FROM (   \n" +
    	        originQuery + " \n) "+TAB_ALIAS+" ";
    	    String RESULT_META = " SELECT "+TAB_ALIAS+".* FROM (  \n" + originQuery +
    	        "\n ) "+TAB_ALIAS+" LIMIT 1 ";
    	    String PAGE_QUERY = "";
    	    java.util.List result = null;

    	    try {

    	      setParams(queryParam);

    	      sRes = runQuery(SELECT_COUNT);
    	     
    	      long totalCount = 0;

    	      for (int row = 0; row < sRes.getRowCount(); row++) {
    	        totalCount = sRes.getLong(row, "NUM_OF_ROWS");
    	      }

    	      if (totalCount > 0) {

    	    	setParams(queryParam);

    	        res = runQueryStreamResults(RESULT_META);

    	        ResultSetMetaData rsmd = res.getMetaData();

    	        PAGE_QUERY = makeQueryMysql(rsmd, originQuery, curr_page, show_rows);
    	      }

    	      setParams(queryParam);

    	      
    	      if(!PAGE_QUERY.equals("")){
    	    	  result = runQueryIntoHashMap(PAGE_QUERY);
    	      }

    	      int totalPages =
    	          (int) Math.ceil( (double) totalCount / ( (double) show_rows));

    	      if (totalPages == 0) {
    	        totalPages = 1;
    	      }

    	      pageMap.put("setList",result);
    	      pageMap.put("setTotalCount",Long.toString(totalCount));
    	      pageMap.put("setPageSize",Integer.toString(show_rows));
    	      pageMap.put("setTotalPageCount",Integer.toString(totalPages));
    	      pageMap.put("setCurrentPage",Integer.toString(curr_page));
    	      pageMap.put("TRS_MSG","");

    	    }catch(SQLException e){
    			log.debug("SQLException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMysql :");
    		}catch(NullPointerException e){
    			log.debug("NullPointerException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMysql :");		
    		}catch(ArrayIndexOutOfBoundsException e){
    			log.debug("ArrayIndexOutOfBoundsException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMysql :");
    		}catch (Exception e) {
    	    	log.error("Exception");
    	    	closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMysql :");
    	    	//throw new JSysException(e);
    	    }finally{
    	    	clearParams();
    	    }
  
    	    return pageMap;
    	  }   
    	  
    	  private String makeQueryMysql(ResultSetMetaData rsmd, String sql, int curPage,
                  int showRows) throws SQLException, NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
			String columnName = "";
			String query = "";
			try {

			int firstRow = (curPage * showRows) - showRows;
			int endRow = curPage * showRows;
			int numCount = rsmd.getColumnCount();

			for (int i = 1; i <= numCount; i++) {
				columnName += rsmd.getColumnLabel(i) + "";
				if(i< numCount){
					columnName += " , \n";
				}
			}
			query = " SELECT " + columnName + "  FROM ( \n" +
			 sql +
			 "\n  ) RPA LIMIT " + firstRow + ", " + showRows;
			
			}catch(SQLException e){
				log.debug("SQLException:");
				throw new JSysException(e);		
			}catch(NullPointerException e){
				log.debug("NullPointerException:");
				throw new JSysException(e);		
			}catch(ArrayIndexOutOfBoundsException e){
				log.debug("ArrayIndexOutOfBoundsException:");
				throw new JSysException(e);		
			}catch (Exception e) {
				throw new JSysException(e);
			}
			return query;
    	  } 
    	  
    	  /**
    	   * PageUtil 瑜��댁��������寃곌낵媛�異������� ��������
    	   *
    	   * @param originQuery Pagination �������린 ��� Orign 荑쇰━
    	   * @param queryParam Query����� parameter binding����� parameters
    	   * @param curr_page ��� ���吏�
    	   * @param show_rows 蹂댁�二쇱��쇳� row 媛��
    	   *
    	   * @return DTOList
    	   * @throws JSysException 
    	   */
    	  // TODO : runPageQueryMssql
    	  public Map runPageQueryMssql(String originQuery, ArrayList queryParam,
    	                              int curr_page, int show_rows, String keystr, String orgsort) throws SQLException, NullPointerException, ArrayIndexOutOfBoundsException, JSysException {

    		HashMap pageMap = new HashMap();

    	    HashMap countMap = new HashMap();

    	    SQLResults sRes = null;
    	    ResultSet res = null;
    	    
    	    String TAB_ALIAS = "RPA";

    	    // 荑쇰━瑜�媛��怨���껜 媛��瑜�媛���⑤�
    	    String SELECT_COUNT = "SELECT COUNT(*) AS NUM_OF_ROWS FROM (   \n" +
    	        originQuery + " \n) "+TAB_ALIAS+" ";
    	    // 而щ�紐�� 媛���⑤�
    	    String RESULT_META = " SELECT TOP 1 "+TAB_ALIAS+".* FROM (  \n" + originQuery +
    	        "\n ) "+TAB_ALIAS+" ";
    	    String PAGE_QUERY = "";
    	    java.util.List result = null;

    	    try {
      	      
    	      setParams(queryParam);

    	      sRes = runQuery(SELECT_COUNT);
    	     
    	      long totalCount = 0;

    	      for (int row = 0; row < sRes.getRowCount(); row++) {
    	        totalCount = sRes.getLong(row, "NUM_OF_ROWS");
    	      }
    	      log.debug("runPageQueryMssql totalCount:"+totalCount);   

    	      if (totalCount > 0) {

    	    	setParams(queryParam);

    	        res = runQueryStreamResults(RESULT_META);

    	        ResultSetMetaData rsmd = res.getMetaData();

    	        PAGE_QUERY = makeQueryMssql(rsmd, originQuery, totalCount, curr_page, show_rows, keystr, orgsort);
    	      }

    	      setParams(queryParam);

    	      
    	      if(!PAGE_QUERY.equals("")){
    	    	  result = runQueryIntoHashMap(PAGE_QUERY);
    	      }

    	      int totalPages =
    	          (int) Math.ceil( (double) totalCount / ( (double) show_rows));

    	      if (totalPages == 0) {
    	        totalPages = 1;
    	      }
    	      pageMap.put("setList",result);
    	      pageMap.put("setTotalCount",Long.toString(totalCount));
    	      pageMap.put("setPageSize",Integer.toString(show_rows));
    	      pageMap.put("setTotalPageCount",Integer.toString(totalPages));
    	      pageMap.put("setCurrentPage",Integer.toString(curr_page));
    	      pageMap.put("TRS_MSG","");

    	    }catch(SQLException e){
    			log.debug("SQLException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMssql :");		
    		}catch(NullPointerException e){
    			log.debug("NullPointerException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMssql :");		
    		}catch(ArrayIndexOutOfBoundsException e){
    			log.debug("ArrayIndexOutOfBoundsException:");
    			closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMssql :");		
    		}catch (Exception e) {
    	    	log.error("Exception:");
    	    	closeConnection();
    	    	throw new JSysException("Exception: runPageQueryMssql :");
    	    	//throw new JSysException(e);
    	    }finally{
    	    	clearParams();
    	    }
  
    	    return pageMap;
    	  } 
    	  
    	  // TODO : makeQueryMssql
    	  private String makeQueryMssql(ResultSetMetaData rsmd, String sql,long totalCount, int curPage,
                  int showRows, String keystr , String orgsort) throws SQLException, NullPointerException, ArrayIndexOutOfBoundsException, JSysException {
			String columnName = "";
			String query = "";
			try {
				
				long firstRow = totalCount - ((curPage-1) * showRows);//珥��곗��곗� - ( (���吏�� - 1) * 10)
				
				int endRow = curPage * showRows;
				int numCount = rsmd.getColumnCount();
				
				for (int i = 1; i <= numCount; i++) {
					columnName += rsmd.getColumnLabel(i) + "";
					if(i< numCount){
						columnName += " , \n";
					}
				}
				
				query = " SELECT TOP "+showRows+" PAGE_TA.* FROM( \n";
				query = query + sql +" ) PAGE_TA WHERE "+keystr+" IN \n";
				query = query + " (SELECT TOP "+firstRow+" "+keystr+" FROM( \n";
				query = query + sql+ " ) PAGE_TB \n";
				if(orgsort.equals("DESC")){
					query = query + " ORDER BY "+keystr+" ASC) \n";	
				}else{
					query = query + " ORDER BY "+keystr+" DESC) \n";	
				}
				if(orgsort.equals("DESC")){
					query = query + " ORDER BY "+keystr+" DESC \n";
				}else{
					query = query + " ORDER BY "+keystr+" ASC \n";	
				}	
				
			}catch(SQLException e){
				log.debug("SQLException:");
				throw new JSysException("makeQueryMssql::query:");		
			}catch(NullPointerException e){
				log.debug("NullPointerException:");
				throw new JSysException("makeQueryMssql::query:");		
			}catch(ArrayIndexOutOfBoundsException e){
				log.debug("ArrayIndexOutOfBoundsException:");
				throw new JSysException("makeQueryMssql::query:");		
			}catch (Exception e) {
				
				throw new JSysException("makeQueryMssql::query:");
			}
			return query;
    	  }    	  
}