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
<%
/* String id = request.getParameter("userId"); */

DataSource ds = null;
Connection connection = null;
Statement statement = null;
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement2 = null;
PreparedStatement preparedStatement3 = null;
ResultSet resultSet = null;

    String[] code = request.getParameterValues("code");


   String frombranch = request.getParameter("fbranch");
   String tobranch = request.getParameter("tbranch");
   String[] qty = request.getParameterValues("qty");
   String totalqty=request.getParameter("totalq");
   String sd=request.getParameter("sd");
   String ibt=request.getParameter("ibt");
   int id= Integer.parseInt(request.getParameter("pid"));
   String[] saleprice = request.getParameterValues("saleprice");
   double[] sp=new double[saleprice.length];
   String t=request.getParameter("tax");
   double tax;
   if(t==null || t=="")
	   tax=0;
   else
       tax=Double.parseDouble(t);
   String tp=request.getParameter("totalprice");
   double totalprice;
   if(tp==null || tp=="")
	   totalprice=0;
   else
	   totalprice=Double.parseDouble(tp);
float tq=Float.parseFloat(totalqty);
float[] q= new float[qty.length];


for(int i=0;i<qty.length;i++)
{
   q[i]=Float.parseFloat(qty[i]);  
} 
for(int i=0;i<saleprice.length;i++)
{
	  // System.out.println("saleprice"+"["+i+"]: "+saleprice[i]);
     String salep=saleprice[i];
     if(salep!=null && salep!="")
	   		sp[i]=Double.parseDouble(salep);  
     //else
     		//sp[i]=0;
} 
   
 /*   String connectionURL = "jdbc:mysql://localhost:8889/KKTrack";

Class.forName("com.mysql.jdbc.Driver").newInstance(); */
   int updateQuery = 0;

              try {
       
      /*  connection = DriverManager.getConnection(connectionURL, "root", "root"); */
                     // sql query to insert values in the secified table.
                      
                     /* Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
	  connection = ds.getConnection(); */
	  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	    // connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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
	    Statement st=connection.createStatement();
       statement=connection.createStatement();       
  
      
       
       Statement st2=connection.createStatement();

int count=code.length;
String qparts="";
String sq1="";
String sq2="";

for(int i=0;i<count;i++)
{
qparts+=" ("+code[i]+","+q[i]+","+id+","+sp[i]+")";
/*  sq1="Update NewInventory SET Quantity=Quantity-? WHERE Code=?and Branch=?";	
 sq2="Update NewInventory SET Quantity=Quantity+? WHERE Code=?and Branch=?";	 */
sq1="INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity-?";
sq2="INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity+?";
//System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code[i]+","+frombranch+","+qty[i]+") ON DUPLICATE KEY UPDATE Quantity=Quantity-"+qty[i]);
//System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code[i]+","+tobranch+","+qty[i]+") ON DUPLICATE KEY UPDATE Quantity=Quantity-"+qty[i]);
preparedStatement = connection.prepareStatement(sq1);
/* preparedStatement.setString(1,code[i]);
preparedStatement.setString(2,frombranch);
preparedStatement.setString(3,qty[i]);
preparedStatement.setString(4,qty[i]);
preparedStatement.executeUpdate(); 

preparedStatement2 = connection.prepareStatement(sq2);
preparedStatement2.setString(1,code[i]);
preparedStatement2.setString(2,tobranch);
preparedStatement2.setString(3,qty[i]);
preparedStatement2.setString(4,qty[i]);
preparedStatement2.executeUpdate();  */

connection.setAutoCommit(false);

preparedStatement.setString(1,code[i]);
preparedStatement.setString(2,frombranch);
preparedStatement.setFloat(3,q[i]);
preparedStatement.setFloat(4,q[i]);
preparedStatement.addBatch();

preparedStatement.setString(1,code[i]);
preparedStatement.setString(2,tobranch);
preparedStatement.setFloat(3,q[i]);
preparedStatement.setFloat(4,-q[i]);
preparedStatement.addBatch();

int[] cnt = preparedStatement.executeBatch();

if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO IBTDetails (`Code`, `Qty`, `IBT`, `SalePrice`) VALUES"+ qparts;

int y=st2.executeUpdate(isql);

String s="UPDATE `IBT` SET `TotalQty`=`TotalQty`+? , `TotalPrice`=`TotalPrice`+?, `Tax`=`Tax`+? WHERE Id=?"; 
/* String s="UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+"+ft+",`BalanceAmount`=TotalPrice-AmountPaid WHERE Id="+id; */
/* System.out.println(s); */
preparedStatement3 = connection.prepareStatement(s);
preparedStatement3.setFloat(1,tq);
preparedStatement3.setDouble(2,totalprice);
preparedStatement3.setDouble(3,tax);
preparedStatement3.setInt(4,id);
preparedStatement3.executeUpdate();  
connection.commit();
       response.sendRedirect("editibtindividual.jsp?res=1&fbranch="+frombranch+"&dc="+ibt+"&sd="+sd);
      /*  out.println("Inserted successfully in database."); */
   //  }
              }
     catch (Exception ex) {
     out.println("Unable to connect to database.");
     System.out.println(ex);

        }
     finally {
         // close all the connections.
        
         connection.close();
     }

%>