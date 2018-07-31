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
DataSource ds = null;
Connection connection = null;
Statement statement = null;
Statement st = null;
Statement st2 = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs2 = null;

%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- Sales</title>

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
<script language="javascript" type="text/javascript">  
 var xmlHttp  
 var xmlHttp
 function showState(){ 
if (typeof XMLHttpRequest != "undefined"){
   xmlHttp= new XMLHttpRequest();
       }
       else if (window.ActiveXObject){
   xmlHttp= new ActiveXObject("Microsoft.XMLHTTP");
       }
if (xmlHttp==null){
    alert ("Browser does not support XMLHTTP Request")
return
} 

var url="salefilter.jsp";
var str=document.getElementById("branch").value;
var d=document.getElementById("da1").value;
var code=document.getElementById("code").value;

url += "?branch="+str+"&Date="+d+"&code=" +code;
xmlHttp.onreadystatechange = stateChange;
xmlHttp.open("GET", url, true);
xmlHttp.send(null);
}
 function stateChange(){   
 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 var data=xmlHttp.responseText;
	 document.getElementById("datatable-buttons").innerHTML="";
	 document.getElementById("datatable-buttons").innerHTML=data;
 }   
 }
  
 </script>  
  <body class="nav-md">
   <!--  <div class="se-pre-con"></div> -->
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="viewinventory.jsp" class="site_title"><i class="fa fa-line-chart"></i> <span>KK Track</span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
          <!--   <div class="profile clearfix">
              <div class="profile_pic">
                <img src="images/img.jpg" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Welcome,</span>
                <h2>Krishna Kolluri</h2>
              </div>
            </div> -->
            <!-- /menu profile quick info -->

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

String user=(String)session.getAttribute("user"); 
String uBranch=(String)session.getAttribute("ubranch");
String role=(String)session.getAttribute("role");
if(user==null)
	response.sendRedirect("login.jsp");

/* System.out.println("Branch "+uBranch); */

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
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>Sales <!-- <small>Some examples to get you started</small> --></h1>
              </div>
 <form id="FormId" action="viewsale.jsp" method="post" class="form-horizontal form-label-left">
                  
                <!--   <label class="control-label col-md-1 col-sm-1 col-xs-2" for="dc"> DCNumber:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="text" id="dc"  class="form-control col-md-7 col-xs-12" name="dc" >
                        </div>
                       <label class="control-label col-md-1 col-sm-1 col-xs-2" for="dc"> Customer Name:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="text" id="cn" class="form-control col-md-7 col-xs-12" name="cn" >
                        </div> -->
                        <div class="col-md-9 col-sm-5 col-xs-12">
      
             <div class="col-md-3 col-sm-3 col-xs-6" style=" margin-top: 1%">
                          <select class="select2_single form-control admin" tabindex="-1" name="branch" id="branch" >
                            <option value="">Select A Branch</option>
                            <option value="">All Branches</option>
                                  <option value="Bowenpally">Bowenpally</option>
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
                            <option value="Chittoor">Chittoor</option>
                          </select>
                        </div>
                        <button type="submit" class="btn btn-success admin" onclick="d()" style="margin-top: 1%">Go </button>
                       </div>
                        <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                        </form>
                      
                           <br/>
            <div class="clearfix"></div>
    
<%  String branch = request.getParameter("branch");
if(role!=null && !(role.equals("1")))
	   branch=uBranch; 

                   %>
            <div style=" float:right; margin-right: 10px; margin-top:-50px">

            <a href="addsale.jsp"><button type="button" class="btn btn-success">Add </button></a>

                  <a href="viewsale.jsp" style="color:white;">  <button type="button" class="btn btn-info">View </button></a>

                 <a href="editSale.jsp" style="color:white;">   <button type="button" class="btn btn-warning admin">Edit</button></a>
                  <a href="saleReturn.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Return</button></a>
             </div>        

            <br/>
        <div class="table-responsive"> 
                  <table class="table" >
       
        <tbody>
          
            <tr id="filter_col" >
         
                <td align="center">Date: <input type="text" class="column_filter" id="col2_filter" data-column="2"></td>
        
          <!--   </tr>
            <tr id="filter_col4" data-column="4"> -->
               <!--  <td>Date</td> -->
                <td align="center">DC Number: <input type="text" class="column_filter" id="col3_filter" data-column="3"></td>
              
            <!-- </tr>
            <tr id="filter_col5" data-column="5"> -->
               <!--  <td>Type</td> -->
                <td align="center">Customer Name: <input type="text" class="column_filter" id="col4_filter" data-column="4"></td>
               
           <!--  </tr>
            <tr id="filter_col6" data-column="6"> -->
                <!-- <td>Description</td> -->
                <td align="center">Type: <input type="text" class="column_filter" id="col8_filter" data-column="8"></td>
  
       
  
            </tr>
        </tbody></table></div>

            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View Sale</h2>
              
  <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  
                     <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                        <tr>
                            <tr>
                            <th>Id</th>
                                            <th>Branch</th>
                                            <th>Date</th>
                                            <th>DC Number</th><!-- 
                                            <th>Code</th>
                                            <th>Description</th>
                                            <th>Sale Price</th>
                                            <th>Quantity</th> -->
                                            <th>Customer Name</th>
                                            <th>Customer Number</th>
                                            <th>Total price</th>
                                            <th>Amount Paid</th>
                                            <th>Type</th>
                                       
                                             <th>Details</th> 
                                             <th>Additional Details </th>
                                        
                                        </tr>
                      </thead>
                           <tfoot>
            <tr class="admin">
                <th colspan="6" style="text-align:right">Total Sale:</th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </tfoot>
                        <tbody id="country">


                                        <tr class="odd gradeX">



<td><table id="" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                            <tr>
                                            
                                            <th>Code</th>
                                            <th>Description</th>
                                            <th>Machine</th>
                                            <th>Part No</th>
                                            <th>Group</th>
                                            <th>Quantity</th>
                                            <th>Sale Price</th>
                                            <th>Total</th>
                                            <th class="admin">LC</th> 
                                            <th>Max Price</th>

                                        </tr>
                      </thead>
                      
                        <tbody >
                          <tr class="odd gradeX">
                       
</tbody> </table></td>



<%-- <td><button type="button" class="btn btn-success" style="margin-bottom: 1px;margin-left: 2%; " onclick="showDet(<%=primaryKey%>)">View </button></td> --%>
                                       


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
    <!-- bootstrap-datetimepicker -->    
    
    <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
    <script>
jQuery(function(){
$("#code").autocomplete("dem.jsp");
});
</script>
<script>
function showDet(i)
{
	if(document.getElementById(i).style.display=="none")
	document.getElementById(i).style.display="block";
	else
		document.getElementById(i).style.display="none";
}
</script>
 
<script>
function filterColumn ( i ) {
    $('#ex').DataTable().column( i ).search(
        $('#col'+i+'_filter').val()
    ).draw();
}
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
	var table=$('#ex').DataTable( {
        "bProcessing": true,
        /* "sDom": 'prtp',   */
        "processing": true,
        "language": {
            "sProcessing" : '<img src="images/Preloader_2.gif"  style="z-index:60000000; margin-top:20%"/> '},
            
            "bServerSide": true,
        "iDisplayStart":0,
        "columnDefs": [
            { "targets": [1], "searchable": false }
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
                .column( 6 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
 
            // Total over this page
            pageTotal = api
                .column( 6, { page: 'current'} )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
 
            // Update footer
            $( api.column( 6 ).footer() ).html(
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
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
        "sAjaxSource":"viewsaleserver.jsp?ubranch="+ubran+"&role="+role,
        scrollY:        '50vh',
        scrollCollapse: true,
    /*     "createdRow": function ( row, data, index ) {
           
                $('td', row).eq(5).addClass('highlight');}, */
      
        dom: 'Blfrtip',
        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ]
    } );

	    
$('input.column_filter').on( 'keyup click', function () {
    filterColumn( $(this).attr('data-column') );
} );
} );
  $("#FormId").submit( function(e) {
	  loadAjax();
	  e.returnValue = false;
	  return false;
	});  
function dch(val) { 
  var d=document.getElementById(val).value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
if(val=="single_cal3")
  document.getElementById('da1').value=da;
else
	document.getElementById('da2').value=da;
	
}
</script>
<script type='text/javascript'>
function d(){
	localStorage.setItem("branch", document.getElementById('branch').value);
/*    	localStorage.setItem("sd", document.getElementById('single_cal3').value);
	localStorage.setItem("pd", document.getElementById('da1').value); */
	/* localStorage.setItem("dc", document.getElementById('dc').value); */
}
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");

	 var s = document.getElementById("branch");
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
	  /*   	localStorage.setItem("sd", ""); */
	  /*   	localStorage.setItem("dc", ""); */
/* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
});
</script> 
</body>
</html>