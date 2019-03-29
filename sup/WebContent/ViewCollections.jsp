<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@ page import= "java.text.SimpleDateFormat" %>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.io.InputStream" %>
<%
/* String id = request.getParameter("userId"); */
/* String driverName = "com.mysql.jdbc.Driver";


try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}
 */
 DataSource ds = null;
Connection connection = null;
Statement statement = null;
Statement st,st2 = null;
ResultSet resultSet = null;
ResultSet rs,rs2 = null;
int sno=1;
%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- View Collections</title>

    <!-- Bootstrap -->
    <link href="vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Datatables -->
    <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
  <!-- bootstrap-wysiwyg -->
    <link href="vendors/google-code-prettify/bin/prettify.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- Switchery -->
    <link href="vendors/switchery/dist/switchery.min.css" rel="stylesheet">
    <!-- starrr -->
    <link href="vendors/starrr/dist/starrr.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="build/css/custom.min.css" rel="stylesheet">
      <style>
        .no-js #loader { display: none;  }
.js #loader { display: block; position: absolute; left: 100px; top: 0; }
.se-pre-con {
	position: fixed;
	left: 0px;
	top: 0px;
	width: 100%;
	height: 100%;
	z-index: 600000000;
	background: url(images/Preloader_2.gif) center no-repeat #fff;
}
  </style>
  </head>

  <body class="nav-md">
   <div class="se-pre-con"></div>
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="viewinventory.jsp" class="site_title"><i class="fa fa-line-chart"></i> <span>KK Track</span></a>
            </div>

            <div class="clearfix"></div>


            <br />

            <!-- sidebar menu -->
             <%! String includeMenuPage= "sidebarMenu.html"; %>
			<jsp:include page="<%= includeMenuPage %>"></jsp:include>
       
          </div>
        </div>
<%   
String uBranch=(String)session.getAttribute("ubranch");
String role=(String)session.getAttribute("role");
String user=(String)session.getAttribute("user"); 
if(user==null)
	response.sendRedirect("login.jsp");
Properties props = new Properties();
InputStream in = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
props.load(in);
in.close();

String driver = props.getProperty("jdbc.driver");
String url = props.getProperty("jdbc.url");
String username = props.getProperty("jdbc.username");
String password = props.getProperty("jdbc.password");
String environment = props.getProperty("jdbc.environment");
%> 
        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>

              <ul class="nav navbar-nav navbar-right">
                <li class="">
                  <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    <!-- <img src="images/img.jpg" alt=""> --><%=user %>
                    <span class=" fa fa-angle-down"></span>
                  </a>
                  <ul class="dropdown-menu dropdown-usermenu pull-right">
               <!--      <li><a href="javascript:;"> Profile</a></li>
                    <li>
                      <a href="javascript:;">
                        <span class="badge bg-red pull-right">50%</span>
                        <span>Settings</span>
                      </a>
                    </li>
                    <li><a href="javascript:;">Help</a></li> -->
                    <li><a href="login.jsp"><i class="fa fa-sign-out pull-right"></i> Log Out</a></li>
                  </ul>
                </li>

               
              </ul>
            </nav>
          </div>
        </div>
         
        <!-- /top navigation -->

        <!-- page content -->
        <div class="right_col " role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>Collections <!-- <small>Some examples to get you started</small> --></h1>
              </div>

             <!--  <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div> -->


            <div class="clearfix"></div>

          
<form action="ViewCollections.jsp" method="post" class="form-horizontal form-label-left" onsubmit="d()">
  <div class="col-md-4 col-sm-6 col-xs-12">
                        <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                          <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                          <span id="daterange"></span> <b class="caret"></b>
                            <input id="std" name="std" class="form-control col-md-7 col-xs-12" type="hidden" > 
                  <input id="end" name="end" class="form-control col-md-7 col-xs-12" type="hidden" > 
                        </div>
                      </div>

                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
             <div class="col-md-3 col-sm-3 col-xs-4" id="br">
                          <select class="select2_single form-control hide4branch" tabindex="-1" name="branch" id="branch">
                            <option value="">Select Another Branch</option>
                            <option value="All">All Branches</option>
                        
                            <%
							 while (resourceKeys.hasMoreElements()) {
									String branchKey = (String) resourceKeys.nextElement();
									listOfBranches.add(branchKey);
							 Collections.sort(listOfBranches);
							 }		
							 String branchKey="";
                        	 	 String branchValue="";
							for(int i=0;i<listOfBranches.size();i++)
							{
								branchKey = listOfBranches.get(i);
								branchValue=resources.getString(branchKey);																															
							%>
							<option value="<%=branchKey%>"> <%=branchValue%>
							</option> 
							<%
								}
							%> 
                            
                          </select>
                           <input type="text" id="name" required="required" class="form-control col-md-7 col-xs-12 user" name="br" style="display:none;" value=<%=uBranch%> disabled>
                        </div>
                       <button type="submit" class="btn btn-success " >Go </button>
                        <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                    <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
                  </form>
                         <br/>
        <br/>
                <br/>
                   
              
 <div class="table-responsive"> 
                  <table class="table" >
       
        <tbody>
          
            <tr id="filter_col" >
           
                <td align="center"> Customer ID: <input type="text" class="column_filter" id="col1_filter" data-column="1"></td>
        
                <td align="center">Customer Name: <input type="text" class="column_filter" id="col2_filter" data-column="2"></td>
  
                <td align="center">Status <input type="text" class="column_filter" id="col6_filter" data-column="6"></td>

            </tr>
        </tbody></table></div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View Collections</h2>
                    
               <%  String branch = request.getParameter("branch");
            
               if(role!=null && !(role.equals("1")) && !(role.equals("5")))
            	   branch=uBranch; 
               //if(branch!=null && branch.equals("All"))
            	   if(branch == null || branch.equals("All")) 
               branch="";
               String sn = request.getParameter("sno");
               if(sn==null)
            	   sn="";
               String std=request.getParameter("std");
               String end=request.getParameter("end");	
                   %>
                    <label style="float:right" ><%= branch %></label>
  <div class="clearfix"></div>
  
                  </div>
                  <div class="x_content">
                 
                 <div class="table-responsive"> 
                    <table id="ex" class=" display table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                       
                            <tr>
    			                       
                          			<th>Branch</th>
                          			<th>Customer ID</th>
                                     <th>Customer Name</th>
                                     <th>OB</th>
                                     <th>Target</th>
                                   	<th>Collections</th>
                                     <th>Last Payment</th>
                                     <th class="none" >Sale History</th>
                                     <th class="none" >Payment History</th>
                            </tr>
                                        
                      </thead>
                      <tfoot>
            <tr>
          

<th colspan="3" style="text-align:right"></th>
                <th></th>
                <th></th>
                <th></th>
             <th> </th>
              <th> </th>
         <th> </th>
            </tr>
        </tfoot>
                        <tbody>
<%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root"); */
 /* Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    connection = ds.getConnection(); */
    if (driver != null) {
        Class.forName(driver).newInstance();  
    }

    connection = DriverManager.getConnection(url, username, password);
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
     //connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");     
statement=connection.createStatement();
//SELECT d.CustId,d.Branch,d.CustomerName,d.OB,SUM(s.Amount) as Collections  FROM Debtors d , SaleCredit s  WHERE d.CustId=s.CustId and Date between '2018-12-01' and '2018-12-31' group by s.CustId
//String sql ="SELECT d.CustId,d.Branch,d.CustomerName,d.OB,s.Amount,s.Date,s.Comments  FROM Debtors d , SaleCredit s WHERE d.CustId=s.CustId";
//String sql="SELECT d.CustId,d.Branch,d.CustomerName,d.OB FROM Debtors d WHERE 1";
String sql="SELECT d.CustId,d.Branch,d.CustomerName,d.OB, (Select SUM(Amount) from SaleCredit where month(Date)= month(CURRENT_DATE) and year(Date)=year(CURRENT_DATE) and CustID=d.CustID group by CustId) as Collections, (Select SUM(BalanceAmount) from Sale sa where sa.CustID=d.CustID and  DATEDIFF(Last_Day(CURRENT_DATE), sa.Date)>50 group by d.CustID) as target, (Select Datediff((CURRENT_DATE),Max(sc.Date)) from SaleCredit sc where sc.CustID=d.CustID ) as lastpayment  FROM Debtors d left outer join SaleCredit s on d.CustID=s.CustID WHERE 1"; 
String whr="";
String primaryKey;
String sql2="SELECT d.CustId,d.Branch,d.CustomerName,d.OB, (Select SUM(Amount) from SaleCredit where CustID=d.CustID";
String sql3=") as Collections, (Select SUM(BalanceAmount) from Sale sa where sa.CustID=d.CustID and  DATEDIFF(Last_Day(CURRENT_DATE), sa.Date)>50 group by d.CustID) as target, (Select Datediff((CURRENT_DATE),Max(sc.Date)) from SaleCredit sc where sc.CustID=d.CustID ) as lastpayment  FROM Debtors d left outer join SaleCredit s on d.CustID=s.CustID WHERE 1";
String sql3a=") as Collections, (Select SUM(BalanceAmount) from Sale sa where sa.CustID=d.CustID and  DATEDIFF(Last_Day(";
String sql3b="), sa.Date)>50 group by d.CustID) as target, (Select Datediff((CURRENT_DATE),Max(sc.Date)) from SaleCredit sc where sc.CustID=d.CustID ) as lastpayment  FROM Debtors d left outer join SaleCredit s on d.CustID=s.CustID WHERE 1";



if(branch!="" && branch!=null)
	whr+=" and d.Branch='"+branch+"'";
whr+=" group by d.CustId order by lastpayment desc";
sql+=whr;
if(std!=null && std.length()!=0)
	sql2+=" and Date between '"+std+"' and '"+end+"' group by CustId"+sql3a+"'"+end+"'"+sql3b+whr; 
	
statement=connection.createStatement();

if(std!=null && std.length()!=0)
{
resultSet = statement.executeQuery(sql2);
 System.out.println("sql: "+sql2); 
}
else
{
	resultSet = statement.executeQuery(sql);	
	 System.out.println("sql: "+sql); 
}
while(resultSet.next()){
	primaryKey = resultSet.getString("d.CustId");
	int target=resultSet.getInt("target") ;
	if(resultSet.getInt("d.OB")<target)
		target=resultSet.getInt("d.OB");
	
%>
                                        <tr class="odd gradeX">
                                         <td ><%=resultSet.getString("d.Branch") %></td>
                                         <td ><%=resultSet.getString("d.CustId")  %></td>
                                        
                                         <td width="60%"><%=resultSet.getString("d.CustomerName") %></td>
                                         <td ><%=resultSet.getInt("d.OB") %></td>                                          
                                        <td ><%=target%></td>                                      
                                          <td ><%=resultSet.getInt("Collections") %></td>
 										<td ><%=resultSet.getInt("lastpayment") %></td> 
 									<%
 									String sql4="select *, DATEDIFF(CURRENT_DATE, Date) as 'days' from Debtors d inner join Sale s on d.CustID=s.CustID where d.CustId='";
                                     String sql5="select * from SaleCredit where CustId='";
 									String whr2=primaryKey+"' ";
 									sql4+=whr2;
 									sql5+=whr2;
 									st=connection.createStatement();
 									rs = st.executeQuery(sql4);
 									st2=connection.createStatement();
 									rs2= st2.executeQuery(sql5);
 									if(!rs.isLast() && ((rs.getRow() != 0) || rs.isBeforeFirst()))	
 									{
 										
 									%>	
 										<td>
 										<table id="ex2" class="table table-striped table-bordered dt-responsive">
                      <thead>
                        <tr>
                            <tr>
                                            
                                            <th>Invoice No</th>
                                            <th width="10%">Date</th>
                                            <th width="60%">Customer Name</th>
                                            <th width="60%">Total price</th>
                                            <th width="60%">Balance Amount</th>
                                            <th width="60%">Amount Paid</th>
                                            <th width="60%">No.of Days</th>
                                            
                                            
                                        </tr>
                      </thead>
                      
                        <tbody >
                          <tr class="odd gradeX">
                          <% 
                        	  
                          while(rs.next()){
	%>

<%-- <td><%=rs.getString("DCNumber") %> --%>
<td>
	<a style="color: #35c335;" href="viewInvoice.jsp?dc=<%=rs.getString("DCNumber") %>&sd=<%=new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("Date") ) %>&branch=<%=rs.getString("Branch") %>&callingPage=ViewCollections.jsp"> <%=rs.getString("DCNumber")%></a> 
    	

</td>
<td width="60%"><%=new SimpleDateFormat("dd-MM-yyyy").format(rs.getDate("Date") )%></td>
<td width="60%"><%=rs.getString("CustomerName") %></td>
<td><%=rs.getInt("Totalprice") %></td>
<td><%=rs.getInt("BalanceAmount") %></td>
<td><%=rs.getInt("AmountPaid") %></td>
<td><%=rs.getInt("days") %></td>


</tr>
<%}
                                               %>
</tbody> </table></td>
<%}
                          else 
                          {
 %>
<td> Did not buy anything recently</td>
                                       
                                        <% }
 									
 									if(!rs2.isLast() && ((rs2.getRow() != 0) || rs2.isBeforeFirst()))	
 									{
 										
 									%>	
 										   <td><table width="100%" id="" class="table table-striped table-bordered">
                                           <thead>
                                             <tr>
                                                  <tr> 
                                                                 
                                                                 <th>Amount</th>
                                                                 <th>Discount</th>
                                                                 <th>Date</th>
                                                                 <th>Comments </th>

                                                             </tr>
                                           </thead>
                                             <tbody >
                                               <tr class="odd gradeX">
                                               <%while(rs2.next()){
                                             		 %>
                                               <td><%=rs2.getInt("Amount") %></td>
                                               <td><%=rs2.getInt("Discount") %></td>
                     <td><%=rs2.getString("Date") %></td>
                     <%
                     String comm="";
                    	 if(rs2.getString("Comments") == null) 
                     	comm="";
                     else
                     	comm=rs2.getString("Comments");%>
                     <td><%=comm %></td>
                    </tr>
                   <%}
                                               %>
                                                </tbody> </table></td>
                                                <% } 
                   else
                   {
             
                   %>
                   <td></td>
                                        </tr>
                                        <% }
}

//} 
}catch (Exception e) {
e.printStackTrace();
}
finally {
	     try {
	       if (statement != null)
	    	   statement.close();
	    
	       }  catch (SQLException e) {}
	       try {
	        if (connection != null)
	        	connection.close();
	        } catch (SQLException e) {}
	    }
%>

                      </tbody>
                    </table>
                  </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <footer>
          <div class="pull-right">
            KK Heavy Machinery 
          </div>
          <div class="clearfix"></div>
        </footer>
      </div>
    </div>

 

    <!-- jQuery -->
     <script src="vendors/jquery/dist/jquery.min.js"></script>
      <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <!-- Bootstrap -->
    <script src="vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="vendors/nprogress/nprogress.js"></script>
    <!-- iCheck -->
    <script src="vendors/iCheck/icheck.min.js"></script>
    <!-- Datatables -->
    <script src="vendors/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
    <script src="vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
    <script src="vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
    <script src="vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
    <script src="vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
    <script src="vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
    <script src="vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    

    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
    <script src="http://www.datejs.com/build/date.js" type="text/javascript"></script>
     <script>
    var ubran=document.getElementById('ubran').value;
    var role=document.getElementById('urole').value;
    var environment=document.getElementById('uenv').value;
    var path = window.location.pathname;
    var callingJSP = path.split("/").pop();
</script>
    <script>
function convert(str) {
    var date = new Date(str),
        mnth = ("0" + (date.getMonth()+1)).slice(-2),
        day  = ("0" + date.getDate()).slice(-2);
    return [ date.getFullYear(), mnth, day ].join("-");
}

function d(){

	 	var dr=document.getElementById('daterange').innerHTML;
    	if(dr!="Select Date Range")
    		{
    	var drv=dr.split('-');
    	var sdate = new Date(drv[0]);
    	
   // 	var std = sdate.toString("yyyy-MM-dd");
   var std=convert(sdate);

    	var edate = new Date(drv[1]);
 //   	var end = edate.toString("yyyy-MM-dd");
  var end=convert(edate);
    	document.getElementById('std').value=std;
    	document.getElementById('end').value=end;
    	
    	

    	localStorage.setItem("std", std);
    	localStorage.setItem("end", end);
    		}
    	if(dr=="Select Date Range")
    		{
    		localStorage.setItem("std", "");
        	localStorage.setItem("end", "");
    		}
    	localStorage.setItem("branch", document.getElementById('branch').value);

    	localStorage.setItem("daterange", document.getElementById('daterange').innerHTML);
    }
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");
	
	 var s = document.getElementById("branch");
	 
	// document.getElementById('sno').value=localStorage.getItem("sno");
	 document.getElementById('daterange').innerHTML=localStorage.getItem("daterange"); 
	 document.getElementById('std').value=localStorage.getItem("std"); 
	 document.getElementById('end').value=localStorage.getItem("end"); 
/* 
document.getElementById('single_cal3').value=localStorage.getItem("sd"); 

document.getElementById('da1').value=localStorage.getItem("pd");  */

	/*  document.getElementById('dc').value=localStorage.getItem("dc"); */

	    	// Loop through all the items in drop down list

	    	for (i = 0; i< s.options.length; i++)

	    	{ 
       
	    	if (s.options[i].value == localStorage.getItem("branch"))

	    	{
	    		/* if(s.options[i].value=="Bowenpally")
	    	s.selectedIndex=i+1;
	    		else */
	    		 	s.selectedIndex=i;
	    	break;

	    	}

	    	}
	    	localStorage.setItem("branch", "");
	    	localStorage.setItem("sno", ""); 
	    	localStorage.setItem("daterange", "Select Date Range"); 
	  /*   	localStorage.setItem("dc", ""); */
/* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
});
function filterColumn ( i ) {
    $('#ex').DataTable().column( i ).search(
        $('#col'+i+'_filter').val()
       
    ).draw();
}
$.fn.dataTable.ext.search.push(
	    function( settings, data, dataIndex ) {
	        var min = parseInt( $('#min').val(), 10 );
	        var amt = parseFloat( data[6] ) || 0; // use data for the age column
	 
	        if ( ( isNaN( min ) ) ||
	             ( min <= amt  ) )
	        {
	            return true;
	        }
	        return false;
	    }
	);
$(document).ready(function() {
	 $.getScript("js/rolePermissions.js");
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
/* 	var environment=document.getElementById('uenv').value;
	if(environment!=null && environment=="local")
		{
		$('.site_title').css('background-color', 'red');
		}
	else
		{
		$('.site_title').css('background-color', '');
		}
	if(role!=null && role!="1")
	{
		$( '[class*="admin"]' ).hide();
	}
	if(role!=null && role=="2")
	{
		$( '[class*="branch"]' ).hide();
 		var elements = document.getElementsByClassName('user');

	    for (var i = 0; i < elements.length; i++){
	        elements[i].style.display = "block";
	    }
	    if(ubran!=null && ((ubran=="Workshop")||(ubran=="Barhi")))
	    		document.getElementById("invAdj").style.display="block";
	    if(ubran!=null && ((ubran=="Workshop")||(ubran=="Workshop2")))
			{
			document.getElementById("mod").style.display="block";
			document.getElementById("grping").style.display="block";
			}
	}
	 if(role!=null && role=="3")
	{
		 $( '[class*="man"]' ).hide();
	} 
	

	if(role!=null && role=="4")
	{
		$( '[class*="store"]' ).hide();
	    
	}
	if(role!=null && role=="5")
	{
		$( '[class*="acc"]' ).hide();
	    
		document.getElementById("br").style.display="block";
	} */
	
	/*  var h= $('.right_col').min-height()+20;
	 $('.right_col').animate({height:h}, 500); */
var table=$('#ex').DataTable( {
	     
	        "iDisplayStart":0,
	        "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
	      // "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
	        "order": [[ 0, "desc" ]],
	         "columnDefs": [
	            { "visible": false, "targets": 0 }
	          ], 
	          "footerCallback": function ( row, data, start, end, display ) {
	              var api = this.api(), data;
	   
	              // Remove the formatting to get integer data for summation
	              var intVal = function ( i ) {
	                  return typeof i === 'string' ?
	                      i.replace(/[\$,]/g, '')*1 :
	                      typeof i === 'number' ?
	                          i : 0;
	              };
	   
	              // Total over all pages
	              total = api
	                  .column( 5 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Total over this page
	              pageTotal = api
	                  .column( 5, { page: 'current'} )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Update footer
	              $( api.column( 5 ).footer() ).html(
	                 pageTotal.toLocaleString('en-IN', {
		                	    maximumFractionDigits: 2,
		                	    style: 'currency',
		                	    currency: 'INR'
		                	}) +' ( '+  total.toLocaleString('en-IN', {
		                	    maximumFractionDigits: 2,
		                	    style: 'currency',
		                	    currency: 'INR'
		                	}) +' total)'
	              );
	              
	              total = api
                  .column( 4 )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );
   
              // Total over this page
              pageTotal = api
                  .column( 4, { page: 'current'} )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );
   
              // Update footer
              $( api.column( 4 ).footer() ).html(
                 pageTotal.toLocaleString('en-IN', {
	                	    maximumFractionDigits: 2,
	                	    style: 'currency',
	                	    currency: 'INR'
	                	}) +' ( '+  total.toLocaleString('en-IN', {
	                	    maximumFractionDigits: 2,
	                	    style: 'currency',
	                	    currency: 'INR'
	                	}) +' total)'
              );
              
              total = api
              .column( 3 )
              .data()
              .reduce( function (a, b) {
                  return intVal(a) + intVal(b);
              }, 0 );

          // Total over this page
          pageTotal = api
              .column( 3, { page: 'current'} )
              .data()
              .reduce( function (a, b) {
                  return intVal(a) + intVal(b);
              }, 0 );

          // Update footer
          $( api.column( 3 ).footer() ).html(
             pageTotal.toLocaleString('en-IN', {
                	    maximumFractionDigits: 2,
                	    style: 'currency',
                	    currency: 'INR'
                	}) +' ( '+  total.toLocaleString('en-IN', {
                	    maximumFractionDigits: 2,
                	    style: 'currency',
                	    currency: 'INR'
                	}) +' total)'
          );
	          },
	          
	          scrollY:        '53vh',
		        scrollCollapse: true,
	    /*     "createdRow": function ( row, data, index ) {
	           
	                $('td', row).eq(5).addClass('highlight');}, */
	      
	        dom: 'Blfrtip' ,
	        buttons: [
	            'copy', 'excel', 'pdf', 'print'
	        ] 
	    } );
$('input.column_filter').on( 'keyup click', function () {
    filterColumn( $(this).attr('data-column') );
} );
$('select.column_filter').on( 'change', function () {
    filterColumn( $(this).attr('data-column') );
} );

$('#min').keyup( function() {
    table.draw();
} );
} );
</script>
  </body>
</html>