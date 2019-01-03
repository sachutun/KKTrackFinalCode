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

    String recordToUpdate = request.getParameter("deleteid");
    System.out.println(recordToUpdate); 
    
    String branch = request.getParameter("branch");
    
     String dc = request.getParameter("dc"); 
    String sd = request.getParameter("sd");
    String ba = request.getParameter("ba");

    int d=Integer.parseInt(recordToUpdate);
    double bala=Double.parseDouble(ba);
    double ftot=0;
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
  
       String bb = request.getParameter("i");
    int sn=Integer.parseInt(bb);
     /*   while (resultSet.next())
       {
       sn=resultSet.getInt("Id");
       } */
   /*  String sno = request.getParameter("i");
    int sn=Integer.parseInt(sno); */

 
    String cp = request.getParameter("cp"+sn);
 

    String q = request.getParameter("q"+sn);
    String bid = request.getParameter("bid"+sn);
    String cod = request.getParameter("code"+sn);
    String totp=request.getParameter("tp");
    System.out.println(q+","+bid+","+cod+","+totp+","+bb);  
     code=Integer.parseInt(cod);
     cost=Integer.parseInt(cp);
     qty=Float.parseFloat(q);
     nq=0;
  
     billid=Integer.parseInt(bid);
   /*  String up=Integer.toString(d);  */
    //totalp is total price of item being deleted
   double totalp=Double.parseDouble(totp);
 
    //if new quantity> q i.e. more items
    String s3= "";
 
 
    s3= "UPDATE `NewInventory` SET `Quantity`=`Quantity`+"+qty+" WHERE Code="+code+" AND Branch="+branch;
     

    //diff to subtract from Sale total - Sale=Sale-diff

    //bal amt = bal amt- diff

     st=conn.createStatement();

   
 String s1= "UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-"+cost*qty+",`BalanceAmount`=`BalanceAmount`-"+(cost*qty)+" WHERE Id="+d;
   String s2="DELETE FROM BillDetails WHERE id ="+billid;


    ps = conn.prepareStatement("DELETE FROM BillDetails WHERE id = ?");
    ps.setInt(1,billid);
    ps.executeUpdate();   
    System.out.println(s2);
   
    ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`+? WHERE Code= ? AND Branch=?");
    ps2.setFloat(1,qty);
    ps2.setInt(2,code);
    ps2.setString(3,branch);
    ps2.executeUpdate(); 
    System.out.println(s3);
    
    preparedStatement = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=`TotalPrice`-?,`BalanceAmount`=`BalanceAmount`-? WHERE Id=?");
    preparedStatement.setDouble(1,cost*qty);
    preparedStatement.setDouble(2,cost*qty);
    preparedStatement.setInt(3,d);
    preparedStatement.executeUpdate(); 
    System.out.println(s1);
    
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
     
    	 response.sendRedirect("editsalindividual.jsp?res=2&branch="+branch+"&dc="+dc+"&sd="+sd+"&pk="+d);

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
	       
	     if (ps4 != null)
	    	   ps4.close();
	       }catch (SQLException e) {}
	       try {
	        if (conn != null)
	         conn.close();
	        } catch (SQLException e) {}
	    }
%>