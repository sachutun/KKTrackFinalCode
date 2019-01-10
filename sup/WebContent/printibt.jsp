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
/* String driverName = "com.mysql.jdbc.Driver"; */

String sd="";
String rd="";
Statement statement = null;
Statement st = null;
Statement st2 = null;
Statement st3 = null;
DataSource ds = null;
Connection conn = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs2 = null;

int i=0;
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
        <div class="right_col" role="main">
          <div class="">
           
            <div class="page-title">
            
              <div class="title_left" style="width:80%;  margin-left: 12%;">
              <h4 style="text-align:center; ">INVOICE</h4>
              <h6 style="text-align:center; ">CASH/CREDIT</h6>
                <h3 style="text-align:center;"> <img style="width:4%" src="images/kklogo.jpg" alt=""> KK Heavy Machinery & Services Pvt. Ltd.  <!-- <small>Some examples to get you started</small> --></h3>
              <h5 style="text-align:center;">#29, BHEL Enclave, Bowenpally, Secunderabad-500 009</h5>
              <h6 style="text-align:center; ">Email: kkheavymachinery@gmail.com</h6>
              <h5 style="text-align:right; margin-right:-9%">GSTIN: 36AADCK3292Q1ZX</h5>
              </div>
               <div style="overflow: auto">
             <div class="row">
          
                      </div>
                    </div> 
                    
                     </div>
                                 <div style=" float:right; margin-right: 10px;">

            <!--   <a href="#"><button type="button" class="btn btn-success" onclick="javascript:window.print();">Print </button></a> -->

             </div>   
       <br/>              
 
     <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>IBT updated successfully.</strong></div>";
 String succ2="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>IBT deleted successfully.</strong></div>";
 if(r!=null)
        	out.println(succ);
/*  else if(r=="2")
	 out.println(succ2); */
     %> 
           <%  String branch = request.getParameter("fbranch"); %>
       <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  
                  <div class="x_content">
                
                     <div class="table-responsive"> 
                    <table id="" class="table" >
                    <thead>
                    
                                     
                    </thead>
                    <tbody>
                        <%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");
statement=connection.createStatement(); */
String dc=request.getParameter("dc");

String cn=request.getParameter("sd");

/* Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    conn = ds.getConnection(); */
   
   // Class.forName("com.mysql.jdbc.Driver").newInstance();  
    // conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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
    String environment = props.getProperty("jdbc.environment");
    conn = DriverManager.getConnection(url, username, password);
    statement=conn.createStatement();
    st = conn.createStatement();
String sql1 ="SELECT DISTINCT * FROM IBT";
String wher=" where";

	wher+=" FromBranch='"+branch+"'";

	wher+=" and IBTNo='"+dc+"'";

	if(cn!=null && cn.length()!=0)
	{
	wher+=" and Date='"+cn+"'";
	}
	else
		wher+=" and Date='"+cn+"'";

sql1+=wher;

if(branch!=null && dc!=null && cn!=null)
{
resultSet = statement.executeQuery(sql1);
int sno=1;
while(resultSet.next()){
	
	String sql2="SELECT * FROM IBTDetails inner join CodeList on IBTDetails.Code=CodeList.Code where IBTDetails.IBT=";
	int	primaryKey = resultSet.getInt("Id");
	String whr=primaryKey+"";
	sql2+=whr;
	int sno2=1;
	rs = st.executeQuery(sql2);
	Date date=resultSet.getDate("Date");

%>
 <tr class="odd gradeX">

<%-- <td><%=sno%></td>      --%>                                     
<td width="3%"><strong> IBT Number: </strong><%=resultSet.getString("IBTNo") %></td>
<td width="2%"><strong> Date: </strong><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td width="3%"><strong> From Branch: </strong><%=resultSet.getString("FromBranch") %></td>
<td width="3%"><strong> To Branch: </strong><%=resultSet.getString("ToBranch") %> </td>
<td width="3%"><strong> Total Qty: </strong><%=resultSet.getFloat("TotalQty") %></td>

</tr></tbody></table>
<table id="" class="table table-striped table-bordered dt-responsive">
                      <thead>
                       
                            <tr>
                                            <th>Sno</th>
                                            <th>Code</th>
                                            <th>HSNCode</th>
                                            <th>Description</th>
                                            <!-- <th>Machine</th>
                                            <th>Part No</th>
                                            <th>Group</th> -->
                                            <th>IBT Price</th>
                                            <th>Quantity</th>
                                        </tr>
                      </thead>
                        <tbody >
   <tr class="odd gradeX">
                          <% while(rs.next())
{
                        	  i=rs.getInt("IBTDetails.Id") ;
	%>
<td><%=sno2++%></td> 
<td><%=rs.getString("IBTDetails.Code") %></td>
<td><%=rs.getString("CodeList.HSNCode") %></td>
<td ><%=rs.getString("Description") %> <%=rs.getString("Machine") %> </td>
<%-- <td width="30%"><%=rs.getString("Machine") %></td>
<td width="80%"><%=rs.getString("PartNo") %></td>
<td><%=rs.getString("Grp") %></td> --%>
<td><%=rs.getDouble("MinPrice") %></td> 
<td><%=rs.getFloat("IBTDetails.Qty") %>
<input type="hidden" id="i" name="i">  
 <input type="hidden" id="code<%=i %>" name="code<%=i %>" value=<%=rs.getString("IBTDetails.Code")%> >
 <input type="hidden" id="q<%=i %>" name="q<%=i %>" value=<%=rs.getFloat("IBTDetails.Qty")%> >
  <input type="hidden" id="payid" name="payid" value=<%=primaryKey %> > 
  <input type="hidden" id="sd" name="sd" value=<%=cn %> > 
  <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                   <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
</td>


</tr>
 <%
 sno++;
} 
 %>
</tbody> 
</table> 

 
 <% 

}
}
//} 
}catch (Exception e) {
e.printStackTrace();
}
                        finally {
                      	     try {
                      	       if (st != null)
                      	        st.close();
                      	    if (st2 != null)
                      	        st2.close();
                      	       }  catch (SQLException e) {}
                      	       try {
                      	        if (conn != null)
                      	         conn.close();
                      	        } catch (SQLException e) {}
                      	    }
%>
                    
                  
                
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
function chsn(i)
{
	document.getElementById("i").value=i;
}
 $(document).ready(function() {
	 var table=$('#ex').DataTable( {
	        "bProcessing": true,
	        /* "sDom": 'prtp',   */
	        "processing": true,
	        "language": {
	            "sProcessing" : '<img src="images/Preloader_2.gif"  style="z-index:60000000; margin-top:20%"/> '},
	            
	            "bServerSide": true,
	        "iDisplayStart":0,
	        
	        "lengthMenu": [[25, 50, 100,-1], [25, 50, 100, "All"]],
	        scrollY:        '50vh',
	        scrollCollapse: true,
	        "columnDefs": [
	            { "targets": [1], "searchable": false },
	            /* { "targets": [8], "visible": false } */
	        ],
	    /*     "createdRow": function ( row, data, index ) {
	           
	                $('td', row).eq(5).addClass('highlight');}, */
	      
	        dom: 'Blfrtip',
	        buttons: [
	            'copy', 'excel', 'pdf', 'print'
	        ]
	    } );
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

			document.getElementById("br").style.display="block";
		}
		
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
function chsn(i)
{
	document.getElementById("i").value=i;
}
function d(){
    	localStorage.setItem("branch", document.getElementById('branch').value);
     	localStorage.setItem("sd", document.getElementById('single_cal3').value);
   /*  	localStorage.setItem("rd", document.getElementById('single_cal4').value);  */
     	localStorage.setItem("dc", document.getElementById('dc').value); 
}
    $(window).load(function () {
    	$(".se-pre-con").fadeOut("slow");
    	window.print();
  
    });
</script> 

  </body>
</html>