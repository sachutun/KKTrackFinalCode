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

    String recordToUpdate = request.getParameter("payid");
    String branch = request.getParameter("branch");
    String dc = request.getParameter("dcn");
    String sd = request.getParameter("sad");
    String ba = request.getParameter("ba");
    String rd = request.getParameter("red");
    
    int d=Integer.parseInt(recordToUpdate);
    float bala=Integer.parseInt(ba);
    float ftot=0;
    
    String s4="SELECT * FROM InvoiceDetails WHERE INo="+d;
   
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
       resultSet = st2.executeQuery(s4);
       
       while (resultSet.next())
       {
       int sn=resultSet.getInt("Id");
    
   /*  String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno); */

 
    String dq = request.getParameter("dq"+sn);
    String cp = request.getParameter("cp"+sn);
    String eq = request.getParameter("eq"+sn);

   
    String q = request.getParameter("q"+sn);
    String bid = request.getParameter("bid"+sn);
    String cod = request.getParameter("code"+sn);



    
    int damage=Integer.parseInt(dq);
    int code=Integer.parseInt(cod);
    int cost=Integer.parseInt(cp);
    float qty=Float.parseFloat(q);
    float excess=Float.parseFloat(eq);
   
    int billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    
    //initial total
    float itotalp=cost*qty;
    
    //after return
    qty-=damage+excess;
    
    //new total - total to update in BillDetails
    float totalp=cost*qty;
    
    //diff to subtract from Sale total - Sale=Sale-diff
    float diff=itotalp-totalp;
    
    //bal amt = bal amt- diff
    		
    	 bala-=diff;
    	ftot+=diff;
    	
     st=conn.createStatement();

     if(excess > 0 || damage>0){
      String query="INSERT INTO PurchaseReturn (InvoiceNumber, Branch, PurchaseDate, ReturnDate, Code, ExcessQty, DamagedQty) values ('"+ dc+"', '"+branch+"', '"+sd+"','"+rd+"', '"+code+"', '"+excess+"', '"+damage+"')";
      int n=st.executeUpdate(query);  }
   
 String s1= "UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-"+diff+",`BalanceAmount`="+bala+" WHERE Id="+d;
   String s2="UPDATE `BillDetails` SET `Total`="+totalp+",`Qty`="+qty+" WHERE Id="+billid;
  String s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+"+excess+" WHERE Code="+code+" AND Branch="+branch;
  
/*   System.out.println(s1);
  System.out.println(s2);
  
  System.out.println(query); */

  
    
     ps = conn.prepareStatement("UPDATE `InvoiceDetails` SET `TotalPrice`=?,`Qty`=? WHERE Id=?");
    ps.setFloat(1,totalp);
    ps.setFloat(2,qty);
    ps.setInt(3,billid);
    ps.executeUpdate();   
    
 
 
    ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`-? WHERE Code=? AND Branch=?");
    ps2.setFloat(1,excess+damage);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate();
    
   
   
       } 
       
       preparedStatement = conn.prepareStatement("UPDATE `Purchases` SET `TotalPrice`=`TotalPrice`-?,`BalanceAmount`=? WHERE Id=?");
       preparedStatement.setFloat(1,ftot);
       preparedStatement.setFloat(2,bala);
       preparedStatement.setInt(3,d);
       preparedStatement.executeUpdate();  
  
    
    
    if(branch!=null && branch.length()!=0)
     response.sendRedirect("purchasereturn.jsp?res=1&branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  
    	 response.sendRedirect("purchasereturn.jsp?res=1");

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
	       }  catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>