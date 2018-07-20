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


    String mac = request.getParameter("mac");
    String code = request.getParameter("cod");
    String pno = request.getParameter("pno");
    String des = request.getParameter("des");
    String grp = request.getParameter("grp");
    String max = request.getParameter("max");
    String min = request.getParameter("min");
    String lc = request.getParameter("lc");
    String hsn = request.getParameter("hsn");
    
   /*  System.out.println(nq); */
   
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
      Class.forName("com.mysql.jdbc.Driver").newInstance();  
	     conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
    st2=conn.createStatement();

  String s3="UPDATE `CodeList` SET `Machine`="+mac+",`HSNCode`="+hsn+",`PartNo`="+pno+",`Description`="+des+",`Grp`="+grp+",`MaxPrice`="+max+",`MinPrice`="+min+",`LC`="+lc+" WHERE `Code`="+code;
 

  ps2 = conn.prepareStatement("UPDATE `CodeList` SET `Machine`=?,`HSNCode`=?,`PartNo`=?,`Description`=?,`Grp`=?,`MaxPrice`=?,`MinPrice`=?,`LC`=? WHERE `Code`=?");
    ps2.setString(1,mac);
    ps2.setString(2,hsn);
    ps2.setString(3,pno);
    ps2.setString(4,des);
    ps2.setString(5,grp);
    ps2.setString(6,max);
    ps2.setString(7,min);
    ps2.setString(8,lc);
    ps2.setString(9,code);
    ps2.executeUpdate(); 

    	  response.sendRedirect("editCodeIndividual.jsp?res=1&c="+code); 
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