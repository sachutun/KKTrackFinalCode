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

    <title>KK Track- Purchase Outstanding</title>

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
           <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
               <div class="menu_section">
              
                     <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home </a>
                    
                  </li>
                  <li class="hide4store"><a><i class="fa fa-inr"></i> Expenses <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                         <li class="hide4acc&store" ><a href="expenseform.jsp">Add New Expense</a></li>
                      <li class="hide4store"><a href="expenses.jsp">View Expenses</a></li>
                      <li class="hide4store"><a href="PurchaseCost.jsp">View Purchase Costs</a></li>
                       <li class="hide4store"><a href=CashTransfer.jsp>View Cash Transfers</a></li>
                    </ul>
                  </li>
                 <li class="hide4acc&store"><a><i class="fa fa-shopping-cart"></i> Purchase <span class="fa fa-chevron-down"></span></a>
                  <ul class="nav child_menu">
                      <li class="admin"><a href="addpurchase.jsp">Add New Purchase</a></li>
                      <li  class="hide4store"><a href="viewpurchase.jsp">View Purchase</a></li>
                      <li  class="hide4store"><a href="creditpurchase.jsp">Credit Purchase</a></li>
                      <li  class="hide4store"><a href="printpurchase.jsp">Print Purchase</a></li>
                      <li  class="admin"><a href="printpurchaseRecord.jsp">Print Purchase Admin</a></li>
                      <li class="hide4store"><a>Purchase Returns</a>
                      <ul class="nav child_menu">
                      <li class="hide4store"><a href="viewpurchasereturn.jsp">View Returned Purchase items</a></li>
                      <li class="admin"><a href="purchasereturn.jsp">Enter Returned Purchase items</a></li>
                    </ul>
                      </li>
                    </ul>
                  </li>
                  <li class="hide4store"><a><i class="fa fa-table"></i> Sales <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li class="hide4acc&store"><a href="addsale.jsp">Add New Sale</a></li>
                      <li  class="hide4store"><a href="viewsale.jsp">View Sale</a></li>
                      <li class="hide4acc&store"><a href="creditsale.jsp">Credit Sale</a></li>
                      <li class="hide4acc&store"><a href="creditalert.jsp">Credit Alert</a></li>
                      <li class="hide4acc&store"><a href="printsale.jsp">Print Sale</a></li>
                      <li class="hide4acc&store"><a>Sale Returns <span class="fa fa-chevron-down"></span></a>
                      <ul class="nav child_menu">
                      <li><a href="viewsalereturn.jsp">View Returned Sale items</a></li>
                      <li><a href="saleReturn.jsp">Enter Returned Sale items</a></li>
                    </ul>
                      </li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart-o"></i> Inventory <span class="fa fa-chevron-down"></span></a>
                   <ul class="nav child_menu">
                   <li ><a href="viewinventory.jsp">View Stock</a></li>
                   <li class="hide4branch"><a href="viewinvbal.jsp">View Overall Stock</a></li>
                   <li ><a href="CodeList.jsp">View Code List</a></li>
                   <li class="hide4acc&store" ><a href="inventoryAdjustment.jsp">Inventory Adjustment</a></li>
                      <li class="admin"><a href="AddCode.jsp">Add New Code</a></li>
                      </ul>
                  </li>
                  <li><a><i class="fa fa-truck"></i> Branch Transfer <span class="fa fa-chevron-down"></span></a>
                     <ul class="nav child_menu">
                      <li class="hide4acc&store"><a href="ibtform.jsp">IBT Form</a></li>
                      <li><a href="viewIBT.jsp">View IBT</a></li>
                      <li class="hide4acc&store"><a href="printingibt.jsp">Print IBT</a></li>
                    </ul>
                 </li>
                
                </ul>
              </div>

            </div>
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
                <h1>Purchase OB <!-- <small>Some examples to get you started</small> --></h1>
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

                        <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> </form>
                         <br/>
        <br/>
                <br/>
            
              
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
                    <h2>View Purchase OB</h2>
                    
               <%  String branch = request.getParameter("branch");
            
               if(role!=null && !(role.equals("1")))
            	   branch=uBranch; 
               if(branch!=null && branch.equals("All"))
               branch="";
                   %>
                    <label style="float:right" id><%= branch %></label>
  <div class="clearfix"></div>
  
                  </div>
                  <div class="x_content">
                  <form action="saledit.jsp">   
                 <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                       
                            <tr>
                                          
                                            <th>Sno</th>
                                            <th>Name</th>
                                            <th>Amount</th>
                                            <th>Pay</th>
                                        </tr>
                                        
                      </thead>
                     <tfoot>
            <tr>
                <th style="text-align:right">Total:</th>
                <th></th>
                <th></th>
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

if(branch!="" && branch!=null)
	whr+=" and Branch='"+branch+"'";
sql+=whr;

statement=connection.createStatement();

resultSet = statement.executeQuery(sql);
	
while(resultSet.next()){
	
	/* Date date=resultSet.getDate("Date"); */
%>
                                        <tr class="odd gradeX">
                                        <td><%=resultSet.getString("Id")  %></td>
                                        
<td><%=resultSet.getString("Name") %></td>

<td><%=resultSet.getInt("Amount") %></td>
   <td>  <div class="col-md-4 col-sm-3 col-xs-4 ">
               <label for="pay"> Amount:</label>
                <input type="text" id="pay" name="pay" style="margin-left: 7%;width: 40%;" min="0" max=<%=resultSet.getString("Amount")%>> 
             </div>
             <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="dis"> Discount:</label>
                <input type="text" id="dis" value="0" name="dis" style="margin-left: 7%;width: 40%;"> 
             </div>
               <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="pdate"> Date:</label>
                <input type="text" id="pdate" name="pdate" style="margin-left: 7%;width: 60%;"> 
             </div><button type="submit" class="btn btn-success" style="float:right">Pay</button></td>
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
                  </div></form>
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
    <!-- bootstrap-datetimepicker -->    
    
    <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>

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
	}
	/* if(role!=null && role=="3")
	{
		var elements = document.getElementsByClassName('userv');

		for (var i = 0; i < elements.length; i++){
    		elements[i].style.display = "none";
		}
	} */

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
	                  .column( 2 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Total over this page
	              pageTotal = api
	                  .column( 2, { page: 'current'} )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Update footer
	              $( api.column( 2 ).footer() ).html(
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