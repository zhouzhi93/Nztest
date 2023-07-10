/***
 * SqlServer 操作类
 * 1.读取Tomcat配置文件创建数据库连接
 * 2.
 */
package com.infol.nztest.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.transaction.annotation.Transactional;

public class SqlServerOperator {


	/**
	 * 构造函数
	 * 读配置文件
	 */
	public SqlServerOperator() throws Exception {
		this.getConnection();
	}
	
	/**
	 * 构造函数
	 * @param linkConfig 传入的配置数据库属性节点
	 */
    public SqlServerOperator(String linkConfig) throws Exception{
    	this.getConnection(linkConfig);
    }
    
    /**
     * 默认的数据库配置
     */
    private String defaultLinkConfig = "pesticides";
    
    /**
     * 测试使用：打印出所有数据库操作
     */
    private boolean debug = true;
    
	/**
	 * 数据库连接对象
	 */
    private Connection conn = null ;
    
    /**
     * 数据库集对象
     */
    private ResultSet rst = null ;
    
    public ResultSet getRst(){
    	return this.rst ; 
    }
    
    /**
     * 数据操作对象
     */
    private Statement smt = null ;
    
    public Connection getConn(){
    	return this.conn;
    }
    
	/**
	 * 存放参数的列表
	 */
	public HashMap<String,String> params = new HashMap();

	public HashMap<String, String> getParams() {
		return params;
	}

	public void setParams(HashMap<String, String> params) {
		this.params = params;
	}
	
	/**
    * 获取参数值
    * @param name
    * @return
    */
   public String getParameter(String name){
	   	String Result = null;
	   	try{
	   		Result = (String)this.params.get(name);
	   		//
	   		if(Result == null)Result = "";
	   		return Result;
	   	}catch(Exception e){
	   		return Result;
	   	}
   	}
   
	/**
	 * servlet的对象，用于获取参数 
	 */
	private HttpServletRequest request;
	
	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
		this.getProperty(request);
	}
	
	/**
	 * 将servlet的对象放入到参数列表中
	 * @param request
	 */
	public void getProperty(HttpServletRequest request) {
		this.request = request;
        Enumeration en = request.getParameterNames();
        String value;
        String key = null;
        while (en.hasMoreElements()) {
            key = (String) en.nextElement();
            value = request.getParameter(key);
            this.params.put(key, value);
        }
    }

	/**
	 * 返回数据库连接对象
	 * @return
	 */
	public Connection getConnection(String linkConfig) throws Exception {
    	if(linkConfig.equals(""))
    		linkConfig = this.defaultLinkConfig;
    	Context c = new InitialContext();
    	DataSource ds =(DataSource)c.lookup("java:comp/env/jdbc/"+linkConfig) ;
    	this.conn = ds.getConnection();
    	return this.conn;
    }

	/**
	 * 返回数据库连接对象
	 * @return
	 */
	public Connection getConnection() throws Exception {
		this.conn = JdbcUtil.getConnection();
		return this.conn;
	}
	
	
	private static String ErrorInfo = "";
	
	public static String getErrorInfo() {
		return ErrorInfo;
	}

	/**
	 * 打印Sql
	 * @param sql
	 * @param args
	 */
    private void printSqlAndArgs(String sql,String[] args) {
    	if(!this.debug)return;
    	System.out.println(sql);
    	int s = args==null?0:args.length;
    	for(int i=0;i<s; i++)System.out.print(args[i]+", ");
    	System.out.println("");
    }
    
    /**
	 * 打印Sql
	 * @param sql
	 */
    private void printSqlArgs(String[] sql) {
    	if(!this.debug)return;
    	System.out.println(sql);
    	int s = sql==null?0:sql.length;
    	for(int i=0;i<s; i++)System.out.println(sql[i]);
    }
    
    /**
	 * 打印Sql
	 * @param sql
	 */
    private void printSqlList(List sql) {
    	if(!this.debug)return;
    	int s = sql==null?0:sql.size();
    	String sSqlString = null;
    	for(int i=0;i<s; i++){
    		sSqlString = (String)sql.get(i);
    		System.out.println(sSqlString);
    	}
    }
    
    
    /**
     * @deprecated：执行数据库的update/delete/insert操作
     * @param sql String：要执行的SQL语句
     * @return int：返回对数据库影响的行数
     * @throws SQLException
     */
    public int executeUpdate(String sql) {//log.info(sql); 
    	if(sql==null||sql.length()<5) {
    		return -1;
    	}
        int i = -1;
        Connection conn = null;
        Statement state = null;
        try {
            conn = this.getConn();
            conn.setAutoCommit(false); //手工提交事务
            state = conn.createStatement();
            i = state.executeUpdate(sql); //执行操作
            conn.commit(); //提交事务
            conn.setAutoCommit(true);
			System.out.println(sql);
        } catch (SQLException e) { //数据库更新不成功,执行回滚.           
            //log.log(Level.INFO, sql + "   " + e.getMessage());
            e.printStackTrace();
            System.out.println(sql);
            i = -1;
            try {
            
            if (conn != null) {
                conn.rollback();
                conn.setAutoCommit(true);
            }
            } catch (Exception ee){}
            
        } finally {
            this.closeConnection();            
        }
        return i;
    } 
    
	/**
	 * 执行一条Sql语句
	 * @param SqlString
	 * @throws Exception
	 */
	public void ExecSQL(String SqlString) throws Exception{
		this.printSqlAndArgs(SqlString, null);
		
		if ( conn == null ) throw new Exception("未连接数据库！");    		
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要执行的SQL！");
		
		smt = conn.createStatement() ;    			
		smt.executeUpdate(SqlString);    			
		smt.close();
	}

	public String execSqls(List sqls) throws Exception{
		//this.printSqlAndArgs(SqlString, null);

		if ( conn == null ) throw new Exception("未连接数据库！");
		int s = sqls==null?0:sqls.size();
		if ( s==0 ) throw new Exception("当前没有任何需要执行的SQL！");
		boolean ok = false;
		try {
			conn.setAutoCommit(false);//自动提交取消
			smt = conn.createStatement();
			String str = null;
			for (int i = 0; i < s; i++) {
				str = (String)sqls.get(i);
				if(str.length()>10)smt.executeUpdate(str);
			}
			smt.close();
			conn.commit();
			ok = true;
			conn.setAutoCommit(true);//重置为自动提交
		} catch(Exception e){
            try{
            	if(!conn.getAutoCommit()){
            		conn.rollback();
            		conn.setAutoCommit(true);
				}
			} catch(Exception ee){};
		}
		return ok?"操作成功":"操作失败";
	}
	
	/**
	 * 执行Sql数组
	 * @param SqlString
	 * @throws Exception
	 */
	public void ExecSQL(String[] SqlString) throws Exception  {      	
		this.printSqlArgs(SqlString);   		
 		
		if ( conn == null ) throw new Exception("未连接数据库！");    		
 		if ( SqlString.length == 0 ) throw new Exception("当前没有任何需要执行的SQL！");
 		
 		for(String s : SqlString){    			
 			smt = conn.createStatement() ;    			
 			smt.executeUpdate(s);    			
 			smt.close();   			
 		}    		
	}
	
	/**
	 * 执行Sql列表,带事务
	 * @param SqlString
	 * @throws Exception
	 */
	@Transactional
	public void ExecSql(List<String> SqlString) throws Exception{
		this.printSqlList(SqlString);   
		
		if ( conn == null ) throw new Exception("未连接数据库！");    		
		if ( SqlString.size() == 0 ) throw new Exception("当前没有任何需要执行的SQL！");
		
		try{  
			conn.setAutoCommit(false);
			smt = conn.createStatement() ;
			for(String s : SqlString){
				smt.executeUpdate(s);
			}
			smt.close();
			conn.commit();
			conn.setAutoCommit(true);
		}catch(Exception e){
			System.out.print("error:"+e.getMessage());
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			throw e;
		}
	}
	
	/**
	 * 执行Sql列表，不带事务
	 * @param SqlString
	 * @throws Exception
	 */
	public void ExecSqlList(List<String> SqlString) throws Exception{
		this.printSqlList(SqlString);    		
		if ( conn == null ) throw new Exception("未连接数据库！");    		
		if ( SqlString.size() == 0 ) throw new Exception("当前没有任何需要执行的SQL！");
		smt = conn.createStatement() ;
		for(String s : SqlString){

			smt.executeUpdate(s);    			

		}
		smt.close();
	}
	
	/**
	 * 执行Sql，带参数
	 * @param SqlString
	 * @param args
	 * @throws Exception
	 */
	public void ExecSQL(String SqlString,String[] args) throws Exception {
		this.printSqlAndArgs(SqlString, args);
		
		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！");
		
		if( args.length == 0 ){
			ExecSQL(SqlString) ;  //如果没有参数，直接调用上面的普通查询
			return;
		}
		
		try{
			int i = 0 ;
			PreparedStatement pStmt = conn.prepareStatement(SqlString);
			for(String sParam : args){
				pStmt.setString(++i, sParam) ;
			}
			
			pStmt.executeUpdate();
		}catch(Exception e){
			System.out.println("错误Sql");
			System.out.println(SqlString);
    		for(int i=0;i<args.length;i++)System.out.print(args[i]+"    ");
    		throw e;
		}
	}

	public void ExecSQL(String SqlString,String[] args,Map cols) throws Exception {
		this.printSqlAndArgs(SqlString, args);

		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！");

		if( args.length == 0 ){
			ExecSQL(SqlString) ;  //如果没有参数，直接调用上面的普通查询
			return;
		}

		try{
			int i = 0 ;
			PreparedStatement pStmt = conn.prepareStatement(SqlString);
			for(String sParam : args){
				if(cols!=null && cols.containsKey(String.valueOf(i))) {
					pStmt.setBytes(++i,sParam.getBytes("UTF-8"));
				} else pStmt.setString(++i, sParam) ;
			}

			pStmt.executeUpdate();
		}catch(Exception e){
			System.out.println("错误Sql");
			System.out.println(SqlString);
			for(int i=0;i<args.length;i++)System.out.print(args[i]+"    ");
			throw e;
		}
	}

	public void ExecSQL(String SqlString,List<String[]> params) throws Exception {

		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要执行的SQL！");
		try{
			int i = 0,j=0,k=0 ;
			conn.setAutoCommit(false);
			PreparedStatement pStmt = conn.prepareStatement(SqlString);
			int s = params.size();
			String[] args = null;
			String val = null;

			for(i=0; i<s; i++){
				args = (String[])params.get(i);
				k = args.length;
				this.printSqlAndArgs(SqlString, args);
				for(j=0; j<k; j++) {
					//System.out.println(j+" ==== " + args[j]);
					pStmt.setString(j+1,args[j]);
				}
				pStmt.executeUpdate();
			}
			conn.commit();
			conn.setAutoCommit(true);
		}catch(Exception e){
			//e.printStackTrace();
			conn.rollback();
			System.out.println("错误Sql");
			System.out.println(SqlString);
			throw e;
		}
	}
	
	/**
     * @deprecated  查询出键值对
     * @param sql
     * @return
     */
    public Map queryMap(String sql){
    	Map map = new HashMap();
    	Connection conn_ = null;
        Statement state = null;
        ResultSet rs = null;
        String result = null;
        try {
        	conn_ = this.getConnection("");
            state = conn_.createStatement();
            rs = state.executeQuery(sql);
            while (rs.next()) {
            	//System.out.println(rs.getString(1).toLowerCase()+"-----"+rs.getString(2));
                map.put(rs.getString(1).toLowerCase(),rs.getString(2));
            }
        } catch (Exception e) {
            //log.log(Level.INFO, sql + "   " + e.getMessage());
        }finally{
        	this.closeConnection();
        }
    	return map;
    }
	
	
	/**
	 * 查询一条SQL
	 * @param SqlString
	 * @throws Exception
	 */
	public void RunSQL(String SqlString) throws Exception {
    	this.printSqlAndArgs(SqlString, null);        	        	       
        	if ( conn == null ) throw new Exception("未连接数据库！");
    		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！"); 
    		
    		rst = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY).executeQuery(SqlString);
    		//rst = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_READ_ONLY).executeQuery(SqlString);
    }
	
	/**
	 * 查询Sql，带参数
	 * @param SqlString
	 * @param args
	 * @throws Exception
	 */
	public void RunSQL(String SqlString,String[] args) throws Exception {
		if(args==null || args.length == 0 ){
			RunSQL(SqlString) ;  //如果没有参数，直接调用上面的普通查询
			return;

		}
    	this.printSqlAndArgs(SqlString, args);
    	
		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！");
    		
		int i = 0 ;
		PreparedStatement pStmt = conn.prepareStatement(SqlString);
		for(String sParam : args){
			i++ ;
			pStmt.setString(i, sParam) ;
		}       		
		rst = pStmt.executeQuery() ;     		    		
    }
	
	/**
	 * 查询Sql，带参数
	 * @param SqlString
	 * @param args
	 * @throws Exception
	 */
	public void RunSQL(String SqlString,List<String> args) throws Exception {
    	if( args.size() == 0 ){
			RunSQL(SqlString) ;  //如果没有参数，直接调用上面的普通查询
			return;

		}
    	this.printSqlAndArgs(SqlString, null);
    	
		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！");
		
		
		
		int i = 0 ;
		PreparedStatement pStmt = conn.prepareStatement(SqlString);
		for(String sParam : args){
			i++ ;
			pStmt.setString(i, sParam) ;
		}       		
		rst = pStmt.executeQuery() ;     		    		
    }
	
	/**
	 * 执行Sql返回数据集
	 * @param SqlString
	 * @throws Exception
	 */
	public ResultSet RunSQLToResSet(String SqlString) throws Exception  {
	       
    	if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！"); 
		
		this.printSqlAndArgs(SqlString, null); 
		ResultSet outRst = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
							ResultSet.CONCUR_UPDATABLE).executeQuery(SqlString) ;
		return outRst ;
	}
	
		
	/**
	 * 查询sql，返回json字符串
	 * @param SqlString
	 * @return
	 * @throws Exception
	 */
	public String RunSQL_JSON(String SqlString) throws Exception {
    	this.printSqlAndArgs(SqlString, null);
    	if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！"); 
		rst = conn.createStatement().executeQuery(SqlString.toUpperCase()) ;      		    		
		
		return resultSetToJson(rst);                
    }

	/**
	 * 查询sql，返回json字符串不同一大小写key
	 * @param SqlString
	 * @return
	 * @throws Exception
	 */
	public String RunSQL_JSONNoToCase(String SqlString) throws Exception {
		this.printSqlAndArgs(SqlString, null);
		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！");
		rst = conn.createStatement().executeQuery(SqlString) ;

		return resultSetToJsonNoToCase(rst);
	}
	
	/**
	 * 查询带参sql，返回json字符串
	 * @param SqlString
	 * @param args
	 * @return
	 * @throws Exception
	 */
	public String RunSQL_JSON(String SqlString,String[] args) throws Exception {
		return this.RunSQL_JSON(SqlString,args,null);
	}
	//20230517 新增image字段处理
	public String RunSQL_JSON(String SqlString,String[] args,String cols) throws Exception {
		this.printSqlAndArgs(SqlString,args);

		if ( conn == null ) throw new Exception("未连接数据库！");
		if ( SqlString.equals("") ) throw new Exception("当前没有任何需要查询的SQL！"); 
		this.RunSQL(SqlString, args);
		rst = this.getRst();

		return resultSetToJson(rst,cols);
	}
	
	/**
	 * 将RestSet转换成Json
	 * @param myRst
	 * @return
	 * @throws Exception
	 */
	public String RunSQL_JSON(ResultSet myRst) throws Exception  {
		if(myRst == null) throw new Exception("未指定有效的ResultSet对象！");
		return resultSetToJson(myRst);
	}
	
	
	/**
	 * 将数据集转换成Json
	 * @param jsonRst
	 * @return
	 * @throws Exception
	 */
	private String resultSetToJson(ResultSet jsonRst) throws Exception  {
		return this.resultSetToJson(jsonRst,null);
	}
	private String resultSetToJson(ResultSet jsonRst,String cols) throws Exception  {

		//json数组
    	JSONArray array = new JSONArray();      	   
    	// 获取列数      	
    	try{
    	  ResultSetMetaData metaData = jsonRst.getMetaData();  
    	  int columnCount = metaData.getColumnCount();
		  String columnName = null, value = null;

			while (jsonRst.next()){
    		 JSONObject jsonObj = new JSONObject();      		 
			 for(int i=1;i<= columnCount;i++){
				 columnName =metaData.getColumnLabel(i);
				 if (cols != null && cols.indexOf(columnName.toUpperCase() + ",") != -1)
					 value = new String(new String(jsonRst.getBytes(columnName)).getBytes(), "UTF-8");
				 else value = jsonRst.getString(columnName);
				 try{
					 jsonObj.put(columnName.toUpperCase(), value);						 						 				 
				 }catch(JSONException ee){
					 return "";  
				 }
			 }
			 array.put(jsonObj) ;
		  }
		}catch (Exception e){
			e.printStackTrace();
			throw e;
		}
		return array.toString() ;
    }

	/**
	 * 将数据集转换成Json不统一大小写
	 * @param jsonRst
	 * @return
	 * @throws Exception
	 */
	private String resultSetToJsonNoToCase(ResultSet jsonRst) throws Exception  {
		//json数组
		JSONArray array = new JSONArray();
		// 获取列数
		//try{
		ResultSetMetaData metaData = jsonRst.getMetaData();
		int columnCount = metaData.getColumnCount();

		while (jsonRst.next()){
			JSONObject jsonObj = new JSONObject();
			for(int i=1 ;i<= columnCount;i++){
				String columnName =metaData.getColumnLabel(i);
				String value = jsonRst.getString(columnName);
				try{
					jsonObj.put(columnName, value);
				}catch(JSONException ee){
					return "";
				}
			}
			array.put(jsonObj) ;
		}
		return array.toString() ;
	}
	
	
	/**
    * 传入json字符串，从数据库中获取值
    * @param JsonSql
    * @return
    * @throws Exception
    */
   public String RunSqlJsonToJson(String JsonSql)throws Exception{
   	//将传入的字符转换Json对象
		JSONObject jo = new JSONObject(JsonSql);
		//Json对象的迭代器
		Iterator<?> it = jo.keys();
		String tableName = "";
		String sqlString = "";
		Hashtable<String,String> htResult = new Hashtable<String,String>();
		//遍历JSONObject 
		while(it.hasNext()){
			//获得Json对象的表明
			tableName = (String) it.next().toString();
			//获取表的Json数组
			sqlString = jo.getString(tableName);
			htResult.put(tableName, this.RunSQL_JSON(sqlString));
       } 
		//循环hash
		sqlString = "";
		for(String e:htResult.keySet()){
			if (!sqlString.equals(""))
				sqlString += ",";
			sqlString += "\""+ e + "\":"+ htResult.get(e) + "";
		}
		sqlString = "{" + sqlString + "}";
		return sqlString;
   }
   
   /**
    * 查询一条sql，判断时间是否存在
    * @param sql
    * @param args
    * @return
    * @throws Exception
    */
   public boolean exists(String sql,String[] args) throws Exception {
   		this.RunSQL(sql,args);
		ResultSet rs = this.getRst();
		rs.next();	
		return !"0".equals(rs.getString(1));
	}

   /**
    * 查询一条sql，判断时间是否存在
    * @param sql
    * @return
    * @throws Exception
    */
   public boolean exists(String sql) throws Exception {
  		this.RunSQL(sql);
		ResultSet rs = this.getRst();
		rs.next();	
		return !"0".equals(rs.getString(1));
	}
   
   /**
    * 关闭连接
    */
   public void closeConnection(){
       try{
    	 if(this.conn != null) {
    		 if(!this.conn.isClosed()){
    			 this.conn.close();
    		 }    			 
    	 }   
       }catch (Exception e) {
		  ErrorInfo = e.getMessage();
	   } 			
	}    
   
   /**
    * 解析Sql条件
    * @param searchCondition
    * @return
    * @throws Exception
    */
    public String decodeSearchCondition(String searchCondition)throws Exception{
	   	String Result = "";
	   	JSONObject jsonCondition = new JSONObject(searchCondition);
	   	Iterator<?> it = jsonCondition.keys();
	   	while (it.hasNext()) {  
	   		String key = (String)it.next();
	   		String value = jsonCondition.getString(key);
	   		if(!"".equals(Result)) Result += " and ";
	   		Result += key + "='" + value + "'";
	   	}
	   	return Result;
    }
   
   	
    /**
     * 判断字符串是否为数字
     * @param str
     * @return
     */
    public boolean isNumeric(String str){
   	 	return str.matches("-?[0-9]+.*[0-9]*");
    }
    
    
    
    
    /**
     * 查询仅有一列的数据集合
     * @param sql
     * @return
     * @throws Exception
     */
    public List queryOneColumnData(String sql) throws Exception{//log.info(sql);
    	List list = new ArrayList();
        this.RunSQL(sql);
        //rst.getMetaData();
        while (rst.next()) {
        	list.add(rst.getString(1));
        }
        return list;
    }
    
    /**
     * 查询仅有一列的数据集合,带参数
     * @param sql
     * @return
     * @throws Exception
     */
    public List queryOneColumnDataByArgs(String sql,String[] args)throws Exception {//log.info(sql);
    	this.printSqlAndArgs(sql, args);
    	List list = new ArrayList();
        this.RunSQL(sql,args);
        while (rst.next()) {
        	list.add(rst.getString(1));
        }
        return list;
    }
    
    public List queryList(String sql) {
    	return this.queryList(sql,null);
	}
	public List queryList(String sql,String[] args){
    	if(args!=null)this.printSqlAndArgs(sql, args);
    	List list = new ArrayList();
        //Connection conn = null;
        PreparedStatement state = null;
        ResultSet rs = null;
        try {//print(sql);
            //conn = this.getConn();
            state = conn.prepareStatement(sql);
            if(args!=null) {
            	int i=0;
				for (String sParam : args) {
					i++;
					state.setString(i, sParam);
				}
			}
            rs = state.executeQuery();
            int j = rs.getMetaData().getColumnCount();
            int i = 0;
            String value = null;            
            String[] arr = null;
            while (rs.next()) {
            	arr = new String[j];
                for(i = 0; i < j; i++) arr[i] = rs.getString(i+1);
                list.add(arr);
            }
        } catch (Exception e) {   
            
            e.printStackTrace();
           System.out.println(sql);
        } finally {
            //this.closeConnection();
            return list;
        }
    }
    
    /**
     * 查询仅有一行多列的数据集合
     * @param sql
     * @return
     * @throws Exception
     */
    public String[] queryArrData(String sql) throws Exception{//log.info(sql);
    	List list = new ArrayList();
        this.RunSQL(sql);
        ResultSetMetaData mrst = rst.getMetaData();
        int s = mrst.getColumnCount();
        String[] arr = new String[s];
        while (rst.next()) {
        	for(int i=0;i<s; i++) arr[i] = rst.getString(i+1);
        	break;
        }
        return arr;
    }
    
    /**
     * 查询仅有一行多列的数据集合
     * @param sql
     * @param args
     * @return
     * @throws Exception
     */
    public String[] queryArrData(String sql,String[] args) throws Exception{//log.info(sql);
    	List list = new ArrayList();
        this.RunSQL(sql,args);
        ResultSetMetaData mrst = rst.getMetaData();
        int s = mrst.getColumnCount();
        String[] arr = new String[s];
        while (rst.next()) {
        	for(int i=0;i<s; i++) arr[i] = rst.getString(i+1);
        	break;
        }
        return arr;
    }
    
    /**
     * 专门为仅返回一行，并且只需要返回第一个字段值
     * @param sql
     * @return
     */
    public String queryOneRecorderData(String sql) {  //log.info(sql);
    	return this.queryOneRecorderData(sql,null);
    }
    
    /**
     * 专门为仅返回一行，并且只需要返回第一个字段值
     * @param SqlString
     * @return
     */
    public String queryOneRecorderData(String SqlString,String[] args) {  //log.info(sql);
		String result = null;
		//if (conn == null) throw new Exception("未连接数据库！");
		//if (SqlString.equals("")) throw new Exception("当前没有任何需要查询的SQL！");
        if(SqlString==null||"".equals(SqlString)){
        	System.out.println("当前没有任何需要查询的SQL！");
        	return "";
		}
		try {
			PreparedStatement pStmt = conn.prepareStatement(SqlString);
			if (args==null||args.length == 0) {
			} else {
				this.printSqlAndArgs(SqlString, args);
				int i = 0;
				for (String sParam : args) {
					i++;
					pStmt.setString(i, sParam);
				}
			}
			rst = pStmt.executeQuery();
			while (rst.next()) {
				result = rst.getString(1);
				break;
			}
		} catch(Exception e){

		}
		return result;
    }
    
    
    public void responseWrite(HttpServletResponse response,String Result) throws Exception{
    	
    	//判断是否JSONP
		boolean jsonP = false;
		String cb = request.getParameter("callback");
		if (cb != null) {
		    jsonP = true;
		    response.setContentType("text/javascript");
		} else {
		    response.setContentType("application/x-json");
		}
		String resString = "";
		//返回数据
		if (jsonP) {
			resString = cb + "(";			
		}			
		ServletResponse res = (ServletResponse)response;
		res.setCharacterEncoding("UTF-8");		
		if (jsonP) {
			resString += Result;
			resString += ");";
			response.getWriter().write(resString);
		}else{
			response.getWriter().write(Result);
		}
    }
    
    
    public void reply(HttpServletResponse response,String value) {
    	if(value!=null) {
    		//System.out.println("return "+value);
    		ServletResponse res = (ServletResponse)response;
    		res.setCharacterEncoding("UTF-8");
    		try {
	    		response.getWriter().print(value);
	    	} catch (Exception e) {
	    	    	
	    	}
    	}
    }

    public void executeStoredProcedure(String sql,String[] ags){
		try{
			CallableStatement cstmt = conn.prepareCall(sql);
			int i = 1;
			for (String t:ags) {
				cstmt.setString(i,t);
				i++;
			}
			cstmt.executeQuery();
		}catch (Exception e){
			e.printStackTrace();
		}
	}

}
