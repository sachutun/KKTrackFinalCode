  <%@page language="java" import ="java.sql.*" %>  
<%@page language="java" import ="java.util.*" %>  
 <%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
 <%@ page import="java.io.InputStream" %>
 <%  
 String name=request.getParameter("count");  
 String branch=request.getParameter("branch"); 
//String ibt=request.getParameter("ibt");
 String dt=request.getParameter("da");  
 String dc=request.getParameter("dcnumber");  

/*  String buffer="";   */
String mac="";
String des="";
String part="";
String min="";
String max="";
String grp="";
String b="";
Statement stmt = null;
Statement stmt2 = null;
Statement st4 = null;
DataSource ds = null;
Connection con = null;
ResultSet rs3=null;
ResultSet rs4=null;
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
st4 = con.createStatement();   
stmt2 = con.createStatement();  
 ResultSet rs = stmt.executeQuery("SELECT * FROM CodeList where Code = "+name); 
 
 float iq=0;
 rs3 = st4.executeQuery("Select * from NewInventory where Code='"+name+"'and Branch='"+branch+"'");

while  ( rs3.next())
{

 iq=rs3.getFloat("Quantity");

}
rs3=null;
rs3=st4.executeQuery("Select * from Manufacturing where Date='"+dt+"'and Branch='"+branch+"'and InvoiceNumber='"+dc+"'");
//System.out.println("Select * from Manufacturing where Date='"+dt+"'and Branch='"+branch+"'and InvoiceNumber='"+dc+"'");
if(rs3.next())
{

	res=2;

}
//System.out.println("res: "+res);

   while(rs.next()){
   mac+=rs.getString("Machine");  
   des+=rs.getString("Description"); 
   part+=rs.getString("PartNo"); 
   min+=rs.getString("MinPrice"); 
   max+=rs.getString("MaxPrice"); 
   grp+=rs.getString("Grp"); 
   }  




 b+=mac+","+des+","+part+","+min+","+max+","+grp+","+iq+","+res; 
 //System.out.println(b);
 response.getWriter().println(b);    
//}
} catch (Exception e) {
e.printStackTrace();
}
                        finally {
                      	     try {
                      	       if (stmt != null)
                      	        stmt.close();
                      	    if (stmt2 != null)
                      	        stmt2.close();
                      	       }  catch (SQLException e) {}
                      	       try {
                      	        if (con != null)
                      	         con.close();
                      	        } catch (SQLException e) {}
                      	    }
 %>