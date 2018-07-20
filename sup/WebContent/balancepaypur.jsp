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
<%
/* String id = request.getParameter("userId"); */

DataSource ds = null;
Connection conn = null;
Statement st = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;
%>
<%
try{ 

    String recordToUpdate = request.getParameter("payid");
    String ap = request.getParameter("ap");
    String ba = request.getParameter("ba");
    String pay = request.getParameter("pay");
    String branch = request.getParameter("branch");
    String pdate = request.getParameter("pdate");
    int d=Integer.parseInt(recordToUpdate);
    int payment=Integer.parseInt(pay);
    int amtp=Integer.parseInt(ap);
    int bala=Integer.parseInt(ba);
    String up=Integer.toString(d);
    
  /*   Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
 
      Class.forName("com.mysql.jdbc.Driver").newInstance();  
	     conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
	     
    preparedStatement = conn.prepareStatement("UPDATE `Purchases` SET `AmountPaid`=?,`BalanceAmount`=? WHERE Id=?");
    preparedStatement.setInt(1,amtp+payment);
    preparedStatement.setInt(2,bala-payment);
    preparedStatement.setInt(3,d);
    preparedStatement.executeUpdate();
    
    st=conn.createStatement();    
    
    int x=st.executeUpdate("INSERT INTO CreditPurchase (DC, Date, Amount) values ("+d+",'"+pdate+"', "+payment+")");
 /*  if(branch!=null && branch.length()!=0)
     response.sendRedirect("creditsale.jsp?branch="+branch); // redirect to JSP one, which will again reload.
     else */
    	 response.sendRedirect("creditpurchase.jsp");
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