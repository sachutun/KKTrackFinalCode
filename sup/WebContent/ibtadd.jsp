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
ResultSet resultSet = null;

          String[] code = request.getParameterValues("code");
        
    String ibtnumber = request.getParameter("ibtnumber");
    String date = request.getParameter("date"); 
   String uBranch=(String)session.getAttribute("ubranch");
   String role=(String)session.getAttribute("role"); 
   String frombranch;

    if(role!=null && role.equals("2") && !uBranch.equals("Bowenpally") && !uBranch.equals("Workshop"))
    	frombranch= uBranch;
   else
   {
	   frombranch= request.getParameter("frombranch");
	  
   }
   String tobranch = request.getParameter("tobranch");
   String[] qty = request.getParameterValues("qty");
   String totalqty=request.getParameter("totalq");

   System.out.println(frombranch);
   
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
      
       int x=st.executeUpdate("INSERT INTO IBT (IBTNo, FromBranch,ToBranch, Date, TotalQty) values ('"+ ibtnumber+"', '"+frombranch+"', '"+tobranch+"','"+date+"', "+totalqty+")");
       
       String sql="Select Max(Id) from IBT";
       resultSet = statement.executeQuery(sql);
     
       resultSet.next();
       int id=resultSet.getInt("Max(Id)");
       
       Statement st2=connection.createStatement();

int count=code.length;
String qparts="";
String sq1="";
String sq2="";

for(int i=0;i<count;i++)
{
qparts+=" ("+code[i]+","+qty[i]+","+id+")";
/*  sq1="Update NewInventory SET Quantity=Quantity-? WHERE Code=?and Branch=?";	
 sq2="Update NewInventory SET Quantity=Quantity+? WHERE Code=?and Branch=?";	 */
sq1="INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity-?";
sq2="INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity+?";
//System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code[i]+","+frombranch+","+qty[i]+") ON DUPLICATE KEY UPDATE Quantity=Quantity-"+qty[i]);
//System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ("+code[i]+","+tobranch+","+qty[i]+") ON DUPLICATE KEY UPDATE Quantity=Quantity-"+qty[i]);
preparedStatement = connection.prepareStatement(sq1);
preparedStatement.setString(1,code[i]);
preparedStatement.setString(2,frombranch);
preparedStatement.setString(3,qty[i]);
preparedStatement.setString(4,qty[i]);
preparedStatement.executeUpdate(); 

preparedStatement2 = connection.prepareStatement(sq2);
preparedStatement2.setString(1,code[i]);
preparedStatement2.setString(2,tobranch);
preparedStatement2.setString(3,qty[i]);
preparedStatement2.setString(4,qty[i]);
preparedStatement2.executeUpdate(); 

if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO IBTDetails (`Code`, `Qty`, `IBT`) VALUES"+ qparts;

int y=st2.executeUpdate(isql);
 
       response.sendRedirect("ibtform.jsp?res=1");
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