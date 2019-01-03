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


    String branch = request.getParameter("branch");
    String role=(String)session.getAttribute("role"); 
    String uBranch=(String)session.getAttribute("ubranch");
    if(!(role.equals("1")) && role!=null)
 	   branch = uBranch;
    String ocode = request.getParameter("oldcode");
    String ncode=request.getParameter("newcode"); 
    String q=request.getParameter("qty"); 
     int qty=Integer.parseInt(q);
     
     int z=0;
   //  int one=1;
   
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
     // Class.forName("com.mysql.jdbc.Driver").newInstance();  
	 //    conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234"); 
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
/* 

    String s3= "UPDATE `NewInventory` SET `Quantity-`=1 WHERE Code="+ocode+" AND Branch="+branch;
    String s4= "UPDATE `NewInventory` SET `Quantity+`=1 WHERE Code="+ncode+" AND Branch="+branch;
     */
  String  sq="INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity+?";

     preparedStatement = conn.prepareStatement(sq);

     conn.setAutoCommit(false);
     
  //   preparedStatement.setInt(1,-1);
     preparedStatement.setString(1,ocode);
     preparedStatement.setString(2,branch);
     preparedStatement.setInt(3,z);
     preparedStatement.setInt(4,-qty);
     preparedStatement.addBatch();

    // preparedStatement.setInt(1,1);
     preparedStatement.setString(1,ncode);
     preparedStatement.setString(2,branch);
     preparedStatement.setInt(3,qty);
     preparedStatement.setInt(4,qty);
     preparedStatement.addBatch();

     int[] cnt = preparedStatement.executeBatch();

     conn.commit();
     
    	  response.sendRedirect("modification.jsp?res=1&oldcode="+ocode+"&newcode="+ncode+"&branch="+branch ); 
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