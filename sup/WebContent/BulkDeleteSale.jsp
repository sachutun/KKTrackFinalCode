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
PreparedStatement ps4 = null;
ResultSet resultSet = null;
ResultSet resultSet2 = null;
Statement st=null;
Statement st2=null;
Statement st3=null;
%>
<%
try{ 
	int i=0;
	  String recordToUpdate = request.getParameter("deleteid");
	    //System.out.println(recordToUpdate); 
	    
	    String branch = request.getParameter("branch");
	    String totRecs=request.getParameter("totRecs");
	    String checkedRecs=request.getParameter("checkedRecs");
	    
	    
	     String dc = request.getParameter("dc"); 
	    String sd = request.getParameter("sd");
	    //System.out.println("sd: "+sd);
	    String ap = request.getParameter("amtpaid");
	    float amountpaid=Float.parseFloat(ap);
	   // System.out.println("amountpaid: "+amountpaid);
	    String comments=request.getParameter("comments");
	    boolean mflag=false;
	    //System.out.println("comments if: "+comments);
	     if(comments.contains("Reference Memo"))
		    {
	    	 		mflag=true;
		    }
	    int delimiter1; 
	    int delimiter2; 
	   
	    String memoNo; 	    
	    String memodate; 

	    int d=Integer.parseInt(recordToUpdate);
String selectedItems = request.getParameter("selectedItems");
String[] selectedItemsArray=selectedItems.split(",");
//String mapData = request.getParameter("mapData");
//System.out.println("--------------&&&&&&&--------------------");
    //System.out.println("selectedItems: " +selectedItems);
    //System.out.println("selectedItemsArray: " +selectedItemsArray);
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
    boolean flag;
    String custId="";
    float bal=0;
    System.out.println("totRecs: " +totRecs); 
    System.out.println("checkedRecs: "+checkedRecs); 
    if(totRecs.equals(checkedRecs))
    { 
   	   flag=true;
    }
   	   else
   	   {   		
     	   flag=false;
   	   }
for(i=0;i<selectedItemsArray.length;i++)
{
	 //System.out.println("Fetching Keys and corresponding [Multiple] Values n");
    Map<Integer, List<String>> map = (HashMap<Integer, List<String>>)session.getAttribute("map");
  //Map<Integer, List<String>> map = (HashMap<Integer, List<String>>)request.getParameter("mapData");
 
    for (Map.Entry<Integer, List<String>> entry : map.entrySet()) {
        int key = entry.getKey();
        //System.out.println("Key = " + key);
        //System.out.println(selectedItemsArray[i]);
        if(Integer.parseInt(selectedItemsArray[i]) ==key)
        {
        List<String> values = entry.getValue();
       // String bv=values.get(9);
      
        //System.out.println("Values = " + values + "n");
        
        ////System.out.println("bv = " + bv);
    
//String recordToUpdate = request.getParameter("deleteid");
 recordToUpdate = values.get(0);
    //System.out.println(recordToUpdate); 
    
   // String branch = request.getParameter("branch");
    branch=values.get(1);
    
    // String dc = request.getParameter("dc"); 
     dc=values.get(2);
    //String sd = request.getParameter("sd");
     sd=values.get(4);
   // String ba = request.getParameter("ba");
String ba=values.get(5);
 custId=values.get(10);
     d=Integer.parseInt(recordToUpdate);
    float bala=Float.parseFloat(ba);
    float ftot=0;
    int code=0;
    int cost=0;
    float qty=0;
    int nq=0;
    int newtotal=0;
    int billid=0;
    String s4="SELECT * FROM BillDetails WHERE DC="+d;
   
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
      //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	    // conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
  
  
       //String bb = request.getParameter("i");
       String bb=values.get(9);
    int sn=Integer.parseInt(bb);
     /*   while (resultSet.next())
       {
       sn=resultSet.getInt("Id");
       } */
   /*  String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno); */

 
    //String cp = request.getParameter("cp"+sn);
    String cp=values.get(7);
 

  //  String q = request.getParameter("q"+sn);
    String q= values.get(3);
    //String bid = request.getParameter("bid"+sn);
    //String cod = request.getParameter("code"+sn);
    //String totp=request.getParameter("tp");
    String bid = values.get(9);
    String cod = values.get(6);
    String totp = values.get(8);
    //System.out.println(q+","+bid+","+cod+","+totp+","+bb);  
     code=Integer.parseInt(cod);
     cost=Integer.parseInt(cp);
     qty=Float.parseFloat(q);
     nq=0;
  
     billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    //totalp is total price of item being deleted
   float totalp=Float.parseFloat(totp);
    bal=Float.parseFloat(ba);
   //System.out.println("custId: " +custId);
 //System.out.println("bal: " +bal);
    //if new quantity> q i.e. more items
    String s3= "";
 
 
    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+"+qty+" WHERE Code="+code+" AND Branch="+branch;
     

    //diff to subtract from Sale total - Sale=Sale-diff

    //bal amt = bal amt- diff

     st=conn.createStatement();

   
 
   String s2="DELETE FROM BillDetails WHERE id ="+billid;


    ps = conn.prepareStatement("DELETE FROM BillDetails WHERE id = ?");
    ps.setInt(1,billid);
    ps.executeUpdate();   
    //System.out.println(s2);
   if(!mflag)
   {
	   //System.out.println(s3);
    		ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`+? WHERE Code= ? AND Branch=?");
    		ps2.setFloat(1,qty);
    		ps2.setInt(2,code);
    		ps2.setString(3,branch);
    		ps2.executeUpdate(); 
   
   }
   float totalprice= cost*qty;
  
   float tax=(float)(cost*qty*0.18);
   totalprice=totalprice+tax;

   String s1= "UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-"+totalprice+",`BalanceAmount`=`BalanceAmount`-"+(totalprice)+" ,`Tax`="+tax+" WHERE Id="+d;
  // System.out.println(s1);
    preparedStatement = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-?,`BalanceAmount`=`BalanceAmount`-?, `Tax`=`Tax`-? WHERE Id=?");
    preparedStatement.setFloat(1,totalprice);
    preparedStatement.setFloat(2,totalprice);
    preparedStatement.setFloat(3,tax);
    preparedStatement.setInt(4,d);
    preparedStatement.executeUpdate(); 
    
    
    st2=conn.createStatement();
    resultSet = st2.executeQuery("SELECT count(*) as c FROM Sale s inner join BillDetails b on s.Id=b.DC where s.Id="+d);
    
    while(resultSet.next())
    {
    	int c=resultSet.getInt("c");
    	
    	if (c==0)
    	{
    		  ps4 = conn.prepareStatement("DELETE FROM Sale WHERE Id = ?");
    		    ps4.setInt(1,d);
    		    ps4.executeUpdate();   
    	}
    } 
    
/*    if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  */
     if(flag==false && custId!=null && custId!="")
     {
		String s="UPDATE `Debtors` SET `OB`=`OB`-"+(totalprice)+" WHERE CustId="+custId;
		//System.out.println("single: " +s);
     	ps1 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`-? WHERE CustId=?");
     	ps1.setFloat(1,totalprice);
     	ps1.setString(2,custId);
     	ps1.executeUpdate();
     
     }
  st3=conn.createStatement();
  //System.out.println("comments if: "+comments);
     if(comments.contains("Reference Memo"))
	    {
	    delimiter1 = comments.indexOf(":");
	    delimiter2 = comments.indexOf(",");
	    //System.out.println("delimiter1: "+delimiter1);
	    //System.out.println("delimiter2: "+delimiter2);
	    delimiter1=delimiter1+2;
	    //System.out.println("delimiter1 +1 : "+delimiter1);
	    memoNo = comments.substring(delimiter1, delimiter2);
	    delimiter2=delimiter2+2;	
	    //System.out.println("delimiter2 +1: "+delimiter2);
	    memodate = comments.substring(delimiter2);
	   // System.out.println("memoNo : "+memoNo);
	    //System.out.println("memodate : "+memodate);
	   // System.out.println("Select * from Sale where Date='" + memodate + "'and Branch='" + branch+ "'and DCNumber='" + memoNo + "'");
	    resultSet2 = st3.executeQuery("Select * from Sale where Date='" + memodate + "'and Branch='" + branch
				+ "'and DCNumber='" + memoNo + "'");
	    if (resultSet2.next()) {

			int memoId = resultSet2.getInt("Id");
			 // System.out.println("UPDATE `BillDetails` SET `Notes`=?  WHERE DCNumber=? and Code=? and DC=?" +": " +memoNo +" , "+ +code +" , " +memoId);
		     ps3 = conn.prepareStatement("UPDATE `BillDetails` SET `Notes`=?  WHERE DCNumber=? and Code=? and DC=?");
		     ps3.setString(1,"");
		     ps3.setString(2,memoNo);
		     ps3.setInt(3,code);
		     ps3.setInt(4,memoId);

		     ps3.executeUpdate();
	    }
	    }
//}
        }
    }
}



	  if(flag==true && custId!=null && custId!="")
	     {
	String s="UPDATE `Debtors` SET `OB`=`OB`-"+(bal+amountpaid)+" WHERE CustId="+custId;
	//System.out.println("all checked: " +s);
	     ps1 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`-? WHERE CustId=?");
	     ps1.setFloat(1,bal+amountpaid);
	     ps1.setString(2,custId);
	     ps1.executeUpdate();
	     
	     }
	  
	 

	 response.sendRedirect("editsalindividual.jsp?res=2&branch="+branch+"&dc="+dc+"&sd="+sd+"&pk="+d);
}catch (Exception e) {
    	 e.printStackTrace();
    	 }
finally {
		session.setAttribute("map","");
	     try {
	       if (st != null)
	        st.close();
	    if (st2 != null)
	        st2.close();
	    if (st3 != null)
	        st3.close();
	    if (preparedStatement != null)
	    	   preparedStatement.close();
	    if (ps != null)
	    	   ps.close();
	    if (ps2 != null)
	    	   ps2.close();
	       
	     if (ps4 != null)
	    	   ps4.close();
	     if (ps3 != null)
	    	   ps3.close();
	       }catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
    %>