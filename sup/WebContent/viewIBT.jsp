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
DataSource ds = null;
Connection connection = null;
Statement statement = null;
Statement st = null;
ResultSet resultSet = null;
ResultSet rs = null;
%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- IBT</title>

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
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>IBT <!-- <small>Some examples to get you started</small> --></h1>
              </div>
              <div class="clearfix"></div>
<form id="FormId" action="viewIBT.jsp" method="post" class="form-horizontal form-label-left">
       <div class="col-md-4 col-sm-6 col-xs-12">
                        <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                          <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                          <span id="daterange"></span> <b class="caret"></b>
                            <input id="std" name="std" class="form-control col-md-7 col-xs-12" type="hidden" > 
                  <input id="end" name="end" class="form-control col-md-7 col-xs-12" type="hidden" > 
                        </div>   
                        </div>   
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="sno" style=" margin-left:-7% "> Code:</label>
                        <div class="col-md-1 col-sm-3 col-xs-3">
                          <input type="text" id="code" class="form-control col-md-7 col-xs-12" name="code">
                        </div>     
              <button type="submit" class="btn btn-success " onclick="d()">Go </button>
       
                         <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                       <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
                        </form>
            <div class="clearfix"></div>
           
<% /*  String branch = request.getParameter("branch");
String Tbranch = request.getParameter("Tbranch"); */
                   /* if(branch ==null)
                	   branch="Select a Branch"; */
                   %>
             <div class="hide4acc&store&man" style=" float:right; margin-right: 10px;">

              <a class="hide4acc&store" href="ibtform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a  href="viewIBT.jsp"> <button type="button" class="btn btn-info">View </button></a>
                   
                   <a class="hide4acc&store" href="editIBT.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Edit</button></a>
             </div>       

            <br/>
        <br/>
      <br/> 
<div class="table-responsive"> 
                  <table class="table" >
       
        <tbody>
          
            <tr id="filter_col" >
         
                <td align="center">Date: <input type="text" class="column_filter" id="col2_filter" data-column="2"></td>
        
          <!--   </tr>
            <tr id="filter_col4" data-column="4"> -->
               <!--  <td>Date</td> -->
                <td align="center">IBT Number: <input type="text" class="column_filter" id="col1_filter" data-column="1"></td>
              
            <!-- </tr>
            <tr id="filter_col5" data-column="5"> -->
               <!--  <td>Type</td> -->
                <td align="center">From Branch: <input type="text" class="column_filter" id="col3_filter" data-column="3"></td>
               
           <!--  </tr>
            <tr id="filter_col6" data-column="6"> -->
                <!-- <td>Description</td> -->
                <td align="center">To Branch: <input type="text" class="column_filter" id="col4_filter" data-column="4"></td>
  
       
  
            </tr>
        </tbody></table></div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View IBT</h2>
              
  <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                        <tr>
                            <tr>
                            <th>Id</th>
                            <!-- <th>Sno</th> -->
                                            <th>IBT Number</th>
                                            <th>Date</th>
                                            <th>From Branch</th>
                                            <th>To Branch</th>
                                            <th>Total Quantity</th>
                                            <th>Total Price</th>
                                            <th>Tax</th>
                                             <th>Total IBT</th>
                                             <th>Invoice Details</th> 

                                        </tr>
                      </thead>
                          <tfoot>
            <tr >
                <th colspan="6" style="text-align:right">Total :</th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                
            </tr>
        </tfoot>
                        <tbody id="country">
<%
try{ 
	/*  Context context = new InitialContext();
	  Context envCtx = (Context) context.lookup("java:comp/env");
	  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
	  if (ds != null) {
		  connection = ds.getConnection(); */
		 
		  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	 	   //  connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
		 if (driver != null) {
        		Class.forName(driver).newInstance();  
    		}  
	 	  

    		connection = DriverManager.getConnection(url, username, password);
	 	     statement=connection.createStatement();
st=connection.createStatement();

String std=request.getParameter("std");
String end=request.getParameter("end");
String code=request.getParameter("code");	
String sqlc="";
String sql ="SELECT * FROM IBT where 1";
String sqlf ="SELECT * FROM IBT where Month(Date) in( Month(CURDATE())) and year(Date) in (year(CURDATE()))";
int sno=1;
if(code!=null && code.length()!=0)
{
sqlc="SELECT *, IBTDetails.Qty as 'tq' From IBT inner join IBTDetails on IBT.Id=IBTDetails.IBT where IBT.Id in(SELECT IBT FROM IBTDetails where Code='"+code+"') and IBTDetails.Code='"+code+"'";
}
String whr1="";

if(std!=null && std.length()!=0)
	whr1+=" and Date between '"+std+"' and '"+end+"'";

sql+=whr1;
sqlc+=whr1;

if(code!=null && code.length()!=0)
{
resultSet = statement.executeQuery(sqlc);
}
else if(std!=null && std.length()!=0)
{
resultSet = statement.executeQuery(sql);	
}
else
{
resultSet = statement.executeQuery(sqlf);
}

while(resultSet.next()){
	String sql2="SELECT IBTDetails.Code, CodeList.HSNCode, CodeList.Description, CodeList.Machine, CodeList.PartNo, CodeList.Grp, CodeList.MinPrice, IBTDetails.Qty, IBTDetails.Id,IBTDetails.SalePrice FROM IBTDetails inner join CodeList on IBTDetails.Code=CodeList.Code where IBTDetails.IBT=";
	
	int	primaryKey = resultSet.getInt("Id");
	String whr=primaryKey+"";
	sql2+=whr;
	/* if(code!=null && code.length()!=0)
		sql2+=" and IBTDetails.Code='"+code+"'";  */
	int sno2=1;
	rs = st.executeQuery(sql2);
	Date date=resultSet.getDate("Date");
	String ibtno=resultSet.getString("IBTNo");
%>
                                        <tr class="odd gradeX">
                                        <td><%=resultSet.getString("Id") %></td>
<%-- <td><%=sno%></td>      --%>                                     
<td><%=ibtno %></td>
<td width="20%"><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td width="40%"><%=resultSet.getString("FromBranch") %></td>
<td width="50%"><%=resultSet.getString("ToBranch") %></td>
<td><%=resultSet.getFloat("TotalQty") %></td>
<% if(ibtno.contains("T")||ibtno.contains("t"))
{%> 
<td width="50%"><%=resultSet.getInt("TotalPrice") %></td>
<td width="50%"><%=resultSet.getInt("Tax") %></td>
<%}else{ %>
<td></td> 
<td></td>
<%} %>
<%if(code!=null && code.length()!=0){%>
<td><%=resultSet.getInt("tq") %></td>
<%}else {%>
<td></td>
<%} %>

<td><table id="" class="table table-striped table-bordered dt-responsive">
                      <thead>
                        <tr>
                            <tr>
                                            <th>Sno</th>
                                            <th>Code</th>
                                            <th>HSNCode</th>
                                            <th>Description</th>
                                            <th>Machine</th>
                                            <th>Part No</th>
                                            <th>Group</th>
                                            <th>IBT Price</th>
                                            <th>Quantity</th>

                                        </tr>
                      </thead>
                  
                        <tbody >
                          <tr class="odd gradeX">
                          <% while(rs.next())
{
	%>
<td><%=sno2++%></td> 
<td><%=rs.getString("IBTDetails.Code") %></td>
<td><%=rs.getString("CodeList.HSNCode") %></td>
<td width="80%"><%=rs.getString("Description") %></td>
<td width="80%"><%=rs.getString("Machine") %></td>
<td width="80%"><%=rs.getString("PartNo") %></td>
<td><%=rs.getString("Grp") %></td>
<% if(ibtno.contains("T")||ibtno.contains("t"))
{%> 
<td><%=rs.getInt("SalePrice") %></td> 
<%}else{ %>
<td><%=rs.getInt("MinPrice") %></td> 
<%} %>
<td><%=rs.getFloat("IBTDetails.Qty") %></td>
</tr>
 <% }%>
</tbody> </table></td>

                                        
                   
                                        <%
                                        whr="";
                                        sno++;
}
	 // }
} catch (Exception e) {
e.printStackTrace();
}
finally {
	     try {
	       if (st != null)
	        st.close();
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


	localStorage.setItem("daterange", document.getElementById('daterange').innerHTML);
 	localStorage.setItem("code", document.getElementById('code').value);
}
$(window).load(function () {
 $(".se-pre-con").fadeOut("slow");
 document.getElementById('daterange').innerHTML=localStorage.getItem("daterange"); 
 document.getElementById('std').value=localStorage.getItem("std"); 
 document.getElementById('end').value=localStorage.getItem("end"); 
 document.getElementById('code').value=localStorage.getItem("code"); 
 
    	localStorage.setItem("daterange", "Select Date Range"); 
  /*   	localStorage.setItem("dc", ""); */
/* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
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
	 $.getScript("js/rolePermissions.js");
	var ubran=document.getElementById('ubran').value;
  	var role=document.getElementById('urole').value;
	/* var environment=document.getElementById('uenv').value;
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

		//document.getElementById("br").style.display="block";
	} */
	var table=$('#ex').DataTable( {
	     
        "iDisplayStart":0,
        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
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
   
              // Total over all pages
              total = api
                  .column( 8 )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );
   
              // Total over this page
              pageTotal = api
                  .column( 8, { page: 'current'} )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );
   
              // Update footer
              $( api.column( 8 ).footer() ).html(
            		  pageTotal+' ( '+ total+' total)'
              );
          },
          scrollY:        '53vh',
	        scrollCollapse: true,
    /*     "createdRow": function ( row, data, index ) {
           
                $('td', row).eq(5).addClass('highlight');}, */
      
        dom: 'lfrtip'/* ,
        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ] */
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

</body>
</html>