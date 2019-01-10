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
ResultSet resultSet = null;
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
    String recordToDelete = request.getParameter("deleteid");
    int d=Integer.parseInt(recordToDelete);
    String del=Integer.toString(d);
  /*   preparedStatement=connection.createStatement();
    // Use PreparedStatements here instead of Statment
    resultSet = statement.executeQuery("delete from Expenses where id="+ recordToDelete ); */
    System.out.println("DELETE FROM CashTransfer WHERE id = " +d);
    preparedStatement = conn.prepareStatement("DELETE FROM CashTransfer WHERE id = ?");
    preparedStatement.setInt(1,d);
    preparedStatement.executeUpdate();
     response.sendRedirect("editCashTransfer.jsp?res=1"); // redirect to JSP one, which will again reload.
}catch (Exception e) {
    	 e.printStackTrace();
    	 }
%>