<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@page import="java.util.Date"%>
<%@ page import= "java.text.SimpleDateFormat" %>
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
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
PreparedStatement ps3 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
Statement st3=null;
%>
<%
try{ 

    String recordToUpdate = request.getParameter("payid");
    String i = request.getParameter("i");

    String branch = request.getParameter("branch");
    String ba = request.getParameter("ba");
    String dc = request.getParameter("dcno");
    String cname = request.getParameter("cusnam");
    String cno = request.getParameter("cusno");
    String com = request.getParameter("com");
    String gst = request.getParameter("GST");
    String creditCustId=request.getParameter("creditCustId");
    String CrediCustStatus=request.getParameter("CrediCustStatus");

    String custId=request.getParameter("custId");
 /*    String date=new SimpleDateFormat("MM-dd-yyyy").format(request.getParameter("date")) ; */
 if(custId!=null && custId!="")
	 creditCustId=custId;
 String date=request.getParameter("date") ;

 SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy"); 
 Date startDate;

     startDate = df.parse(date);
     String dt = df.format(startDate);
Date ndate=df.parse(dt);
  String nd=new SimpleDateFormat("yyyy-MM-dd").format(ndate);
    String amp=request.getParameter("ap");
    String tx=request.getParameter("tax");
    String dis=request.getParameter("dis");
    String s1="";
    int Pid=Integer.parseInt(recordToUpdate);
    double oldBal=Double.parseDouble(ba);
    int tax=Integer.parseInt(tx);
    int disc=Integer.parseInt(dis);
    int code=0;
    double newcp=0; 
    double oldcp=0;
    float oq=0;
    float nq=0;
    double ap=0;
    int billid=0;
    double ftot=0;
    double newOB=0;
 
    String s4="SELECT * FROM BillDetails WHERE DC="+Pid;
   
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
     // Class.forName("com.mysql.jdbc.Driver").newInstance();  
	   //  conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
  
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
       double newBalAmt=0;
       while (resultSet.next())
       {
       int sn=resultSet.getInt("Id");
  

    String newq = request.getParameter("nq"+sn);
    String ncp = request.getParameter("cp"+sn);
    String ocp = request.getParameter("ocp"+sn);
    String oldq = request.getParameter("q"+sn);
    
    String bid = request.getParameter("bid"+sn);
    String cod = request.getParameter("code"+sn);
    String oldftp=request.getParameter("tp");


    float diffq=0;
     code=Integer.parseInt(cod);
     newcp=Double.parseDouble(ncp);
     oldcp=Double.parseDouble(ocp);
     oq=Float.parseFloat(oldq);
     nq=Float.parseFloat(newq);
     ap=Double.parseDouble(amp);
     double oldftotalp=Double.parseDouble(oldftp);
     double newtotalp=0;
   
     //oldbalamt=oldftotalp-ap
    		 
    		 //OB+=newbalamt-oldbalamt
    		 
    		 /*
    		 OB=1000
    		 old bal= 100
    		 new bal=190
    		 new-old= 90
    		 ob=1000+90.
    		 
    		 old bal= 100
    		 new bal=80
    		 new-old= -20
    		 ob=1000-20
    		 */
     
     billid=Integer.parseInt(bid);

     
     newtotalp=newcp*nq;
     ftot+=newtotalp;

    String s3="";
    if(nq>oq)
    {

    diffq=nq-oq;

    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`- ? WHERE Code=? AND Branch=?";
   
    }   
    else  if(nq<oq)
    {

    diffq=oq-nq;
  
    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+ ? WHERE Code=? AND Branch=?";
    }  
   
     st=conn.createStatement();

     

 String s2="UPDATE `BillDetails` SET `Total`="+newtotalp+",`Qty`="+nq+", `CostPrice`="+newcp+"  WHERE Id="+billid; 
//System.out.println(s2);

    preparedStatement = conn.prepareStatement("UPDATE `BillDetails` SET `Total`=?,`Qty`=?, `CostPrice`=?  WHERE Id=?");
    preparedStatement.setDouble(1,newtotalp);
    preparedStatement.setFloat(2,nq);
    preparedStatement.setDouble(3,newcp);
    preparedStatement.setInt(4,billid);
    preparedStatement.executeUpdate();  
  

    if(nq!=oq)
    {
    ps2 = conn.prepareStatement(s3);
    ps2.setFloat(1,diffq);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate();   
     

    }
   
    
  
       } 
       ftot+=tax;
       ftot-=disc;
       newBalAmt=ftot-ap;
 
   	   newOB=newBalAmt-oldBal;
   	//System.out.println("newBalAmt: " +newBalAmt);
	//System.out.println("newOB: " +newOB);
   
       if(creditCustId!="" && creditCustId!=null)
       {
    	    s1="UPDATE `Sale` SET `TotalPrice`="+ftot+",`BalanceAmount`="+newBalAmt+",`CustomerName`="+cname+", `CustomerNumber`="+cno+", `AmountPaid`="+ap+", `Date`="+nd+", `Tax`="+tx+", `Discount`="+dis+", `Comments`="+com+" , `GST`="+gst+", `CustID`="+creditCustId+", `Type`=Credit WHERE Id="+Pid;
    	      // System.out.println(s1);
       	ps = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=?,`CustomerName`=?, `CustomerNumber`=?, `AmountPaid`=?, `Date`=?, `Tax`=?, `Discount`=?, `Comments`=? , `GST`=? , `CustID`=?, `Type`=?  WHERE Id=?");
       ps.setDouble(1,ftot);
       ps.setDouble(2,newBalAmt);
       ps.setString(3,cname);
       ps.setString(4,cno);
       ps.setDouble(5,ap);
       ps.setString(6,nd);
       ps.setString(7,tx);
       ps.setString(8,dis);
       ps.setString(9,com);
       ps.setString(10,gst);
       ps.setString(11,creditCustId);    
       ps.setString(12,"Credit"); 
       ps.setInt(13,Pid);
       ps.executeUpdate(); 
       }
       else
       {
    	    s1="UPDATE `Sale` SET `TotalPrice`="+ftot+",`BalanceAmount`="+newBalAmt+",`CustomerName`="+cname+", `CustomerNumber`="+cno+", `AmountPaid`="+ap+", `Date`="+nd+", `Tax`="+tx+", `Discount`="+dis+", `Comments`="+com+" , `GST`="+gst+" WHERE Id="+Pid;
    	      // System.out.println(s1);
    	 	ps = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=?,`CustomerName`=?, `CustomerNumber`=?, `AmountPaid`=?, `Date`=?, `Tax`=?, `Discount`=?, `Comments`=? , `GST`=? WHERE Id=?");
    	       ps.setDouble(1,ftot);
    	       ps.setDouble(2,newBalAmt);
    	       ps.setString(3,cname);
    	       ps.setString(4,cno);
    	       ps.setDouble(5,ap);
    	       ps.setString(6,nd);
    	       ps.setString(7,tx);
    	       ps.setString(8,dis);
    	       ps.setString(9,com);
    	       ps.setString(10,gst);    
    	       ps.setInt(11,Pid);
    	       ps.executeUpdate();
       }
       if(custId!=null && custId!="")
       {
    	   String s5="UPDATE `Debtors` SET `OB`=`OB`+" +newOB+" WHERE CustId="+custId; 
    	   //System.out.println(s5);
    	  // System.out.println("existing credit cust: "+s5);
       ps1 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`+? WHERE CustId=?");
       ps1.setDouble(1,newOB);
       ps1.setString(2,custId);
       ps1.executeUpdate(); 
       }
    		//System.out.println("CrediCustStatus: " +CrediCustStatus);
    	   	if(CrediCustStatus.equals("update"))
    	   	{
    	   String s5="UPDATE `Debtors` SET `OB`=`OB`+" +newBalAmt+" WHERE CustId="+creditCustId; 
    	  // System.out.println("update s5: "+s5);
       ps3 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`+? WHERE CustId=?");
       ps3.setDouble(1,newBalAmt);
       ps3.setString(2,creditCustId);
       ps3.executeUpdate();
       
   	}
   	if(CrediCustStatus.equals("insert"))
   	{
   		if(cno==null)
   			cno="";
   		String aadhaar="";
   		 String sqlc="INSERT INTO Debtors (CustID, CustomerName, Mobile, OB, Branch, GST, Aadhaar) VALUES('"+ creditCustId+"', '"+ cname+"', '"+cno+"','"+newBalAmt+"', '"+branch+"', '"+gst+"', '"+aadhaar+"')";
   		// System.out.println("add sqlc: " +sqlc); 
   		      st3=conn.createStatement();
   		 int z=st3.executeUpdate(sqlc);
   	}
       
    	 response.sendRedirect("editsalindividual.jsp?res=1&branch="+branch+"&dc="+dc+"&sd="+nd+"&pk="+Pid);

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
	    if (ps3 != null)
	    	   ps3.close();
	    if (ps1 != null)
	    	   ps1.close();
	       }  catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>