<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import= "java.util.Arrays" %>
<%@page import="java.util.Date"%>
<%@ page import= "java.text.SimpleDateFormat" %>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.io.*" %>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
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
    String branch = request.getParameter("branch");
    String ba = request.getParameter("ba");
    String dc = request.getParameter("dc");
    String tx = request.getParameter("tax");
    String date=request.getParameter("date");
    String sname = request.getParameter("supnam");
    String sno = request.getParameter("supno");
    String s1="";
    int Pid=Integer.parseInt(recordToUpdate);
    int tax=Integer.parseInt(tx);
    double bala=Double.parseDouble(ba);
    int code=0;
    double newcp=0; 
    double oldcp=0;
    int oq=0;
    int nq=0;
    double ap=0;
    int billid=0;
    double ftot=0;
    String s4="SELECT * FROM InvoiceDetails WHERE INo="+Pid;
    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy"); 
    Date startDate;

        startDate = df.parse(date);
        String dt = df.format(startDate);
   Date ndate=df.parse(dt);
     String nd=new SimpleDateFormat("yyyy-MM-dd").format(ndate);
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
      Class.forName("com.mysql.jdbc.Driver").newInstance();  
	     conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
  
      st2=conn.createStatement();
       resultSet = st2.executeQuery(s4);
       
       while (resultSet.next())
       {
       int sn=resultSet.getInt("Id");
  
   /*  String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno); */

   
    String newq = request.getParameter("nq"+sn);
    String ncp = request.getParameter("cp"+sn);
    String ocp = request.getParameter("ocp"+sn);
    String oldq = request.getParameter("q"+sn);
   
    String bid = request.getParameter("bid"+sn);
    String cod = request.getParameter("code"+sn);
    String oldftp=request.getParameter("tp");
    String amtpaid=request.getParameter("ap");
   /*  System.out.println(newq+","+ncp+","+ocp+","+oldq+","+bid+","+cod+","+oldftp);   */
    int diffq=0;
     code=Integer.parseInt(cod);
     newcp=Double.parseDouble(ncp);
     oldcp=Double.parseDouble(ocp);
     oq=Integer.parseInt(oldq);
     nq=Integer.parseInt(newq);
     ap=Double.parseDouble(amtpaid);
     double oldftotalp=Double.parseDouble(oldftp);
     double newtotalp=0;
     
     billid=Integer.parseInt(bid);

     
     newtotalp=newcp*nq;
     ftot+=newtotalp;
    //if new quantity> q i.e. more items
    String s3="";
    if(nq>oq)
    {

    diffq=nq-oq;

    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+ ? WHERE Code=? AND Branch=?";
   
    }   
    else  if(nq<oq)
    {

    diffq=oq-nq;
  
    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`- ? WHERE Code=? AND Branch=?";
    }    
   
    //diff to subtract from Sale total - Sale=Sale-diff
   
    //bal amt = bal amt- diff
    
     st=conn.createStatement();

 /*     System.out.println(newtotalp+","+ftot); */
 

  ftot+=tax;
  s1= "UPDATE `Purchases` SET `TotalPrice`="+ftot+",`BalanceAmount`="+(ftot-ap)+" WHERE Id="+Pid;
 String s2="UPDATE `InvoiceDetails` SET `TotalPrice`="+newtotalp+",`Qty`="+nq+", `Price`="+newcp+"  WHERE Id="+billid;
  
    preparedStatement = conn.prepareStatement("UPDATE `InvoiceDetails` SET `TotalPrice`=?,`Qty`=?, `Price`=?  WHERE Id=?");
    preparedStatement.setDouble(1,newtotalp);
    preparedStatement.setDouble(2,nq);
    preparedStatement.setDouble(3,newcp);
    preparedStatement.setInt(4,billid);
    preparedStatement.executeUpdate();  
   
    double minp=(newcp+(10*newcp)/100);

    String s="UPDATE `CodeList` SET `LC`=?, `minprice`=? WHERE Code=?"; 
    /* String s="UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+"+ft+",`BalanceAmount`=TotalPrice-AmountPaid WHERE Id="+id; */
    /* System.out.println(s); */
    preparedStatement2 = conn.prepareStatement(s);
    preparedStatement2.setDouble(1,newcp);
    preparedStatement2.setDouble(2,minp);
    preparedStatement2.setInt(3,code);
    preparedStatement2.executeUpdate();  
    
    if(nq!=oq)
    {
    ps2 = conn.prepareStatement(s3);
    ps2.setInt(1,diffq);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate();  
     
   
    }
   
    
  
       } 
      
      /*  System.out.println(tax); */
       ps = conn.prepareStatement("UPDATE `Purchases` SET `TotalPrice`=?,`BalanceAmount`=?, `SupplierName`=?, `SupplierNumber`=?, `AmountPaid`=?, `Date`=?, `Tax`=? WHERE Id=?");
       ps.setDouble(1,ftot);
       ps.setDouble(2,ftot-ap);
       ps.setString(3,sname);
       ps.setString(4,sno);
       ps.setDouble(5,ap);
       ps.setString(6,nd);
       ps.setDouble(7,tax);
       ps.setInt(8,Pid);
       ps.executeUpdate();    
       
/*    if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  */
    	 response.sendRedirect("editpurindividual.jsp?res=1&branch="+branch+"&dc="+dc+"&sd="+nd);

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