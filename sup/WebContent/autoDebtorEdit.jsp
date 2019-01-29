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
PreparedStatement preparedStatement = null;
PreparedStatement ps = null;
PreparedStatement ps2 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
%>
<%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root"); */


    String custId = request.getParameter("custId");
    String custName = request.getParameter("custName");
    String mobile = request.getParameter("mobile");
    String aadhaar = request.getParameter("aadhaar");
    String gstno = request.getParameter("gst");
    String amt = request.getParameter("ob");
    String addMob = request.getParameter("addMob");
   // int gst=Integer.parseInt(gstno);
    int ob=Integer.parseInt(amt);
   /*  System.out.println(nq); */
   
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
     // Class.forName("com.mysql.jdbc.Driver").newInstance();  
	  //   conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234"); 
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
    st2=conn.createStatement();

  String s3="UPDATE `Debtors` SET `CustomerName`="+custName+",`Mobile`="+mobile+",`Aadhaar`="+aadhaar+",`GST`="+gstno+",`OB`="+ob+",`AdditionalMobile`="+addMob+" WHERE `CustID`="+custId;
 
System.out.println(s3);
  ps2 = conn.prepareStatement("UPDATE `Debtors` SET `CustomerName`=?,`Mobile`=?,`Aadhaar`=?,`GST`=?,`OB`=?,`AdditionalMobile`=? WHERE `CustID`=?");
    ps2.setString(1,custName);
    ps2.setString(2,mobile);
    ps2.setString(3,aadhaar);
    ps2.setString(4,gstno);
    ps2.setInt(5,ob);
    ps2.setString(6,addMob);
    ps2.setString(7,custId);
    ps2.executeUpdate(); 

    	  response.sendRedirect("EditDebtors.jsp"); 
  //  }
}catch (Exception e) {
    	 e.printStackTrace();
    	 }
finally {
	     try {
	       if (st != null)
	        st.close();
	    if (st2 != null)
	        st2.close();
	    if (ps != null)
	        ps.close();
	    if (ps2 != null)
	        ps2.close();
	    if (preparedStatement != null)
	    	preparedStatement.close();
	       }  catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>