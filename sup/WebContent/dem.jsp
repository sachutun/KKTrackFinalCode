<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
 
   <%
   try{
	   String name = request.getParameter("name");
	   String buffer="";  
 
     Class.forName("com.mysql.jdbc.Driver").newInstance();  
     Connection con = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");  
     Statement stmt = con.createStatement(); 
     ResultSet rs;
     rs = stmt.executeQuery("SELECT * FROM Inventory where Code like '"+name+"%'");
     while(rs.next())
     {
     buffer=buffer+"'"+rs.getString("Code")+"',";
     }
 response.getWriter().println(buffer);
 
rs.close();
stmt.close();
con.close();
 
}
catch(Exception e){
e.printStackTrace();
}
 
//www.java4s.com
%>

