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
PreparedStatement ps4 = null;
ResultSet resultSet = null;
Statement st=null;
Statement st2=null;
%>
<%
try{ 
	  //System.out.println("------------------------------------");
	int i=0;
    String recordToUpdate = request.getParameter("deleteid");
    //System.out.println(recordToUpdate); 
    
    String branch = request.getParameter("branch");
    
     String dc = request.getParameter("dc"); 
     
    String sd = request.getParameter("sd");
    String selectedItems = request.getParameter("selectedItems");
   //String selectedItems = session.getAttribute("selectedItems").toString();
   
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
        for(i=0;i<selectedItemsArray.length;i++)
        {
        	 //System.out.println("Fetching Keys and corresponding [Multiple] Values n");
            Map<Integer, List<String>> map = (HashMap<Integer, List<String>>)session.getAttribute("map");
        
            for (Map.Entry<Integer, List<String>> entry : map.entrySet()) {
                int key = entry.getKey();
                //System.out.println("Key = " + key);
                //System.out.println(selectedItemsArray[i]);
                if(Integer.parseInt(selectedItemsArray[i]) ==key)
                {
                List<String> values = entry.getValue();
              
              
                //System.out.println("Values = " + values + "n");
                
    //String ba = request.getParameter("ba");
    String ba=values.get(2);

    int d=Integer.parseInt(recordToUpdate);
    float bala=Float.parseFloat(ba);
    float ftot=0;
    int code=0;
    int cost=0;
    float qty=0;
    int nq=0;
    int newtotal=0;
    int billid=0;
    String s4="SELECT * FROM InvoiceDetails WHERE INo="+d;
    //System.out.println(s4);
   
    /* Context context = new InitialContext();
    Context envCtx = (Context) context.lookup("java:comp/env");
    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
    if (ds != null) {
      conn = ds.getConnection(); */
      
      //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	  //   conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
  
  
      // String bb = request.getParameter("i");
       String bb =values.get(8);
    int sn=Integer.parseInt(bb);
     /*   while (resultSet.next())
       {
       sn=resultSet.getInt("Id");
       } */
   /*  String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno); */

 
    //String cp = request.getParameter("cp"+sn);
    String cp=values.get(5);
 
    sd=values.get(10);
    //String q = request.getParameter("q"+sn);
    String q=values.get(4);
   // String bid = request.getParameter("bid"+sn);
    String bid=values.get(6);
    //String cod = request.getParameter("code"+sn);
    String cod=values.get(3);
   // String totp=request.getParameter("tp");
    String totp=values.get(7);
   
     code=Integer.parseInt(cod);
     cost=Integer.parseInt(cp);
     qty=Float.parseFloat(q);
     nq=0;
  
     billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    //totalp is total price of item being deleted
   float totalp=Float.parseFloat(totp);
 
    //if new quantity> q i.e. more items
    String s3= "";
 
 
    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`-"+qty+" WHERE Code="+code+" AND Branch="+branch;
     

    //diff to subtract from Sale total - Sale=Sale-diff

    //bal amt = bal amt- diff

     st=conn.createStatement();

   
 String s1= "UPDATE `Purchases` SET `TotalPrice`=`TotalPrice`-"+cost*qty+",`BalanceAmount`=`BalanceAmount`-"+(cost*qty)+" WHERE Id="+d;
   String s2="DELETE FROM InvoiceDetails WHERE id ="+billid;
  

    ps = conn.prepareStatement("DELETE FROM InvoiceDetails WHERE id = ?");
    ps.setInt(1,billid);
    ps.executeUpdate();   
    //System.out.println(s2);
   
    ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`-? WHERE Code= ? AND Branch=?");
    ps2.setFloat(1,qty);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate(); 
    //System.out.println(s3);
    
    preparedStatement = conn.prepareStatement("UPDATE `Purchases` SET `TotalPrice`=`TotalPrice`-?,`BalanceAmount`=`BalanceAmount`-? WHERE Id=?");
    preparedStatement.setFloat(1,cost*qty);
    preparedStatement.setFloat(2,cost*qty);
    preparedStatement.setInt(3,d);
    preparedStatement.executeUpdate(); 
    //System.out.println(s1);
    
    st2=conn.createStatement();
   resultSet = st2.executeQuery("SELECT count(*) as c FROM Purchases s inner join InvoiceDetails b on s.Id=b.INo where s.Id="+d);
   //System.out.println("SELECT count(*) as c FROM Purchases s inner join InvoiceDetails b on s.Id=b.INo where s.Id="+d);
   
    while(resultSet.next())
    {
    	int c=resultSet.getInt("c");
    	
    	if (c==0)
    	{
    		  ps4 = conn.prepareStatement("DELETE FROM Purchases WHERE Id = ?");
    		    ps4.setInt(1,d);
    		    ps4.executeUpdate();  
    		    //System.out.println("DELETE FROM Purchases WHERE Id = " +d);
    	}
    } 
    }
                }
            }
    
/*    if(branch!=null && branch.length()!=0)
     response.sendRedirect("addsalereturn.jsp?branch="+branch+"&dc="+dc+"&sd="+sd); // redirect to JSP one, which will again reload.
     else  */
     //System.out.println("editpurindividual.jsp?res=2&branch="+branch+"&dc="+dc+"&sd="+sd);
    	 response.sendRedirect("editpurindividual.jsp?res=2&branch="+branch+"&dc="+dc+"&sd="+sd);

//}
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