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
    String amtPaid= request.getParameter("amtPaid");

    String ob = request.getParameter("ob");

    String custId = request.getParameter("custId");

    String p ="pdate"+custId;
 
    String pdate = request.getParameter(String.valueOf((p)));

    String disc = request.getParameter("disc");

    String comments = request.getParameter("comments");
    String Id = request.getParameter("Id");

    System.out.println("amtPaid : " +amtPaid);
	if(amtPaid!=null && amtPaid!="")
	{
	
		 int dis=0;
	if(disc!=null && disc!="")
     dis=Integer.parseInt(disc);

    int amtp=Integer.parseInt(amtPaid);
  
    int outBal=Integer.parseInt(ob);
  
    int id = Integer.parseInt(Id);
  
 
    		outBal = outBal - dis - amtp;
   
    	
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
    System.out.println("UPDATE `Debtors` SET `OB`="+outBal+ "WHERE Id=" +id);
    preparedStatement = conn.prepareStatement("UPDATE `Debtors` SET `OB`=? WHERE Id=?");
    preparedStatement.setInt(1,outBal);
    preparedStatement.setInt(2,id);
    

    preparedStatement.executeUpdate();
    
    st=conn.createStatement();    
    System.out.println("INSERT INTO SaleCredit (CustID, Date, Amount, Discount,Comments) values ("+custId+",'"+pdate+"', "+amtp+",'"+comments+"')");
    int x=st.executeUpdate("INSERT INTO SaleCredit (CustID, Date, Amount, Discount,Comments) values ('"+custId+"','"+pdate+"', "+amtp+","+dis+",'"+comments+"')");
    
 /*  if(branch!=null && branch.length()!=0)
     response.sendRedirect("creditsale.jsp?branch="+branch); // redirect to JSP one, which will again reload.
     else */
  }
    	 response.sendRedirect("Debtors.jsp");
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