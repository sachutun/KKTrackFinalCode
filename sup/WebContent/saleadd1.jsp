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
Statement st6 = null;
Statement st7 = null;
PreparedStatement preparedStatement = null;
PreparedStatement preparedStatement1 = null;
PreparedStatement preparedStatement2 = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs1 = null;
ResultSet rs2 = null;
int res=0;
int id=0;
          String[] code = request.getParameterValues("code");
        
    
    String dcCode = request.getParameter("dcCode");
    String dcno = request.getParameter("dcnumber");
    String dcnumber =dcCode+dcno;
   // System.out.println("dcnumber: "+dcnumber);
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
   String[] typeArray = request.getParameterValues("type");
   String amountpaid = request.getParameter("amountpaid");
   String balanceamount = request.getParameter("balanceamount");
   String gst = request.getParameter("GST");
   String custIdCode=request.getParameter("custIdCode");
   String custId=request.getParameter("creditCustId");
   String creditCustId=custIdCode+custId;
   String CrediCustStatus=request.getParameter("CrediCustStatus");
   String aadhaar = request.getParameter("aadhaar");
   String taxtype = request.getParameter("taxtype");
   String transtype = request.getParameter("transType");
   String cashAP = request.getParameter("cashAP");
   String neftAP = request.getParameter("neftAP");
   String chequeAP = request.getParameter("chequeAP");
   String swipeAP = request.getParameter("swipeAP");
   String type="";
   float totalARR=0;
/*    System.out.println("typeArray: " +typeArray);
   System.out.println("transtype: " +transtype);
   System.out.println("cashAP: " +cashAP);
   System.out.println("neftAP: " +neftAP);
   System.out.println("chequeAP: " +chequeAP);
   System.out.println("swipeAP: " +swipeAP); */
   if(taxtype==null)
	   taxtype="";
   if(cashAP=="" || cashAP==null)
	   cashAP="0";
   if(neftAP=="" || neftAP==null)
	   neftAP="0";
   if(chequeAP=="" || chequeAP==null)
	   chequeAP="0";
   if(swipeAP=="" || swipeAP==null)
	   swipeAP="0";
   String sqlb="";
   float[] q= new float[qty.length];
//System.out.println("balanceamount: "+balanceamount);

   for(int i=0;i<qty.length;i++)
  {
	   q[i]=Float.parseFloat(qty[i]);
	   System.out.println("qty: "+q[i]);
  } 
   
   
   if(transtype.equals("credit"))
   {
	   type="Credit";
   }
   else
   {
	   type="";
   }
   if(typeArray!=null)
   {
   		for(int i=0;i<typeArray.length;i++)
   		{
 	   		if(type=="")
 	   		{
	   			type=typeArray[i]; 
 	   		}
 	   		else
 	   		{
 		  		type+=","+ typeArray[i];
 	   		}
   		} 
   }
   //System.out.println("type: " +type);
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
     
        st5=connection.createStatement(); 
     rs1=st5.executeQuery("Select * from Sale where Date='"+date+"'and Branch='"+branch+"'and DCNumber='"+dcnumber+"'");

if(rs1.next())
{
	res=2;
}
else
{
statement=connection.createStatement();       
        	
    	  int x=st.executeUpdate("INSERT INTO Sale (DCNumber, Branch, Date, TotalPrice, CustomerName, CustomerNumber, Type, AmountPaid, BalanceAmount, Tax, Discount, Comments, GST, CustID, TaxType, Cash, Neft, Cheque, Swipe) values ('"+ dcnumber+"', '"+branch+"', '"+date+"','"+total+"', '"+customername+"', '"+customernumber+"', '"+type+"', '"+amountpaid+"', '"+balanceamount+"', '"+tax+"', '"+dis+"', '"+comments+"', '"+gst+"', '"+creditCustId+"','"+taxtype+"','"+cashAP+"','"+neftAP+"','"+chequeAP+"','"+swipeAP+"')");

       String sql="Select Max(Id) from Sale";
       resultSet = statement.executeQuery(sql);
     
       resultSet.next();
       id=resultSet.getInt("Max(Id)");
       
        st2=connection.createStatement();
        st3=connection.createStatement();
        st6=connection.createStatement(); 
        rs2=st6.executeQuery("Select * from CodeList");
        
        Map<String,String> codeList = new HashMap<String,String>();

        // parsing the column each time is a linear search
        int column1Pos = rs2.findColumn("Code");
        int column2Pos = rs2.findColumn("MinPrice");
        int column3Pos = rs2.findColumn("ARR");
        while (rs2.next()) {
            String codeKey = rs2.getString(column1Pos);
            String mp = rs2.getString(column2Pos);
            String arr = rs2.getString(column3Pos);
            String mplcValue=mp+","+arr;
            codeList.put(codeKey, mplcValue);
        }

int count=code.length;
String qparts="";
String sq="";
String mapValue="";
String cde;
for(int i=0;i<count;i++)
{
	/* 
	while(rs2.next())
	{
		if(rs2.getString("Code").equals(code[i]))
		{
			minPrice=rs2.getString("MinPrice");
			ARR=rs2.getString("ARR");
			break;
		}
	} */
	cde=code[i];
	mapValue=codeList.get(cde);
	String[] values = mapValue.split(",");
//	values[0] is minPrice  and values[1] is ARR
	
qparts+=" ('"+dcnumber+"',"+code[i]+","+q[i]+","+costprice[i]+","+totalprice[i]+","+id+","+values[0]+","+values[1]+")";
totalARR+=q[i]*Float.parseFloat(values[1]);
 sq="Update NewInventory SET Quantity=Quantity-? WHERE Code=?and Branch=?";	
/* System.out.println("Update NewInventory SET Quantity=Quantity-"+qty[i]+" WHERE Code="+code[i]+" and Branch="+branch); */
System.out.println("---qparts---" +qparts);
preparedStatement = connection.prepareStatement(sq);
preparedStatement.setFloat(1,q[i]);
preparedStatement.setString(2,code[i]);
preparedStatement.setString(3,branch);
preparedStatement.executeUpdate(); 

if(i!=(count-1))
qparts+=",";
	
}

String isql= "INSERT INTO BillDetails (`DCNumber`, `Code`, `Qty`, `CostPrice`, `Total`, `DC`,`MinPrice`, `ARR`) VALUES"+ qparts;
System.out.println("Bill Details: "+isql);

int y=st2.executeUpdate(isql);
//System.out.println("---type---" +type);

String sq2="UPDATE `Sale` SET `TotalARR`=? WHERE Id=?";
// System.out.println("--update-sq---" +sq);
 preparedStatement2 = connection.prepareStatement(sq2);
 preparedStatement2.setString(1,String.valueOf(totalARR));
 preparedStatement2.setInt(2,id);
 preparedStatement2.executeUpdate(); 

if(type.contains("Neft"))
{
	   String cbankname=request.getParameter("cusbank");
	   String kkbank=request.getParameter("kkbank");
	   sqlb="INSERT INTO BankDetails (Id, Type, CSBankName, KKBankName) VALUES ('"+ id+"', 'sale', '"+cbankname+"','"+kkbank+"')";
	   //System.out.println("---sqlb---" +sqlb);
	   int z=st3.executeUpdate(sqlb);
	  
}
else if(type.contains("Cheque"))
{
	   String bank=request.getParameter("bankname");
	   String cd=request.getParameter("cd");
	   String chkno=request.getParameter("chkno");
	   sqlb="INSERT INTO ChequeDetails (Id, Type, ChequeNo, Date, BankName) VALUES('"+ id+"', 'sale', '"+chkno+"','"+cd+"', '"+bank+"')";
	   //System.out.println("---sqlb---" +sqlb);
	   int z=st3.executeUpdate(sqlb);
}
if(type.contains("Credit"))
{
	int OBnew=0;
	System.out.println("CrediCustStatus: " +CrediCustStatus);
	//System.out.println("---balanceamount---: "+balanceamount);
	if(CrediCustStatus.equals("update"))
	{
		
		 OBnew=Integer.parseInt(balanceamount);
		 sq="UPDATE `Debtors` SET `OB`=`OB`+? WHERE CustID=?";
		// System.out.println("--update-sq---" +sq);
		 preparedStatement1 = connection.prepareStatement(sq);
		 preparedStatement1.setInt(1,OBnew);
		 preparedStatement1.setString(2,creditCustId);
		 preparedStatement1.executeUpdate(); 
	}
	if(CrediCustStatus.equals("insert"))
	{
		if(customernumber==null)
			customernumber="";
		 String sqlc="INSERT INTO Debtors (CustID, CustomerName, Mobile, OB, Branch, GST, Aadhaar) VALUES('"+ creditCustId+"', '"+ customername+"', '"+customernumber+"','"+Integer.parseInt(balanceamount)+"', '"+branch+"', '"+gst+"', '"+aadhaar+"')";
		 //System.out.println("add sqlc: " +sqlc); 
		 int z=st4.executeUpdate(sqlc);
	}
}
res=1;
}
       response.sendRedirect("addsale.jsp?res="+res);
      /*  out.println("Inserted successfully in database."); */
   //  } 
              }
     catch (Exception ex) {
    out.println("SALE DID NOT GET ADDED. PLEASE ADD SALE AGAIN.");
     out.println(ex);
     System.out.println(ex);
     System.out.println(id);
     if(id!=0)
     {
    	 st7=connection.createStatement();
    	st7.executeUpdate("Delete from Sale where Id="+id);
     }
        }
              finally {
           	     try {
           	       if (st != null)
           	        st.close();
           	    if (st2 != null)
           	        st2.close();
           	 if (st6 != null)
     	        st6.close();
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