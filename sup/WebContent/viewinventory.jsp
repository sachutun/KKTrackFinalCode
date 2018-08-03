<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*" %>
<%
/* String id = request.getParameter("userId"); */

String sd = "";

%>
<%   
  
String user=request.getParameter("uname"); 
String uBranch=request.getParameter("branch");
String role=request.getParameter("role");
if(user==null)
{
 user=(String)session.getAttribute("user");  
  uBranch=(String)session.getAttribute("ubranch");
  role=(String)session.getAttribute("role");
 
}
if(user==null)
	response.sendRedirect("login.jsp");

session.setAttribute("user",user);
session.setAttribute("ubranch",uBranch);
session.setAttribute("role",role);

/* System.out.println("Branch "+uBranch); */
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
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/1.5.0/css/buttons.bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.1/css/responsive.bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/scroller/1.4.3/css/scroller.bootstrap.min.css"/>
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
   .price{
    display: none;
        padding: 8px;
    color: #73879C;
    font-family: "Helvetica Neue",Roboto,Arial,"Droid Sans",sans-serif;
    font-size: 13px;
    font-weight: inherit;
    line-height: 1.471;
    }
    
    th.price{
    
    font-weight: bold;
    }
  td.highlight {
        font-weight: bold;
        color: #ce1a1a;
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

var url="datatableinv.jsp";
var str=document.getElementById("branch").value;


url += "?br="+str;
var ubran=document.getElementById('ubran').value;
var role=document.getElementById('urole').value;

$("#ex").dataTable().fnDestroy()
var table= $('#ex').DataTable( {
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
   
       "lengthMenu": [[25, 50, 100, -1], [25, 50,100, "All"]],
       "sAjaxSource":"datatableinv.jsp?ubranch="+ubran+"&role="+role+"&br="+str,
       scrollY:        '50vh',
       scrollCollapse: true,  
       "createdRow": function ( row, data, index ) {
       		var quantity=$('td', row).eq(7).html();      	
			var minLevel= $('td', row).eq(9).html();
     		if((minLevel != null || minLevel != "") && parseInt(quantity) < parseInt(minLevel))
   	 		{
   				$('td', row).addClass('highlight');
    	 		}
		},
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
  
 user=(String)session.getAttribute("user"); 
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
                    <!-- <li><a href="javascript:;"> Profile</a></li>
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
                <h1>Inventory Stock <!-- <small>Some examples to get you started</small> --></h1>
              </div>



            <div class="clearfix"></div>
            
             <div class="well" style="overflow: auto">
             <div class="row">
             <form id="FormId"  method="post" >
      
                  <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                <%
				ResourceBundle resources =ResourceBundle.getBundle("branches");
				Enumeration resourceKeys = resources.getKeys();
				ArrayList<String> listOfBranches = new ArrayList<String>();
				%>      
             <div class="col-md-3 col-sm-3 col-xs-3" id="br">
             	<select class="select2_single form-control hide4branch" tabindex="-1" name="branch" id="branch" onchange=showState() >
                             <option value="">All Branches</option>
                              <!--    <option value="Bowenpally">Bowenpally</option>
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
                            <option value="Chittoor">Chittoor</option>  -->
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
                        </div><!-- 
                        <button type="button" class="btn btn-success" onclick=showState()>Go </button> -->
                        <input id="b1" class="form-control col-md-7 col-xs-12" type="hidden"  >
                        </form>
                       <input id="das" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=sd%> >
                      </div>
                    </div> 
                    
                     </div>
                     <br/>
                     <br/>
                     <br/>
                      <br/>
                      <br/>
                    
                       <div class="hide4branch&acc" style=" float:right; margin-right: 10px; margin-top: -10px;">
           
              <a class="hide4acc&store" href="AddCode.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a class="hide4acc&store" href="viewinventory.jsp"> <button type="button" class="btn btn-info">View </button></a>
                    <a class="hide4acc&store" href="inventoryAdjustment.jsp" style="color:white;">   <button type="button" class="btn btn-warning admin">Adjust</button></a>
             <a id="bup" href="binlocupdate.jsp" style="color:white; display:none">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Bin Update</button></a>
             </div>       

            <br/>
        <br/>
      <br/>

            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View Stock</h2>
                <%  String branch = request.getParameter("branch");
                
                    if(uBranch!="All")
                	   branch=uBranch; 
                    
                   %>
                    <%-- <label style="margin-left:10%" id><%= sd %></label>
                     <label style="margin-left:10%" id><%= ed %></label> --%>
              <%--  <label style="float:right" id><%= branch %></label> --%>
  <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  
                     <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                        <tr>
                            <tr>
                            <th>Branch</th>
                                            <th>Code</th>
                                            <th>Machine</th>
                                            <th>HSN Code</th>
                                            <th>PartNo</th>
                                            <th>Description</th>
                                            <th>Group</th>
                                           
          <%--                                   <th>Max</th>
                                                                                  <%
            if(role!=null && role.equals("1"))
            {
           
            %>
                                            <th>Min</th>
                                            	<%
            }
            %> --%>
                                            <th>Quantity</th>
                                             <th>Bin Location</th>
                                             <th>Min Level</th>
                    <%--                          <%
            if(role!=null && role.equals("1"))
            {
           
            %>
                                            <th class="">LC</th>
                                            	<%
            }
            %> --%>
                                        </tr>
                      </thead>
                        <tfoot>
            <tr>
            <%
            if(role!=null && role.equals("1"))
            {
           
            %>
         <th >Branch</th>
         <%} 
            else{
            	%>
            	<th id="bran"></th>
            	<%
            }
            %>
                                            <th>Code</th>
                                            <th>Machine</th>
                                            <th>HSN Code</th>
                                            <th>PartNo</th>
                                            <th>Description</th>
                                            <th>Group</th>
                                           
                                           <%--  <th>Max</th>
                                                                                  <%
            if(role!=null && role.equals("1"))
            {
           
            %>
                                            <th>Min</th>
                                            	<%
            }
            %> --%>
                                            <th>Quantity</th>
                                             <th>Bin Location</th>
                                             <th>Min Level</th>
                                                                                <%--  <%
            if(role!=null && role.equals("1"))
            {
           
            %>
                                            <th class="">LC</th>
                                            	<%
            }
            %> --%>
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
  $("#FormId").submit( function(e) {
	  loadAjax();
	  e.returnValue = false;
	  return false;
	});  

	$(window).load(function() {
		
		$(".se-pre-con").fadeOut("slow");
	});
	
  $(document).ready(function() {
	  
		shortcut.add("Ctrl+Shift+X",function() {
			hideprices();
			if(role!=null && role!="1")
			{
			var elements = document.getElementsByClassName('admin');

		    for (var i = 0; i < elements.length; i++){
		    	elements[i].innerHTML="";
		    }
			}
		});
	
	/* alert(document.getElementById('ubran').value);   */
	//session mgmt
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	var s=document.getElementById('branch');

/*   	for (var i = 0; i< s.options.length; i++)

	{ 
  		
	if (s.options[i].value == ubran)

	{
		alert('hi');
		if(s.options[i].value=="Bowenpally")
	    	s.selectedIndex=i+1;
	    		else
		 	s.selectedIndex=i;
	break;

	}
	} */
	

	
	   $('#ex tfoot th').each( function () {
	        var title = $(this).text();
	        $(this).html( '<input id=i'+title+' type="text" placeholder="Search '+title+'" />' );
	    } );
	$('#bran').html('');
	/* if(role!=null && role!="1")
		{
		var elements = document.getElementsByClassName('admin');

	    for (var i = 0; i < elements.length; i++){
	        elements[i].style.display = "none";
	    }
		
		}//
	if(role!=null && role=="3")
	{
	var elements = document.getElementsByClassName('userv');

    for (var i = 0; i < elements.length; i++){
        elements[i].style.display = "none";
    }
	
	}
	if(role!=null && role=="5")
	{
	var elements = document.getElementsByClassName('acc');

    for (var i = 0; i < elements.length; i++){
        elements[i].style.display = "none";
    }
	document.getElementById("br").style.display="block";
	}	
	if(role!=null && role=="4")
	{
	var elements = document.getElementsByClassName('acc');

    for (var i = 0; i < elements.length; i++){
        elements[i].style.display = "none";
    }
    
    
    
    document.getElementById("exp").style.display="none";
	document.getElementById("br").style.display="block";
	document.getElementById("bup").style.display="inline";
	} */
	
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
	    var elements = document.getElementsByClassName('hide4branch&acc');

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
		 
	    document.getElementById("exp").style.display="none";
		document.getElementById("br").style.display="block";
		document.getElementById("bup").style.display="inline";
	    
	}
	if(role!=null && role=="5")
	{
		var elements = document.getElementsByClassName('hide4acc&store');

		for (var i = 0; i < elements.length; i++){
    			elements[i].style.display = "none";
		}
		var elements = document.getElementsByClassName('hide4branch&acc');

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
	        
	        "lengthMenu": [[25, 50, 100,-1], [25, 50, 100, "All"]],
	        "sAjaxSource":"datatableinv.jsp?ubranch="+ubran+"&role="+role,
	        scrollY:        '50vh',
	        scrollCollapse: true,
	        "createdRow": function ( row, data, index ) {
	        		var quantity=$('td', row).eq(7).html();      	
	        		var minLevel= $('td', row).eq(9).html();
	       
		         if((minLevel != null || minLevel != "") && parseInt(quantity) < parseInt(minLevel))
		       	 {
               		$('td', row).addClass('highlight');
		        	 }
	        	}, 
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
	    if(role!=null && role=="1")
		{
	    	  table.column(10).visible(false);
		
		}
	    function hideprices()
	    {
	    	var elements = document.getElementsByClassName('price');

	        for (var i = 0; i < elements.length; i++){
	        	elements[i].style.display = "table-cell";
	        }
	        table.column(10).visible(true);
	    }
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
</script>






  </body>
</html>