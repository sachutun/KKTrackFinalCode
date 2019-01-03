  <%@page language="java" import ="java.sql.*" %>  
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@page language="java" import ="java.util.*" %> 
<%@ page import="java.io.InputStream" %>
 
 <%  
 DataSource ds = null;
 Connection conn = null;
 Statement stmt=null;
 String branch=request.getParameter("branch");
 String Date=request.getParameter("Date");  
 String code=request.getParameter("code"); 
String b=""; 
try{
/* Context context = new InitialContext();
Context envCtx = (Context) context.lookup("java:comp/env");
ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
if (ds != null) {
  conn = ds.getConnection();  */
  
  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
   //conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234"); 
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
  stmt = conn.createStatement(); 

 ResultSet rs;
 if(code=="")
 {
rs=	 stmt.executeQuery("SELECT DISTINCT Sales.Branch, Sales.Date, Sales.DCNumber, Sales.Code, Inventory.Machine, Inventory.PartNo, Inventory.Description, Inventory.MaxPrice, Inventory.MinPrice, Sales.Price, Sales.Qty, Sales.TotalPrice, Sales.CustomerName, Sales.CustomerMobile, Sales.Type, Sales.AmountPaid FROM Sales INNER JOIN Inventory ON Sales.Code=Inventory.Code ");
 } 
else{
  rs = stmt.executeQuery("SELECT DISTINCT Sales.Branch, Sales.Date, Sales.DCNumber, Sales.Code, Inventory.Machine, Inventory.PartNo, Inventory.Description, Inventory.MaxPrice, Inventory.MinPrice, Sales.Price, Sales.Qty, Sales.TotalPrice, Sales.CustomerName, Sales.CustomerMobile, Sales.Type, Sales.AmountPaid FROM Sales INNER JOIN Inventory ON Sales.Code=Inventory.Code where Sales.Branch='"+branch+"'and Sales.Date='"+Date+"'and Sales.Code='"+code+"'");
}
 b+="<thead> <tr><tr><th>Branch</th> <th>Date</th><th>Invoice No</th> <th>Code</th>  <th>Description</th>  <th>Sale Price</th> <th>Quantity</th><th>Total price</th><th>Customer Name</th><th>Customer Number</th><th>Amount Paid</th><th>Type</th> <th>Machine</th><th>Part No</th> <th>Max Price</th><th>Min Price</th></tr></thead><tbody>";
   while(rs.next()){
 b+="<tr class=\"odd gradeX\"><td>"+rs.getString("Branch")+"</td><td>"+rs.getString("Date")+"</td><td>"+rs.getString("DCNumber")+"</td><td>"+rs.getString("Code")+"</td><td>"+rs.getString("Description")+"</td><td>"+rs.getString("Price")+"</td><td>"+rs.getFloat("Qty")+"</td><td>"+rs.getString("TotalPrice")+"</td><td>"+rs.getString("CustomerName")+"</td><td>"+rs.getString("CustomerMobile")+"</td><td>"+rs.getString("AmountPaid")+"</td><td>"+rs.getString("Type")+"</td><td>"+rs.getString("Machine")+"</td><td>"+rs.getString("PartNo")+"</td><td>"+rs.getString("MaxPrice")+"</td><td>"+rs.getString("MinPrice")+"</td></tr>";

   }  
   b+="</tbody>";
  
 response.getWriter().println(b);    
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
                      	        if (conn != null)
                      	         conn.close();
                      	        } catch (SQLException e) {}
                      	    }
 %>
 