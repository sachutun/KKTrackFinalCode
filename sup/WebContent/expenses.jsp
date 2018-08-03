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
ResultSet resultSet = null;
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

    <title>KK Track- Expenses</title>

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
                <h1>Expenses <!-- <small>Some examples to get you started</small> --></h1>
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

          
<form action="expenses.jsp" method="get" class="form-horizontal form-label-left" onsubmit="d()">
  <div class="col-md-4 col-sm-6 col-xs-12">
                        <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                          <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                          <span id="daterange"></span> <b class="caret"></b>
                            <input id="std" name="std" class="form-control col-md-7 col-xs-12" type="hidden" > 
                  <input id="end" name="end" class="form-control col-md-7 col-xs-12" type="hidden" > 
                        </div>
                      </div>
 <label class="control-label col-md-1 col-sm-1 col-xs-2" for="sno" style="/* margin-left:-7% */"> SNo:</label>
                        <div class="col-md-1 col-sm-3 col-xs-3">
                          <input type="text" id="sno" class="form-control col-md-7 col-xs-12" name="sno">
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
                            
                            <option value="KKExpenses">KKExpenses</option>
                             <!--  <option value="Bowenpally">Bowenpally</option>
                            <option value="Miyapur">Miyapur</option>
                            <option value="LBNagar">LB Nagar</option>
                            <option value="Workshop">Workshop</option>
                            <option value="Workshop2">Workshop 2</option>
                            <option value="Vishakapatnam">Vishakapatnam</option>
                            <option value="Bhubhaneshwar">Bhubhaneshwar</option>
                            <option value="Vijayawada">Vijayawada Old</option>
                            <option value="Vijayawadan">Vijayawada New</option>
                            <option value="Rajahmundry">Rajahmundry</option>
                            <option value="Tekkali">Tekkali</option>
                           <option value="Barhi">Barhi</option>
                            <option value="Udaipur">Udaipur</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Chittoor">Chittoor</option> -->
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
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> </form>
                         <br/>
        <br/>
                <br/>
                 <div style=" float:right; margin-right: 10px; margin-top: -5%">         
              <a class="hide4acc" href="expenseform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="expenses.jsp"> <button type="button" class="btn btn-info">View </button></a>

                 <a class="hide4acc" href="editexpense.jsp">   <button type="button" class="btn btn-warning">Edit</button></a>
                 
                 <a href="CashTransfer.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Cash Transfers</button></a>
             <a class="ws" href="PurchaseCost.jsp" style="color:white;">   <button type="button" class="btn btn-info" >Purchase Costs</button></a>
             </div>      
              
 <div class="table-responsive"> 
                  <table class="table" >
       
        <tbody>
          
            <tr id="filter_col" >
               <!--  <td>Sno</td> -->
             <!--    <td align="center">Sno: <input type="text" class="column_filter col-md-7" id="col1_filter" data-column="1"></td> -->
          
           <!--  </tr>
            <tr id="filter_col2" data-column="2"> -->
               <!--  <td>Branch</td> -->
             <!--    <td align="center">Branch: <input type="text" class="column_filter" id="col2_filter" data-column="2"></td> -->
              
        <!--     </tr>
            <tr id="filter_col3" data-column="3"> -->
               <!--  <td>Name</td> -->
                <td align="center">Name: <input type="text" class="column_filter" id="col3_filter" data-column="3"></td>
        
          <!--   </tr>
            <tr id="filter_col4" data-column="4"> -->
               <!--  <td>Date</td> -->
           <!--      <td align="center">Date: <input type="text" class="column_filter" id="col4_filter" data-column="4"></td> -->
              
            <!-- </tr>
            <tr id="filter_col5" data-column="5"> -->
               <!--  <td>Type</td> -->
                <td align="center">Type:   <select class="column_filter " tabindex="-1"  id="col5_filter" data-column="5" style="border: 1px solid #ccc;background-color: white;">
                            <option></option>
                            <option value="Rent">Rent</option>
                            <option value="Salary">Salary</option>
                            <option value="Conveyance">Conveyance</option>
                            <option value="Refreshments">Refreshments</option>
                            <option value="Food&Water">Food & Water</option>
                            <option value="TelephoneBill">Telephone Bill</option>
                            <option value="Transport">Transport</option>
                            <option value="VehicleService">Vehicle Service</option>
                            <option value="TourExpense">Tour Expenses</option>
                            <option value="Labour&Hamali">Labour Or Hamali</option>
                            <option value="Stationery">Stationery</option>
                            <option value="Steel">Steel</option>
                            <option value="Repair">Repair</option>
                            <option value="Commission">Commission</option>
                            <option value="ElectricityBill">Electricity Bill</option>
                            <option value="Courier">Courier</option>
                            <option value="Interest">Interest On Loans</option>
                            <option value="CreditCard">Credit Card Expenses</option>
                            <option value="Building">Building Maintenance</option>
                            <option value="Others">Others</option>
                          </select></td>
               
           <!--  </tr>
            <tr id="filter_col6" data-column="6"> -->
                <!-- <td>Description</td> -->
                <td align="center">Description: <input type="text" class="column_filter" id="col6_filter" data-column="6"></td>
  
           <!--  </tr>
             <tr id="filter_col7" data-column="7"> -->
               <!--  <td>Amount</td> -->
                <td align="center">Amount: <input type="text"  id="min" ></td>
  
            </tr>
        </tbody></table></div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View Expenses</h2>
                    
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
                    <label style="float:right" id><%= branch %></label>
  <div class="clearfix"></div>
  
                  </div>
                  <div class="x_content">
                 
                 <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                       
                            <tr>
                                            <th>Id</th>
                                            <th>Sno</th>
                                            <th>Branch</th>
                                            <th>Name</th>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Description</th>
                                            <th width="20%">Amount</th>

                                        </tr>
                                        
                      </thead>
                      <tfoot>
            <tr>
                <th colspan="7" style="text-align:right">Total:</th>
                <th></th>
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
    Class.forName("com.mysql.jdbc.Driver").newInstance();  
     connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");     
statement=connection.createStatement();

String sql ="SELECT * FROM Expenses where 1";
String whr="";
if(sn!=null && sn.length()!=0)
	whr+=" and Id="+sn;
if(std!=null && std.length()!=0)
	whr+=" and Date between '"+std+"' and '"+end+"'";
if(branch!="" && branch!=null)
	whr+=" and Branch='"+branch+"'";
sql+=whr;

statement=connection.createStatement();

resultSet = statement.executeQuery(sql);
	
while(resultSet.next()){
	
	Date date=resultSet.getDate("Date");
%>
                                        <tr class="odd gradeX">
                                        <td><%=resultSet.getString("Date") %></td>
                                        <td><%=resultSet.getString("Id")  %></td>
                                          <td><%=resultSet.getString("Branch") %></td>
<td><%=resultSet.getString("Name") %></td>
<td width="10%"><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td><%=resultSet.getString("Type") %></td>
<td><%=resultSet.getString("Description") %></td>
<td><%=resultSet.getInt("Amount") %></td>
                                        </tr>
                                        <% 
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
    function d(){

    	var dr=document.getElementById('daterange').innerHTML;
    	if(dr!="Select Date Range")
    		{
    	var drv=dr.split('-');
    	var sdate = new Date(drv[0]);
    	var std = sdate.toString("yyyy-MM-dd");
    	var edate = new Date(drv[1]);
    	var end = edate.toString("yyyy-MM-dd");
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
	 document.getElementById('sno').value=localStorage.getItem("sno");
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
	        var amt = parseFloat( data[7] ) || 0; // use data for the age column
	 
	        if ( ( isNaN( min ) ) ||
	             ( min <= amt  ) )
	        {
	            return true;
	        }
	        return false;
	    }
	);
$(document).ready(function() {
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	if(role!=null && role!="1")
	{
		var elements = document.getElementsByClassName('admin');

    		for (var i = 0; i < elements.length; i++){
        		elements[i].style.display = "none";    		
    		}
	
	}
	if(role!=null && role=="2")
	{
		var elements = document.getElementsByClassName('hide4branch');

   		 for (var i = 0; i < elements.length; i++){
        		elements[i].style.display = "none";
    		}
 		var elements = document.getElementsByClassName('user');

	    for (var i = 0; i < elements.length; i++){
	        elements[i].style.display = "block";
	    }
	    if(ubran!=null && ubran=="Workshop")
	    		document.getElementById("invAdj").style.display="block";
	}
	/* if(role!=null && role=="3")
	{
		var elements = document.getElementsByClassName('userv');

		for (var i = 0; i < elements.length; i++){
    		elements[i].style.display = "none";
		}
	} 
	*/

	if(role!=null && role=="4")
	{
		var elements = document.getElementsByClassName('hide4store');

		for (var i = 0; i < elements.length; i++){
    			elements[i].style.display = "none";
	    }
		var elements1 = document.getElementsByClassName('hide4acc&store');

		for (var j = 0; j < elements1.length; j++){
    			elements1[j].style.display = "none";
	    }
	    
	}
	if(role!=null && role=="5")
	{
		var elements = document.getElementsByClassName('hide4acc&store');

		for (var i = 0; i < elements.length; i++){
    			elements[i].style.display = "none";
		}
		var elements1 = document.getElementsByClassName('hide4acc');

		for (var j = 0; j < elements1.length; j++){
    			elements1[j].style.display = "none";
	    }
	    
		document.getElementById("br").style.display="block";
	}
	
	/*  var h= $('.right_col').min-height()+20;
	 $('.right_col').animate({height:h}, 500); */
var table=$('#ex').DataTable( {
	     
	        "iDisplayStart":0,
	        "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
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
	                  .column( 7 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Total over this page
	              pageTotal = api
	                  .column( 7, { page: 'current'} )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Update footer
	              $( api.column( 7 ).footer() ).html(
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