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
<%
/* String id = request.getParameter("userId"); */

Connection connection = null;
Statement statement = null;
Statement st = null;
Statement st2 = null;
Statement st3 = null;
Statement st4 = null;
PreparedStatement preparedStatement = null;
ResultSet resultSet = null;
ResultSet rs = null;

          String[] code = request.getParameterValues("code");
        
    String dcnumber = request.getParameter("dcnumber");
    String date = request.getParameter("date"); 
  
   String[] costprice = request.getParameterValues("costprice");
   String branch = request.getParameter("branch");
   String[] qty = request.getParameterValues("qty");
   String[] totalprice=request.getParameterValues("totalprice");
   String total=request.getParameter("ftotal");
   String tax=request.getParameter("tax");
   String dis=request.getParameter("dis");
   String comments=request.getParameter("comments");
   String customername = request.getParameter("customername");
   String customernumber = request.getParameter("customernumber");
   String type = request.getParameter("type");
   String amountpaid = request.getParameter("amountpaid");
   String balanceamount = request.getParameter("balanceamount");
   String sqlb="";

   
   DataSource ds = null;
   int updateQuery = 0;

              try {
       
            	  /* Context context = new InitialContext();
            	  Context envCtx = (Context) context.lookup("java:comp/env");
            	  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
            	  if (ds != null) {
            	    connection = ds.getConnection(); */
            	    
            	    Class.forName("com.mysql.jdbc.Driver").newInstance();  
            	     connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
                     // sql query to insert values in the secified table.
        st=connection.createStatement();
        st4=connection.createStatement();
        //check inventory quantity>sale qty
        
         
   /*       for(int j=0;j<qty.length;j++)  
         {
        	 int iq=0;
        	 rs = st4.executeQuery("Select * from NewInventory where Code='"+code[j]+"'and Branch='"+branch+"'");
          while  ( rs.next())
          {
             iq=rs.getInt("Quantity");
             System.out.println(iq);
             System.out.println(code[j]);
          }
         if(iq<Integer.parseInt(qty[j]))
         {
        	 st4.close();
        	 response.sendRedirect("addsale.jsp?res=2&code="+code[j]);
        	 return;
         }
          
         } */
     /*    System.out.println("fine"); */
       statement=connection.createStatement();       
       
       int x=st.executeUpdate("INSERT INTO Sale (DCNumber, Branch, Date, TotalPrice, CustomerName, CustomerNumber, Type, AmountPaid, BalanceAmount, Tax, Discount, Comments) values ('"+ dcnumber+"', '"+branch+"', '"+date+"','"+total+"', '"+customername+"', '"+customernumber+"', '"+type+"', '"+amountpaid+"', '"+balanceamount+"', '"+tax+"', '"+dis+"', '"+comments+"')");
       
       String sql="Select Max(Id) from Sale";
       resultSet = statement.executeQuery(sql);
     
       resultSet.next();
       int id=resultSet.getInt("Max(Id)");
       
        st2=connection.createStatement();
        st3=connection.createStatement();

int count=code.length;
String qparts="";
String sq="";

for(int i=0;i<count;i++)
{
qparts+=" ('"+dcnumber+"',"+code[i]+","+qty[i]+","+costprice[i]+","+totalprice[i]+","+id+")";
 sq="Update NewInventory SET Quantity=Quantity-? WHERE Code=?and Branch=?";	
/* System.out.println("Update NewInventory SET Quantity=Quantity-"+qty[i]+" WHERE Code="+code[i]+" and Branch="+branch); */
preparedStatement = connection.prepareStatement(sq);
preparedStatement.setString(1,qty[i]);
preparedStatement.setString(2,code[i]);
preparedStatement.setString(3,branch);
preparedStatement.executeUpdate(); 

if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO BillDetails (`DCNumber`, `Code`, `Qty`, `CostPrice`, `Total`, `DC`) VALUES"+ qparts;

int y=st2.executeUpdate(isql);

if(type.equals("Neft"))
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
}


       response.sendRedirect("addsale.jsp?res=1");
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