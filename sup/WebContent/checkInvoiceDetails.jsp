  <%@page language="java" import ="java.sql.*" %>  
<%@page language="java" import ="java.util.*" %>  
 <%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
 <%@ page import="java.io.InputStream" %>
 <%   
 String branch=request.getParameter("branch"); 
 String dt=request.getParameter("date");  
 String dc=request.getParameter("dcnumber");  
Statement stmt = null;

DataSource ds = null;
Connection con = null;
ResultSet rs=null;
int res=0;
try{
/* Context context = new InitialContext();
Context envCtx = (Context) context.lookup("java:comp/env");
ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
if (ds != null) {
  con = ds.getConnection(); */
  
 // Class.forName("com.mysql.jdbc.Driver").newInstance();  
 //  con = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
    Properties props = new Properties();
    InputStream in = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
    props.load(in);
    in.close();

    String driver = props.getProperty("jdbc.driver");
    if (driver != null) {
        Class.forName(driver).newInstance();  
    }

    String url = props.getProperty("jdbc.url");
    String username = props.getProperty("jdbc.username");
    String password = props.getProperty("jdbc.password");

    con = DriverManager.getConnection(url, username, password);
stmt = con.createStatement();  
//System.out.println("Select * from Sale where Date='"+dt+"'and Branch='"+branch+"'and DCNumber='"+dc+"'");
rs=stmt.executeQuery("Select * from Sale where Date='"+dt+"'and Branch='"+branch+"'and DCNumber='"+dc+"'");

if(rs.next())
{

	res=2;

}

//System.out.println("res invoice " +res);
 response.getWriter().println(res);    
//}
} catch (Exception e) {
e.printStackTrace();
}
                        finally {
                      	     try {
                      	       if (stmt != null)
                      	        stmt.close();
                      	
                      	       }  catch (SQLException e) {}
                      	       try {
                      	        if (con != null)
                      	         con.close();
                      	        } catch (SQLException e) {}
                      	    }
 %>