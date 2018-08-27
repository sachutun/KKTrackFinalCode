<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import= "java.util.Arrays" %>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.io.*" %>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*" %>
<%
/* String id = request.getParameter("userId"); */

 DataSource ds = null;
 Connection conn = null;
 Statement st = null;
PreparedStatement preparedStatement = null;

%>
<%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root"); */
    String recordToUpdate = request.getParameter("payid");
    String ap = request.getParameter("ap");
    String ba = request.getParameter("ba");
    String pay = request.getParameter("pay");
    String branch = request.getParameter("branch");
    String pdate = request.getParameter("pdate");
    String dis = request.getParameter("dis");
    
    int d=Integer.parseInt(recordToUpdate);
    int payment=Integer.parseInt(pay);
    int disc=Integer.parseInt(dis);
    int amtp=Integer.parseInt(ap);
    int bala=Integer.parseInt(ba);
    String up=Integer.toString(d);
   

   /*  Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    conn = ds.getConnection(); */
    
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
     //conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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

    conn = DriverManager.getConnection(url, username, password);
    
    preparedStatement = conn.prepareStatement("UPDATE `Sale` SET `AmountPaid`=?,`BalanceAmount`=?, `TotalPrice`=`TotalPrice`-? WHERE Id=?");
    preparedStatement.setInt(1,amtp+payment);
    preparedStatement.setInt(2,bala-payment);
    preparedStatement.setInt(3,disc);
    preparedStatement.setInt(4,d);
    preparedStatement.executeUpdate();
    
    st=conn.createStatement();    
    
    int x=st.executeUpdate("INSERT INTO SaleCredit (INo, Date, Amount, Discount) values ("+d+",'"+pdate+"', "+payment+","+disc+")");
    
 /*  if(branch!=null && branch.length()!=0)
     response.sendRedirect("creditsale.jsp?branch="+branch); // redirect to JSP one, which will again reload.
     else */
    	 response.sendRedirect("creditsale.jsp");
  //}
}catch (Exception e) {
    	 e.printStackTrace();
    	 }
finally {
	     try {
	       if (preparedStatement != null)
	    	   preparedStatement.close();
	    
	       }  catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>