<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%
/* String id = request.getParameter("userId"); */

String sd = "";


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
  </head>
  <style>
  td.highlight {
        font-weight: bold;
        color: blue;
    }
    tfoot input {
        width: 100%;
        padding: 3px;
        box-sizing: border-box;
    }
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

var url="datainvbal.jsp";
var str=document.getElementById("branch").value;


url += "?branch="+str;
$("#ex").dataTable().fnDestroy()
var table= $('#ex').DataTable( {
       "bProcessing": true,
       "bServerSide": true,
       "iDisplayStart":0,
       "language": {
	        "sProcessing" : '<img src="images/Preloader_2.gif"  style="z-index:60000000; margin-top:20%"/> '},
       "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
       "sAjaxSource":"datainvbal.jsp?ubranch="+ubran+"&role="+role+"&br="+str,
       scrollY:        '50vh',
       scrollCollapse: true,
       "sAjaxSource":url,
       
   /*     "createdRow": function ( row, data, index ) {
          
               $('td', row).eq(5).addClass('highlight');}, */
     
       dom: 'Bfrtip',
       buttons: [
           'copy', 'excel', 'pdf', 'print'
       ]
   } );
table.columns().every( function () {
    var that = this;

    $( 'input', this.footer() ).on( 'keyup change', function () {
        if ( that.search() !== this.value ) {
            that
                .search( this.value )
                .draw();
        }
    } );
} );
}
 function stateChange(){   
 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 var data=xmlHttp.responseText;
	 
	/*  document.getElementById("country").innerHTML=data; */
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

        <!-- top navigation -->
  

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>Inventory Current Balance  <!-- <small>Some examples to get you started</small> --></h1>
              </div>



            <div class="clearfix"></div>
       
           <form id="FormId"  method="post" >
         
                      
                  <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                  <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
                  </form>
                 
                    
                     </div>
                     <br/>
                    
                    
                       <div class="admin" style=" float:right; margin-right: 10px;">
           
              <a href="AddCode.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="viewinventory.jsp"> <button type="button" class="btn btn-info">View </button></a>
             </div>       

            <br/>
        <br/>
      <br/>

            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View Stock</h2>
                <%  String branch = request.getParameter("branch");
                   /* if(branch ==null)
                	   branch="Select a Branch"; */
                   %>
                    <%-- <label style="margin-left:10%" id><%= sd %></label>
                     <label style="margin-left:10%" id><%= ed %></label> --%>
              <%--  <label style="float:right" id><%= branch %></label> --%>
  <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  
                    <table id="ex" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                            <tr>
                           
                                            <th>Code</th>
                                            <th>Machine</th>
                                            <th>HSN Code</th>
                                            <th>PartNo</th>
                                            <th>Description</th>
                                            <th>Group</th>
                                           <!--  <th>Max</th>
                                            <th>Min</th> -->
                                            <th>Quantity</th>
                                            
                                            
                                        </tr>
                      </thead>
                        <tfoot>
            <tr>
                                            <th>Code</th>
                                            <th>Machine</th>
                                            <th>HSN Code</th>
                                            <th>PartNo</th>
                                            <th>Description</th>
                                            <th>Group</th>
                                           <!--  <th>Max</th>
                                            <th>Min</th> -->
                                            <th>Quantity</th>
                                            
            </tr>
        </tfoot> 
                        <tbody id="country">


                      </tbody>
                    </table>
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
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap-datetimepicker -->    
    
    <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>

    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>
    <script>
    var ubran=document.getElementById('ubran').value;
    var role=document.getElementById('urole').value;
    var environment=document.getElementById('uenv').value;
    var path = window.location.pathname;
    var callingJSP = path.split("/").pop();
</script> 
<script>
  $("#FormId").submit( function(e) {
	  loadAjax();
	  e.returnValue = false;
	  return false;
	});  
  $(document).ready(function() {
	  $.getScript("js/rolePermissions.js");
		var ubran=document.getElementById('ubran').value;
		var role=document.getElementById('urole').value;
		var s=document.getElementById('branch');
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
		}
		 */
	   $('#ex tfoot th').each( function () {
	        var title = $(this).text();
	        $(this).html( '<input type="text" placeholder="Search '+title+'" />' );
	    } );
	   
var table=$('#ex').DataTable( {
	        "bProcessing": true,
	        "bServerSide": true,
	        "iDisplayStart":0,
	        "language": {
	        "sProcessing" : '<img src="images/Preloader_2.gif"  style="z-index:60000000; margin-top:20%"/> '},
	        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
	        "sAjaxSource":"datainvbal.jsp?ubranch="+ubran+"&role="+role,
	        scrollY:        '50vh',
	        scrollCollapse: true,
	    /*     "createdRow": function ( row, data, index ) {
	           
	                $('td', row).eq(5).addClass('highlight');}, */
	      
	        dom: 'Blfrtip',
	        buttons: [
	            'copy', 'excel', 'pdf', 'print'
	        ]
	    } );
	 // Apply the search
	    table.columns().every( function () {
	        var that = this;
	 
	        $( 'input', this.footer() ).on( 'keyup change', function () {
	            if ( that.search() !== this.value ) {
	                that
	                    .search( this.value )
	                    .draw();
	            }
	        } );
	    } );
	 
	    var h= $('.right_col').height()+200;
	    $('.right_col').animate({height:h}, 500);
	  
	} );
function dch(val) { 
  var d=document.getElementById(val).value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
if(val=="single_cal3")
  document.getElementById('da1').value=da;
else
	document.getElementById('da2').value=da;
}
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");
});
</script>


  </body>
</html>