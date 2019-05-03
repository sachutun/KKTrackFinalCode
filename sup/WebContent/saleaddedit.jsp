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
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement2 = null;
PreparedStatement preparedStatement3 = null;
ResultSet rs = null;


          String[] code = request.getParameterValues("code");
        
    String dcnumber = request.getParameter("dc");
    String date = request.getParameter("sd");
   
    String custId = request.getParameter("custId");
  // System.out.println(custID);
   String[] costprice = request.getParameterValues("costprice");
   String branch = request.getParameter("branch");
   String[] qty = request.getParameterValues("qty");
   String[] totalprice=request.getParameterValues("totalprice");
   float ftx=0;
   
/*    System.out.println(code[0]+dcnumber+costprice[0]+branch+qty[0]+totalprice[0]); */
/*    String total=request.getParameter("total"); */
/*    String customername = request.getParameter("customername");
   String customernumber = request.getParameter("customernumber"); */
/*    String type = request.getParameter("type"); */
 
/*    String balanceamount = request.getParameter("balanceamount"); */
   String sqlb="";

   float[] q= new float[qty.length];


    for(int i=0;i<qty.length;i++)
   {
	   q[i]=Float.parseFloat(qty[i]);  
   } 
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
        st3=connection.createStatement();
         rs=st3.executeQuery("Select * from CodeList");
        
        Map<Integer,String> codeList = new HashMap<Integer,String>();

        // parsing the column each time is a linear search
        int column1Pos = rs.findColumn("Code");
        int column2Pos = rs.findColumn("MinPrice");
        int column3Pos = rs.findColumn("LC");
        while (rs.next()) {
            int codeKey = rs.getInt(column1Pos);
            String mp = rs.getString(column2Pos);
            String lc = rs.getString(column3Pos);
            String mplcValue=mp+","+lc;
            codeList.put(codeKey, mplcValue);
        }


int count=code.length;
String qparts="";
String sq="";
int ft=0;
String mapValue="";
int cde=0;
for(int i=0;i<count;i++)
{
	cde=Integer.parseInt(code[i]);
	mapValue=codeList.get(cde);
	String[] values = mapValue.split(",");
//	values[0] is minPrice  and values[1] is LC
qparts+=" ('"+dcnumber+"',"+code[i]+","+q[i]+","+costprice[i]+","+totalprice[i]+","+id+","+values[0]+","+values[1]+")";
 sq="Update NewInventory SET Quantity=Quantity-? WHERE Code=?and Branch=?";	
/* System.out.println("Update NewInventory SET Quantity=Quantity-"+qty[i]+" WHERE Code="+code[i]+"and Branch="+branch); */
 preparedStatement = connection.prepareStatement(sq);
preparedStatement.setFloat(1,q[i]);
preparedStatement.setString(2,code[i]);
preparedStatement.setString(3,branch);
preparedStatement.executeUpdate();  
ft+=Float.parseFloat(totalprice[i]);
ftx+=Float.parseFloat(totalprice[i])*0.18;
if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO BillDetails (`DCNumber`, `Code`, `Qty`, `CostPrice`, `Total`, `DC`,`MinPrice`, `LC`) VALUES"+ qparts;
/* System.out.println(isql); */
 int y=st2.executeUpdate(isql); 

 String s="UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+?,`BalanceAmount`=`TotalPrice`-`AmountPaid`, `Tax`=`Tax`+?  WHERE Id=?"; 
 
 System.out.println("UPDATE `Sale` SET `TotalPrice`=`TotalPrice`+"+(ft+ftx)+",`BalanceAmount`=`TotalPrice`-`AmountPaid`, `Tax`=`Tax`+ "+ftx+" WHERE Id="+id); 
 preparedStatement2 = connection.prepareStatement(s);
preparedStatement2.setFloat(1,(ft+ftx));
preparedStatement2.setFloat(2,ftx);
preparedStatement2.setInt(3,id);
preparedStatement2.executeUpdate();  

if(custId!=null && custId!="")
{
	   String s5="UPDATE `Debtors` SET `OB`=`OB`+" +(ft+ftx)+" WHERE CustId="+custId; 
	   //System.out.println(s5);
	  // System.out.println("existing credit cust: "+s5);
preparedStatement3 = connection.prepareStatement("UPDATE `Debtors` SET `OB`=`OB`+? WHERE CustId=?");
preparedStatement3.setFloat(1,(ft+ftx));
preparedStatement3.setString(2,custId);
preparedStatement3.executeUpdate(); 
}



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