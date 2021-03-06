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

    <title>KK Track- Group Sales</title>

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
#grpDiv {
    position:relative;
    height:30px;
    width:200px;
}
#grpDiv select {
    position:absolute;
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
             <%! String includeMenuPage= "sidebarMenu.html"; %>
			<jsp:include page="<%= includeMenuPage %>"></jsp:include>
              
          </div>
        </div>
<%   

String user=(String)session.getAttribute("user"); 
String uBranch=(String)session.getAttribute("ubranch");
String role=(String)session.getAttribute("role");
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
              <div class="clearfix"></div>
 <form id="FormId" action="groupSale.jsp" method="post" class="form-horizontal form-label-left">
             <div class="col-md-4 col-sm-6 col-xs-12">
                        <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                          <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                          <span id="daterange"></span> <b class="caret"></b>
                            <input id="std" name="std" class="form-control col-md-7 col-xs-12" type="hidden" > 
                  <input id="end" name="end" class="form-control col-md-7 col-xs-12" type="hidden" > 
                        </div>
                      </div>
  <%
  if (driver != null) {
      Class.forName(driver).newInstance();  
  }
  connection = DriverManager.getConnection(url, username, password);
  st=connection.createStatement();
  //String query1="Select DISTINCT(Grp) FROM CodeList where Grp <>''";
  rs2 =st.executeQuery("Select DISTINCT(Grp) FROM CodeList where Grp <>''");%>
                     
 <label class="control-label col-md-1 col-sm-1 col-xs-2" for="sno" style=" margin-left:-7% "> Group:</label>
                        <div id="grpDiv" class="col-md-2 col-sm-4 col-xs-4">
                         <!-- <input type="text" id="grp" class="form-control col-md-7 col-xs-12" name="grp"> -->
							<select class="form-control col-md-7 col-xs-12" name="grp" id="grp" onmousedown="if(this.options.length>6){this.size=6;}"  onchange='this.size=0;' onblur="this.size=0;">
								<option value="">Select a Group</option> 
        							<%  while(rs2.next())
        								{
        								String group=rs2.getString(1);%>
            						<option value="<%=group%>"><%= group%></option>
        							<% } %>
        						</select>
                        </div>
                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
             <div class="col-md-3 col-sm-3 col-xs-4">
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
                           <input type="text" id="name" required="required" class="form-control col-md-7 col-xs-12 user" name="br" style="display:none;" value=<%=uBranch %> disabled> 
                        </div>
                       <button type="submit" class="btn btn-success " onclick="d()">Go </button>
                        <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>>
                   <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>>
                   </form>
                     <br/>
                     <br/>
                           <br/>
            <div class="clearfix"></div>
    
<%  String branch = request.getParameter("branch");

if(role!=null && !(role.equals("1")))
{
	if(!(role.equals("5")))
	   branch=uBranch; 
}
if(branch!=null && branch.equals("All"))
    branch="";
String std=request.getParameter("std");
 String end=request.getParameter("end");	
 String grp=request.getParameter("grp");	
                   %>
            <div style=" float:right; margin-right: 10px; margin-top:-50px">

            <a class="hide4man" href="addsale.jsp"><button type="button" class="btn btn-success">Add </button></a>

                  <a href="viewsale.jsp" style="color:white;">  <button type="button" class="btn btn-info">View </button></a>

                 <a class="hide4man" href="editSale.jsp" style="color:white;">   <button type="button" class="btn btn-warning admin">Edit</button></a>
                  <a class="hide4man" href="saleReturn.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Return</button></a>
             </div>        

            <br/>
       <% if(branch==null )
    	   branch="";
       %>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><%=branch %> Sale</h2>
              
  <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                
                     <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%" >
                      <thead>
                        <tr>
                            <tr>
                   <th>Branch</th>
                                            <th>Date</th>
                                            <th>Invoice No.</th>
                                            <th>Customer Name</th>
                                            <th>Code</th> 
                                            <th>Description</th>
                                            <th>Mac</th> 
                                            <th>Grp</th>
                                            <th>Qty</th> 
                                            <th>Invoice Price</th>
                                            <th>ARR</th> 
                                            <th>Total</th> 
                                            <th>Total ARR</th> 
                                           
                                        </tr>
                      </thead>
                         <tfoot>
            <tr class="admin">
                <th colspan="8"></th>
                <th></th>
                <th colspan="2"></th>
                
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
		  
		 // Class.forName("com.mysql.jdbc.Driver").newInstance();  
	 	  //   connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  

statement=connection.createStatement();
st2=connection.createStatement();
String sql1="";
String sqlc="";
int primaryKey=0;

String sql ="SELECT *  FROM BillDetails b inner join Sale s on b.DC= s.Id inner join CodeList c on b.Code=c.Code where Month(Date)= month(CURDATE()) and year(Date)=year(CURDATE())";

//if (branch!=null && branch.length()!=0 )

	//sql1 ="SELECT * FROM BillDetails b inner join Sale s on b.DC= s.Id inner join CodeList c on b.Code=c.Code where Month(Date) = month(CURRENT_DATE) year(Date)=year(CURDATE())";
sql1=sql;
	
	String sql3="SELECT * FROM BillDetails b inner join Sale s on b.DC= s.Id inner join CodeList c on b.Code=c.Code where 1";
	String w="";
	

if(branch!="" && branch!=null)
{
	w+=" and Branch='"+branch+"'";
	
	sql1+=" and Branch='"+branch+"'";
}

if(std!=null && std.length()!=0)
{
	w+=" and Date between '"+std+"' and '"+end+"'";
	
}
if(grp!=null && grp.length()!=0)
{
	w+=" and Grp='"+grp+"'";
	
	sql1+=" and Grp='"+grp+"'";
}

sqlc+=w;
sql3+=w;

 if(std!=null && std.length()!=0)
{
	// System.out.println(sql3);
	 resultSet = statement.executeQuery(sql3);
	 System.out.println(sql3);
}

else if(branch!="" && branch!=null)
{
	//System.out.println("Hi");
	resultSet = statement.executeQuery(sql1);	
	System.out.println(sql1);
}
 
else if(grp!="" && grp!=null)
{
	//System.out.println("Hi2");
	resultSet = statement.executeQuery(sql1);	
	System.out.println(sql1);
}
 
else
{	
	resultSet = statement.executeQuery(sql);
	System.out.println(sql);
}
while(resultSet.next()){
	//System.out.println("Hi4");

	Float arrtot=resultSet.getFloat("ARR") * resultSet.getFloat("Qty");
	Date date=resultSet.getDate("Date");
/* 	SimpleDateFormat mdyFormat = new SimpleDateFormat("MM-dd-yyyy"); */
	/* System.out.println(new SimpleDateFormat("MM-dd-yyyy").format(date)); */
	
%>

<tr class="odd gradeX">
<td><%=resultSet.getString("Branch") %></td>
<td width="10%"><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td><%=resultSet.getString("DCNumber") %></td>
<td ><%=resultSet.getString("CustomerName") %></td>
<td><%=resultSet.getString("Code") %></td>
<td><%=resultSet.getString("Description") %></td>
<td><%=resultSet.getString("Machine") %></td>
<td><%=resultSet.getString("Grp") %></td>
<td><%=resultSet.getString("Qty") %></td>
<td><%=resultSet.getFloat("b.CostPrice")%></td>
<td><%=resultSet.getString("ARR") %></td>
<td><%=resultSet.getString("Total") %></td>
<td><%=arrtot %></td>


<%-- <td><button type="button" class="btn btn-success" style="margin-bottom: 1px;margin-left: 2%; " onclick="showDet(<%=primaryKey%>)">View </button></td> --%>
                                    
                   
                                        <%                     

	  }
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
          <!--    <button type="button" class="btn btn-success " onclick="hideprices()">Hide </button> -->
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
       <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.5.0/jszip.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.0/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.0/js/buttons.bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.0/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.0/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/buttons/1.5.0/js/buttons.print.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.1/js/dataTables.responsive.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.1/js/responsive.bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/scroller/1.4.3/js/dataTables.scroller.min.js"></script>
 <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap-datetimepicker -->    
    
    <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>
   
 
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/pdfmake.min.js"></script> -->
<!-- <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.32/vfs_fonts.js"></script> -->

    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>
     <script src="build/js/shortcut.js"></script>
<!-- <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.5.2/jquery.min.js"></script> -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
 <script>
    var ubran=document.getElementById('ubran').value;
    var bran=localStorage.getItem("branch");
	if(ubran=="All")
		ubran=bran;
    var role=document.getElementById('urole').value;
    var environment=document.getElementById('uenv').value;
    var path = window.location.pathname;
    var callingJSP = path.split("/").pop();
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
	var bran=localStorage.getItem("branch");
	var role=document.getElementById('urole').value;
/* 	var environment=document.getElementById('uenv').value;
	if(environment!=null && environment=="local")
		{
		$('.site_title').css('background-color', 'red');
		}
	else
		{
		$('.site_title').css('background-color', '');
		} */
	
	if(ubran=="All")
		ubran=bran;
/* 	
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
	    
		//document.getElementById("br").style.display="block";
	} */	   
var table=$('#ex').DataTable( {
	     
	        "iDisplayStart":0,
	        "lengthMenu": [[50, 100, -1], [50, 100, "All"]],
	        "order": [[ 0, "desc" ]],
	        "processing": true,
	     
	        "language": {
	            "sProcessing" : '<img src="images/Preloader_2.gif"  style="z-index:60000000; margin-top:20%"> '},
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
		                  .column( 11 )
		                  .data()
		                  .reduce( function (a, b) {
		                      return intVal(a) + intVal(b);
		                  }, 0 );
		   
		              // Total over this page
		              pageTotal = api
		                  .column( 11, { page: 'current'} )
		                  .data()
		                  .reduce( function (a, b) {
		                      return intVal(a) + intVal(b);
		                  }, 0 );
		   
		              // Update footer
		              $( api.column( 11 ).footer() ).html(
		            		   total.toLocaleString('en-IN', {
			                	    maximumFractionDigits: 2,
			                	    style: 'currency',
			                	    currency: 'INR'
			                	}) 
		              );
		              // Total over all pages
		              total = api
		                  .column( 12 )
		                  .data()
		                  .reduce( function (a, b) {
		                      return intVal(a) + intVal(b);
		                  }, 0 );
		   
		              // Total over this page
		              pageTotal = api
		                  .column( 12, { page: 'current'} )
		                  .data()
		                  .reduce( function (a, b) {
		                      return intVal(a) + intVal(b);
		                  }, 0 );
		   
		              // Update footer
		              $( api.column( 12 ).footer() ).html(
		            		  total.toLocaleString('en-IN', {
			                	    maximumFractionDigits: 2,
			                	    style: 'currency',
			                	    currency: 'INR'
			                	}) 
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
		            		  total
		              );
		          }, 
		          scrollY:        '50vh',
			        scrollCollapse: true,
	    /*     "createdRow": function ( row, data, index ) {
	           
	                $('td', row).eq(5).addClass('highlight');}, */
	      
	        dom: 'Blfrtip' ,
	       /*  buttons: [
	        	{
                    extend:    'excelHtml5',
                    text:      '<i class="fa fa-file-excel-o"></i>',
                    titleAttr: 'Excel',
                    "oSelectorOpts": { filter: 'applied', order: 'current' },
                    "sFileName": "report.xls",
                    action : function( e, dt, button, config ) {
                        exportTableToCSV.apply(this, [$('#ex'), 'export.xls']);

                    }

                },
	            {
	                extend: 'print',
	                footer:true,
	                title: ubran + " Sale",
	                
	                
	                exportOptions: {
	                    stripHtml: false
	                    
	               },
	                customize: function ( win ) {
	             
	                    $(win.document.body).find( 'table' )
	                        .addClass( 'compact' )
	                        .css( 'font-size', 'inherit' );
	                }
	            } ,
	            {
	            	extend: 'pdfHtml5',
	                orientation: 'landscape',
	                pageSize: 'A4'
	              
	            },
	            {
	                extend: 'copy',
	                exportOptions: {
	                    stripHtml: true
	               }
	            } 
	        ] */
	        buttons: [
	        	'excel','copy', 'pdf', 'print'
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
<script src="http://www.datejs.com/build/date.js" type="text/javascript"></script>

<script type='text/javascript'>

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
    	localStorage.setItem("grp", document.getElementById('grp').value);
     	localStorage.setItem("daterange", document.getElementById('daterange').innerHTML);
/*    	localStorage.setItem("sd", document.getElementById('single_cal3').value);
	localStorage.setItem("pd", document.getElementById('da1').value); */
	/* localStorage.setItem("dc", document.getElementById('dc').value); */
}
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");

	 var s = document.getElementById("branch");
	 document.getElementById('daterange').innerHTML=localStorage.getItem("daterange"); 
	 document.getElementById('std').value=localStorage.getItem("std"); 
	 document.getElementById('end').value=localStorage.getItem("end"); 
	 document.getElementById('grp').value=localStorage.getItem("grp"); 
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
	    	localStorage.setItem("grp", "");
	     	localStorage.setItem("daterange", "Select Date Range"); 
	  /*   	localStorage.setItem("sd", ""); */
	  /*   	localStorage.setItem("dc", ""); */
/* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
});
</script> 
</body>
</html>