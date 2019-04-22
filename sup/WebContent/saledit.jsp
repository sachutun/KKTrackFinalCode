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
PreparedStatement ps4 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
Statement st3=null;
Statement st4=null;
%>
<%
try{ 
  String[] billIds=request.getParameterValues("billIds");
  
  //System.out.println("saleedit billIds:"+billIds );
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
    String custIdCode=request.getParameter("custIdCode");   
   // String type = request.getParameter("transtype");
    String[] typeArray = request.getParameterValues("transtype");
    String taxtype = request.getParameter("taxtype");
    String existingtype = request.getParameter("existingTranstype");
    String cashAP = request.getParameter("cashAP");
    String neftAP = request.getParameter("neftAP");
    String chequeAP = request.getParameter("chequeAP");
    String swipeAP = request.getParameter("swipeAP");
    String type="";
    if(taxtype==null)
 	   taxtype="";
    if(creditCustId==null)
    	creditCustId="";
    if(cashAP=="" || cashAP==null)
 	   cashAP="0";
    if(neftAP=="" || neftAP==null)
 	   neftAP="0";
    if(chequeAP=="" || chequeAP==null)
 	   chequeAP="0";
    if(swipeAP=="" || swipeAP==null)
 	   swipeAP="0";
    String custId=request.getParameter("custId");
    //System.out.println("type 1: " +type);
    //System.out.println("existingtype 1: " +existingtype);
 /*    String date=new SimpleDateFormat("MM-dd-yyyy").format(request.getParameter("date")) ; */
 
 //System.out.println("creditCustId: " +creditCustId);
		  /*   if(creditCustId!="" && creditCustId!=null )
	       {			  
			   if(!(existingtype.contains("Credit")))
			  		type="Credit";
	       }  */
		 
	       //System.out.println("type changed: " +type);
 creditCustId=custIdCode+creditCustId;
 if(custId!=null && custId!="")
 {
	 //System.out.println("set creditcustID: " +custId);
	 creditCustId=custId;
 }
 if(!(creditCustId.isEmpty()))
 {			  
	  		type="Credit";
 } 
 //System.out.println("type changed: " +type);		
 if(typeArray!=null)
 {
 		for(int j=0;j<typeArray.length;j++)
 		{
	   		if(type=="")
	   		{
	   			type=typeArray[j]; 
	   		}
	   		else
	   		{
		  		type+=","+ typeArray[j];
	   		}
 		} 
 }

/*  if(type.equals("Credit") && !existingtype.contains("Credit"))
 {
	   type=type+existingtype;
	   
 } */
 //System.out.println("type 2: " +type);
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
    String sql1="";
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
    	    s1="UPDATE `Sale` SET `TotalPrice`="+ftot+",`BalanceAmount`="+newBalAmt+",`CustomerName`="+cname+", `CustomerNumber`="+cno+", `AmountPaid`="+ap+", `Date`="+nd+", `Tax`="+tx+", `Discount`="+dis+", `Comments`="+com+" , `GST`="+gst+", `CustID`="+creditCustId+", `Type`="+type+", `TaxType`="+taxtype+", `Cash`="+cashAP+", `Neft`="+neftAP+", `Cheque`="+chequeAP+", `Swipe`="+swipeAP+" WHERE Id="+Pid;
    	       System.out.println(s1);
       	ps = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=?,`CustomerName`=?, `CustomerNumber`=?, `AmountPaid`=?, `Date`=?, `Tax`=?, `Discount`=?, `Comments`=? , `GST`=? , `CustID`=?, `Type`=? , `TaxType`=? , `Cash`=?, `Neft`=?, `Cheque`=?, `Swipe`=?  WHERE Id=?");
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
       ps.setString(12,type); 
       ps.setString(13,taxtype); 
       ps.setString(14,cashAP); 
       ps.setString(15,neftAP); 
       ps.setString(16,chequeAP); 
       ps.setString(17,swipeAP); 
       ps.setInt(18,Pid);
       ps.executeUpdate(); 
       }
       else
       {
    	    s1="UPDATE `Sale` SET `TotalPrice`="+ftot+",`BalanceAmount`="+newBalAmt+",`CustomerName`="+cname+", `CustomerNumber`="+cno+", `AmountPaid`="+ap+", `Date`="+nd+", `Tax`="+tx+", `Discount`="+dis+", `Comments`="+com+" , `GST`="+gst+",`Type`="+type+", `TaxType`="+taxtype+" , `Cash`="+cashAP+", `Neft`="+neftAP+", `Cheque`="+chequeAP+", `Swipe`="+swipeAP+" WHERE Id="+Pid;
 	       //System.out.println(s1);
    	       System.out.println(s1);
    	 	ps = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=?,`CustomerName`=?, `CustomerNumber`=?, `AmountPaid`=?, `Date`=?, `Tax`=?, `Discount`=?, `Comments`=? , `GST`=?, `Type`=? ,`TaxType`=?, `Cash`=?, `Neft`=?, `Cheque`=?, `Swipe`=?  WHERE Id=?");
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
    	       ps.setString(11,type); 
    	       ps.setString(12,taxtype); 
    	       ps.setString(13,cashAP); 
    	       ps.setString(14,neftAP); 
    	       ps.setString(15,chequeAP); 
    	       ps.setString(16,swipeAP); 
    	       ps.setInt(17,Pid);
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
    st4=conn.createStatement();
   	if(type.contains("Neft"))
   	{
   		   String cbankname=request.getParameter("cusbank");
   		   String kkbank=request.getParameter("kkbank");
   		   if(existingtype.contains("Neft"))
   		   {
   		 	   String s6="UPDATE `BankDetails` SET `CSBankName`=?,`KKBankName`=? WHERE Id="  +cbankname +" , " +kkbank +" , "+Pid; 
   	    	   //System.out.println("update neft: " +s6);
   	    	  //System.out.println("existing credit cust: "+s5);
   	       		ps4 = conn.prepareStatement("UPDATE `BankDetails` SET `CSBankName`=?,`KKBankName`=? WHERE Id=?");
   	       		ps4.setString(1,cbankname);
   	       		ps4.setString(2,kkbank);
   	     	    ps4.setInt(3,Pid);
   	       		ps4.executeUpdate(); 
   		   }
   		   else
   		   {
   		   sql1="INSERT INTO BankDetails (Id, Type, CSBankName, KKBankName) VALUES ('"+ Pid+"', 'sale', '"+cbankname+"','"+kkbank+"')";
   		   //System.out.println("---sql1  insert neft---" +sql1);
   		   int z=st4.executeUpdate(sql1);
   		   }
   		  
   	}
   	if(type.contains("Cheque"))
   	{
   		   String bank=request.getParameter("bankname");
   		   String cd=request.getParameter("cd");
   		   String chkno=request.getParameter("chkno");
   		   if(existingtype.contains("Cheque"))
 		   {
   			String s6="UPDATE `ChequeDetails` SET `ChequeNo`=?,`Date`=?,`BankName`=? WHERE Id="  +chkno +" , "+cd +" , " +bank +" , "+Pid; 
	    	   	//System.out.println("update cheque: " +s6);
	    	  			// System.out.println("existing credit cust: "+s5);
	       		ps4 = conn.prepareStatement("UPDATE `ChequeDetails` SET `ChequeNo`=?,`Date`=?,`BankName`=? WHERE Id=?");
	       		ps4.setString(1,chkno);
	       		ps4.setString(2,cd);
	     	    ps4.setString(3,bank);
	     	   ps4.setInt(4,Pid);
	       		ps4.executeUpdate(); 
 		   }
 		   else
 		   {
   		   sql1="INSERT INTO ChequeDetails (Id, Type, ChequeNo, Date, BankName) VALUES('"+ Pid+"', 'sale', '"+chkno+"','"+cd+"', '"+bank+"')";
   		   //System.out.println("---sql1--insert cheque-" +sql1);
   		   int z=st4.executeUpdate(sql1);
 		   }
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
	    if (st3 != null)
	        st3.close();
	    if (st4 != null)
	        st4.close();
	    if (preparedStatement != null)
	    	   preparedStatement.close();
	    if (ps != null)
	    	   ps.close();	    
	    if (ps2 != null)
	    	   ps2.close();
	    if (ps3 != null)
	    	   ps3.close();
	    if (ps4 != null)
	    	   ps4.close();
	    if (ps1 != null)
	    	   ps1.close();
	       }  catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>