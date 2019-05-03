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
PreparedStatement ps1 = null;
PreparedStatement ps2 = null;
PreparedStatement ps3 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
%>
<%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root"); */

    String recordToUpdate = request.getParameter("payid");
    String branch = request.getParameter("branch");
    String dc = request.getParameter("dcn");
    String sd = request.getParameter("sad");
    String ba = request.getParameter("ba");
    String ap = request.getParameter("ap");
    String tp = request.getParameter("tp");
    String rd = request.getParameter("red");
    String custId = request.getParameter("custId"); 
    int d=Integer.parseInt(recordToUpdate);
    float bala=Float.parseFloat(ba);
//     float totalPrice = Float.parseFloat(totPrice);
    float ftot=0;
    float iftot=Float.parseFloat(tp);
    //System.out.println();
    float totalQty=0;
    String s4="SELECT * FROM BillDetails WHERE DC="+d;
    float rtx=0;
    float frtx=0;
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
      //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	  //   conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");
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
    Float cost=Float.parseFloat(cp);
    float qty=Float.parseFloat(q);
    float excess=Float.parseFloat(eq);
   
    int billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    
    //initial total
    float itotalp=cost*qty;
    
    //after return
    qty-=damage+excess;
    totalQty+=qty;
    
    //returned cost
    
    float returncost=cost*(damage+excess);
    
    //return tax amount
    	
    	 rtx=(float)(returncost*0.18);
    frtx+=rtx;
    //new total - total to update in BillDetails
    float totalp=cost*qty;
    
    //diff to subtract from Sale total - Sale=Sale-diff
    float diff=itotalp-totalp;
    //System.out.println("diff: " +diff);
    //System.out.println("qty: " +qty);
    //System.out.println("totalQty: " +totalQty);
    //bal amt = bal amt- diff
    		
    	 bala-=diff;
    	ftot+=diff;
  
  
     st=conn.createStatement();

     if(excess > 0 || damage>0){
      String query="INSERT INTO SaleReturn (DCNumber, Branch, SaleDate, ReturnDate, Code, ExcessQty, DamagedQty) values ('"+ dc+"', '"+branch+"', '"+sd+"','"+rd+"', '"+code+"', '"+excess+"', '"+damage+"')";
      int n=st.executeUpdate(query);  }
   

   
 
  
/*   System.out.println(s1);
  System.out.println(s2);
  
  System.out.println(query); */

  
  String s2="UPDATE `BillDetails` SET `Total`="+totalp+",`Qty`="+qty+" WHERE Id="+billid;
  //System.out.println(s2);
     ps = conn.prepareStatement("UPDATE `BillDetails` SET `Total`=?,`Qty`=? WHERE Id=?");
    ps.setFloat(1,totalp);
    ps.setFloat(2,qty);
    ps.setInt(3,billid);
    ps.executeUpdate();   
    
    if(excess > 0)
    {
    	 String s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+"+excess+" WHERE Code="+code+" AND Branch="+branch;
    	  // System.out.println(s3);
    ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`+? WHERE Code=? AND Branch=?");
    ps2.setFloat(1,excess);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate();
    } 
    if(diff > 0 && custId!=null && custId!="")
    {
   
	String s="UPDATE `Debtors` SET `OB`=`OB`-"+(diff+rtx)+" WHERE CustId="+custId;
	System.out.println(s);
	     ps1 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`-? WHERE CustId=?");
	     ps1.setFloat(1,(diff+rtx));
	     ps1.setString(2,custId);
	     ps1.executeUpdate();
	     
	     
    }
   
   
       } 
      	float finaltot=iftot-ftot-frtx;  
    	bala=finaltot-Float.parseFloat(ap);
     	
       String s1= "UPDATE `Sale` SET `TotalPrice`="+finaltot+",`BalanceAmount`="+bala+" WHERE Id="+d;
       System.out.println(s1);
       preparedStatement = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=?, `Tax`=`Tax`-? WHERE Id=?");
       preparedStatement.setFloat(1,finaltot);
       preparedStatement.setFloat(2,bala);
       preparedStatement.setFloat(3,frtx);
       preparedStatement.setInt(4,d);
       preparedStatement.executeUpdate(); 
  
       //totalPrice-=ftot;
       System.out.println("final : " +finaltot);
   	  System.out.println("bala: " +bala);
       if(totalQty == 0 && custId!=null && custId!="")
       {
      	if(bala>0)
      	{
   			String s="UPDATE `Debtors` SET `OB`=`OB`-"+(bala)+" WHERE CustId="+custId;
   			//System.out.println("subtract rem bal  " +s);
   	     	ps1 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`-? WHERE CustId=?");
   	     	ps1.setFloat(1,bala);
   	     	ps1.setString(2,custId);
   	     	ps1.executeUpdate();
      	}
   	  		String s2= "UPDATE `Sale` SET `TotalPrice`="+0+",`Tax`="+0+" ,`Discount`="+0+" WHERE Id="+d;
      		//System.out.println(s2);
      		ps3 = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`Tax`=?,`Discount`=? WHERE Id=?");
      		ps3.setFloat(1,0);
			ps3.setInt(2,0);
      		ps3.setInt(3,0);
      		ps3.setInt(4,d);
      		ps3.executeUpdate();
      	
   	     
       }
    
    if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?res=1&branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  
    	 response.sendRedirect("addsalereturn.jsp?res=1");
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
	    if (ps1 != null)
	        ps1.close();
	    if (ps2 != null)
	        ps2.close();
	    
	    if (ps3 != null)
	        ps3.close();
	    if (preparedStatement != null)
	    	preparedStatement.close();
	       }  catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>