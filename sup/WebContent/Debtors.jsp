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
Statement st2 = null;
ResultSet resultSet = null;
ResultSet rs2 = null;
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
   <!-- Datatables -->
    <link href="vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
    <link href="vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/jquery.dataTables.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
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
        <div class="right_col " role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>Debtors <!-- <small>Some examples to get you started</small> --></h1>
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

          
<form action="Debtors.jsp" method="post" class="form-horizontal form-label-left" >

                  
                  <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
             <div class="col-md-3 col-sm-3 col-xs-4">
                          <select class="select2_single form-control hide4branch" tabindex="-1" name="branch" id="branch">
                            <option value="">Select Another Branch</option>
                            <option value="All">All Branches</option>
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
              
 <div class="table-responsive"> 
                  <table class="table" >
       
        <tbody>
          
            <tr id="filter_col" >
            
                <td align="center">Name: <input type="text" class="column_filter" id="col1_filter" data-column="1"></td>
        
                <td align="center">Customer ID: <input type="text" class="column_filter" id="col0_filter" data-column="0"></td>
  
  
            </tr>
        </tbody></table></div>
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2> Debtors OB</h2>
                    
               <%  String branch = request.getParameter("branch");
            
               if(role!=null && !(role.equals("1")))
            	   branch=uBranch; 
               if(branch==null || branch.equals("All"))
               branch="";
            
                   %>
                    <label style="float:right" id><%= branch %></label>
  <div class="clearfix"></div>
  
                  </div>
                  <div class="x_content">
                    
                 <div class="table-responsive"> 
                    <table id="ex" class=" display table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                       <tr>
                            <tr>
                                          
                                            <th width="10%">Cust ID</th>
                                            <th width="30%">Name</th>
                                            <th>Mobile</th>
                                            <th>OB</th>
                                            <th>Pay</th>
                                            <th class="none">Previous Payment Details
                                            </th> 
                                    
                                        </tr>
                                        
                      </thead>
                     <tfoot>
            <tr>
                
                <th></th>
                <th></th>
                <th></th>
                
                <th style="text-align:right">Total:</th>
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
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
    // connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
      if (driver != null) {
        Class.forName(driver).newInstance();  
    } 

    connection = DriverManager.getConnection(url, username, password);
statement=connection.createStatement();
st2 = connection.createStatement();

String sql ="select * from Debtors where 1";
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
                                        <td><%=resultSet.getString("CustID")  %></td>
                                        
<td><%=resultSet.getString("CustomerName") %></td>
<%String mobile="";
String additionalMobile=resultSet.getString("AdditionalMobile");
if(additionalMobile!=null && additionalMobile!="")
	mobile=resultSet.getString("Mobile") +","+ additionalMobile;
else
  	mobile=resultSet.getString("Mobile");%>
<td><%=mobile %></td>

<td><%=resultSet.getInt("OB") %></td>
   <td> 
   
                 
                    <form id="form2" action="DebtorsBalPay.jsp" method="post">
                     <div class="form-group">
                  <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="amtPaid"> Amount:</label>
                <input type="text" id="amtPaid" name="amtPaid" style="width: 80%;" min="0" max=<%=resultSet.getInt("OB")%> required="true"> 
             </div>
             <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="disc" style="margin-left: 17%;"> Discount:</label>
                <input type="text" id="disc" name="disc" style="margin-left: 17%;width: 80%;"> 
             </div>
                <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="pdate"> Date:</label>
                <input  required  type="text" id="pdate<%=resultSet.getString("CustID")%>" name="pdate<%=resultSet.getString("CustID")%>" class="dateField datepicker" > 
</div>

                       <div class="col-md-7 col-sm-3 col-xs-4">
                       <label for="comments"> Comments:</label>
                       <textarea id="comments" class="form-control col-md-7 col-xs-12" name="comments" style="width: 150%;"></textarea>
                       </div>
        
        			<input id="branch" name="branch" type="hidden" value=<%=branch %>> 
                  <input type="hidden" id="ob" name="ob" value=<%=resultSet.getInt("OB") %> > 
                   <input type="hidden" id="custId" name="custId" value=<%=resultSet.getString("CustID")  %> > 
             <input type="hidden" id="Id" name="Id" value=<%=resultSet.getInt("Id") %> >
             
         <!--      <div class="form-group" style="margin-left:40%; margin-top: 3%;"> -->
             <button type="submit" class="btn btn-success" style="float:right;margin-top: 6%;">Pay</button>
         </div> 
             </form>
            
             </td>

                                        <% 


//} 
//System.out.println("SELECT * FROM SaleCredit where CustID="+resultSet.getString("CustID"));
//rs2 = st2.executeQuery("SELECT * FROM SaleCredit where Ino="+resultSet.getString("CustID"));
PreparedStatement statement2 = connection.prepareStatement("select * from SaleCredit where CustId = ?");    
statement2.setString(1, resultSet.getString("CustID")); 
rs2 = statement2.executeQuery();                    
if(!rs2.isLast() && ((rs2.getRow() != 0) || rs2.isBeforeFirst()))
{

                     	%>
                     <td><table width="100%" id="" class="table table-striped table-bordered">
                                           <thead>
                                            <tr> 
                                                  <tr> 
                                                                 
                                                                 <th>Amount</th>
                                                                 <th>Discount</th>
                                                                 <th>Date</th>
                                                                 <th>Comments </th>
                                                                 <th> Delete </th> 

                                                             </tr>
                                           </thead>
                                             <tbody >
                                               <tr class="odd gradeX">
                                               <%while(rs2.next()){
                                             		 %>
                                               <td><%=rs2.getInt("Amount") %></td>
                                               <td><%=rs2.getInt("Discount") %></td>
                     <td><%=rs2.getString("Date") %></td>
                     <%
                     String comm="";
                    	 if(rs2.getString("Comments") == null) 
                     	comm="";
                     else
                     	comm=rs2.getString("Comments");%>
                     <td><%=comm %></td>
                    <td>
     <a class="btn btn-danger" onclick="return confirm('Do you really want to delete this record?')" href=<%= "\"DeleteDebtorPayment.jsp?deleteId=" + rs2.getInt("Id") +"&amt="+rs2.getInt("Amount")+ "&disc="+rs2.getInt("Discount")+"&CustId="+rs2.getString("CustId")+"&OB="+resultSet.getInt("OB")+"&branch="+branch+"\"" %> > <i class="fa fa-trash-o"></i></a> 
</td>
                    </tr>
                   <%}
                                               %>
                                                </tbody> </table>  </td>
                                                <% } 
                   else
                   {
             
                   %>
                   <td></td>
                                                          
                   <% 
                  
                   } 
%>
</tr>
 <% }

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
	    } %>


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
   
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap-datetimepicker -->    
    
    <script src="vendors/bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min.js"></script>
    <script src="vendors/jszip/dist/jszip.min.js"></script>
    <script src="vendors/pdfmake/build/pdfmake.min.js"></script>
    <script src="vendors/pdfmake/build/vfs_fonts.js"></script>
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
/*     function dch() { 
  	  var d=document.getElementById("single_cal3").value.toString();
  	var dv=d.split("/");
  	var da=dv[2]+'-'+dv[0]+'-'+dv[1];
  	  document.getElementById('da').value=da;
  	} */
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

    	localStorage.setItem("daterange", document.getElementById('daterange').innerHTML);
    } 
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");
	 var s = document.getElementById("branch");
	 document.getElementById('sno').value=localStorage.getItem("sno");
	// document.getElementById('daterange').innerHTML=localStorage.getItem("daterange"); 
	// document.getElementById('std').value=localStorage.getItem("std"); 
	// document.getElementById('end').value=localStorage.getItem("end"); 
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
	  //  	localStorage.setItem("daterange", "Select Date Range"); 
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
	   $(".dateField").datepicker({
	        autoclose: true,
	        showOtherMonths: true,
	        selectOtherMonths: true,
	        gotoCurrent: true,
	        dateFormat: 'yy-mm-dd',
	        closeText: "Clear"	        
	    });	
	   $(".dateField").keydown(function (event) {
	        event.preventDefault();
	    });
	   $.getScript("js/rolePermissions.js");
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
/* 	var environment=document.getElementById('uenv').value;
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
	    
		document.getElementById("br").style.display="block";
	} */

	
	/*  var h= $('.right_col').min-height()+20;
	 $('.right_col').animate({height:h}, 500); */
var table=$('#ex').DataTable( {
	     
	        "iDisplayStart":0,
 	       // "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
 	       "lengthMenu":[[5, 10, 15, 20, -1], [5, 10, 15, 20, "All"]],
 //"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
	        "order": [[ 0, "desc" ]],
	      /*   "columnDefs": [
	            { "visible": false, "targets": 0 }
	          ], */
	          'responsive': true,
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
	                  .column( 3 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Total over this page
	              pageTotal = api
	                  .column( 3, { page: 'current'} )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	   
	              // Update footer
	              $( api.column( 3 ).footer() ).html(
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
	        select:true,
	        enabled: true,
	        buttons: [
	            'copy', 'excel', 'pdf', 'print'
	        ] 
	    } );
		  
		 var oTable = $('#ex').DataTable();
	    $('#ex').on('draw.dt', function () { 
	     
	        $(".dateField").datepicker();
	    });
	    $('.dateField').click(function() {
			var i =$(this).attr('id'); 
			//alert("0: "+i);
			 var v =$(this).val(); 
		     //   alert(v);
		    	v = new Date(date).getTime();
	        $(".dateField").datepicker();
	    });
	    $(".dateField").datepicker({
	        autoclose: true,
	        showOtherMonths: true,
	        selectOtherMonths: true,
	        gotoCurrent: true,
	        dateFormat: 'yy-mm-dd',
	        closeText: "Clear"
	        
	    });	  
	    $(document).on("click", ".ui-datepicker-close", function(){
	        $('.datepicker').val("");
	        dataTable.columns(pdate).search("").draw();
	    });
	    $(".dateField").keydown(function (event) {
	        event.preventDefault();
	    });
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