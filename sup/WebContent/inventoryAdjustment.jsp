<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*" %>
<%@ page import="java.io.InputStream" %>
<%
/* String id = request.getParameter("userId"); */

Connection connection = null;
Statement statement = null;
Statement st = null;
DataSource ds = null;
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

    <title>KK Track- Inventory</title>

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
                <h1>Inventory Adjustment <!-- <small>Some examples to get you started</small> --></h1>
              </div>
            <div class="clearfix"></div>
<% String r=request.getParameter("res");
 String succ="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Inventory adjusted successfully.</strong></div>";
 String succ2="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Sale deleted successfully.</strong></div>";
 if(r!=null)
        	out.println(succ);
/*  else if(r=="2")
	 out.println(succ2); */
     %> 
            <div>
         
           <form id="FormId" action="inventoryAdjustment.jsp" method="post" class="form-horizontal form-label-left">
                <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>>   
                   <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
                  <label class="control-label col-md-1 col-sm-1 col-xs-2" for="code"> Code:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="number" id="code"  class="form-control col-md-7 col-xs-12" name="code" >
                        </div>
                       <!-- <label class="control-label col-md-1 col-sm-1 col-xs-2" for="dc"> Customer Name:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="text" id="cn" class="form-control col-md-7 col-xs-12" name="cn" >
                        </div> -->
                     <label class="control-label col-md-1 col-sm-1 col-xs-2"> Branch:<span class="required">*</span></label>
                        <div class="col-md-3 col-sm-3 col-xs-3">
                        <%--   <input class="" type="text" id="fbranch" name="fbranch" value=<%=uBranch%> readonly="readonly" style="border:none"> --%>

                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
                          <select class="select2_single form-control hide4branch" tabindex="-1" id="branch" name="branch">

                 
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

                          <input type="text" id="BranchName" class="form-control col-md-7 col-xs-12 user" name="BranchName" style="display:none;" value=<%=uBranch%> disabled>


                      <%--     <input type="text" id="name" required="required" class="form-control col-md-7 col-xs-12 user" name="br" style="display:none;" value=<%=uBranch %> disabled>  --%>
                        </div>
                        <button type="submit" class="btn btn-success" onclick="d()">Go </button>
                        <button  class="btn btn-success" type="reset" onclick="window.location.reload(true)">Refresh </button>
                       
                        </form>
                      
                           <br/>
       

          <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Inventory Adjustment</h2>
                   <%  
                   
                   String branch = request.getParameter("branch");
                   if(role!=null && !(role.equals("1")))
                	   branch = uBranch;
            //    System.out.println(branch);
                   %>
                       <%--  <label style="float:right" ><%= branch %></label> --%>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
              <form action="inventedit.jsp" method="get">        
       <table id="" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                            <tr>
                                            
                                            <th>Branch</th>
                                            <th>Code</th>
                                         <!--    <th>HSN Code</th> -->
                                            <th>Machine</th>
                                            <th>PartNo</th>
                                            <th>Description</th>
                                            <th>Group</th>
                                            <!-- <th>MinPrice</th>
                                            <th>LC</th> -->
                                            <th>Quantity</th>
                                            <th>New Quantity</th>
                                            <th></th>
                                            
                                           
                                        </tr>
                      </thead>
                        <tbody>
                        <%
try{ 
	 /* Context context = new InitialContext();
	  Context envCtx = (Context) context.lookup("java:comp/env");
	  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
	  if (ds != null) {
		  connection = ds.getConnection(); */
		  
		 // Class.forName("com.mysql.jdbc.Driver").newInstance();  
	 	  //   connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  

    if (driver != null) {
        Class.forName(driver).newInstance();  
    }
    connection = DriverManager.getConnection(url, username, password);		  
statement=connection.createStatement();
String code=request.getParameter("code"); 
	
String sql1 ="SELECT * FROM CodeList c INNER JOIN NewInventory n ON c.Code=n.Code where n.Code='"+code+"' and Branch='"+branch+"'";
if(code!=null && branch!=null)
rs = statement.executeQuery(sql1); 
int i=1;
while(rs.next()){
	 
%>
<tr class="odd gradeX">
<td><%=rs.getString("Branch") %></td>
<td><%=rs.getString("n.Code") %></td>
<%-- <td><%=rs.getString("HSNCode") %></td> --%>
<td><%=rs.getString("Description") %></td>
<td><%=rs.getString("Machine") %></td>
<td><%=rs.getString("PartNo") %></td>
<td><%=rs.getString("Grp") %></td>
<%-- <td><%=rs.getDouble("MinPrice") %></td>
<td><%=rs.getDouble("LC") %></td> --%>
<td><%=rs.getFloat("Quantity") %></td>
<td style="width: 10%;">          
                <input id="nq<%=code %>" name="nq<%=code %>" style="width: 80%;margin-left: 7%;" type="number" min=0> 
          
                 <input type="hidden" id="code" name="code" value=<%=rs.getString("n.Code")%> >
               
                <input type="hidden" id="branch" name="branch" value=<%=branch %> > 
              
</td>
<td> <button type="submit" class="btn btn-success" style="margin-bottom: 1px;margin-left: 2%;">Go </button></td> 
</tr>
 <% 
 }%>
</tbody> </table><!-- <button type="button" class="btn btn-success" style="margin-bottom: 1px;margin-left: 2%;" onclick="this.form.submit()">Go </button> --></form>
                                        
                   
                                        <%
   
	//  }
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


                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
         </div>
         </div>
        <!-- /page content -->

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
<script>
$(document).ready(function() {
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	var environment=document.getElementById('uenv').value;
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
    		var elements = document.getElementsByClassName('user');

    	    for (var i = 0; i < elements.length; i++){
    	        elements[i].style.display = "block";
    	    }
	
	}
	if(role!=null && role=="2")
	{
		 $( '[class*="branch"]' ).hide();
   		if(ubran!=null && ((ubran=="Workshop")||(ubran=="Barhi")||(ubran=="Tekkali")|| (ubran=="Vishakapatnam")||(ubran=="Bowenpally")))
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
	}
	});
function dch() { 
  var d=document.getElementById("single_cal3").value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
  document.getElementById('da').value=da;
}
$(document).ready(function() {
var h= $('.right_col').height()+100;
$('.right_col').animate({height:h}, 500);
});
</script>    
<script type='text/javascript'>
function d(){
    	localStorage.setItem("branch", document.getElementById('branch').value);
 /*    	localStorage.setItem("sd", document.getElementById('single_cal3').value);
    	localStorage.setItem("pd", document.getElementById('da1').value); */
    	localStorage.setItem("code", document.getElementById('code').value);
}
    $(window).load(function () {
    	$(".se-pre-con").fadeOut("slow");
    	 var s = document.getElementById("branch");
   /* 
   document.getElementById('single_cal3').value=localStorage.getItem("sd"); 
   
   document.getElementById('da1').value=localStorage.getItem("pd");  */
 
    	 document.getElementById('code').value=localStorage.getItem("code");
   
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
    	    	localStorage.setItem("code", "");
    /* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
    });
</script> 
  </body>
</html>


