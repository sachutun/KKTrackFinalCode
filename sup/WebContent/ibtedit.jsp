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
PreparedStatement preparedStatement2 = null;
PreparedStatement ps = null;
PreparedStatement ps2 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
%>
<%
try{ 

    String recordToUpdate = request.getParameter("payid");
    String tbranch = request.getParameter("tbranch");
    String fbranch = request.getParameter("fbranch");
    String ibtno = request.getParameter("ibtno");
    String date=request.getParameter("sd");
    
    String s1="";
    String sq1="";
    String sq2="";
    int Pid=Integer.parseInt(recordToUpdate);

    String s4="SELECT * FROM IBTDetails WHERE IBT="+Pid;
   
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
       resultSet = st2.executeQuery(s4);
       float diffq=0;  
       while (resultSet.next())
       {
       int sn=resultSet.getInt("Id");
  


    String olq = request.getParameter("q"+sn);
    String newq = request.getParameter("nq"+sn);
    String code = request.getParameter("code"+sn);
    
   if(newq=="")
	   newq="0";
    float oq=Float.parseFloat(olq);
    float nq=Float.parseFloat(newq);
    String newsp=request.getParameter("nsp"+sn);
    float nsp=0;
    if(newsp!= null && newsp!="")
    		nsp=Float.parseFloat(newsp);
    String totalprice=request.getParameter("totalprice");
    String tax=request.getParameter("tax");
    //System.out.println("tax: "+tax);
   // System.out.println("totalprice: "+totalprice);
    String sno = request.getParameter("i");
    int billid=Integer.parseInt(sno);
    //if new quantity> q i.e. more items
    String s3="";
  
    if(nq>oq)
    {

    diffq=nq-oq;


    sq1="UPDATE `NewInventory` SET `Quantity`=`Quantity`- ? WHERE Code=? AND Branch=?";
    sq2="UPDATE `NewInventory` SET `Quantity`=`Quantity`+ ? WHERE Code=? AND Branch=?";
    
   
  //System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code+","+fbranch+","+diffq+") ON DUPLICATE KEY UPDATE Quantity=Quantity-"+diffq);
  //System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code+","+tbranch+","+diffq+") ON DUPLICATE KEY UPDATE Quantity=Quantity+"+diffq);

    }   
    else  if(nq<oq)
    {
    	 diffq=oq-nq;
    	  sq1="UPDATE `NewInventory` SET `Quantity`=`Quantity`+ ? WHERE Code=? AND Branch=?";
    	    sq2="UPDATE `NewInventory` SET `Quantity`=`Quantity`- ? WHERE Code=? AND Branch=?";
   //System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code+","+fbranch+","+diffq+") ON DUPLICATE KEY UPDATE Quantity=Quantity+"+diffq);
   //System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code+","+tbranch+","+diffq+") ON DUPLICATE KEY UPDATE Quantity=Quantity-"+diffq);
   
 
    }    
   
    //diff to subtract from Sale total - Sale=Sale-diff
   
    //bal amt = bal amt- diff
    
     st=conn.createStatement();


    if(nq!=oq)
    {
     //update inventory
     System.out.println(diffq);
     System.out.println(sq1);
     System.out.println(sq2);
    preparedStatement = conn.prepareStatement(sq1);
    preparedStatement.setFloat(1,diffq);
    preparedStatement.setString(2,code);
    preparedStatement.setString(3,fbranch);
    preparedStatement.executeUpdate(); 

    preparedStatement2 = conn.prepareStatement(sq2);
    preparedStatement2.setFloat(1,diffq);
    preparedStatement2.setString(2,code);
    preparedStatement2.setString(3,tbranch);
    preparedStatement2.executeUpdate(); 
     
 /*    preparedStatement = conn.prepareStatement(sq1);

    conn.setAutoCommit(false);

    preparedStatement.setFloat(1,diffq);
    preparedStatement.setString(2,code);
    preparedStatement.setString(3,fbranch);
    preparedStatement.addBatch();

    preparedStatement.setFloat(1,-diffq);
    preparedStatement.setString(2,code);
    preparedStatement.setString(3,tbranch);
    preparedStatement.addBatch();

    int[] cnt = preparedStatement.executeBatch(); */
    
    ps2 = conn.prepareStatement("UPDATE `IBTDetails` SET `Qty`=?,`SalePrice`=?  WHERE Id=?");
    ps2.setFloat(1,nq);
    ps2.setFloat(2,nsp);
    ps2.setInt(3,sn);
    ps2.executeUpdate(); 
     
    }
   
    
  if(nq>oq)
  {
     ps = conn.prepareStatement("UPDATE `IBT` SET `Date`=?,`IBTNo`=?,`TotalQty`=`TotalQty`+?,`TotalPrice`=?,`Tax`=? WHERE Id=?");
       ps.setString(1,date);
       ps.setString(2,ibtno);
       ps.setFloat(3,diffq);
       ps.setString(4,totalprice);
       ps.setString(5,tax);
       ps.setInt(6,Pid);
       ps.executeUpdate();     
      // conn.commit();
  }
  else if(nq<oq)
  {
	     ps = conn.prepareStatement("UPDATE `IBT` SET `Date`=?,`IBTNo`=?,`TotalQty`=`TotalQty`-? ,`TotalPrice`=?,`Tax`=? WHERE Id=?");
	       ps.setString(1,date);
	       ps.setString(2,ibtno);
	       ps.setFloat(3,diffq);
	       ps.setString(4,totalprice);
	       ps.setString(5,tax);
	       ps.setInt(6,Pid);
	       ps.executeUpdate();     
	     //  conn.commit();
	  }
  else
	 {
		 //System.out.println("updating tax: ");	 
		 ps = conn.prepareStatement("UPDATE `IBT` SET `TotalPrice`=?,`Tax`=? WHERE Id=?");
	       ps.setString(1,totalprice);
	       if(tax!="")
	       ps.setString(2,tax);
	       else
	    	   ps.setString(2,"0");
	       ps.setInt(3,Pid); 
	       ps.executeUpdate(); 
	 } 
       }    

      
      /*    if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  */
    	 response.sendRedirect("editibtindividual.jsp?res=1&fbranch="+fbranch+"&dc="+ibtno+"&sd="+date);

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