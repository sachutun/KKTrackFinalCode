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
Statement st3 = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs2,rs3 = null;


/* SELECT S.Branch,
B.Code,
B.CostPrice,
S.CustomerName,
S.Date,
S.Id
FROM Sale S  inner join BillDetails B on S.Id=B.DC inner join CodeList C on B.Code=C.Code
INNER JOIN (
SELECT S.Branch,
  MAX(S.Id) AS 'tranc_date'
FROM Sale S
where S.Id in(SELECT DC FROM BillDetails where Code='3320')
GROUP BY S.Branch  ) last_tranc ON S.Branch = last_tranc.Branch AND S.Id = last_tranc.tranc_date
where B.code='3320'*/

/*SELECT S.Branch,
B.Code,
B.CostPrice,
S.CustomerName,
S.Date,
S.Id
FROM Sale S  inner join BillDetails B on S.Id=B.DC inner join CodeList C on B.Code=C.Code

WHERE S.Id IN (SELECT MAX(S.Id)
              FROM Sale S
              where S.Id in(SELECT DC FROM BillDetails where Code='3320')
              GROUP BY S.Branch)
AND B.Code='3320'*/

/* SELECT
Branch, Id, Date
FROM
(
SELECT
Branch, Id, Date,
@rn := IF(@prev = Branch, @rn + 1, 1) AS rn,
@prev := Branch
FROM Sale
JOIN (SELECT @prev := NULL, @rn := 0) AS vars
ORDER BY Branch, Id DESC
) AS T1
WHERE rn <= 2 */

/* SELECT
Branch, Code, CostPrice,Date, Id, rn
FROM
(
SELECT
 Branch, S.Id, Date,Code,CostPrice,
@rn := IF(@prev = Branch, @rn + 1, 1) AS rn,
@prev := Branch
FROM Sale S inner join BillDetails on S.Id=BillDetails.DC
JOIN (SELECT @prev := NULL, @rn := 0) AS vars 
ORDER BY Branch, S.Id DESC,BillDetails.DC Desc, Date desc
) AS T1
WHERE rn <= 2 and Code='3320' order by Branch */
%>

<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- Price Check</title>

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
    td.highlight {
        font-weight: bold;
        color: #ce1a1a;
    }
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

            <!-- sidebar menu-->
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
 <form id="FormId" action="PurchasePriceCheck.jsp" method="post" class="form-horizontal form-label-left">
    <!--  <div class="col-md-4 col-sm-6 col-xs-12">
                        <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                          <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                          <span id="daterange"></span> <b class="caret"></b>
                            <input id="std" name="std" class="form-control col-md-7 col-xs-12" type="hidden" > 
                  <input id="end" name="end" class="form-control col-md-7 col-xs-12" type="hidden" > 
                        </div>
                      </div> -->
 <label class="control-label col-md-1 col-sm-1 col-xs-2" for="sno" style="  "> Code:</label>
                        <div class="col-md-1 col-sm-3 col-xs-3">
                          <input type="text" id="code" class="form-control col-md-7 col-xs-12" name="code">
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
    
<%  String branch = request.getParameter("branch");

if(role!=null && !(role.equals("1")))
{
	if(role.equals("2") || role.equals("4"))
	   branch=uBranch; 
}
if(branch!=null && branch.equals("All"))
    branch="";
/* String std=request.getParameter("std");
 String end=request.getParameter("end");	 */
 String code=request.getParameter("code");	
 if(code==null)
	 code="";
                   %>
             

            <br/>
    

            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2 style="text-align:center; font-size:large">Last 5 Prices of  <b><%=code %></b></h2>
              
  <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  
                  <%
try{ 
	/*  Context context = new InitialContext();
	  Context envCtx = (Context) context.lookup("java:comp/env");
	  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
	  if (ds != null) {
		  connection = ds.getConnection(); */
		  
		  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	 	  //   connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
   
    if (driver != null) {
        Class.forName(driver).newInstance();  
    }
    connection = DriverManager.getConnection(url, username, password);		  
statement=connection.createStatement();
st=connection.createStatement();
st2=connection.createStatement();
st3=connection.createStatement();
String sql1="";
int primaryKey=0;
String sqlc="";
String o=" order by p.Id Desc Limit 5"; 
//String sql ="SELECT * FROM Sale s inner join BillDetails b on s.Id=b.DC inner join CodeList c on b.Code=c.Code WHERE  month(Date)=month(CURRENT_DATE) and year(Date)=year(CURRENT_DATE) ";
/* if (branch!=null && branch.length()!=0 )
	sql1 ="SELECT * FROM Sale s inner join BillDetails b on s.Id=b.DC inner join CodeList c on b.Code=c.Code WHERE  month(Date)=month(CURRENT_DATE) and year(Date)=year(CURRENT_DATE)  "; */

	if(code!="" && code!=null && code.length()!=0)
	{
		//sqlc="SELECT s.Branch, b.Code, b.CostPrice, s.Id,s.DCNumber, s.Date From Sale s inner join BillDetails b on s.Id=b.DC inner join CodeList c on b.Code=c.Code where s.Id in(SELECT DC FROM BillDetails where Code='"+code+"') and b.Code='"+code+"'";
	    sqlc="SELECT p.Branch, i.Code, i.Price,i.Qty, p.Id,p.InvoiceNumber, p.Date From Purchases p inner join InvoiceDetails i on p.InvoiceNumber=i.InvoiceNo  where i.Code='"+code+"'";  
	}

String w="";
if(branch!=null && branch!="")
 w += " and p.Branch='"+branch+"'";


sqlc+=w+o;
//sqlc+=o;


if(code!="" && code!=null && code.length()!=0)
{
	resultSet = statement.executeQuery(sqlc);
	System.out.println(sqlc);
}

else
{
//resultSet = statement.executeQuery(sql);
//System.out.println(sql);

}
%>
        
                     <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                        <tr>
                            <tr>
                           
                                            <th>Branch</th>
                                            <th>Date</th>
                                           <!--  <th>Code</th> -->
                                           <!--  <th>Sale Price</th> -->
                                              
											<th> Quantity</th>
                                            <th>Total Price</th>
                                            <th>Invoice No</th>
                                        </tr>
                      </thead>
                           <tfoot>
            <tr >
                <th colspan="3" style="text-align:right">Avg Price:</th>
                <th colspan="2" ></th>
            </tr>
        </tfoot>
                        <tbody id="country">

<%
if(resultSet!=null)
{
while(resultSet.next()){

	Date date=resultSet.getDate("Date");
	double cp=Math.round(resultSet.getFloat("i.Price")+resultSet.getFloat("i.Price")*(0.18));
	String costp=String.format("%,.2f",cp);
%>

                                        <tr class="odd gradeX">
                                       
<td><%=resultSet.getString("Branch") %></td>
<td width="10%"><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td><%=resultSet.getInt("i.Qty") %></td> 

<%-- <td ><%=resultSet.getString("b.Code") %></td> --%>
<%-- <td ><%=resultSet.getString("b.CostPrice") %></td> --%>
<td><%=costp%></td>
<td><%=resultSet.getString("InvoiceNumber") %></td>
<%-- <td><a style="color: #35c335;" target="_blank" href="viewInvoice.jsp?dc=<%=resultSet.getString("InvoiceNumber") %>&sd=<%=new SimpleDateFormat("yyyy-MM-dd").format(resultSet.getDate("Date") ) %>&branch=<%=resultSet.getString("Branch") %>&callingPage=PurchasePriceCheck.jsp"> <%=resultSet.getString("InvoiceNumber")%></a></td> --%>


                                        <%
 }
}
%>

</tbody>
                    </table>
                  </div>
                  <% 


	  

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
     <script src="build/js/shortcut.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
 <script>
    var ubran=document.getElementById('ubran').value;
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


	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	 $.getScript("js/rolePermissions.js");

	   
var table=$('#ex').DataTable( {
	     
	        "iDisplayStart":0,
	        "lengthMenu": [[25, 50, -1], [25, 50, "All"]],
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
	              var api = this.api();
	              
	              var columnData = api
	                  .column( 3 )
	                  .data();
	           
	              var theColumnTotal = columnData
	                  .reduce( function (a, b) {
	                  
	                      return (intVal(a) + intVal(b)).toFixed(2);
	                  }, 0 );
	            	  var total=0;
	            	  if(theColumnTotal!=0 && columnData.count()!=0)
	            	  {
	            	      total=theColumnTotal / columnData.count();
	            	  }
	              // Update footer
	              $( api.column( 3 ).footer() ).html(
	            		  total.toLocaleString('en-IN', {
	                  	    maximumFractionDigits: 2,
	                  	    style: 'currency',
	                  	    currency: 'INR'
	            		  })
	              );
	   
	          
	          },
	          scrollY:        '53vh',
		        scrollCollapse: true,
		    
	      
	        dom: 'lfrtip'/* ,
	        buttons: [
	            'copy', 'excel', 'pdf', 'print'
	        ] */
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

	
    
       	localStorage.setItem("branch", document.getElementById('branch').value);
    	localStorage.setItem("code", document.getElementById('code').value);
/*    	localStorage.setItem("sd", document.getElementById('single_cal3').value);
	localStorage.setItem("pd", document.getElementById('da1').value); */
	/* localStorage.setItem("dc", document.getElementById('dc').value); */
}
$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");

	 var s = document.getElementById("branch");
	
	 document.getElementById('code').value=localStorage.getItem("code"); 
	 
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
	    	localStorage.setItem("code", "");
	  /*   	localStorage.setItem("sd", ""); */
	  /*   	localStorage.setItem("dc", ""); */
/* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
});
</script> 
</body>
</html>









