  <%@page language="java" import ="java.sql.*" %>  
<%@page language="java" import ="java.util.*" %>  
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page import="java.io.InputStream" %>
 
 <%  
 
/*  String buffer="";   */
DataSource ds = null;
Connection conn = null;
ResultSet rs = null;
Statement stmt=null;
String userid=request.getParameter("userid");
String pwd=request.getParameter("pwd");
try{
/* Context context = new InitialContext();
Context envCtx = (Context) context.lookup("java:comp/env");
ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
if (ds != null) {
  conn = ds.getConnection(); */
  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
  // conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234"); 
    Properties props = new Properties();
    InputStream in = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
    props.load(in);
    in.close();

    String driver = props.getProperty("jdbc.driver");
    if (driver != null) {
        Class.forName(driver).newInstance();  
    }

    String url = props.getProperty("jdbc.url");
    String jdbcUsername = props.getProperty("jdbc.username");
    String password = props.getProperty("jdbc.password");

    conn = DriverManager.getConnection(url, jdbcUsername, password);
  stmt = conn.createStatement(); 
  rs = stmt.executeQuery("SELECT * FROM Users where UserID = '"+userid+"'and Password='"+pwd+"'"); 



   if(rs.next()){
	   String username=rs.getString("Name");
	   response.sendRedirect("viewinventory.jsp?uname="+username+"&branch="+rs.getString("Branch")+"&role="+rs.getString("Role"));
	   
   }  
   else
	   response.sendRedirect("login.jsp?res=1"); 
//} 
}
catch (Exception e) {
e.printStackTrace();
}
                       finally {
                     	     try {
                     	       if (stmt!= null)
                     	        stmt.close();
                     	       }  catch (SQLException e) {}
                     	       try {
                     	        if (conn != null)
                     	         conn.close();
                     	        } catch (SQLException e) {}
                     	    }
 %>