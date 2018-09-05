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
PreparedStatement ps3 = null;
PreparedStatement ps4 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
%>
<%
try{ 

    String recordToUpdate = request.getParameter("deleteid");

    String fbranch = request.getParameter("fbranch");
    String tbranch = request.getParameter("tbranch");
    String ibt = request.getParameter("ibt"); 
    String sd = request.getParameter("sd");
    int d=Integer.parseInt(recordToUpdate);

    int code=0;
    int qty=0;
    int billid=0;
    String s4="SELECT * FROM IBTDetails WHERE INo="+d;
   
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
  
       String bb = request.getParameter("i");
    int sn=Integer.parseInt(bb);
     /*   while (resultSet.next())
       {
       sn=resultSet.getInt("Id");
       } */
   /*  String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno); */

    String q = request.getParameter("q"+sn);
    String bid = request.getParameter("bid"+sn);
    String cod = request.getParameter("code"+sn);
   
     code=Integer.parseInt(cod);
     qty=Integer.parseInt(q);
  
     billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    //totalp is total price of item being deleted
 
    String isql= "";
    String isql2= "";
 
 //Add back to fbranch and remove from tbranch
    isql= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+"+qty+" WHERE Code="+code+" AND Branch="+fbranch;
    isql2= "UPDATE `NewInventory` SET `Quantity`=`Quantity`-"+qty+" WHERE Code="+code+" AND Branch="+tbranch; 



     st=conn.createStatement();

   
 String s1= "UPDATE `IBT` SET `TotalQty`=`TotalQty`-"+qty+" WHERE Id="+d;
   String s2="DELETE FROM IBTDetails WHERE id ="+billid;
  

    ps = conn.prepareStatement("DELETE FROM IBTDetails WHERE id = ?");
    ps.setInt(1,billid);
    ps.executeUpdate();   
    System.out.println(s2); 
   
    ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`+? WHERE Code= ? AND Branch=?");
    ps2.setInt(1,qty);
    ps2.setInt(2,code);
    ps2.setString(3,fbranch);
    ps2.executeUpdate(); 
    System.out.println(isql);
    
    ps3 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`-? WHERE Code= ? AND Branch=?");
    ps3.setInt(1,qty);
    ps3.setInt(2,code);
    ps3.setString(3,tbranch);
    ps3.executeUpdate(); 
    System.out.println(isql2);
    
    preparedStatement = conn.prepareStatement("UPDATE `IBT` SET `TotalQty`=`TotalQty`-? WHERE Id=?");
    preparedStatement.setInt(1,qty);
    preparedStatement.setInt(2,d);
    preparedStatement.executeUpdate(); 
    System.out.println(s1);
    
    st2=conn.createStatement();
    resultSet = st2.executeQuery("SELECT * FROM IBT where Id="+d);
    
    while(resultSet.next())
    {
    	double t=resultSet.getInt("TotalQty");
    	
    	if (t==0)
    	{
    		  ps4 = conn.prepareStatement("DELETE FROM IBT WHERE Id = ?");
    		    ps4.setInt(1,d);
    		    ps4.executeUpdate();   
    	}
    } 
    
/*    if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  */
     
    	 response.sendRedirect("editibtindividual.jsp?res=2&fbranch="+fbranch+"&dc="+ibt+"&sd="+sd);

//}
}catch (Exception e) {
    	 e.printStackTrace();
    	 }
finally {
	     try {
	       if (st != null)
	        st.close();
	    if (st2 != null)
	        st2.close();
	    if (preparedStatement != null)
	    	   preparedStatement.close();
	    if (ps != null)
	    	   ps.close();
	    if (ps2 != null)
	    	   ps2.close();
	       
	     if (ps4 != null)
	    	   ps4.close();
	       }catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>