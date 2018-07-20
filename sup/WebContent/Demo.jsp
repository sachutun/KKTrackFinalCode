<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>

<%
DataSource ds = null;
Connection conn = null;
ResultSet resultSet = null;
Statement stmt = null;
try{
  Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    conn = ds.getConnection();
    stmt = conn.createStatement();
    resultSet = stmt.executeQuery("SELECT * FROM NewInventory");
   }
 
%>
<h2 align="center"><font><strong>Retrieve data from database in jsp</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>

</tr>
<tr bgcolor="#A52A2A">
<td><b>id</b></td>
<td><b>user_id</b></td>
<td><b>Password</b></td>

</tr>
<%
/* try{ 
connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/jdbcdb","root","root");
statement=connection.createStatement();
String sql ="SELECT * FROM Employee";

resultSet = statement.executeQuery(sql); */
while(resultSet.next()){
%>
<tr bgcolor="#DEB887">

<td><%=resultSet.getString("Code") %></td>
<td><%=resultSet.getString("Branch") %></td>
<td><%=resultSet.getString("Quantity") %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>