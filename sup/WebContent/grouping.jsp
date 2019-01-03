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
Statement st5 = null;
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement1 = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs1 = null;
int res=0;

          String[] code = request.getParameterValues("code");
          String ncode = request.getParameter("newcode");
   String branch = request.getParameter("branch");
   String[] qty = request.getParameterValues("qty");

   DataSource ds = null;
   int updateQuery = 0;

              try {
       
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
            	    // sql query to insert values in the secified table.
        st=connection.createStatement();
        st4=connection.createStatement();
     
     
        st5=connection.createStatement(); 

statement=connection.createStatement();       
        	
       
        st2=connection.createStatement();
        st3=connection.createStatement();
     

int count=code.length;
String qparts="";
String sq="";
sq="INSERT INTO NewInventory (Quantity, Code, Branch) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity+?";	
preparedStatement = connection.prepareStatement(sq);
connection.setAutoCommit(false);

for(int i=0;i<count;i++)
{

 //System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ('"+code[i]+"','"+branch+"',"+qty[i]+") ON DUPLICATE KEY UPDATE Quantity=Quantity+"+qty[i]); 

preparedStatement.setString(1,qty[i]);
preparedStatement.setString(2,code[i]);
preparedStatement.setString(3,branch);
preparedStatement.setInt(4,-Integer.parseInt(qty[i]));
preparedStatement.addBatch();
	
}

preparedStatement.setInt(1,1);
preparedStatement.setString(2,ncode);
preparedStatement.setString(3,branch);
preparedStatement.setInt(4,1);
preparedStatement.addBatch();

//System.out.println("INSERT INTO NewInventory (Code, Branch, Quantity) VALUES ('"+ncode+"','"+branch+"',"+1+") ON DUPLICATE KEY UPDATE Quantity=Quantity+"+1);

int[] cnt = preparedStatement.executeBatch();

connection.commit();
res=1;
 
       response.sendRedirect("group.jsp?res="+res);
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