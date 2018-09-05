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
/* String driverName = "com.mysql.jdbc.Driver";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
 */
 
DataSource ds = null;
Connection conn = null;
PreparedStatement preparedStatement = null;
PreparedStatement ps = null;
PreparedStatement ps2 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;

try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root"); */
    String recordToUpdate = request.getParameter("payid");
    String branch = request.getParameter("branch");
    String dc = request.getParameter("dcn");
    String sd = request.getParameter("sad");
    String ba = request.getParameter("ba");
    
    String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno);
 
 
    String dq = request.getParameter("dq"+sn);
    String cp = request.getParameter("cp"+sn);
    String eq = request.getParameter("eq"+sn);

   
    String q = request.getParameter("q"+sn);
    String bid = request.getParameter("bid"+sn);
    String cod = request.getParameter("code"+sn);


     int d=Integer.parseInt(recordToUpdate);
    int damage=Integer.parseInt(dq);
    int code=Integer.parseInt(cod);
    int cost=Integer.parseInt(cp);
    int qty=Integer.parseInt(q);
    int excess=Integer.parseInt(eq);
    int bala=Integer.parseInt(ba);
    int billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    
    //initial total
    int itotalp=cost*qty;
    
    //after return
    qty-=damage+excess;
    
    //new total - total to update in BillDetails
    int totalp=cost*qty;
    
    //diff to subtract from Sale total - Sale=Sale-diff
    int diff=itotalp-totalp;
    
    //bal amt = bal amt- diff
    		
    	 bala-=diff;
   
   
 String s1= "UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-"+diff+",`BalanceAmount`="+bala+" WHERE Id="+d;
   String s2="UPDATE `BillDetails` SET `Total`="+totalp+",`Qty`="+qty+" WHERE Id="+billid;
  String s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+"+excess+" WHERE Code="+code+" AND Branch="+branch;
 
  /* Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    conn = ds.getConnection(); */
    
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
    // conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234"); 
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
   
   preparedStatement = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-?,`BalanceAmount`=? WHERE Id=?");
    preparedStatement.setInt(1,diff);
    preparedStatement.setInt(2,bala);
    preparedStatement.setInt(3,d);
    preparedStatement.executeUpdate(); 
    
    ps = conn.prepareStatement("UPDATE `BillDetails` SET `Total`=?,`Qty`=? WHERE Id=?");
    ps.setInt(1,totalp);
    ps.setInt(2,qty);
    ps.setInt(3,billid);
    ps.executeUpdate();  
    
    if(excess > 0)
    {
    ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`+? WHERE Code=? AND Branch=?");
    ps2.setInt(1,excess);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate();
    }
   
    
   if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else 
    	 response.sendRedirect("addsalereturn.jsp");
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