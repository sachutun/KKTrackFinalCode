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
<%@ page language="java" import="java.util.*" %>
<%
/* String id = request.getParameter("userId"); */
String driverName = "com.mysql.jdbc.Driver";


try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection conn = null;
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement1 = null;
%>
<%
try{ 
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
  
    String branch = request.getParameter("branch");
    String recordToDelete = request.getParameter("deleteId");
    String amt=request.getParameter("amt");
     String disc=request.getParameter("disc");
     String CustId=request.getParameter("CustId");
     String OB=request.getParameter("OB");
    //System.out.println("-------------------- " +amt+" " +disc+" " +recordToDelete+" " +CustId+" " +OB);
    int d=Integer.parseInt(recordToDelete);
    //String del=Integer.toString(d);
    int dis;
    if(disc!="" && disc!=null)
    		dis=Integer.parseInt(disc);
    else
    		dis=0;
    int outBal=Integer.parseInt(OB)+Integer.parseInt(amt)+dis;
   // System.out.println("---outbal new---- " +outBal);
    preparedStatement = conn.prepareStatement("DELETE FROM SaleCredit WHERE id = ?");
    preparedStatement.setInt(1,d);
    preparedStatement.executeUpdate();
    //System.out.println("UPDATE `Debtors` SET `OB`="+outBal+ " WHERE Id=" +CustId);
    preparedStatement1 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=?  WHERE CustId=?");
    preparedStatement1.setInt(1,outBal);
    preparedStatement1.setString(2,CustId);
    preparedStatement1.executeUpdate();

     response.sendRedirect("Debtors.jsp?branch="+branch); // redirect to JSP one, which will again reload.
}catch (Exception e) {
    	 e.printStackTrace();
    	 }
%>
