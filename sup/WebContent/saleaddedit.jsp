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

Connection connection = null;
Statement statement = null;
Statement st = null;
Statement st2 = null;
Statement st3 = null;
Statement st4 = null;
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement2 = null;
ResultSet resultSet = null;
ResultSet rs = null;

          String[] code = request.getParameterValues("code");
        
    String dcnumber = request.getParameter("dc");
    String date = request.getParameter("sd");
   
  
   String[] costprice = request.getParameterValues("costprice");
   String branch = request.getParameter("branch");
   String[] qty = request.getParameterValues("qty");
   String[] totalprice=request.getParameterValues("totalprice");
/*    System.out.println(code[0]+dcnumber+costprice[0]+branch+qty[0]+totalprice[0]); */
/*    String total=request.getParameter("total"); */
/*    String customername = request.getParameter("customername");
   String customernumber = request.getParameter("customernumber"); */
/*    String type = request.getParameter("type"); */
 
/*    String balanceamount = request.getParameter("balanceamount"); */
   String sqlb="";

   
   DataSource ds = null;
   int updateQuery = 0;

              try {
       
            	  /* Context context = new InitialContext();
            	  Context envCtx = (Context) context.lookup("java:comp/env");
            	  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
            	  if (ds != null) {
            	    connection = ds.getConnection(); */
            	    
            	    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
            	     //connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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

       
       int id= Integer.parseInt(request.getParameter("sid"));
       
        st2=connection.createStatement();
    /*     st3=connection.createStatement(); */

int count=code.length;
String qparts="";
String sq="";
int ft=0;
for(int i=0;i<count;i++)
{
qparts+=" ('"+dcnumber+"',"+code[i]+","+qty[i]+","+costprice[i]+","+totalprice[i]+","+id+")";
 sq="Update NewInventory SET Quantity=Quantity-? WHERE Code=?and Branch=?";	
/* System.out.println("Update NewInventory SET Quantity=Quantity-"+qty[i]+" WHERE Code="+code[i]+"and Branch="+branch); */
 preparedStatement = connection.prepareStatement(sq);
preparedStatement.setString(1,qty[i]);
preparedStatement.setString(2,code[i]);
preparedStatement.setString(3,branch);
preparedStatement.executeUpdate();  
ft+=Double.parseDouble(totalprice[i]);
if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO BillDetails (`DCNumber`, `Code`, `Qty`, `CostPrice`, `Total`, `DC`) VALUES"+ qparts;
/* System.out.println(isql); */
 int y=st2.executeUpdate(isql); 

 String s="UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+?,`BalanceAmount`=TotalPrice-AmountPaid WHERE Id=?"; 
/* String s="UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+"+ft+",`BalanceAmount`=TotalPrice-AmountPaid WHERE Id="+id; */
/* System.out.println(s); */
 preparedStatement2 = connection.prepareStatement(s);
preparedStatement2.setDouble(1,ft);
preparedStatement2.setInt(2,id);
preparedStatement2.executeUpdate();  

/* if(type.equals("Neft"))
{
	   String cbankname=request.getParameter("cusbank");
	   String kkbank=request.getParameter("kkbank");
	   sqlb="INSERT INTO BankDetails (Id, Type, CSBankName, KKBankName) VALUES ('"+ id+"', 'sale', '"+cbankname+"','"+kkbank+"')";
	   int z=st3.executeUpdate(sqlb);
	  
}
else if(type.equals("Cheque"))
{
	   String bank=request.getParameter("bankname");
	   String cd=request.getParameter("cd");
	   String chkno=request.getParameter("chkno");
	   sqlb="INSERT INTO ChequeDetails (Id, Type, ChequeNo, Date, BankName) VALUES('"+ id+"', 'sale', '"+chkno+"','"+cd+"', '"+bank+"')";
	   int z=st3.executeUpdate(sqlb);
} */


       response.sendRedirect("editsalindividual.jsp?res=1&branch="+branch+"&dc="+dcnumber+"&sd="+date+"&pk="+id);
      /*  out.println("Inserted successfully in database."); */
   //  } 
              }
     catch (Exception ex) {
     out.println("Unable to connect to database.");
     System.out.println(ex);

        }
              finally {
           	     try {
           	       if (st != null)
           	        st.close();
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