<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import= "java.util.Arrays" %>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.io.InputStream" %>
<%
/* String id = request.getParameter("userId"); */

DataSource ds = null;
Connection connection = null;
Statement statement = null;
Statement st = null;
Statement st2 = null;
Statement st3 = null;
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement2 = null;
ResultSet resultSet = null;

          String[] code = request.getParameterValues("code");
        
    String innumber = request.getParameter("dc");
    String date = request.getParameter("sd"); 
  
   String[] costprice = request.getParameterValues("costprice");
   String branch = request.getParameter("branch");
   String[] qty = request.getParameterValues("qty");
   String[] totalprice=request.getParameterValues("totalprice");
   float[] q= new float[qty.length];


   for(int i=0;i<qty.length;i++)
  {
	   q[i]=Float.parseFloat(qty[i]);  
  } 
   
/*    String total=request.getParameter("total"); */
/*    String suppliername = request.getParameter("suppliername");
   String suppliernumber = request.getParameter("suppliernumber");
   String type = request.getParameter("type"); */
 /*   String amountpaid = request.getParameter("amountpaid");
   String balanceamount = request.getParameter("balanceamount"); */
   String sqlb="";
   int updateQuery = 0;

              try {
            	  /* Context context = new InitialContext();
            	  Context envCtx = (Context) context.lookup("java:comp/env");
            	  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
            	  if (ds != null) {
            		  connection = ds.getConnection(); */
            		  
            		  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
            	 	   //  connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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
				
				    connection = DriverManager.getConnection(url, username, password);  
                     // sql query to insert values in the secified table.
     /*    st=connection.createStatement();
       statement=connection.createStatement();       
       
       int x=st.executeUpdate("INSERT INTO Purchases (InvoiceNumber, Branch, Date, TotalPrice, SupplierName, SupplierNumber, PaymentMode, AmountPaid, BalanceAmount) values ('"+ innumber+"', '"+branch+"', '"+date+"','"+total+"', '"+suppliername+"', '"+suppliernumber+"', '"+type+"', '"+amountpaid+"', '"+balanceamount+"')");
       
    /*    String sql="Select Max(Id) from Purchases";
       resultSet = statement.executeQuery(sql);
     
       resultSet.next(); */ 
       
       String id= request.getParameter("pid");
       
        st2=connection.createStatement();
        st3=connection.createStatement();

int count=code.length;
String qparts="";
String sq="";
int ft=0;
for(int i=0;i<count;i++)
{
qparts+=" ('"+innumber+"',"+code[i]+","+q[i]+","+costprice[i]+","+totalprice[i]+","+id+")";
/* INSERT IGNORE INTO NewInventory (Code, Branch, Quantity) VALUES ('1', 'Bowenpally', 2) */
/*  sq="Update NewInventory SET Quantity=Quantity+? WHERE Code=?and Branch=?";	 */
sq="INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity+?";

preparedStatement = connection.prepareStatement(sq);
preparedStatement.setString(1,code[i] );
preparedStatement.setString(2,branch);
preparedStatement.setFloat(3,q[i]);
preparedStatement.setFloat(4,q[i]);
preparedStatement.executeUpdate(); 
ft+=Double.parseDouble(totalprice[i]);
if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO InvoiceDetails (`InvoiceNo`, `Code`, `Qty`, `Price`, `TotalPrice`, `Ino`) VALUES"+ qparts;

int y=st2.executeUpdate(isql);

String s="UPDATE `Purchases` SET `TotalPrice`=`TotalPrice`+?,`BalanceAmount`=TotalPrice-AmountPaid WHERE Id=?"; 
/* String s="UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+"+ft+",`BalanceAmount`=TotalPrice-AmountPaid WHERE Id="+id; */
/* System.out.println(s); */
preparedStatement2 = connection.prepareStatement(s);
preparedStatement2.setDouble(1,ft);
preparedStatement2.setString(2,id);
preparedStatement2.executeUpdate();  
 
       response.sendRedirect("editpurindividual.jsp?res=1&branch="+branch+"&dc="+innumber+"&sd="+date);
      /*  out.println("Inserted successfully in database."); */
  //   } 
              }
     catch (Exception ex) {
     out.println("Unable to connect to database.");
     System.out.println(ex);

        }
              finally {
           	     try {
           	       if (st != null)
           	        st.close();
           	    if (statement != null)
           	        statement.close();
           	    if (st2 != null)
           	        st2.close();
           	 if (st3 != null)
        	        st3.close();
           	 if (preparedStatement != null)
           		preparedStatement.close();
           	       }  catch (SQLException e) {}
           	       try {
           	        if (connection != null)
           	        	connection.close();
           	        } catch (SQLException e) {}
           	    }

%>