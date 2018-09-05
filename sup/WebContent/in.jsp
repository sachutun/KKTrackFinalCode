  <%@page language="java" import ="java.sql.*" %>  
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONException"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.io.InputStream" %>

 <%  
 
/*  String branch=request.getParameter("branch"); */
/*  String StartDate=request.getParameter("StartDate");  
 String EndDate=request.getParameter("EndDate");  
System.out.println(branch+StartDate+EndDate); */
String b=""; 
//Class.forName("com.mysql.jdbc.Driver").newInstance();  
// Connection con = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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

   Connection con = DriverManager.getConnection(url, username, password);
 Statement stmt = con.createStatement(); 
 ResultSet rs;
 rs = stmt.executeQuery("SELECT * FROM CodeList inner join NewInventory on NewInventory.Code=CodeList.Code limit 100");
JSONArray json = new JSONArray();
ResultSetMetaData rsmd = rs.getMetaData();
while(rs.next()) {
  int numColumns = rsmd.getColumnCount();
  JSONObject obj = new JSONObject();
  for (int i=1; i<=numColumns; i++) {
    String column_name = rsmd.getColumnName(i);
    obj.put(column_name, rs.getObject(column_name));
  }
  json.put(obj);
}
/*  if(branch==null)
	  rs = stmt.executeQuery("SELECT * FROM CodeList inner join NewInventory on NewInventory.Code=CodeList.Code limit 1000");
 else
  rs = stmt.executeQuery("SELECT * FROM CodeList inner join NewInventory on NewInventory.Code=CodeList.Code where Branch='"+branch+"'"); */
/*  
   while(rs.next()){
 b+="<tr class=\"odd gradeX\"><td>"+rs.getString("Code")+"</td><td>"+rs.getString("HSNCode")+"</td><td>"+rs.getString("Machine")+"</td><td>"+rs.getString("PartNo")+"</td><td>"+rs.getString("Description")+"</td><td>"+rs.getString("Grp")+"</td><td>"+rs.getString("MaxPrice")+"</td><td>"+rs.getString("MinPrice")+"</td><td>"+rs.getString("Quantity")+"</td></tr>";

   }   */
   System.out.println(json);
/*  response.getWriter().println(b);     */
 %>


