package com.ji.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.context.support.ClassPathXmlApplicationContext;
//import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;

import org.springframework.jdbc.core.JdbcTemplate;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.engine.impl.ExtendedSqlMapClient;
import com.ibatis.sqlmap.engine.mapping.parameter.ParameterMap;
import com.ibatis.sqlmap.engine.mapping.parameter.ParameterMapping;
import com.ibatis.sqlmap.engine.mapping.sql.Sql;
import com.ibatis.sqlmap.engine.mapping.statement.MappedStatement;
import com.ibatis.sqlmap.engine.scope.SessionScope;
import com.ibatis.sqlmap.engine.scope.StatementScope;
import com.ji.common.StringUtil;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

public class CmsDs3Dao extends EgovAbstractDAO {
	protected Logger log = Logger.getLogger(CmsDs3Dao.class); //현재 클래스 이름을 Logger에 등록
	
	private static MessageSource messageSource;				// 프로퍼티 메시지
	
	static {
		messageSource = (MessageSource)new ClassPathXmlApplicationContext("egovframework/spring/context-common.xml");
	}
	
    @Resource(name = "sqlMapClient3")
    public void setSuperSqlMapClient(SqlMapClient sqlMapClient) {
        super.setSqlMapClient(sqlMapClient);
    }	
	
	/** SQL ID 출력 */
	public void printSqlId(String sqlId){
		//log.debug("(_SQL아이디.java:000sql_id=\""+ sqlId +"\")");
		log.debug("SQL-ID=["+ sqlId +"]");
	}
	
	/** 해당 쿼리의 결과 int값 */
	public int getInt(String sqlId, Map param){
		printSqlId(sqlId);
		return (Integer)getSqlMapClientTemplate().queryForObject(sqlId, param);
	}
	/** 해당 쿼리의 결과 String값 */
	public String getString(String sqlId, Map param){
		printSqlId(sqlId);
		return (String)getSqlMapClientTemplate().queryForObject(sqlId, param);
	}
	
	
	/**
	 * 
	 * Method Name  : getMessage
	 * Description      :  예외처리시 프로퍼티메시지 키에 대한 메시지 반환  
	 * Comment        :  각 업무별 message-ji-****.properties 파일에 메시지 등록 필요
	 * Parameter       : 
	 * form History    : 2015. 4. 17. : mrkim:  최초작성
	 * @param key
	 * @return
	 */
	public String getMessage(String key){
		return messageSource.getMessage(key, new Object[0], null);
	}
	
	
	/**
	 * 
	 * Method Name  : getSelectByPk
	 * Description      : pk로 조회한 단일행 데이타의 취득    
	 * Comment        :  카멜케이스로 인한 key명 변환 불가.
	 * Parameter       : 
	 * form History    : 2015. 3. 31. : mrkim:  최초작성
	 * @param sqlId
	 * @param param
	 * @return
	 */
	public Map<String,Object> getSelectByPk(String sqlId, Map param){
		printSqlId(sqlId);
		Map<String,Object> dataMap = (Map<String,Object>)getSqlMapClientTemplate().queryForObject(sqlId, param);
		
		Object keyVal = new Object();
		Map<String,Object> keyMap = new HashMap<String,Object>(); 
		Iterator ite = dataMap.keySet().iterator();
		while (ite.hasNext()) {
			String key = (String) ite.next();
			keyVal = dataMap.get(key)!=null ? dataMap.get(key).toString() : "";
			key = StringUtil.egovmapToGrid(key);
			keyMap.put(key, keyVal); 
			
		} 		
		return keyMap;
	}
	
//	/** 해당 쿼리의 COUNT를 조회 */
//	public int getCount(String sqlId, Map param){
//		String innerQuery = getStatmentQuery(sqlId, param);
//		printSqlId(sqlId);
//		return getCountQuerySimpleJdbc(innerQuery);
//	}
//	/** 해당 쿼리를 페이징 조회 */
//	public List getListPaging(String sqlId, Map param, int pageIndex, int pageSize){
//		String innerQuery = getStatmentQuery(sqlId, param);
//		printSqlId(sqlId);
//		return getListQuerySimpleJdbc(innerQuery, pageIndex, pageSize);
//	}
	/** 해당 쿼리를 jqGrid의 속성에 맞는 Map으로 조회 */
	public Map getMapGridPaging(String sqlId, Map param, int pageIndex, int pageSize){
		Map returnMap = new HashMap<String,Object>();

		Page page = getPageGridPaging(sqlId, param, pageIndex, pageSize);
		
		returnMap.put("page"   , String.valueOf(page.getCurrentPage()) );
		returnMap.put("total"  , String.valueOf(page.getMaxPage())     );
		returnMap.put("records", String.valueOf(page.getTotalCount())  );
		returnMap.put("rows"   , page.getList());
		
		return returnMap;
	}
	/** 해당 쿼리를 jqGrid의 속성에 맞는 Page객채로 조회 */
	public Page getPageGridPaging(String sqlId, Map param, int pageIndex, int pageSize){
		Map returnMap = new HashMap<String,Object>();
		
		printSqlId(sqlId);
		String innerQuery = getStatmentQuery(sqlId, param);
		
		int totalCount = getCountQuerySimpleJdbc(innerQuery);
		
		//엑셀출력시 구분에 따라 화면 및 전체출력 -mrkim (2015/06/18))
		if("A".equals((String)param.get("excelGbn"))){
			pageSize = totalCount;
		}
		
		List list = getListQuerySimpleJdbc(innerQuery, pageIndex, pageSize);
		
		Page page = new Page(list, pageIndex, totalCount, pageSize);
		
		return page;
	}

//	/** iBatis 쿼리 출력 */
//	@Deprecated
//	private String getStatmentQuery(String statementId, Object parameterObject) {
//		String resultSql = "";
//
//		MappedStatement mappedStatement;
//		StatementScope statementScope;
//		SessionScope sessionScope;
//		Sql sql ;
//
//		mappedStatement = ((ExtendedSqlMapClient) getSqlMapClient()).getMappedStatement(statementId);
//		sessionScope = new SessionScope();
//		statementScope = new StatementScope(sessionScope);
//		// 생략 하면 다이나믹 쿼리가 적용안됨
//		mappedStatement.initRequest(statementScope);
//
//		sql = mappedStatement.getSql();
//		resultSql = sql.getSql(statementScope, parameterObject);
//		//String sqlExecuted = mappedStatement.getBoundSql(statementScope,parameterObject).getSql(); //미확인
//
//		return resultSql;
//	}
	/** iBatis 쿼리 출력 */
	private String getStatmentQuery(String statementId, Map parameterMap) {
		//SqlMapClientImpl sqlMapClientImpl;
		MappedStatement mappedStatement;
		StatementScope statementScope;
		SessionScope sessionScope;
		ParameterMap paramMap;
		Sql sql ;
		String statement = "";
		List<String> paramList = new ArrayList<String>();
		String result_sql = null;

		try {
			//sqlMapClientImpl = (SqlMapClientImpl)super.getSqlMapClient();
			//mappedStatement = sqlMapClientImpl.getMappedStatement(statementId);
			mappedStatement = ((ExtendedSqlMapClient) getSqlMapClient()).getMappedStatement(statementId);
			sessionScope = new SessionScope();
			statementScope = new StatementScope(sessionScope);
			mappedStatement.initRequest(statementScope);
			sql = mappedStatement.getSql();
			paramMap = sql.getParameterMap(statementScope, parameterMap);
			statement = sql.getSql(statementScope, parameterMap);

			for(ParameterMapping param : paramMap.getParameterMappings()) {
				//log.debug("## param.getPropertyName = "+param.getPropertyName());
				paramList.add(param.getPropertyName());
			}
		}catch(NullPointerException e){
			log.error("Executing Statement Exception ["+statementId+"] ");
			return result_sql;
		}catch(ArrayIndexOutOfBoundsException e){	
			log.error("Executing Statement Exception ["+statementId+"] ");
			return result_sql;
		} catch(Exception e) {
			log.error("Executing Statement Exception ["+statementId+"] ");
			return result_sql;
		}

		try {
			StringBuffer sb = new StringBuffer();
			String [] statementSplits = (statement+" ").split("\\?");

			int index = 0;
			for(String statementSplit : statementSplits) {
				sb.append(statementSplit);
				if(index + 1 < statementSplits.length) {
					//sb.append("'"+ getParameterValue(parameterMap, paramList.get(index)) +"' /* "+paramList.get(index)+" */");
					sb.append("'"+ getParameterValue(parameterMap, paramList.get(index)) +"'");
				}
				index++;
			}

			result_sql = sb.toString();
			//log.debug("Executing Statement["+statementId+"{"+paramMap.getParameterCount()+"}] : " + result_sql);
		}catch(NullPointerException e){
			log.error("Executing Statement Exception ["+statementId+"]  "+ statement);
			
		}catch(ArrayIndexOutOfBoundsException e){	
			log.error("Executing Statement Exception ["+statementId+"]  "+ statement);	
		} catch (Exception e) {
			log.error("Executing Statement Exception ["+statementId+"]  "+ statement);
		}

		return result_sql;
	}
	/** iBatis Query 파라미터 매핑 */
	private String getParameterValue(Map parameterMap, String key) {
		//key : List = SERNO_LIST[2]    파라미터가 List 형식의 경우
		//key : String = WORK_DVSN  파라미터가 String 형식의 경우
		String  tmpKey = key;
		String  tmpIndex = "-1";
		try {
			//ArrayList 형태의 parameter
			if(key.indexOf("[") >= 0 && key.indexOf("]") > 0) {
				tmpKey = key.substring(0, key.indexOf("["));
				tmpIndex = key.substring(key.indexOf("[") + 1, key.length() - 1);
			}
			//Logger.debug("## getParameterValue tmpKey = "+tmpKey);
			//Logger.debug("## getParameterValue tmpIndex = "+tmpIndex);
		}catch(NullPointerException e){
			log.error("getParameterValue Exception  ");
			
		}catch(ArrayIndexOutOfBoundsException e){	
			log.error("getParameterValue Exception  ");	
		} catch(Exception e) {
			log.error("getParameterValue Exception  ");
		}

		Object paramObject = parameterMap.get(tmpKey);
		if(paramObject == null) return "";

		if(paramObject instanceof String) return StringUtils.defaultString((String)paramObject);
		else if(paramObject instanceof Integer) return StringUtils.defaultString(""+paramObject);
		else if(paramObject instanceof Long) return StringUtils.defaultString(""+paramObject);
		else if(paramObject instanceof List) {
			return (String)((List)paramObject).get(Integer.parseInt(tmpIndex));
		}
		else return paramObject.toString();
	}

	
	/** count */
	private int getCountQuerySimpleJdbc(String query){
		int count = 0;
		//NamedParameterJdbcTemplate templateN = new NamedParameterJdbcTemplate(super.getDataSource());
		//count = templateN.queryForInt("SELECT count(*) FROM ("+query+")", new HashMap<String,Object>());

//		SimpleJdbcTemplate template = new SimpleJdbcTemplate(super.getDataSource());
		JdbcTemplate template = new JdbcTemplate(super.getDataSource());
		count = template.queryForObject("SELECT count(*) FROM ("+query+")", Integer.class);
		return count;
	}
//	/** string value */
//	private String getStringQuerySimpleJdbc(String query){
//		SimpleJdbcTemplate template = new SimpleJdbcTemplate(super.getDataSource());
//		String password = template.queryForObject( "SELECT password FROM article WHERE article_number=?", String.class, "변수");
//		return password;
//	}
	/** list */
	private List getListQuerySimpleJdbc(String query, int pageIndex, int pageSize){
//		SimpleJdbcTemplate template = new SimpleJdbcTemplate(super.getDataSource());
		JdbcTemplate template = new JdbcTemplate(super.getDataSource());
		List list = null;
		
		String _query = getPaginationSqlOracle(query,pageIndex,pageSize);
		Object[] _args = getPaginationSqlOracleArgs(pageIndex, pageSize);
		
		list = template.queryForList(_query, _args);
		return list;
	}
	
	/**
	 * 오라클용 - 페이징 쿼리문 
	 * @param innerQuery	페이징처리할 쿼리
	 * @param pageIndex		페이지번호
	 * @param pageSize		페이지사이즈
	 * @return
	 */
	public String getPaginationSqlOracle(String innerQuery, int pageIndex, int pageSize) {
		StringBuffer sql = new StringBuffer(" SELECT * FROM ( SELECT   INNER_TABLE.* , ROWNUM AS ROW_SEQ FROM ( \n");
		sql.append(innerQuery);
		sql.append("\n ) INNER_TABLE WHERE ROWNUM <= ? )  WHERE ROW_SEQ BETWEEN ? AND ?");
		return sql.toString();
	}
	public Object[] getPaginationSqlOracleArgs(int pageIndex, int pageSize) {
		Object[] args = new Object[3];
		int k=0;
		args[k++] = String.valueOf(new Long(pageIndex * pageSize));
		args[k++] = String.valueOf(new Long( (pageIndex - 1) * pageSize + 1));
		args[k++] = String.valueOf(new Long(pageIndex * pageSize));
		return args;
	}


//	@Override
//	public Object insert(String queryId) {
//		return super.insert(queryId);
//	}

	@Override
	public Object insert(String queryId, Object parameterObject) {
		// [사용중] TODO Auto-generated method stub
		printSqlId(queryId);
		return super.insert(queryId, parameterObject);
	}

//	@Override
//	public int update(String queryId) {
//		return super.update(queryId);
//	}

	@Override
	public int update(String queryId, Object parameterObject) {
		// [사용중] TODO Auto-generated method stub
		printSqlId(queryId);
		return super.update(queryId, parameterObject);
	}

//	@Override
//	public void update(String queryId, Object parameterObject, int requiredRowsAffected) {
//		super.update(queryId, parameterObject, requiredRowsAffected);
//	}

//	@Override
//	public int delete(String queryId) {
//		return super.delete(queryId);
//	}

	@Override
	public int delete(String queryId, Object parameterObject) {
		// [사용중] TODO Auto-generated method stub
		printSqlId(queryId);
		return super.delete(queryId, parameterObject);
	}

//	@Override
//	public void delete(String queryId, Object parameterObject, int requiredRowsAffected) {
//		super.delete(queryId, parameterObject, requiredRowsAffected);
//	}

//	@Override
//	public Object selectByPk(String queryId, Object parameterObject) {
//		return super.selectByPk(queryId, parameterObject);
//	}

//	@Override
//	public Object select(String queryId) {
//		return super.select(queryId);
//	}

//	@Override
//	public Object select(String queryId, Object parameterObject) {
//		return super.select(queryId, parameterObject);
//	}

//	@Override
//	public Object select(String queryId, Object parameterObject, Object resultObject) {
//		return super.select(queryId, parameterObject, resultObject);
//	}

//	@Override
//	public List<?> list(String queryId) {
//		return super.list(queryId);
//	}

	@Override
	public List<?> list(String queryId, Object parameterObject) {
		// [사용중] TODO Auto-generated method stub
		printSqlId(queryId);
		return super.list(queryId, parameterObject);
	}

//	@Override
//	public List<?> list(String queryId, int skipResults, int maxResults) {
//		return super.list(queryId, skipResults, maxResults);
//	}

//	@Override
//	public List<?> list(String queryId, Object parameterObject, int skipResults, int maxResults) {
//		return super.list(queryId, parameterObject, skipResults, maxResults);
//	}

//	전체 data를 가져와서 cursor로 내부적으로 해당 페이지를 리턴하는 방식
//	@Override
//	public List<?> listWithPaging(String queryId, Object parameterObject, int pageIndex, int pageSize) {
//		return super.listWithPaging(queryId, parameterObject, pageIndex, pageSize);
//	}

//	@Override
//	public Map<?, ?> map(String queryId, Object parameterObject, String keyProperty) {
//		return super.map(queryId, parameterObject, keyProperty);
//	}

//	@Override
//	public Map<?, ?> map(String queryId, Object parameterObject, String keyProperty, String valueProperty) {
//		return super.map(queryId, parameterObject, keyProperty, valueProperty);
//	}

}
