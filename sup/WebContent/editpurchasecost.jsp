 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@page import="java.util.Date"%>
<%@ page import= "java.text.SimpleDateFormat" %>
<%@ page import= "java.util.Arrays" %>
<%@ page language="java" import="java.util.*" %>
<%
/* String id = request.getParameter("userId"); */
String driverName = "com.mysql.jdbc.Driver";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<html>
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

        <!-- top navigation -->
      
        <!-- page content -->
        <div class="right_col " role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>Purchase Cost <!-- <small>Some examples to get you started</small> --></h1>
              </div>

                   
                       

            <div class="clearfix"></div>

            <div style=" float:right; margin-right: 10px;margin-top: -5%">
            <form action="editpurchasecost.jsp" method="get">
             <div class="control-group">
             <label class="control-label col-md-1 col-sm-1 col-xs-2" for="sno" style="/* margin-left:-7% */"> SNo:</label>
                        <div class="col-md-2 col-sm-3 col-xs-3">
                          <input type="text" id="sno" class="form-control col-md-7 col-xs-12" name="sno" >
                        </div>
                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
             <div class="col-md-7 col-sm-12 col-xs-8">
                          <select class="select2_single form-control admin" tabindex="-1" name="branch"  >
                            <option value="All">Select Another Branch</option>
                             <option value=""> All Branches</option>
                            <!--   <option value="Bowenpally">Bowenpally</option>
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
                        </div>
                        <button type="submit" class="btn btn-success " >Go </button>
                        </div>
                             <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                        </form>
                      
                           <br/>
        <br/>

              <a href="expenseform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                 <a href="expenses.jsp"> <button type="button" class="btn btn-info">View Expenses</button></a>
 <a href="PurchaseCost.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;"> View Purchase Costs</button></a>
                 <a href="editpurchasecost.jsp">   <button type="button" class="btn btn-warning">Edit Purchase Costs</button></a>
             </div>       

            <br/>
        <br/>
         <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-12 col-xs-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Expense deleted successfully.</strong></div>";
 
 if(r!=null)
        	out.println(succ);
/*  else if(r=="2")
	 out.println(succ2); */
     %> 
      <br/>

         <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Edit Purchase Costs</h2>
                   <%  String branch = request.getParameter("branch");
                   if(role!=null && !(role.equals("1")))
                	   branch=uBranch; 
                   if(branch ==null)
                	   branch="";
                   %>
                        <label style="float:right" id><%= branch %></label>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  
        <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                        <tr>
                            <tr>
                                            <th>Id</th>
                                             <th>Sno</th>
                                            <th>Name</th>
                                            <th>Date</th>
                                            <th>Type</th>
                                            <th>Description</th>
                                            <th>Amount</th>
                                            <th>Actions</th>

                                        </tr>
                      </thead>
                        <tbody>
<%
try{ 
	 // Class.forName("com.mysql.jdbc.Driver").newInstance();  
	 //    connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234"); 
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
/* String branch = request.getParameter("branch"); */
String sql ="SELECT * FROM PurchaseCost where 1";
String whr="";
String sn = request.getParameter("sno");
if(sn==null)
	   sn="";
if(sn!=null && sn.length()!=0)
	whr+=" and Id="+sn;
if(branch.equals("All"))
	branch="";
if(branch!="" && branch!=null && branch!="Select a Branch")
	whr+=" and Branch='"+branch+"'";
sql+=whr;

statement=connection.createStatement();

resultSet = statement.executeQuery(sql);
while(resultSet.next()){
int	primaryKey = resultSet.getInt("Id");
Date date=resultSet.getDate("Date");	
%>
                                        <tr class="odd gradeX">
                                          <%-- <td><%=resultSet.getString("Branch") %></td> --%>
<td><%=resultSet.getString("Date") %></td>
<td><%=resultSet.getString("Id")  %></td>
<td><%=resultSet.getString("Name") %></td>
<td><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td><%=resultSet.getString("Type") %></td>
<td><%=resultSet.getString("Description") %></td>
<td><%=resultSet.getDouble("Amount") %></td>
 <td>
<!--                             
                            <a href="#" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Edit </a> -->
                <a href="delpurcost.jsp?deleteid=<%=primaryKey%>" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a> 
          <!--   <button onclick="f()" type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm">Small modal</button> -->

               
               </td>
                                        </tr>
                                        <% 
}

} catch (Exception e) {
e.printStackTrace();
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
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>
<!-- <script>
function f()
{
	window.alert("hi");
	var s="delete.jsp?deleteid="+document.getElementById("dk").innerHTML;
	document.getElement.id("h").innerHTML+='<button type="button" class="btn btn-primary">Save changes</button>'
	window.alert(s);
	}
</script> -->
<script>
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
	   		if(ubran!=null && ubran=="Workshop")
	    		document.getElementById("invAdj").style.display="block";
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
	     
	        "iDisplayStart":0,
	        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
	        "order": [[ 0, "desc" ]],
	        "columnDefs": [
	            { "visible": false, "targets": 0 }
	          ],
	    
	    /*     "createdRow": function ( row, data, index ) {
	           
	                $('td', row).eq(5).addClass('highlight');}, */
	      
	        dom: 'lfrtip'/* ,
	        buttons: [
	            'copy', 'excel', 'pdf', 'print'
	        ] */
	    } );
} );
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");
});
</script>
  </body>
</html>