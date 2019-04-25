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
Statement st = null;
Statement st2 = null;
Statement st3 = null;
DataSource ds = null;
Connection conn = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs2 = null;
int sno=1;
int i=0;
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
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- Sale</title>

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
function showCustomer(custID){ 
	if (typeof XMLHttpRequest != "undefined"){
   		xmlHttp1= new XMLHttpRequest();
       }
    else if (window.ActiveXObject){
   		xmlHttp1= new ActiveXObject("Microsoft.XMLHTTP");
    }
	if (xmlHttp1==null){
    		alert ("Browser does not support XMLHTTP Request")
		return
	} 
	var url="getCreditCustomers.jsp";
	var creditcustID=document.getElementById("custIdCode").value+custID;
	url += "?creditcustID=" +creditcustID+"&branch="+document.getElementById("branch").value;
	
	xmlHttp1.onreadystatechange = getCustomer;
	xmlHttp1.open("GET", url, true);
	xmlHttp1.send(null);
}
  
 function getCustomer(){  
	 var res="";
	 var creditMsg="";
	 document.getElementById("creditMsg").style.color = "blue";
	 document.getElementById("creditMsg").style.fontSize = "medium";
	  if (xmlHttp1.readyState==4 || xmlHttp1.readyState=="complete"){   
		  
	 	 var data=xmlHttp1.responseText;
	 	
	 	 var dv=data.split(",");
	 	//alert("dv[0]: "+dv[0]);
	 	 document.getElementById("cusnam").value=dv[0];
	 	 document.getElementById("cusno").value=dv[1];
	       document.getElementById("cusnam").readOnly = true;
			 document.getElementById("cusno").readOnly = true;
	 /* 	if(dv[3]!="" && dv[3]!=null)
	 		document.getElementById("aadhaar").value=dv[3];
	 	else
	 		document.getElementById("aadhaar").value=""; */
		var gst=dv[4];
		if(gst!="" && gst!=null)
			{
			document.getElementById("GST").value=gst;	
			document.getElementById('taxInvoice').checked=true;
	        document.getElementById('GSTdiv').style.visibility = 'visible';
	        document.getElementById('GSTLabel').style.visibility = 'visible';
	        document.getElementById('GST').required = true;

	       /*  document.getElementById("GST").readOnly = true; */

	       // document.getElementById("GST").readOnly = true;

			}
		else
			{
			document.getElementById("GST").value="";	
			document.getElementById('generalInvoice').checked=true;
	        document.getElementById('GSTdiv').style.visibility = 'hidden';
	        document.getElementById('GSTLabel').style.visibility = 'hidden';
	        document.getElementById('GST').required = false;
	        //document.getElementById("GST").readOnly = false;
			}
	 	 res="update";
	 	
	 	creditMsg = "Existing credit balance:" +dv[2];
       
	 	 if(dv[5]==0)
	 		 {
	 		var answer = confirm("Credit Customer ID does not exists.\nDo you want to add the Credit Customer?");
	 	
	 		if (answer) {
	 		     document.getElementById("cusnam").focus();
	 			 document.getElementById("cusnam").readOnly = false;
	 			 document.getElementById("cusno").readOnly = false;
	 			// document.getElementById("aadhaar").readOnly = false;
	 			 //document.getElementById("GST").readOnly = false;
	 			  	document.getElementById('cusnam').value=localStorage.getItem("cusnam"); 
	 			 	document.getElementById('cusno').value=localStorage.getItem("cusno"); 
	 			document.getElementById("GST").value="";	 			
				document.getElementById('generalInvoice').checked=true;
		        document.getElementById('GSTdiv').style.visibility = 'hidden';
		        document.getElementById('GSTLabel').style.visibility = 'hidden';
		   	  document.getElementById('GST').required = false;
	 			creditMsg="Add the above Customer!"
	 			res="insert";
	 		}
	 		else {
	 		document.getElementById("GST").value="";	 			
			document.getElementById('generalInvoice').checked=true;
	        document.getElementById('GSTdiv').style.visibility = 'hidden';
	        document.getElementById('GSTLabel').style.visibility = 'hidden';
	        document.getElementById('GST').required = false;
	        document.getElementById("cusnam").readOnly = true;
			 document.getElementById("cusno").readOnly = true;
				document.getElementById('cusnam').value=localStorage.getItem("cusnam"); 
 			 	document.getElementById('cusno').value=localStorage.getItem("cusno"); 
 		
 				document.getElementById("creditCustId").value="";	 
			// document.getElementById("aadhaar").readOnly = true;

			/*  document.getElementById("GST").readOnly = true; */

			 //document.getElementById("GST").readOnly = true;

	 		 res="error";
	 		creditMsg="Please enter valid Credit Customer Id to proceed."
	 		document.getElementById("creditMsg").style.color = "#ff0000";
	 		 }
	 		 }
	  }
	  //alert(creditMsg);
	  //alert(res);
	  document.getElementById("creditMsg").innerHTML = creditMsg;
	 
	  document.getElementById("CrediCustStatus").value=res;
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
String uBranch=(String)session.getAttribute("ubranch");
String role=(String)session.getAttribute("role");   
String user=(String)session.getAttribute("user"); 
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
              <div class="title_left">
                <h1>Sale Edit <!-- <small>Some examples to get you started</small> --></h1>
              </div>
               <div style="overflow: auto">
             <div class="row">
            <!--    <form id="FormId" action="editpurindividual.jsp" method="post" > -->
            <%--   <div style="float:right;" class="col-md-4">
               
<label class="control-label" style="float: left;">Return Date</label> 
                   <div class="col-md-8" >
                         <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text"  value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-11 xdisplay_inputx form-group has-feedback">
                                <input onchange="dch('single_cal4')" name="dateval" type="text" class="form-control has-feedback-left" name="rd" id="single_cal4" aria-describedby="inputSuccess2Status3">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>
                         <input id="da2" class="form-control col-md-7 col-xs-12" type="hidden" name="RetDate" >
                          <%   rd = request.getParameter("RetDate");
                   if(rd ==null)
                	   rd="";
                   %>
                      </div></div> --%>
            <div class="clearfix"></div>
            

                      </div>
                    </div> 
                    
                     </div>
                     
       <br/>              
 <div style=" float:right; margin-right: 10px; margin-top:-20px">


                  <a href="viewsale.jsp" style="color:white;">  <button type="button" class="btn btn-info">View </button></a>

                 <a href="editSale.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Go Back to Edit</button></a>
             </div>   
     <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Sale updated successfully.</strong></div></div>";
 String succ2="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Sale deleted successfully.</strong></div></div>";
 String succ3="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Added to Invoice successfully.</strong></div></div>";
 String succ4="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Added to Memo successfully.</strong></div></div>";
%>
  <div id="successMsg" >
<%  if(r!=null && r.equals("1"))
        	out.println(succ);
  else if(r!=null && r.equals("2"))
	 out.println(succ2); 
  else if(r!=null && r.equals("5"))
		 out.println(succ3); 
  else if(r!=null && r.equals("3"))
		 out.println(succ4); 
     %>
     </div>
<!--       <span id="errorMsg"></span>  -->
      <div id="errorMsg" class="col-md-12" style= "float:left; display: none">
      <div class="alert alert-danger alert-dismissible fade in" role="alert">
      <button type="button" class="close" onclick="ref()" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">×</span></button>
      <strong>Please select atleast one checkbox to delete the record</strong>
      </div>
      </div>
          <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  
                  <%  String branch = request.getParameter("branch"); %>
                 
                    <div class="clearfix"></div>
                  
                  <div class="x_content">
                 
        <form id="form1" action="saledit.jsp">   
        
             <%--    <input type="hidden" id="sno" name="sno" value=<%=sno%> > --%>
                         <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>>
                  <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>>
              <div class="table-responsive"> 
       <table class="table  dt-responsive" width="100%">
               
                        <tbody>
                        <%
try{ 
	 int mflag=0;
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");
statement=connection.createStatement(); */
String dc=request.getParameter("dc");
/* System.out.println(dc); */
String cn=request.getParameter("sd");
String pk=request.getParameter("pk");

/* System.out.println(cn);
System.out.println(branch); */
/* st=connection.createStatement(); */

/* Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    conn = ds.getConnection(); */
   
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
     //conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
    if (driver != null) {
        Class.forName(driver).newInstance();  
    }
    conn = DriverManager.getConnection(url, username, password);
    st = conn.createStatement();
String sql1 ="SELECT DISTINCT * FROM Sale";
String whr=" where";

 if(branch!=null && branch.length()!=0 )
{
	whr+=" Branch='"+branch+"'";
}
if(dc!=null && dc.length()!=0 )
{
	whr+=" and DCNumber='"+dc+"'";
}
if(cn!=null && cn.length()!=0 )
{
	whr+=" and Date='"+cn+"'";
} 
if(pk!=null && pk.length()!=0 )
{
	whr+=" and Id='"+pk+"'";
}
sql1+=whr;
 System.out.println(sql1); 
 if((dc.startsWith("m")||dc.startsWith("M")||dc.startsWith("WSM")||dc.startsWith("WS M") ||dc.startsWith("WSm")||dc.startsWith("WS m")) && !(dc.substring(0,2).equals("MY"))) 
	mflag=1;

if(branch!=null && dc!=null && cn!=null)
{
resultSet = st.executeQuery(sql1);

while(resultSet.next()){
	String sql2="SELECT BillDetails.Code,BillDetails.Id,BillDetails.DC, CodeList.Description, CodeList.Machine, CodeList.PartNo,  CodeList.Grp,CodeList.MinPrice, CodeList.MaxPrice, BillDetails.CostPrice, BillDetails.Qty, BillDetails.Total, BillDetails.Notes FROM BillDetails inner join CodeList on BillDetails.Code=CodeList.Code where DC=";
	int	primaryKey = resultSet.getInt("Id");
	String whr2=primaryKey+"";
	sql2+=whr2;
	String existingtype=resultSet.getString("Type");
	   st2 = conn.createStatement();
	   st3 = conn.createStatement();
	   String sql3="";
	   String cusbank="";
	   String kkbank="";
	   String bankname="";
	   String chkno="";
	   String chkdate="";

	   //Date chkdate=new Date();
	    // System.out.println("---existingtype---" +existingtype);
	   if(existingtype.contains("Neft"))
	   {
		   sql3="SELECT * from BankDetails where Type='sale' and Id="+primaryKey;
		   //System.out.println("---sql3 neft---" +sql3);
		   rs2=st3.executeQuery(sql3);
		   while(rs2.next())
		   {
			   cusbank=rs2.getString("CSBankName");
			   kkbank=rs2.getString("KKBankName");
			   
		   }
		   //System.out.println("---cusbank neft---" +cusbank);
		   //System.out.println("---kkbank neft---" +kkbank);
	   }
	   if(existingtype.contains("Cheque"))
	   {
		   sql3="SELECT * from ChequeDetails where Type='sale' and Id="+primaryKey;
		  // System.out.println("---sql3 cheque---" +sql3);
		   rs2=st3.executeQuery(sql3);
		   while(rs2.next())
		   {
			   bankname=rs2.getString("BankName");
			   chkno=rs2.getString("ChequeNo");
			   chkdate=new SimpleDateFormat("MM-dd-yyyy").format(rs2.getDate("Date"));
		   }
		  // System.out.println("---bankname cheque---" +bankname);
		  // System.out.println("---chkno cheque---" +chkno);
		  // System.out.println("---chkdate cheque---" +chkdate);
	   }
	  
	rs = st2.executeQuery(sql2);
	Date date=resultSet.getDate("Date");
	  String gst = resultSet.getString("GST");
	  
	
%>
                                        <tr class="odd gradeX">


<td><strong> Branch: </strong> <%=resultSet.getString("Branch") %></td>
<td><strong> Date: </strong><input class="col-md-12" type="text" id="date" name="date" value="<%=new SimpleDateFormat("dd-MM-yyyy").format(date) %>" ></td>

<td><strong> DCNumber: </strong><%=resultSet.getString("DCNumber") %></td>
<%String custId="";
if(resultSet.getString("CustID")!=null && resultSet.getString("CustID")!="")
{
	custId=resultSet.getString("CustID");
	%>
	<td width="10%"><strong> Credit CustId: </strong><%=custId %></td>
	<% 
}
%>
<td><strong> Customer Name: </strong><input class="col-md-12" type="text" id="cusnam" name="cusnam" value="<%=resultSet.getString("CustomerName") %> "></td>
<td><strong> Customer No: </strong><input class="col-md-10" type="number" id="cusno" name="cusno" value="<%=resultSet.getString("CustomerNumber") %>" maxlength = "10" oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength);"></td>
<td><strong> TotalPrice: </strong><input class="col-md-12" type="text" style="border:none;" id="totalprice" name="totalprice" value="<%=resultSet.getDouble("TotalPrice") %> "> </td>
<td><strong> Amount Paid: </strong><input class="col-md-8 disable4Credit" type="number" id="ap" name="ap" value=<%=resultSet.getString("AmountPaid") %> onchange="balcalc()"></td>
<td><strong> Tax Amount: </strong><input class="col-md-8 disable4Credit" type="number"  id="tax" name="tax" value=<%=resultSet.getString("Tax") %> onchange="calculatetax()"></td>
<td><strong> Discount: </strong><input class="col-md-8 disable4Credit" type="number" id="dis" name="dis" min="0" value=<%=resultSet.getString("Discount") %> onchange="calculatedis()"></td></tr>

                      </tbody>
                    </table>
                    <table  class="table table-striped table-bordered">
                      <thead>
                        <tr>
                            <tr>
                                           <th>S.no</th>
                                           <th>Code</th>
                                            <th>Description</th>
                                            <th>Machine</th>
                                            <th>Part No</th>
                                            <th>Group</th> 
                                            <th>Sale Price</th>
                                            <th>Quantity</th>
                                            <th>
                                            <input class=" cboxes disableButton4Credit" type='checkbox' name='selectAllCheck' onClick='funcSelectAll()' value='Select All'></input>
                                            Select All
                                          </th>
              <%if(mflag==1) {%>
              <th>Notes</th>
              <%} %>
                                        </tr>
                      </thead>
                        <tbody >
                          <tr class="odd gradeX">
                          <% 
                          //System.out.println("i values: ");
                       // create map to store
                          Map<Integer, List<String>> map = new HashMap<Integer, List<String>>();                      
                          while(rs.next())
						{
                        	 
                        	  List<String> list = new ArrayList<String>();
                        	  float bqty=rs.getFloat("BillDetails.Qty") ;
                        	   i=rs.getInt("BillDetails.Id") ;
                        	  // System.out.println(i);
                        	  
                        	   //System.out.println(rs.getString("BillDetails.DC") );
                        	   String cp="";
                      
                        	   cp=rs.getString("BillDetails.CostPrice");
                        	   double total=Double.parseDouble(cp) * bqty;
                        	   String bal=resultSet.getString("BalanceAmount");
                        	   
	%>

<td><%=sno%></td>
<td><%=rs.getString("BillDetails.Code") %></td>
<td><%=rs.getString("CodeList.Description") %></td>
<td><%=rs.getString("CodeList.Machine") %></td>
<td><%=rs.getString("CodeList.PartNo") %></td>
<td><%=rs.getString("CodeList.Grp") %></td>
<td><input type="number" class="cp disable4Credit" id="cp<%=i %>" name="cp<%=i %>" value=<%=cp%> onchange="calculate(<%=i %>)"  ></td>
<td><input type="number" class=" qnty disable4Credit" step="any"  id="nq<%=i %>" name="nq<%=i %>" value=<%=bqty%> onchange="calculate(<%=i %>)" >   
               <%--  <input type="number" id="dq<%=i %>" name="dq<%=i %>" value="0" style="width: 80%;margin-left: 7%;" min="0" max="<%=bqty%>">  --%>
          <%--        <input type="hidden" id="ap" name="ap" value=<%=resultSet.getString("AmountPaid")%> > --%>
                <input type="hidden" id="ba" name="ba" value=<%=bal%> > 
           <input type="hidden" id="oldba" name="oldba" value=<%=bal%> > 
                <input type="hidden" id="q<%=i %>" name="q<%=i %>" value=<%=bqty%> > 
               <%--  <input type="hidden" id="cp<%=i %>" name="cp<%=i %>" value=<%=rs.getString("BillDetails.CostPrice")%> > --%>
                 <input type="hidden" id="bid<%=i %>" name="bid<%=i %>" value=<%=i%> >
                 <input type="hidden" class="cde" id="code<%=i %>" name="code<%=i %>" value=<%=rs.getString("BillDetails.Code")%> >
                <input type="hidden" id="payid" name="payid" value=<%=primaryKey %> > 
                <input type="hidden" id="branch" name="branch" value=<%=branch %> > 
                <input type="hidden" id="ocp<%=i %>" name="ocp<%=i %>" value=<%=rs.getString("BillDetails.CostPrice")%> > 
                <input type="hidden" id="tp" name="tp" value=<%=resultSet.getDouble("TotalPrice") %> > 
                <input type="hidden" id="i" name="i">  
               <input type="hidden" id="total<%=i %>" name="total<%=i %>" value=<%=total %>>  
       
          <input type="hidden" id="custId" name="custId" value=<%=custId%> > 
                <input type="hidden" id="dc" name="dc" value=<%=dc%> > 
                 <input type="hidden" id="dcno" name="dcno" value=<%=resultSet.getString("DCNumber")%> > 
                 <input type="hidden" id="ddd" name="ddd" value=<%=cn%> >  
               <input type="hidden"  name="ids[]" class="billIds"  value="<%=i %>" />
</td>
<%-- <td style="width: 10%;"><a href="delsal.jsp?deleteid=<%=primaryKey %>&branch=<%=branch %>&dc=<%=dc%>&sd=<%=cn%>&ba=<%=resultSet.getString("BalanceAmount")%>&code<%=i %>=<%=rs.getString("BillDetails.Code")%>&q<%=i %>=<%=bqty%>&cp<%=i %>=<%=rs.getString("BillDetails.CostPrice")%>&bid<%=i %>=<%=i %>&tp=<%=resultSet.getDouble("TotalPrice") %>&i=<%=i %>" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a> </td> --%>

<%--  <td><button onclick="f(<%=i%>)" type="button" class="btn btn-danger btn-sm" data-toggle="modal" data-target=".bs-example-modal-sm"><i class="fa fa-trash-o"></i></button></td> --%>

  <td>  <input type="checkbox" class="cboxes chkbox disableButton4Credit" name="checkboxRow" value="<%=i %>">   </td>     
     <%if(mflag==1) {
    	 String notes="";
    	 if (rs.getString("BillDetails.Notes")==null || rs.getString("BillDetails.Notes").length()==0)
    	 {
    		 notes=""; %>
    		  <td class="notes" width="20%"  ><%=notes%></td>
    	<%  }
    	 else
    	 {
    		 notes=rs.getString("BillDetails.Notes");
    		 int delimiter = notes.indexOf(",");
		String invNo = notes.substring(17, delimiter);
		delimiter = delimiter + 2;
		String invdate = notes.substring(delimiter);
	%>
    		   <td class="notes" width="20%" >Added to Invoice
<%--     		 <a href="viewInvoice.jsp?pk=<%=dc %>&recordtoupdate=<%=i %>&sd=<%=cn %>&dc=<%=dc%>&branch=<%=branch %>&code=<%=rs.getString("BillDetails.Code")%>&qty=<%=bqty%>&cp=<%=rs.getString("BillDetails.CostPrice")%>&notes=<%=notes %>" class="btn btn-success btn-xs"><%=invNo%></a> --%>
<%--     		<a class="btn btn-success btn-xs" href="viewInvoice.jsp?dc=<%=invNo %>&sd=<%=invdate %>&branch=<%=branch %>&memodc=<%=dc%>&memodate=<%=cn%>&memopk=<%=primaryKey%>&callingPage=editsalindividual.jsp"> <%=invNo%></a>  --%>
  
   <a style="color: #35c335;" href="editsalindividual.jsp?dc=<%=invNo %>&sd=<%=invdate %>&branch=<%=branch %>"> <%=invNo%></a>   		
    		
    		, <br/><br/> <%=invdate %> 
    		<br/>
    		<br/>
    		   <a style="color: red;" href="ConvertInvToMemo.jsp?recordtoupdate=<%=i %>&sd=<%=cn %>&dc=<%=dc%>&branch=<%=branch %>&code=<%=rs.getString("BillDetails.Code")%>&qty=<%=bqty%>&cp=<%=rs.getString("BillDetails.CostPrice")%>&notes=<%=notes %>" class="fa fa-undo"> Undo</a>
 </td>
    <%	 }
   
              } %>
</tr>
 <%
 
 list.add(String.valueOf(primaryKey));
 list.add(branch);
 list.add(dc);
 list.add(String.valueOf(bqty));
 list.add(cn);
 list.add(resultSet.getString("BalanceAmount"));
 list.add(rs.getString("BillDetails.Code"));
 list.add(rs.getString("BillDetails.CostPrice"));
 list.add(String.valueOf(resultSet.getDouble("TotalPrice")));
 list.add(String.valueOf(i));
 list.add(custId);
 list.add(existingtype);
 map.put(i, list);
 sno++;
} 
                          //System.out.println("Fetching Keys and corresponding [Multiple] Values n");
                          for (Map.Entry<Integer, List<String>> entry : map.entrySet()) {
                              int key = entry.getKey();
                              List<String> values = entry.getValue();
                             // String bv=values.get(9);
                            // System.out.println("Key = " + key);
                              //System.out.println("Values = " + values + "n");
                              
                              //System.out.println("bv = " + bv);
                          }
                          session.setAttribute("map", map);
                          //request.getRequestDispatcher("BulkDeleteSale.jsp").forward(request, response);
                        
 %>

</tbody> 
</table>
   <input type="hidden" id="mapValues" name="<%=map%>">  
   
<input type="hidden" id="existingTaxtype" name="existingTaxtype" value="<%=resultSet.getString("TaxType") %>"> 
<input type="hidden" id="existingTranstype" name="existingTranstype" value="<%=existingtype %>"> 
<label for="com" style="float:left;margin-left:10px"><strong> Comments: </strong></label><input class="col-md-4" type="text" id="com" name="com" style="margin-left:10px;" value="<%=resultSet.getString("Comments") %>">     

   <input class="col-md-4" type="hidden" id="comments" name="comments" style="margin-left:10px;" value="<%=resultSet.getString("Comments") %>">             
<br/> 
 
 <div class="form-group" style="margin-top:3%;">
                    <label class="control-label col-md-2 col-sm-2 col-xs-5">Type:<span class="required">*</span></label>
                      <%--   <div class="col-md-3 col-sm-3 col-xs-6" style="margin-left:-100px;">
                          <select id="transtype" class="select2_single form-control" tabindex="-1" name="transtype" required="required">
                            <option></option>
                            <%if(custId=="") {%>
                               <option value="Cash">Cash</option>
                            <option value="Neft">Bank Transfer</option>
                            <option value="Cheque">Cheque</option>
                            <option value="Swipe">Swipe</option>
                            <%}else{ %>
                             <option value="CreditCash">Credit Cash</option>
                             <option value="CreditNeft">Credit Bank Transfer</option>
                              <option value="CreditCheque">Credit Cheque</option>
                            <option value="CreditSwipe">Credit Swipe</option>
                            <%} %>
                          </select>
                        </div> --%>
                        
                         <div class="col-md-6 col-sm-3 col-xs-6" style="margin-left:-100px;">
                         <input type="checkbox" name="transtype" value="Cash"> <b>Cash </b>  &nbsp;  &nbsp;  &nbsp;
 						 <input type="checkbox" name="transtype" value="Neft"> <b> Bank Transfer </b> &nbsp; &nbsp; &nbsp;
  					<input type="checkbox" name="transtype" value="Cheque"> <b> Cheque </b> &nbsp; &nbsp; &nbsp;
  					<input type="checkbox" name="transtype" value="Swipe"><b> Swipe </b>
  					</div> 
                
                        </div>
                       <br/>
               
                   <div style=" border: 1px solid rgba(128, 128, 128, 0.2);margin-top: 3%;background-color: rgb(247, 247, 247);">
                     <b><p style="padding: 20px 50px 0px 38px;font-size: medium;">Amount Paid Details</p> </b>
                    <div class="form-group Cash bankdet" style=" display: none;  margin-top: 3%; padding: 20px 50px 50px 38px;/* border: 1px solid rgba(128, 128, 128, 0.2); */margin-bottom: 2%;/* background-color: rgb(247, 247, 247); */">
                        <b> <p id="Cashlabel"></p> </b>
                      
                       <label class="control-label col-md-2 col-sm-2 col-xs-5" style="margin-top:1%;margin-left:1%;width:200px;">Amount Paid(Cash):<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="cashAP" class="form-control col-md-7 col-xs-12" type="number" name="cashAP" onchange="calculateTotalAP();" min="0" value="<%=resultSet.getString("Cash")%>" >
                        </div> 
                    </div>
                   
                        <div class="form-group Neft bankdet" style=" display: none; padding: 20px 50px 50px 38px;/* border: 1px solid rgba(128, 128, 128, 0.2); *//* margin-bottom: 2%; *//* background-color: rgb(247, 247, 247); */">
                            <b> <p id="Neftlabel"></p> </b> 
                             <label class="control-label col-md-2 col-sm-2 col-xs-5" style="margin-top:1%;margin-left:1%;width:200px;">Amount Paid(NEFT/RTGS):<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="neftAP" class="form-control col-md-7 col-xs-12" type="number" name="neftAP" onchange="calculateTotalAP();" min="0" value="<%=resultSet.getString("Neft")%>">
                        </div>
                        <br/>
                        <br/>
                         <br/>
                       <label class="control-label col-md-3 col-sm-2 col-xs-3" style="margin-top:1%;margin-left:1%;width:200px;">Customer Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="cusbank" class="form-control col-md-7 col-xs-12" type="text" name="cusbank" value="">
                        </div>
                        
                        <label class="control-label col-md-2 col-sm-2 col-xs-3" style="margin-top:1%;margin-left:3%;">KK Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6" style="margin-left:-1%;" >
                        <input id="kkbank" class="form-control col-md-7 col-xs-12" type="text" name="kkbank" value="">
                        </div>  
                 
                        </div>
                        
                              <div class="form-group Cheque bankdet" style=" display: none; padding-left: 38px;padding-right: 50px;padding-top: 20px;padding-bottom: 50px;/* border: 1px solid rgba(128, 128, 128, 0.2); */margin-bottom: 2%;/* background-color: rgb(247, 247, 247); */">
                                 <b> <p id="Chequelabel"></p> </b> 
                                <!--  <br/>
                                 <br/> -->
                     
                        <label class="control-label col-md-2 col-sm-2 col-xs-5" style="margin-top:1%;margin-left:1%;width:200px;">Amount Paid(Cheque):<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="chequeAP" class="form-control col-md-7 col-xs-12" type="number" name="chequeAP" onchange="calculateTotalAP();" min="0" value="<%=resultSet.getString("Cheque")%>">
                        </div>
                        <br/> 
                      
<br/>
<br/>
  <label class="control-label col-md-2 col-sm-2 col-xs-3" for="bankname" style="margin-top:1%;margin-left:1%;width:200px;">Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                          <input id="bankname" class="form-control col-md-7 col-xs-12" type="text" name="bankname" value="<%=bankname %>" >
                        </div>
                        
                       <label class="control-label col-md-2 col-sm-2 col-xs-3" for="chkno" style="margin-top:1%;margin-left: 1%;">Cheque No:</label>
                        <div class="col-md-2 col-sm-3 col-xs-6" style="margin-left: -8%;">
                        <input id="chkno" class="form-control col-md-7 col-xs-12" type="text" name="chkno" value="<%=chkno %>" >
                        </div> 
                        <label class="control-label col-md-1 col-sm-2 col-xs-3" for="chkdate" style="margin-top:1%;">Date:<span class="required">*</span>
                        </label>
                      <div class="col-md-3" style="margin-left: -4%;">
                           <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-11 xdisplay_inputx form-group has-feedback">
                                <input onchange="dch1()" name="chkdate" type="text" class="form-control has-feedback-left" id="single_cal4" aria-describedby="inputSuccess2Status3" value="<%=chkdate %>" >
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>
                         <input id="cd" class="form-control col-md-7 col-xs-12" type="hidden" name="cd" value="2017-11-16">
                      </div> 
              
                      </div>
                   
               <!--     <div class="form-group Swipe bankdet" style="display: none;padding-left: 38px; padding-right: 50px;padding-top: 20px;padding-bottom: 50px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);">
                        <b> <p id="Swipelabel"></p> </b> -->
                        <div class="form-group Swipe bankdet" style="display: none; padding: 20px 50px 50px 38px;/* border: 1px solid rgba(128, 128, 128, 0.2); *//* margin-bottom: 2%; *//* background-color: rgb(247, 247, 247); */">
                        <b> <p id="Swipelabel"></p> </b>
                      
                       <label class="control-label col-md-2 col-sm-2 col-xs-5" style="margin-top:1%;margin-left:1%;width:200px;">Amount Paid(Swipe):<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="swipeAP" class="form-control col-md-7 col-xs-12" type="number" name="swipeAP" onchange="calculateTotalAP();" min="0" value="<%=resultSet.getString("Swipe")%>">
                        </div> 
                    </div>      
                    </div>
                                      
                        
   <div class="form-group" style="margin-top:3%;">
                    			<label class="control-label col-md-2 col-sm-2 col-xs-5">Tax Type:<span class="required">*</span></label>
                        		<div class="col-md-3 col-sm-3 col-xs-6" style="margin-left:-100px;">
                          		<select id="taxtype" class="select3_single form-control" tabindex="-1" name="taxtype" required="required" >
                            			<option></option>
                               		<option value="CGST">CGST+SGST</option>
                            			<option value="IGST">IGST</option>
                                 </select>
                        		</div>                
                        </div> 
 
  <br/> <br/> 
 <br/>                        
<div class="form-group "  style="margin-left: 10px;">
                       		

<% if(gst!= null && gst!="")
{ 
%>
<label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:125px;"> UN-REG Invoice:</label>
<div class="col-md-1 col-sm-1 col-xs-3" >
                          		<input type="radio" onclick="javascript:invoiceCheck();" name="generalInvoice" id="generalInvoice" value="general">
                        		</div>
                        
                       		 <label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:100px;">REG Invoice:</label>
                       		  <div class="col-md-1 col-sm-1 col-xs-3" >
                        			<input type="radio" onclick="javascript:invoiceCheck();" name="taxInvoice" id="taxInvoice" value="tax" checked>
                       		 </div> 
                       		 
                       		 <label id="GSTLabel" style="width:150px;" class="control-label col-md-2 col-sm-2 col-xs-3">Customer GST No:*</label>
                        		<div id="GSTdiv" class="col-md-3 col-sm-3 col-xs-6">
                        			<input id="GST" style="width:200px;margin-top:-7px" class="form-control col-md-7 col-xs-12" type="text" name="GST" value="<%=gst %>" >
                       		 </div>
<%
}
else
{
gst ="";
%>
	<label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:125px;padding-left: 0px;">UN-REG Invoice:</label>
<div class="col-md-1 col-sm-1 col-xs-3">
                          		<input type="radio" onclick="javascript:invoiceCheck();" name="generalInvoice" id="generalInvoice" value="general" checked>
                        		</div>
                        
                       		 <label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:100px;">REG Invoice:</label>
                       		  <div class="col-md-1 col-sm-1 col-xs-3">
                        			<input type="radio" onclick="javascript:invoiceCheck();" name="taxInvoice" id="taxInvoice" value="tax">
                       		 </div> 
                       		 
                       		 <label id="GSTLabel" style="visibility:hidden;width:150px;" class="control-label col-md-2 col-sm-2 col-xs-3">Customer GST No:*</label>
                        		<div id="GSTdiv" style="visibility:hidden;" class="col-md-3 col-sm-3 col-xs-6">
                        			<input id="GST" style="width:200px;margin-top:-7px" class="form-control col-md-7 col-xs-12" type="text" name="GST" value="<%=gst%>" >
                       		 </div>
<%} %>
                  
                        <br/> 
                           <br/> 
                         <div class="form-group creditDet" style="display:none;">       
       		
  <label for="creditCustId" style="float:left;"><strong> Credit Customer ID: </strong></label>
                            <input type="text" id='custIdCode' name="custIdCode" class="form-control col-md-7 col-xs-12" style="margin-left:10px;width:30px;height:25px;display:none;" readOnly> 
  <input class="col-md-4" type="text" id="creditCustId" name="creditCustId"  onfocusout="showCustomer(this.value)">                       		

  </div>                      
<br/>
 <p id="creditMsg"></p> 
 <input id="CrediCustStatus" class="form-control col-md-7 col-xs-12" type="hidden" name="CrediCustStatus" >
 
<div class="invDet " style="display:none;">
        
           <label class="" for="InvNo" style="float:left;"><strong>Invoice Number: </strong></label><input class=" col-md-2" type="text" id="InvNo" name="InvNo" style="margin-left:10px;">                       		
      
          <label class="" for="InvDt" style="float:left;margin-left: 50px;"><strong>Invoice Date: </strong></label>
<!--           <input class=" col-md-2" type="text" id="InvDt" name="InvDt" style="margin-left:10px;">     -->
    <div class="col-md-3 col-xs-10" style="margin-left:-10px;">
                         <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-11 col-xs-10 xdisplay_inputx form-group has-feedback">
                                <input onchange="dch()" name="dateval" type="text" class="form-control has-feedback-left" id="single_cal3" aria-describedby="inputSuccess2Status3">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>
                         <input id="InvDt" class="form-control col-md-7 col-xs-12" type="hidden" name="InvDt" value="">
                      </div>
<a id="aid" href=""><button type="button"  onclick="addRecordsToInvoice(<%=i%>)" id="addto" class="btn btn-success" style="margin-left: 30px;margin-top: -5px;">Add</button></a> 
  </div> 
                         </div>
                         
                        
         
                      
<br/> 
<br/> 

<button id="deleteButton" onclick="deleteCheckedRecords()" type="button" style= "float:right" class="btn btn-danger disableButton4Credit" data-toggle="modal" data-target=".bs-example-modal-sm"><i class="fa fa-trash-o"></i> Delete</button>
<a href= "saledit.jsp"><button type="submit" id="sub" class="btn btn-success disable4inv" style="float:right" onclick="chsn(<%=i%>);return false;">Save</button></a>
 <a href="addsaleedit.jsp?branch=<%=branch %>&sid=<%=primaryKey%>&dc=<%=dc%>&sd=<%=cn%>&custId=<%=custId%>"><button type="button" class="btn btn-success disableButton4Credit" style="float:right;background: #f19292;border: 1px solid #f19292;">Add More Items</button></a> 
<button type="button"  id="refreshButton" class="btn btn-warning" style="float:right;" onClick="window.location.reload()">Refresh</button>
<%if(mflag!=1) {%>
<button type="button"  id="creditButton" class="btn btn-info disable4inv" style="float:right;">Convert to Credit</button>
<%} %>
<button type="button"  id="invbtn" class="btn btn-success disableButton4Credit" style="float:right;">Add to Invoice</button>
<br/>
<br/>
<br/>
<br/>

 </div>
  <div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-hidden="true" id="deleteModal" >
                    <div class="modal-dialog modal-sm">
                      <div class="modal-content">

                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span>
                          </button>
                          <h4 class="modal-title" id="myModalLabel2">Are you sure?</h4>
                        </div>
                        <div class="modal-body">
                          <!-- <h4>Text in a modal</h4> -->
                          <p id="test">Do you really want to delete this item? Click Cancel if you do not wish to delete this item.</p>
                         
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                      <a id="did" href=""><button type="button" class="btn btn-danger">Yes, Delete</button></a>  
                        </div>

                      </div>
                    </div>
                  </div>
                
</form>
 
 <% 
    whr2="";
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

	var array = $('input:hidden.billIds').map(function(){
        return $(this).val()
    }).get();
</script>
 <script type="text/javascript">
function invoiceCheck() {
if (document.getElementById('taxInvoice').checked) {
    document.getElementById('GSTdiv').style.visibility = 'visible';
    document.getElementById('GSTLabel').style.visibility = 'visible';
    document.getElementById('GST').required = 'true';
}
else 
	{
	 document.getElementById('GST').required = 'false';
     document.getElementById('GST').removeAttribute("required");
     document.getElementById('GST').value = '';
	document.getElementById('GSTdiv').style.visibility = 'hidden';
 	document.getElementById('GSTLabel').style.visibility = 'hidden';
 
	}

}
function calculateTotalAP()
{
var cashAP;
var neftAP;
var chequeAP;
var swipeAP;
var totalAP;
cashAP=document.getElementById("cashAP").value;	
neftAP=document.getElementById("neftAP").value;	
chequeAP=document.getElementById("chequeAP").value;	
swipeAP=document.getElementById("swipeAP").value;	

if(cashAP=="")
	cashAP=0;	
if(neftAP=="")
	neftAP=0;	
if(chequeAP=="")
	chequeAP=0;	
if(swipeAP=="")
	swipeAP=0;	

totalAP=parseInt(cashAP)+parseInt(neftAP)+parseInt(chequeAP)+parseInt(swipeAP);
//alert("totalAP: "+totalAP);
document.getElementById("ap").value=totalAP;
balcalc();
}

function calculate(i)
{
	//alert("hello: "+i);
	//alert(document.getElementById("nq"+i).value);
	/* var array = getElementsByClassName("billIds");
	for(i = 0; i < array.length; i++) {
	    alert(array[i]);
	} */
	

	
	var billId=0;
	var total=0;
	
	    
	
	if(document.getElementById("nq"+i).value!=null && document.getElementById("nq"+i).value!="")
		{
	 //	alert(document.getElementById("qty"+i).value);
	//	alert(document.getElementById("qmax").value);
	/* 	if(document.getElementById("qty"+i).value>document.getElementById("qmax").value)
			{
			alert("Insufficient quantity in Inventory. Current balance="+document.getElementById("qmax").value+"Enter a value less than "+ document.getElementById("qmax").value);
			
			return;
			}  */
			//alert("hi");
			//alert(document.getElementById("nq"+i).value);
			//alert(document.getElementById("cp"+i).value);

			var a;
	total=document.getElementById("nq"+i).value*document.getElementById("cp"+i).value;
	//alert("total: " +total);
	document.getElementById("total"+i).value=total;
		}
	  //var itemc=document.getElementById("i").value;
	  //var tot=0;
	  var totp=0;
	  
	  for(var j = 0; j < array.length; j++) {
		  {
			  //if(document.getElementById("id"+x)!=null)
			  //{
				  billId=array[j];
	
		  //tot+=parseFloat(document.getElementById("nq"+billId).value);
		  totp+=parseInt(document.getElementById("total"+billId).value);
		  
			 // }
		  }
//alert(totp);
   var result= totp;
   if (!isNaN(result)) {
        document.getElementById('totalprice').value = result;
    }
		}

/*   var result2= tot;
  
	
 
    if (!isNaN(result2)) {
        //document.getElementById('totalq').value = result2;
        
        if(document.getElementById("balanceamount").value!=null)
        	balcalc();
        
        document.getElementById("amountpaid").max=result;
    }   */
    
    var tax=document.getElementById("tax").value;
    var dis=document.getElementById("dis").value;
    if(tax=="")
    	  tax=0;
   if(dis=="")
    	dis=0;
  
  	
	document.getElementById('totalprice').value=totp+parseFloat(tax)-parseFloat(dis);
	document.getElementById("ap").max=document.getElementById('totalprice').value;
	balcalc();
}

function calculatetax()
{
	
	var billId=0;
	 var totp=0; 
	  for(var j = 0; j < array.length; j++) 
		  {
			  //if(document.getElementById("id"+x)!=null)
			  //{
				  billId=array[j];
	
		  //tot+=parseFloat(document.getElementById("nq"+billId).value);
		  totp+=parseInt(document.getElementById("total"+billId).value);
		  
			 // }
		  }
	  
	document.getElementById('totalprice').value=totp+parseFloat(document.getElementById("tax").value)-parseFloat( document.getElementById('dis').value);
	
	document.getElementById("ap").max=document.getElementById('totalprice').value;
	balcalc();
}

function calculatedis()
{
	
	var billId=0;
	 var totp=0; 
	  for(var j = 0; j < array.length; j++) 
		  {
			  //if(document.getElementById("id"+x)!=null)
			  //{
				  billId=array[j];
	
		  //tot+=parseFloat(document.getElementById("nq"+billId).value);
		  totp+=parseInt(document.getElementById("total"+billId).value);
		  
			 // }
		  }
	
	document.getElementById('totalprice').value=totp+parseInt(document.getElementById("tax").value)-parseInt(document.getElementById("dis").value);
	document.getElementById("ap").max=document.getElementById('totalprice').value;
	balcalc();
}
	  
	  function balcalc()
	  {
	  var bal;
	  var finalTotal;
	  finalTotal=document.getElementById("totalprice").value;
	  if(finalTotal==null)
	  	finalTotal=0;	
	  bal=finalTotal-document.getElementById("ap").value;
	  document.getElementById("ba").value=bal;
	  //alert("bal: "+bal);
	  //document.getElementById("creditBal").value=bal;
	/*   var totalprice=document.getElementById('total').value;
	  var phtax;
	  	//phtax=0.18*finalTotal;
	  	phtax=0.18*totalprice;
	  	if(!isNaN(phtax))
	  	document.getElementById("taxmsg").innerHTML=phtax; */
	  }
function chsn(i)
{
	

	var amountpaid= parseFloat(document.getElementById('ap').value);
	var ftotal= parseFloat(document.getElementById('totalprice').value);
	//var type= document.getElementById('transtype').value;
	//alert("amountpaid: "+amountpaid);
	//alert("ftotal: "+ftotal);
	/* if(type!=null && type!="")
	{
		if((type.search("Credit")== "-1"))
		{
			if(amountpaid<ftotal)
		 	{
		 		alert("Amount paid cannot be less than Final Total. Choose 'Credit " +type+ "'");
		 		//document.getElementById("amountpaid").focus();
		 		return;
		 	}
		 	else
		 	{
		 		document.getElementById("i").value=i;
		 		 document.getElementById("form1").submit();
		 		return true;
		 	}
		}
		else
		{
			document.getElementById("i").value=i;
			 document.getElementById("form1").submit();
		 	return true;
		}
	 } */
	 //var transtype=$("input[name='transtype']:checked"). val();
	 var uncheckedTypes = [];  
	 var checkedTypes = [];

     	$.each($("input[name='transtype']:checked"), function(){            
     		checkedTypes.push($(this).val());
     });
     
	   var flag=false;
	 	$.each($("input[name='transtype']:not(:checked)"), function(){            
	 		uncheckedTypes.push($(this).val());
	 });  

	 var creditCustId=document.getElementById("creditCustId").value;
	 var custId=	document.getElementById("custId").value;
	 var creditTrans=false;
	if(custId!="")	
	{
		creditTrans=true;
	}
	else
	{
	  if(creditCustId!="")
	  {
		  creditTrans=true;
	  }
	}

	 if(uncheckedTypes.length==4)
	 {
	 		document.getElementById("cashAP").value="";
	 		document.getElementById("neftAP").value="";
	 		document.getElementById("chequeAP").value="";
	 		document.getElementById("swipeAP").value="";
	 		document.getElementById("amountpaid").value="0";
	 	
	 		document.getElementById("cashAP").required='false';
	 		document.getElementById("neftAP").required='false';
	 		document.getElementById("chequeAP").required='false';
	 		document.getElementById("swipeAP").required='false';
		     document.getElementById("cashAP").removeAttribute("required");
		     document.getElementById("neftAP").removeAttribute("required");
		     document.getElementById("chequeAP").removeAttribute("required");
		     document.getElementById("swipeAP").removeAttribute("required");
		     if(creditTrans==false)
		 	{
		  	  alert("Please select Type.");
		  	  flag=true;
		  	  return;
		 	}
		   
	 }
	 if(flag==false)
	 {
	 		
	 		for(var i=0;i<uncheckedTypes.length;i++)
	 		{ 
	 			var label1="";
	      	if(uncheckedTypes[i]=="Cash")
	 		 	{
	     	    		label1 = "cashAP";
	 		 	}
	      	else if(uncheckedTypes[i]=="Neft")
	      	{ 
	      		label1 = "neftAP";
	      	}
	      	else if(uncheckedTypes[i]=="Cheque")
	      	{ 
	      		label1 = "chequeAP";
	      	}
	       	else if(uncheckedTypes[i]=="Swipe")
	      	{ 
	       		label1 = "swipeAP";
	      	}
	 		    if(label1!="")
	 		    	{
	 		    		document.getElementById(label1).value="";
	 		    		document.getElementById(label1).required='false';
	 		    	     document.getElementById(label1).removeAttribute("required");
	 		    		calculateTotalAP();
	 		    	}
	 		  }

	 		if(amountpaid=="" || amountpaid==null)
	 		{
	 			amountpaid="0";
	 		}
	 		if(checkedTypes.length!=0)
			{ 
				if(creditTrans==false)
				{
					
			        	for(var i=0;i<checkedTypes.length;i++)
					{ 				 	
				 		var label="";
				  		
			         	if(checkedTypes[i]=="Cash")
			    		 	{
			        	    		label = "cashAP";
			    		 	}
			         	else if(checkedTypes[i]=="Neft")
			         	{ 
			         		label = "neftAP";
			         	}
			         	else if(checkedTypes[i]=="Cheque")
			         	{ 
			         		label = "chequeAP";
			         	}
			          	else if(checkedTypes[i]=="Swipe")
			         	{ 
			          		label = "swipeAP";
			         	}

				  	if(document.getElementById(label).value==0)
				  	{
				  		alert("Please enter valid Amount Paid(" +checkedTypes[i] +")");
				  		return;
				  	}
					}
										
					if(parseFloat(amountpaid)<parseFloat(ftotal))
				 	{
				 		alert("Amount paid cannot be less than Final Total. Convert to 'Credit'");
				 		//document.getElementById("amountpaid").focus();
				 		return;
				 	}
				 	else
				 	{
				 		document.getElementById("i").value=i;
				 		 document.getElementById("form1").submit();
				 		return true;
				 		
				 	}
				}
				else
				{
					document.getElementById("i").value=i;
			 		 document.getElementById("form1").submit();
			 		return true;

				}
	      	 }
	 	   }	    	   
	
}
function dch1() 
{ 
 var d=document.getElementById("single_cal4").value.toString();
var dv=d.split("/");
var cd=dv[2]+'-'+dv[0]+'-'+dv[1];
 document.getElementById('cd').value=cd;
} 
function d(){
    	localStorage.setItem("branch", document.getElementById('branch').value);
     	localStorage.setItem("sd", document.getElementById('single_cal3').value);
   /*  	localStorage.setItem("rd", document.getElementById('single_cal4').value);  */
     	localStorage.setItem("dc", document.getElementById('dc').value); 
}
    $(window).load(function () {
    	$(".se-pre-con").fadeOut("slow");
    	
 	
    	 var s = document.getElementById("branch");
   	 document.getElementById('single_cal3').value=localStorage.getItem("sd");
  /*   	 document.getElementById('single_cal4').value=localStorage.getItem("rd");  */
      	 document.getElementById('dc').value=localStorage.getItem("dc"); 
    	    	// Loop through all the items in drop down list

    	    	for (i = 0; i< s.options.length; i++)

    	    	{ 

    	    	if (s.options[i].value == localStorage.getItem("branch"))

    	    	{
    	    		if(s.options[i].value=="Bowenpally")
    	    	s.selectedIndex=i+1;
    	    		else
    	    		 	s.selectedIndex=i;
    	    	break;

    	    	}

    	    	}
    	    	document.getElementById('branch').value=localStorage.getItem("branch"); 
    	    	document.getElementById('dc').value=localStorage.getItem("dc"); 
    	     	/* localStorage.setItem("branch", ""); */
    	     	localStorage.setItem("sd", "");
    	   /*  	localStorage.setItem("rd", "");  */ 
    	 /*    	localStorage.setItem("dc", "");   */

    	
    	 
    	 
    });
    
    
</script>    
<script>

 function funcSelectAll()
{
   if(document.forms[0].selectAllCheck.checked==true)
   {
        var elements=document.getElementsByClassName('chkbox');
       	for(var i=0; i<elements.length; i++){
       		elements[i].checked = true;
     }
   }
     else
     {
    	 var elements=document.getElementsByClassName('chkbox');
        	for(var i=0; i<elements.length; i++){
        		elements[i].checked = false;
      }
     }          

} 

 
$("#invbtn").click(function() { 
	var count_checked = $('input:checkbox[name="checkboxRow"]:checked').length;
	if(count_checked == 0) 
	{
		$('#errorMsg').css({ 'color': 'red'});
		$('#errorMsg').html('Please select atleast one checkbox to add to invoice');	         
		$('#errorMsg').show();
		$("#deleteModal").modal("hide");
	    return false;
	}
	else
	{
		var elements=document.getElementsByClassName('chkbox');
	    	var cpElements=document.getElementsByClassName('cp');
	    	var qtyElements=document.getElementsByClassName('qnty');
	    	var codeElements=document.getElementsByClassName('cde');
	    	var cpflag=false;
	    	var qtyflag=false;
	    	var eMessage="";
	    for(var i=0; i<elements.length; i++)
	    {
	    		if(elements[i].checked == true)
	        {
		     	if(cpElements[i].value==0 || cpElements[i].value=="" || cpElements[i].value==null)
		        {
		         	eMessage='Please enter sale price for code: ' +codeElements[i].value;
		         	cpflag=true;
		         	break;
		        }
		         			
				if(qtyElements[i].value==0 || qtyElements[i].value=="" || qtyElements[i].value==null)
		    		{
		         	eMessage='Please enter quantity for code: ' +codeElements[i].value;
		         	qtyflag=true;
		         	break;
		         }
	        	}	         			         			
		 }
	     if(cpflag==true || qtyflag==true)
	     {
	     	$('#errorMsg').css({ 'color': 'red'});
	        $('#errorMsg').html(eMessage);		         	         
	        $('#errorMsg').show();
	        $("#deleteModal").modal("hide");	
	        return;
	     }
	     else
	     { 	
	     	$( '[class*="invDet"]' ).show();
	        $("#InvNo").prop('required',true);
	        $( '[class*="disable4Credit"]' ).prop("readonly",true);
	        $('.disableButton4Credit').attr('disabled', 'disabled');
			$('[class*="disable4inv"]').attr('disabled', 'disabled'); 
	        //$('#errorMsg').html('');
	        $('#errorMsg').hide();
	     }
	}
 });
 
 
 $("#creditButton").click(function() {
	// $( '[class*="InvDet"]' ).hide();
	 var bal= document.getElementById("ba").value;
	 if(bal=="0")
	{
		 alert("Existing balance is 0. \n So you cannot convert to credit.")
	}
	 else
	{
	 $( '[class*="creditDet"]' ).show();
	 $('.disableButton4Credit').attr('disabled', 'disabled');
		$("#creditCustId").prop('required',true);
	 $( '[class*="disable4Credit"]' ).prop("readonly",true);
		var code;
		var branch = document.getElementById("branch").value;
	  
	  
		  switch(branch) {
		    case "Bowenpally"	: code = "BP";
		    					   	break;
		    case "Miyapur"   	: code = "MY";
		    					   	break;
		    case "LBNagar"   	:code = "LB";
		   					  	break;
		    case "Workshop"   	:code = "WS";
				  			  	break;
		    case "Rajahmundry"  :code = "RJ";
				                	break;
		    case "Vishakapatnam":code = "VZ";
				  				break;
		    case "Bhubhaneshwar":code = "BB";
				  				break;
		    case "Vijayawada"   :code = "VO";
				  				break;
		    case "Vijayawadan"  :code = "VN";
				  				break;
		    case "Tekkali"      :code = "TK";
			  					break;
		    case "Barhi"   		:code = "BH";
			  					break;
		    default:
		    	code = "";
		  }
		  document.getElementById("custIdCode").value = code;
		  if(code!="")
			 {
			  document.getElementById("custIdCode").style.display="block";
			  document.getElementById("creditCustId").style.width = "120px";
			 }
		  else
			  {
			  document.getElementById("custIdCode").style.display="none";
			  document.getElementById("creditCustId").style.marginLeft = "10px"
			  document.getElementById("creditCustId").style.width = "150px";
			  
			  }
	}
 });

$("#deleteButton").click(function() {
	 $('#successMsg').hide();
	  //var count_checked = $("[name='checkboxRow[]']:checked").length; // count the checked rows
	  var count_checked = $('input:checkbox[name="checkboxRow"]:checked').length;
	  //alert(count_checked);
      if(count_checked == 0) 
      {
          //alert("Please select any record to delete.");
           // $('#errorMsg').css({ 'color': 'red'});
          //$('#errorMsg').html('Please select atleast one checkbox to delete a record');
         
         $('#errorMsg').show();
          $("#deleteModal").modal("hide");
          return false;
      }
      else
    	  {
    	
        
    	  //$('#errorMsg').html('');
    	  $('#errorMsg').hide();
    	  }
});	
/* input.onfocus = function() {
	 
		        var input = $(this);
		        alert('Type: ' + input.attr('type') + 'Name: ' + input.attr('name') + 'Value: ' + input.val());
		  
	  } */
	/*   $( "input" ).focusin(function() {
		  if($(this).attr('type')!="checkbox")
			  {
			  //$('.cboxes').attr('disabled', 'disabled');
			 $('#deleteButton').attr('disabled', 'disabled');
			  }
		
		}); */
	  
function deleteCheckedRecords(){
	//var did=document.getElementById("did").value;
	var pk=document.getElementById("payid").value;
	var branch=document.getElementById("branch").value;
	var dc=document.getElementById("dc").value;
	var cn=document.getElementById("ddd").value;
	var comments=document.getElementById("comments").value;
	var ap=document.getElementById("ap").value;
	//alert(pk);
	//alert(branch);
	//alert(dc);
	//alert(comments);
	var items=document.getElementsByName('checkboxRow');
	var selectedItems="";
	for(var i=0; i<items.length; i++){
		if(items[i].type=='checkbox' && items[i].checked==true)
			if(selectedItems!="")				
				{
				selectedItems+=","+items[i].value+"\n";
				}
			else
				{
			selectedItems+=items[i].value+"\n";
				}
	}
	//alert(selectedItems);



/* 	$.ajax({
	    url : "BulkDeleteSale.jsp?selectedItems="+selectedItems,
	    		//  url : "BulkDeleteSale.jsp?selectedItems="+selectedItems+"mapData="+mapData,
	    type : "POST",
	    async : false,
	    success : function(data) {
	    }
	}); */
	if(selectedItems=="")
		{
		 //alert("Please select an item to delete.");
		 return;
		}
	else
		{
	   	  var elements=document.getElementsByClassName('chkbox').length;
    	//  var count_checked = $('input[class="chkbox"]:checked').length;
    	 	var count_checked = $('.chkbox:checked').size();
    //	  alert(count_checked);
	document.getElementById('did').href=('BulkDeleteSale.jsp?selectedItems='+selectedItems+'&deleteid='+pk+'&branch='+branch+'&dc='+dc+'&sd='+cn+'&totRecs='+elements+'&checkedRecs='+count_checked+'&comments='+comments+'&amtpaid='+ap);
	}
}

function addRecordsToInvoice(i){
	//var did=document.getElementById("did").value;
document.getElementById("i").value=i;
	var pk=document.getElementById("payid").value;
	var branch=document.getElementById("branch").value;
	var dc=document.getElementById("dc").value;
	var cn=document.getElementById("ddd").value;
	var GST=document.getElementById("GST").value;
//	alert(GST);
	var cusnam=document.getElementById("cusnam").value;
//	alert(cusnam);
	var cusno=document.getElementById("cusno").value;
//	alert(cusno);
	
	var items=document.getElementsByName('checkboxRow');
	var selectedItems="";
	var cp="";
	for(var i=0; i<items.length; i++){
		if(items[i].type=='checkbox' && items[i].checked==true)
			if(selectedItems!="")				
				{
				selectedItems+=","+items[i].value+"\n";
				cp+=","+document.getElementById("cp"+items[i].value).value+"\n";
			
		//		alert("cp="+document.getElementById("cp"+items[i].value).value);
				
				}
			else
				{
			selectedItems+=items[i].value+"\n";
			cp+=document.getElementById("cp"+items[i].value).value+"\n";
			
		//	alert("si"+items[i].value);
		//	alert("cp="+document.getElementById("cp"+items[i].value).value);
				}
	}
//	alert(selectedItems);

	if(selectedItems=="")
		{
		 //alert("Please select an item to delete.");
		 return;
		}
	else
		{
	   	  var elements=document.getElementsByClassName('chkbox').length;
    //	  var count_checked = $('input[class="chkbox"]:checked').length;
    	//	alert(count_checked);
    	var count_checked = $('.chkbox:checked').size();
    //	alert($('.chkbox:checked').size());
    var InvNo=document.getElementById("InvNo").value;
    var InvDt=document.getElementById("InvDt").value;
 //  alert(InvDt);
	document.getElementById('aid').href=('addtoinv.jsp?selectedItems='+selectedItems+'&deleteid='+pk+'&branch='+branch+'&dc='+dc+'&sd='+cn+'&totRecs='+elements+'&checkedRecs='+count_checked+'&cp='+cp+'&invno='+InvNo+'&invdt='+InvDt+'&cusnam='+cusnam+'&cusno='+cusno+'&GST='+GST);
	}
}

function f(i)
{
	var i =i;
	var pk=document.getElementById("payid").value;
	var branch=document.getElementById("branch").value;
	var dc=document.getElementById("dc").value;
	var q=document.getElementById("q"+i).value;
	var cn=document.getElementById("ddd").value;
	var ba=document.getElementById("ba").value;
	var code=document.getElementById("code"+i).value;
	var cp=document.getElementById("ocp"+i).value;
	var tp=document.getElementById("tp").value;
	var bid=document.getElementById("bid"+i).value;
	
 document.getElementById('did').href=('delsal.jsp?deleteid='+pk+'&branch='+branch+'&dc='+dc+'&sd='+cn+'&ba='+ba+'&code'+i+'='+code+'&q'+i+'='+q+'&cp'+i+'='+cp+'&bid'+i+'='+i+'&tp='+tp+'&i='+i); 

	}
function dch() 
{ 
 var d=document.getElementById("single_cal3").value.toString();
var dv=d.split("/");
var da=dv[1]+'-'+dv[0]+'-'+dv[2];
 document.getElementById('InvDt').value=da;
}
$(document).ready(function() {
	
	 $.getScript("js/rolePermissions.js");
	 $('input[type="checkbox"]').click(function(){
		   
		 	var checkedTypes = [];
		   
		 	var j=1;
	    	    var labelname;
	    	    $(".bankdet").hide();
	        	$.each($("input[name='transtype']:checked"), function(){            
	        		checkedTypes.push($(this).val());
	        });
	        
	       	 var uncheckedTypes = [];  
	  	
	  	 	$.each($("input[name='transtype']:not(:checked)"), function(){            
	  	 		uncheckedTypes.push($(this).val());
	  	 }); 
	        	for(var i=0;i<checkedTypes.length;i++)
			{ 
		 		var labelId="label";
		 		var label="";
		  		$("." + checkedTypes[i]).show();
		  		labelId= checkedTypes[i]+labelId;
		  		
		  		if(checkedTypes[i]=="Neft")
		  		{
			  		labelname=j+". NEFT/RTGS" + " Details"; 		  
		  		}
		  		else
		  		{
			  		labelname=j+". "+checkedTypes[i]+ " Details"; 		  
		  		}
		  		
		  		document.getElementById(labelId).innerHTML=labelname;
	         	if(checkedTypes[i]=="Cash")
	    		 	{
	        	    		label = "cashAP";
	    		 	}
	         	else if(checkedTypes[i]=="Neft")
	         	{ 
	         		label = "neftAP";
	         	}
	         	else if(checkedTypes[i]=="Cheque")
	         	{ 
	         		label = "chequeAP";
	         	}
	          	else if(checkedTypes[i]=="Swipe")
	         	{ 
	          		label = "swipeAP";
	         	}
		  		document.getElementById(label).required='true';
		  	
		  		j++;
			}
	        	
	        	
		 		for(var i=0;i<uncheckedTypes.length;i++)
		 		{ 
		 			var label1="";
		      	if(uncheckedTypes[i]=="Cash")
		 		 	{
		     	    		label1 = "cashAP";
		 		 	}
		      	else if(uncheckedTypes[i]=="Neft")
		      	{ 
		      		label1 = "neftAP";
		      	}
		      	else if(uncheckedTypes[i]=="Cheque")
		      	{ 
		      		label1 = "chequeAP";
		      	}
		       	else if(uncheckedTypes[i]=="Swipe")
		      	{ 
		       		label1 = "swipeAP";
		      	}
		 		    if(label1!="")
		 		    	{
		 		    		document.getElementById(label1).value="";
		 		    		document.getElementById(label1).required='false';
		 		    	     document.getElementById(label1).removeAttribute("required");
		 		    		calculateTotalAP();
		 		    	}
		 		  }
	        	
		    });
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	
	//disable the items which have already been added to invoices
	 var disit=document.getElementsByClassName('notes');
	 var elements=document.getElementsByClassName('chkbox')

	 for(var i=0; i<disit.length; i++){
    
    	if(disit[i].innerHTML.length>0)
    		elements[i].disabled=true;
    		
    		
  }
	 var existingTaxtype=document.getElementById('existingTaxtype').value; 
	// $("#taxtype option:contains(" + existingTaxtype + ")").attr('selected', 'selected');
	 $('#taxtype').val(existingTaxtype);
	 var existingTranstype=document.getElementById('existingTranstype').value; 
	  $('#transtype').val(existingTranstype);
	//alert("existingTranstype" +existingTranstype);
	var lablnme="";
	var k=1;
	var lblId="";
	var lbl="";
 if( existingTranstype.indexOf( "Cash" ) != -1 )
{
	 lbl="Cash";
	 $('input[name="transtype"]')[0].checked = true; 
	 $("." + lbl).show();
	 document.getElementById("cashAP").required='true';
	 lblId= lbl+"label";
	 lablnme=k+". "+lbl+ " Details"; 
	 document.getElementById(lblId).innerHTML=lablnme;
	 k++;
	 }
 if( existingTranstype.indexOf( "Neft" ) != -1 )
 {
	 lbl="Neft";
 	 $('input[name="transtype"]')[1].checked = true; 
	 $("." + lbl).show();
	 document.getElementById("neftAP").required='true';
	 lblId= lbl+"label";
	 lablnme=k+". NEFT/RTGS" + " Details"; 
	 document.getElementById(lblId).innerHTML=lablnme;
	 k++;
 	 }

 if( existingTranstype.indexOf( "Cheque" ) != -1 )
 {
	 lbl="Cheque";
 	 $('input[name="transtype"]')[2].checked = true; 
	 $("." + lbl).show();
	 document.getElementById("chequeAP").required='true';
	 lblId= lbl+"label";
	 lablnme=k+". "+lbl+ " Details"; 
	 document.getElementById(lblId).innerHTML=lablnme;
	 k++;
 	 }
 if( existingTranstype.indexOf( "Swipe" ) != -1 )
 {
	 lbl="Swipe"; 
 	 $('input[name="transtype"]')[3].checked = true; 
	 $("." + lbl).show();
	 document.getElementById("swipeAP").required='true';
	 lblId= lbl+"label";
	 lablnme=k+". "+lbl+ " Details"; 
	 document.getElementById(lblId).innerHTML=lablnme;
	 k++;
 	 }
	 var custId=document.getElementById("custId").value;
	 var cusnam=document.getElementById("cusnam").value;
	 var cusno=document.getElementById("cusno").value;
	 //alert("custId: "+custId);
	 if(custId!="")
	{
		 document.getElementById('creditButton').style.visibility = 'hidden';
		 document.getElementById("cusnam").readOnly = true;
			 document.getElementById("cusno").readOnly = true;
	}
	   	localStorage.setItem("cusnam", cusnam);
	   	localStorage.setItem("cusno", cusno);
	   	
	   	
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
	 $('#ex').DataTable( {
		"processing": true,
        "serverSide": true,
        "ajax":"dem.php",
        "deferRender": true,
        "deferLoading": 57,
        "iDisplayLength":10
    } );
	
	  $("input").change(function(){
		  //alert($(this).attr("name"));
		  if($(this).attr('type')!="checkbox" && ($(this).attr("name")!="transtype"))
		  {
			 
		  //$('.cboxes').attr('disabled', 'disabled');
		 $('#deleteButton').attr('disabled', 'disabled');
		  }
	  });
	  
		 $(".select2_single").change(function(){
				
		        $(this).find("option:selected").each(function(){
		        		var optionValue = $(this).attr("value");
		        	
		           	var flag=false;
		            if(optionValue)
		            {	           	            	
			        		if(optionValue=="CreditNeft" || optionValue=="CreditCheque" || optionValue=="CreditSwipe")
			            	{
			            		var option = optionValue.substr(6, optionValue.length);
			            		$(".bankdet").not("." + option).hide();          
			 	            $("." + option).show();
			 	            $(".Credit").show();
			 	            flag=true;
			            	}
			            	else
			            	{
			                $(".bankdet").not("." + optionValue).hide();
			                //$(".creditDet").not("." + optionValue).hide(); 
			                if(optionValue!="CreditCash")
			                		$(".Credit").hide();
			                $("." + optionValue).show();
			                flag=false;
			            	}	                
		            } 
		            else
		            {
		                $(".bankdet").hide();
		                $(".Credit").hide();
		                flag=false;
		            }
		            /* if(optionValue=='Credit' || flag==true)
		            	{
		               	$("#customername").prop('readonly', true);
		              	$("#customernumber").prop('readonly', true); 

		              	$("#aadhaar").prop('readonly', true); 

		              	$("#creditCustId").prop('required',true);
		            		$("#creditCustId").val("");
		            		$("#customername").val("");
		            		$("#customernumber").val("");
		            		
		            		balcalc();
		            	}
		            else
		            	{
		             	$("#customername").prop('readonly', false);
		              	$("#customernumber").prop('readonly', false); 
		              	$("#creditCustId").prop('required',false);
		              	document.getElementById("creditMsg").innerHTML = "";
		              	document.getElementById('generalInvoice').checked=true;
				        document.getElementById('GSTdiv').style.visibility = 'hidden';
				        document.getElementById('GSTLabel').style.visibility = 'hidden';
				       // $("#GST").prop('readonly', false); 
				   		$("#aadhaar").prop('readonly', false); 
				   	    $("#customername").val("");
	         		    $("#customernumber").val("");
	         		    $("#GST").val("");
	     
		            	}
	 	     
	            	 	 var dcNo= document.getElementById("dcnumber").value;
	           	 	 var taxInvoiceFlag = dcNo.startsWith("T");
	           	 	 if(taxInvoiceFlag==true)
	           	 	 {
	           	 		document.getElementById('GSTdiv').style.visibility = 'visible';
	           	        document.getElementById('GSTLabel').style.visibility = 'visible';
	           	        document.getElementById('GST').required = 'true';
	           	 	 }
	           	 	 else
	           	 	 {
	           	 	 	document.getElementById('GST').required = 'false';
	           	        document.getElementById('GST').removeAttribute("required");
	           	        document.getElementById('GST').value = '';
	           	    		document.getElementById('GSTdiv').style.visibility = 'hidden';
	           	     	document.getElementById('GSTLabel').style.visibility = 'hidden';
	           	 	 } */
		        });
		        
		        //$("div.ttype select").val("");
		    }).change();
} ); 
  $("#FormId").submit( function(e) {
	  loadAjax();
	  e.returnValue = false;
	  return false;
	});  
/* function dch(val) { 
  var d=document.getElementById(val).value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
if(val=="single_cal3")
  document.getElementById('da1').value=da;
else
	document.getElementById('da2').value=da;
} */
</script>



  </body>
</html>