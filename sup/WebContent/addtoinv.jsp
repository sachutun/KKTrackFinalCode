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
PreparedStatement ps4 = null;
ResultSet resultSet = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
Statement st=null;
Statement st2=null;
Statement st3=null;
int exists=0;
int Id;
%>
<%
try{ 
	int i=0;
	
	    String recordToUpdate = request.getParameter("deleteid");
	  //  System.out.println(recordToUpdate); 
	    
	    String branch = request.getParameter("branch");
	    String totRecs=request.getParameter("totRecs");
	    String checkedRecs=request.getParameter("checkedRecs");
	    
	  
	    String dc = request.getParameter("dc"); 
	    String sd = request.getParameter("sd");
        String cname=request.getParameter("cusnam");
      //  System.out.println(cname);  
        String cno=request.getParameter("cusno");
        
      //System.out.println(cno);  
      
        String GST=request.getParameter("GST");
        String type="";
        String qparts="";
        String creditcustId="";
        
    //  System.out.println(GST+type); 
        
	    int d=Integer.parseInt(recordToUpdate);
	    
	    
        String selectedItems = request.getParameter("selectedItems");
        String[] selectedItemsArray=selectedItems.split(",");

        String cp = request.getParameter("cp");
        String[] cpArray=cp.split(",");

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
    //String custId="";
    float bal=0;
    float ftot=0;
    float tax=0;
    if(totRecs.equals(checkedRecs))
    { 
   	   flag=true;
    }
   	   else
   	   {   		
     	   flag=false;
   	   }
       
    
    //ndc is new dc
    String ndc = request.getParameter("invno"); 
    String invdt = request.getParameter("invdt"); 
    
    //System.out.println(invdt);
    
    SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy"); 
    Date startDate;

        startDate = df.parse(invdt);
        String dt = df.format(startDate);
   Date ndate=df.parse(dt);
     String nd=new SimpleDateFormat("yyyy-MM-dd").format(ndate);
    //nd is new date 
    
     st=conn.createStatement();
     st2=conn.createStatement();
   
    // Insert update in Sale with new inv number and inv dt
      
    //System.out.println("Select * from Sale where Date='"+nd+"'and Branch='"+branch+"'and DCNumber='"+ndc+"'");
     
    rs1=st.executeQuery("Select * from Sale where Date='"+nd+"'and Branch='"+branch+"'and DCNumber='"+ndc+"'");

     if(rs1.next())
{
    	 
   // 	 System.out.println("Hi");
    		//sale already exists so retrieve the Id and add to billdetails with DC=Id
    	    	exists=1;
    		 Id=rs1.getInt("Id");
    		 creditcustId=rs1.getString("CustID");
}
else 
{
	exists=0;
	//insert new sale
	
	//System.out.println("INSERT INTO Sale (DCNumber, Branch, Date, TotalPrice, CustomerName, CustomerNumber, Type, AmountPaid, BalanceAmount, Tax, Discount, GST) values ('"+ ndc+"', 'Workshop', '"+nd+"','0', '"+cname+"', '"+cno+"', '"+type+"', '0', '0', '0', '0','"+GST+"')");
	int x=st2.executeUpdate("INSERT INTO Sale (DCNumber, Branch, Date, TotalPrice, CustomerName, CustomerNumber, Type, AmountPaid, BalanceAmount, Tax, Discount, GST) values ('"+ ndc+"', 'Workshop', '"+nd+"','0', '"+cname+"', '"+cno+"', '"+type+"', '0', '0', '0', '0','"+GST+"')");
    
    String sql="Select Max(Id) from Sale";
    resultSet = st2.executeQuery(sql);
  
    resultSet.next();
    Id=resultSet.getInt("Max(Id)");

}
     
     st3=conn.createStatement(); 
     rs2=st3.executeQuery("Select * from CodeList");
     
     Map<Integer,String> codeList = new HashMap<Integer,String>();

     // parsing the column each time is a linear search
     int column1Pos = rs2.findColumn("Code");
     int column2Pos = rs2.findColumn("MinPrice");
     int column3Pos = rs2.findColumn("LC");
     while (rs2.next()) {
         int codeKey = rs2.getInt(column1Pos);
         String mp = rs2.getString(column2Pos);
         String lc = rs2.getString(column3Pos);
         String mplcValue=mp+","+lc;
         codeList.put(codeKey, mplcValue);
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

     recordToUpdate = values.get(0);

     branch=values.get(1);
   
     dc=values.get(2);

     sd=values.get(4);

     //String ba=values.get(5);
     //custId=values.get(10);
     type=values.get(11);

     d=Integer.parseInt(recordToUpdate);
     
  // float bala=Float.parseFloat(ba);
  
   
    int code=0;
    int cost=0;
    float qty=0;
   // int nq=0;
    int newtotal=0;
    int billid=0;
    String mapValue="";
    //memo
       String s4="SELECT * FROM BillDetails WHERE DC="+d;

       String bb=values.get(9);
  
  //  String cp=values.get(7);
 
    String fcp=cpArray[i];
  //  System.out.println(fcp);
    String q= values.get(3);

    String bid = values.get(9);
    String cod = values.get(6);

    
    code=Integer.parseInt(cod);
    cost=Integer.parseInt(fcp);
    qty=Float.parseFloat(q);
   //  nq=0;
  
    billid=Integer.parseInt(bid);

    float totp=cost*qty;
    
 
   // System.out.println(q+","+bid+","+cod+","+fcp+","+ndc+","+nd);  
 
    // String s3= "";

    // Calculate total price of all selected items 

    ftot+=totp;
    tax=(float)(0.18*ftot);
  
    //System.out.println("total price: " +ftot);
    //System.out.println("tax: " +tax);
    
	mapValue=codeList.get(code);
	String[] mplcValues = mapValue.split(",");
//	mplcValues[0] is minPrice  and mplcValues[1] is LC

   //Add billdetails depending on whther the sale exists or not

    qparts+=" ('"+ndc+"',"+code+","+qty+","+cost+","+totp+","+Id+","+mplcValues[0]+","+mplcValues[1]+")";

    System.out.println("qparts: " +qparts);

// insert each item into BillDetails along with the new invno and invdt in notes column

//delete from memo bill details

 /*   ps = conn.prepareStatement("DELETE FROM BillDetails WHERE id = ?");
    ps.setInt(1,billid);
    ps.executeUpdate();   
    //System.out.println(s2);

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
 */

//}
        
//update notes in memo for selected item

ps2 = conn.prepareStatement( "UPDATE `BillDetails` SET `Notes`=?,`Total`=?,`Qty`=?, `CostPrice`=?  WHERE Id=?");
ps2.setString(1,"Added to Invoice "+ndc+ ", "+nd);
ps2.setFloat(2, totp);
ps2.setFloat(3,qty);
ps2.setFloat(4,cost);
ps2.setString(5,bid);
ps2.executeUpdate(); 

 

        }
    }
    String isql= "INSERT INTO BillDetails (`DCNumber`, `Code`, `Qty`, `CostPrice`, `Total`, `DC`,`MinPrice`, `LC`) VALUES"+ qparts;
    //System.out.println("Bill Details: "+isql);
    int y=st2.executeUpdate(isql);
    
qparts="";
}


//update sale bal amt, ftot, custId, type
float totalprice=ftot+tax;
 	ps = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+ ?,`BalanceAmount`=`BalanceAmount` + ?,`Comments`=? , `Type`=?, `Tax`=`Tax`+?  WHERE Id=?");
     ps.setFloat(1,totalprice);
     ps.setFloat(2,totalprice);
     ps.setString(3,"Reference Memo: "+dc+", "+sd);
     //ps.setString(4,custId);
     ps.setString(4,type);
     ps.setFloat(5,tax);
     ps.setInt(6,Id);
     ps.executeUpdate(); 
   
     //System.out.println("creditcustId: " +creditcustId);
     if(creditcustId!=null && creditcustId!="")
     {
String s="UPDATE `Debtors` SET `OB`=`OB`+"+(totalprice)+" WHERE CustId="+creditcustId;
//System.out.println("single: " +s);
     ps4 = conn.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`+? WHERE CustId=?");
     ps4.setFloat(1,totalprice);
     ps4.setString(2,creditcustId);
     ps4.executeUpdate();
     
     }
     

	 response.sendRedirect("editsalindividual.jsp?res=5&branch="+branch+"&dc="+dc+"&sd="+sd+"&pk="+d);
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
	       }catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
    %>