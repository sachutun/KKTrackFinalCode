  <%@page language="java" import ="java.sql.*" %>  
<%@page language="java" import ="java.util.*" %>  
 <%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
 <%@ page import="java.io.InputStream" %>
 <%  
 String creditcustID=request.getParameter("creditcustID");  
 String branch=request.getParameter("branch");  

/*  String buffer="";   */
String custName="";
String custNumber="";
String output="";
int OB=0;
String aadhaar="";
String gst="";
Statement stmt = null;

Connection con = null;

int res=0;

try{
/* Context context = new InitialContext();
Context envCtx = (Context) context.lookup("java:comp/env");
ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
if (ds != null) {
  con = ds.getConnection(); */
  
 // Class.forName("com.mysql.jdbc.Driver").newInstance();  
 //  con = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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

    con = DriverManager.getConnection(url, username, password);
stmt = con.createStatement();  
 System.out.println("SELECT * FROM Debtors where CustID = '"+creditcustID+"'");
 ResultSet rs = stmt.executeQuery("SELECT * FROM Debtors where CustID = '"+creditcustID+"'");
 


   while(rs.next()){
   custName+=rs.getString("CustomerName");  
   custNumber+=rs.getString("Mobile"); 
   OB+=rs.getInt("OB");
   aadhaar+=rs.getString("Aadhaar"); 
   gst+=rs.getString("GST");
res=1;
   }  

 output+=custName+","+custNumber+","+OB+","+aadhaar+","+gst+","+res; 
 System.out.println("output: " +output);
 response.getWriter().println(output);    
//}
} catch (Exception e) {
e.printStackTrace();
}
                        finally {
                      	     try {
                      	       if (stmt != null)
                      	        stmt.close();
                      	  
                      	       }  catch (SQLException e) {}
                      	       try {
                      	        if (con != null)
                      	         con.close();
                      	        } catch (SQLException e) {}
                      	    }
 %>