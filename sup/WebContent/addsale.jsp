<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import= "java.util.Arrays" %>
 <%@ page language="java" import="java.util.*" %>
<%-- 
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
%> --%>
  
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 
	  
    <title>KK Track- Add Sale</title>

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
              <script language="javascript">var p = false;
              </script>
 <script language="javascript" type="text/javascript">  
 var xmlHttp
 var xmlHttp1
 var res="notCredit"
 function showState(str,i){ 
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
document.getElementById("numb").value=i;
var url="value.jsp";
url += "?count=" +str+"&branch="+document.getElementById("branch").value+"&dt="+document.getElementById("da").value+"&dc="+document.getElementById("dcnumber").value;
	
xmlHttp.onreadystatechange = stateChange;
xmlHttp.open("GET", url, true);
xmlHttp.send(null);
}
 function stateChange(){   
 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 var data=xmlHttp.responseText;
	 var dv=data.split(",");
	 var i=document.getElementById("numb").value;
	 document.getElementById("mac"+i).value=dv[0];
	 document.getElementById("description"+i).value=dv[1];
	 document.getElementById("partno"+i).value=dv[2];
	/*  document.getElementById("minprice"+i).value=dv[3]; */
	 document.getElementById("mp"+i).value=dv[4];
	 document.getElementById("grp"+i).value=dv[5];
	  document.getElementById("qmax").value=dv[7];
	 document.getElementById("qty"+i).max=dv[7]; 
	 
	 if(dv[8]==2)
		 {
		 alert("Sale already exists for same date, branch and DCNumber! Please verify in view sale or please enter a different DCNumber!");
		 document.getElementById("dcnumber").value="";
		 document.getElementById("dcnumber").focus();
		 }
 }   
 }
 
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
	url += "?creditcustID=" +custID+"&branch="+document.getElementById("branch").value;
	
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
	 
	 	 document.getElementById("customername").value=dv[0];
	 	 document.getElementById("customernumber").value=dv[1];
	
	 	 res="update";
	 	
	 	creditMsg = "Existing credit balance:" +dv[2];
       
	 	 if(dv[3]==0)
	 		 {
	 		 //alert("Credit Customer ID do not exists");
	 		var answer = confirm("Credit Customer ID do not exists.\nDo you want to add the Credit Customer?");
	 	
	 		if (answer) {
	 		    //some code
	 		     document.getElementById("customername").focus();
	 			document.getElementById("customername").disabled = false;
	 			document.getElementById("customernumber").disabled = false;	 			
	 			creditMsg="Add the above Customer!"
	 			res="insert";
	 		}
	 		else {
	 		    //some code
	 		
	 		 //document.getElementById("creditCustId").value="";
	 		 document.getElementById("customername").disabled = true;
	 		document.getElementById("customernumber").disabled = true;
	 		// document.getElementById("creditCustId").focus();
	 		 res="error";
	 		creditMsg="Please enter valid Credit Customer Id to proceed."
	 		document.getElementById("creditMsg").style.color = "#ff0000";
	 		 }
	 		 }
	  }
	 // alert(creditMsg);
	 // alert(res);
	  document.getElementById("creditMsg").innerHTML = creditMsg;
	 
	  document.getElementById("CrediCustStatus").value=res;
	  } 
 </script>  
 <body  class="nav-md">
 <div class="se-pre-con"></div>
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="viewinventory.jsp" class="site_title"><i class="fa fa-line-chart"></i> <span>KK Track</span></a>
            </div>

            <div class="clearfix"></div>


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
              <div class="title_left">
                <h1>Sales <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>

             <div style=" float:right; margin-right: 10px; margin-top:-20px">

            <a href="addsale.jsp"><button type="button" class="btn btn-success">Add </button></a>

                  <a href="viewsale.jsp" style="color:white;">  <button type="button" class="btn btn-info">View </button></a>

                 <a href="editSale.jsp" style="color:white;">   <button type="button" class="btn btn-warning admin">Edit</button></a>
                 <a href="saleReturn.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Return</button></a>
             </div>  
             <br/>
        
                <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Add Sale</h2>
               
                    <div class="clearfix"></div>
                  </div>
                  <div >
                    <br />
                  <form id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left" action="saleadd1.jsp" method="post" novalidate="" onsubmit="return(p)">
                    <div id="main">
                      <div class="form-group">
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Branch:<span class="required">*</span></label>
                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
                        <div class="col-md-3 col-sm-3 col-xs-10">
                          <select class="select2_single form-control admin" tabindex="-1" id="branch" name="branch" required="required">
                            <option></option>
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
                         <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                      <!-- </div>
                       <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Date:<span class="required">*</span>
                        </label>
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
                         <input id="da" class="form-control col-md-7 col-xs-12" type="hidden" name="date" value="2017-11-16">
                      </div>
                    <!-- </div>
                    <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="dcnumber">Invoice No<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="text" id="dcnumber" required="required" class="form-control col-md-7 col-xs-12" name="dcnumber">
                        </div>
                      <button class="add col-md-1 col-xs-3" type="button" style="background: #26B99A;color: white;border: 1px solid #169F85; line-height: 2;">Add Item</button>
                     
                      </div>
                      
                      <div class="codedetails" id="id1">
                      <ul class="nav navbar-right panel_toolbox">
                      <li style="float: right;"><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                    
                    </ul>
                      <div class="x_content" style="padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);">
                      <a style="float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer" class="cls" onclick="cls(this);"><i class="fa fa-close"></i></a>
                      <div class="form-group" style="margin-left:-3%"> 
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="code"> Code:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-4">
                          <input type="number" id="code"  style="padding:0" class="form-control col-md-7 col-xs-12" name="code" onchange="showState(this.value,1)">
                        </div>
                        <label class="control-label col-md-1 col-sm-1 col-xs-8">Description:</label>
                        <div class="col-md-2 col-sm-2 col-xs-6">
                          <input id="description1" class="form-control col-md-7 col-xs-12" type="text" name="description" disabled="" style="padding: 0;">
                        </div>
                          <label class="control-label col-md-1 col-sm-1 col-xs-9">Sale Price:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                          <input id="costprice1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="costprice" onchange="calculate(1)" min="0">
                        </div>
                 <!--      </div>
                      <div class="form-group"> -->
                        <input id="qmax" class="form-control col-md-7 col-xs-12" type="hidden" name="qmax" value="0">
                        <label class="control-label col-md-1 col-sm-1 col-xs-9">Quantity:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-4">
                          <input id="qty1" class="form-control col-md-7 col-xs-12" style="padding:0" required="required" type="number" name="qty" onchange="calculate(1)" >
                        </div>
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Total:</label>
                        <div class="col-md-1 col-sm-1 col-xs-4">
                          <input id="totalprice1" class="form-control col-md-7 col-xs-12" style="padding:0" type="text" name="totalprice" readonly="readonly" >
                        </div>
                        
                      </div>
                    
                      
                      <div class="form-group" style="margin-top:2%; margin-bottom:2%; margin-left:-3%">
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="mac"> Mac:</label>
                        <div class="col-md-1 col-sm-1 col-xs-3">
                          <input type="text" id="mac1"  class="form-control col-md-7 col-xs-12" name="mac" disabled="" style="padding: 0;">
                        </div>
                     <!--  </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">PartNo:</label>
                        <div class="col-md-2 col-sm-2 col-xs-5">
                          <input id="partno1" class="form-control col-md-7 col-xs-12" type="text" name="partno" disabled="" style="padding: 0;">
                        </div>
                   <!--    </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Group:</label>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                          <input id="grp1" class="form-control col-md-7 col-xs-12" type="text" name="grp" disabled="" style="padding: 0;">
                        </div>
                   <!--    </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Max Price:</label>
                        <div class="col-md-1 col-sm-1 col-xs-3">
                          <input id="mp1" class="form-control col-md-7 col-xs-12"  type="text" name="maxprice" disabled="" style="padding: 0;">
                        </div>
                      <!-- </div>
                    
                      <div class="form-group"> -->
                      <!--   <label class="control-label col-md-1 col-sm-1 col-xs-2 admin" style="display: none;">Min Price:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="minprice1" class="form-control col-md-7 col-xs-12 admin" required="required" type="text" name="minprice" disabled="" style="display: none;">
                        </div> -->
                      </div>
                     </div></div></div>
                      
                      <div class="form-group"> 
                        <label class="control-label col-md-1 col-sm-2 col-xs-3">Total Price:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="total" class="form-control col-md-7 col-xs-12" type="number" name="total" readonly="readonly"  style="">
                        </div>
                      
                        <label class="control-label col-md-1 col-sm-2 col-xs-3">Total Qty:</label>
                        <div class="col-md-1 col-sm-2 col-xs-3">
                          <input id="totalq" class="form-control col-md-7 col-xs-12" type="text" name="totalq" readonly="readonly">
                        </div>
                           <label class="control-label col-md-1 col-sm-1 col-xs-9">Tax:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-2 col-xs-4">
                          <input id="tax" class="form-control col-md-7 col-xs-12" required="required" type="number" name="tax" onchange="calculatetax()" min="0">
                        </div>
                         <label class="control-label col-md-1 col-sm-1 col-xs-9">Discount:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-2 col-xs-4">
                          <input id="dis" class="form-control col-md-7 col-xs-12" required="required" type="number" name="dis" onchange="calculatedis()" min="0">
                        </div>
                         <label class="control-label col-md-1 col-sm-2 col-xs-3">Final Total:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="ftotal" class="form-control col-md-7 col-xs-12" type="number" name="ftotal" onchange="balcalc()" readonly="readonly" >
                        </div>
                      </div>
                    
                    <br/>
                      
                     
                      
                    <div class="form-group" style="margin-top:2%;">
                    <label class="control-label col-md-2 col-sm-2 col-xs-5">Type:<span class="required">*</span></label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <select id="type" class="select2_single form-control" tabindex="-1" name="type" required="required">
                            <option></option>
                               <option value="Cash">Cash</option>
                            <option value="Neft">Bank Transfer</option>
                            <option value="Cheque">Cheque</option>
                            <option value="Swipe">Swipe</option>
                             <option value="Credit">Credit</option>
                          </select>
                        </div>
                      <!-- </div>
                       <div class="form-group"> -->
                       <div class="form-group Credit creditDet" style="display:none;">
                        <label class="control-label col-md-2 col-sm-2 col-xs-5">Credit Customer ID:<span class="required">*</span>
                         </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="creditCustId" class="form-control col-md-7 col-xs-12" type="text" name="creditCustId" onfocusout="showCustomer(this.value)">
                        </div>
                        </div>
                        </div>
                         <div class="form-group custDet">
                        <label class="control-label col-md-2 col-sm-2 col-xs-5">Customer Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="customername" class="form-control col-md-7 col-xs-12" required="required" type="text" name="customername">
                        </div>
                        
                        <label class="control-label col-md-2 col-sm-2 col-xs-5">Customer Number:
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="customernumber" class="form-control col-md-7 col-xs-12" type="number" name="customernumber">
                        </div>
                      </div>
                           <div class="form-group">
                        <label class="control-label col-md-2 col-sm-2 col-xs-5">Amount Paid:<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="amountpaid" class="form-control col-md-7 col-xs-12" type="number" name="amountpaid" onchange="balcalc();" min="0" required="required">
                        </div>
                          <div class="form-group Credit creditDet"style="display:none;" id="displayCreditBal">
                           <label class="control-label col-md-2 col-sm-2 col-xs-5">Credit Balance:
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="creditBal" class="form-control col-md-7 col-xs-12" type="number" name="creditBal"  min="0" disabled>
                        </div>
                        </div> 
                      </div>
                        <p id="creditMsg"></p> 
                      <div class="form-group Cheque bankdet" style="margin-top: 2%; display: none;">
                       <label class="control-label col-md-2 col-sm-2 col-xs-3" for="bankname">Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                          <input id="bankname" class="form-control col-md-7 col-xs-12" type="text" name="bankname">
                        </div>
                        
                        <label class="control-label col-md-1 col-sm-2 col-xs-3" for="chkno">Cheque Number:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                        <input id="chkno" class="form-control col-md-7 col-xs-12" type="text" name="chkno">
                        </div> 
                        <label class="control-label col-md-1 col-sm-2 col-xs-3" for="chkdate">Cheque Date:<span class="required">*</span>
                        </label>
                       <div class="col-md-3" style="margin-left:-10px;">
                           <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-11 xdisplay_inputx form-group has-feedback">
                                <input onchange="dch1()" name="chkdate" type="text" class="form-control has-feedback-left" id="single_cal4" aria-describedby="inputSuccess2Status3">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>
                         <input id="cd" class="form-control col-md-7 col-xs-12" type="hidden" name="cd" value="2017-11-16">
                      </div>
                      </div>
                      <div class="form-group Neft bankdet" style="margin-top: 2%; display: none;">
                       <label class="control-label col-md-3 col-sm-2 col-xs-3">Customer Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                          <input id="cusbank" class="form-control col-md-7 col-xs-12" type="text" name="cusbank">
                        </div>
                        
                        <label class="control-label col-md-2 col-sm-2 col-xs-3">KK Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                        <input id="kkbank" class="form-control col-md-7 col-xs-12" type="text" name="kkbank">
                        </div> </div>
                        <br/>
                          
                        
                   		<div class="form-group ">
                       		<label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:125px;">UN-REG Invoice:</label>
                        		<div class="col-md-1 col-sm-1 col-xs-3" style="margin-top: 0.7%;">
                          		<input type="radio" onclick="javascript:invoiceCheck();" name="taxtype" id="generalInvoice" value="general" checked="checked">
                        		</div>
                        
                       		 <label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:100px;">REG Invoice:</label>
                       		 <div class="col-md-1 col-sm-1 col-xs-3" style="margin-top: 0.7%;">
                        			<input type="radio" onclick="javascript:invoiceCheck();" name="taxtype" id="taxInvoice" value="tax">
                       		 </div> 
                       		 <label id="GSTLabel" style="visibility:hidden;width:150px;" class="control-label col-md-2 col-sm-2 col-xs-3">Customer GST No:*</label>
                        		<div id="GSTdiv" style="visibility:hidden" class="col-md-3 col-sm-3 col-xs-6">
                        			<input id="GST" style=";width:200px; "class="form-control col-md-7 col-xs-12" type="text" name="GST">
                       		 </div>
                        </div>
                        
                      
                        <br/>
                   
                        <div class="form-group"> 
                       <label class="control-label col-md-2 col-sm-2 col-xs-3">Comments:</label>
                       <div class="col-md-8 col-sm-7 col-xs-8">
                       <textarea id="comments" class="form-control col-md-7 col-xs-12" name="comments"></textarea>
                       </div>
                       </div>
                       <input id="balanceamount" class="form-control col-md-7 col-xs-12" type="hidden" name="balanceamount">
                       <input id="numb" class="form-control col-md-7 col-xs-12" type="hidden" name="numb" value="1">
                       <input id="CrediCustStatus" class="form-control col-md-7 col-xs-12" type="hidden" name="CrediCustStatus" >
                       
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-4">
                          <button class="btn btn-primary" type="button">Cancel</button>
                          <button class="btn btn-primary" type="reset">Reset</button>
  
                         <button type="submit" name="myButton" class="btn btn-success" onClick = "javascript: p=true;" >Submit</button> 
                         

  

                          </div>
 
                 </div>

             </form>
           </div>
         </div>
       </div>
     </div>
     <br> 
     <% String r=request.getParameter("res");
  
 String succ="<div class=\"col-md-6\" style= \" margin-top:-71%\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Inserted successfully in database.</strong></div>";
 String err="<div class=\"col-md-6\" style= \" margin-top:-71%\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong> Sale already exists for same date, branch and Invoice No!   </strong></div>";
 
 if(r!=null && r.equals("1"))
        	out.println(succ);%>
        	
 <%--      <% String r=request.getParameter("res");
      System.out.println(r);	
 String succ="<div class=\"col-md-6\" style= \"margin-left:280px; margin-top:-56%\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Inserted successfully in database.</strong></div>";
 String err="<div class=\"col-md-6\" style= \"margin-left:280px; margin-top:-56%\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong> Sale already exists for same date, branch and Invoice No!   </strong></div>";
 
 if(r!=null && r.equals("1"))
        	out.println(succ);
 else if(r!=null && r.equals("2"))
 	System.out.println(err);		 
        else
        {
        	String cd=request.getParameter("code"); 
        	if(cd!=null)
        	out.println("<div class=\"col-md-6\" style= \"margin-left:280px; margin-top:-56%\"><div class=\"alert alert-error alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Insufficient quantity for Code "+cd+"</strong></div>");
        }
     %>  --%>
 
       
        <!-- /page content -->
</div>
</div>
</div>
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
    <!-- bootstrap-progressbar -->
    <script src="vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- iCheck -->
    <script src="vendors/iCheck/icheck.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="vendors/moment/min/moment.min.js"></script>
    <script src="vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap-wysiwyg -->
    <script src="vendors/bootstrap-wysiwyg/js/bootstrap-wysiwyg.min.js"></script>
    <script src="vendors/jquery.hotkeys/jquery.hotkeys.js"></script>
    <script src="vendors/google-code-prettify/src/prettify.js"></script>
    <!-- jQuery Tags Input -->
    <script src="vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    <!-- Switchery -->
    <script src="vendors/switchery/dist/switchery.min.js"></script>
    <!-- Select2 -->
    <script src="vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- Parsley -->
    <script src="vendors/parsleyjs/dist/parsley.min.js"></script>
    <!-- Autosize -->
    <script src="vendors/autosize/dist/autosize.min.js"></script>
    <!-- jQuery autocomplete -->
    <script src="vendors/devbridge-autocomplete/dist/jquery.autocomplete.min.js"></script>
    <!-- starrr -->
    <script src="vendors/starrr/dist/starrr.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="build/js/custom.min.js"></script>
   
<script>
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

 function dch() 
{ 
 var d=document.getElementById("single_cal3").value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
 document.getElementById('da').value=da;
}
 function dch1() 
 { 
  var d=document.getElementById("single_cal4").value.toString();
 var dv=d.split("/");
 var cd=dv[2]+'-'+dv[0]+'-'+dv[1];
  document.getElementById('cd').value=cd;
 } 
 function ref()
 {
	 window.location.href="addsale.jsp";
 }
function calculate(i)
{
	
	if(document.getElementById("qty"+i).value!=null && document.getElementById("qty"+i).value!="")
		{
	 //	alert(document.getElementById("qty"+i).value);
	//	alert(document.getElementById("qmax").value);
	/* 	if(document.getElementById("qty"+i).value>document.getElementById("qmax").value)
			{
			alert("Insufficient quantity in Inventory. Current balance="+document.getElementById("qmax").value+"Enter a value less than "+ document.getElementById("qmax").value);
			
			return;
			}  */
	document.getElementById("totalprice"+i).value=document.getElementById("qty"+i).value*document.getElementById("costprice"+i).value;

	  var itemc=document.getElementById("numb").value;
	  var tot=0;
	  var totp=0;
	  
		  for(var x=1;x<=itemc;x++)
		  {
			  if(document.getElementById("id"+x)!=null)
			  {
		  tot+=parseInt(document.getElementById("qty"+x).value);
		  totp+=parseInt(document.getElementById("totalprice"+x).value);
		  
			  }
		  }

   var result= totp;
   if (!isNaN(result)) {
        document.getElementById('total').value = result;
    }
		}

  var result2= tot;
 
    if (!isNaN(result2)) {
        document.getElementById('totalq').value = result2;
        
        if(document.getElementById("balanceamount").value!=null)
        	balcalc();
        
        document.getElementById("amountpaid").max=result;
    }
    if(document.getElementById("tax").value=="")
    	document.getElementById("tax").value=0;
   if(document.getElementById("dis").value=="")
    	document.getElementById("dis").value=0;
    if(!isNaN(document.getElementById('ftotal').value)) 
    	calculatetax();
    calculatedis();
  	balcalc();
    
}

function calculatetax()
{

	document.getElementById('ftotal').value=parseInt(document.getElementById("tax").value)+parseInt( document.getElementById('total').value);
	if(document.getElementById("dis").value!=null && document.getElementById("dis").value!="")
		calculatedis();	
	document.getElementById("amountpaid").max=document.getElementById('ftotal').value;
	balcalc();
}

function calculatedis()
{
	
	document.getElementById('ftotal').value=parseInt( document.getElementById('total').value)+parseInt(document.getElementById("tax").value)-parseInt(document.getElementById("dis").value);
	document.getElementById("amountpaid").max=document.getElementById('ftotal').value;
	balcalc();
}

function calculater(x)
{
	var i=x.substr(2);
	document.getElementById("qty"+i).value=0;
	document.getElementById("totalprice"+i).value=0;
	//document.getElementById("id"+i).style.display='none';
	
	
	var itemc=document.getElementById("numb").value;
	  var tot=0;
	  var totp=0;
	  
		  for(var x=1;x<=itemc;x++)
		  {
			  if(document.getElementById("id"+x)!=null)
				  {
		  tot+=parseInt(document.getElementById("qty"+x).value);
		  totp+=parseInt(document.getElementById("totalprice"+x).value);
				  }
		 
		  }

 var result= totp;
 if (!isNaN(result)) {
      document.getElementById('total').value = result;
  }
		

var result2= tot;

  if (!isNaN(result2)) {
      document.getElementById('totalq').value = result2;
  }
	
	   
	   calculatetax();
	   if(document.getElementById("balanceamount").value!=null)
	       	balcalc();
	   $('#id'+i).remove();	   
	   
}

function tot(i)
{
	
	
}

function balcalc()
{
var bal;
var finalTotal;
finalTotal=document.getElementById("ftotal").value;
if(finalTotal==null)
	finalTotal=0;	
bal=finalTotal-document.getElementById("amountpaid").value;
document.getElementById("balanceamount").value=bal;
document.getElementById("creditBal").value=bal;
}	 
function cls(elt)
{
	
    // Traverse up until root hit or DIV with ID found
	while (elt && (elt.tagName != "DIV" || !elt.id))
	    elt = elt.parentNode;
	if (elt) // Check we found a DIV with an ID
	/*     alert(elt.id); */
	var r=elt.id;
	calculater(r);
	/* $('#'+r).remove(); */
	/* document.getElementById(); */
	 var h= $('.right_col').height()-200;
	 $('.right_col').animate({height:h}, 500);
}


 $(document).ready(function() {
	 	
	 $(window).keydown(function(event){
		    if(event.keyCode == 13) {
		      event.preventDefault();
		      return false;
		    }
		  });
	 var ubran=document.getElementById('ubran').value;
		var role=document.getElementById('urole').value;
		
		if(role!=null && role!="1")
		{
		var elements = document.getElementsByClassName('admin');

	    for (var i = 0; i < elements.length; i++)
	    {
	        elements[i].style.display = "none";
	    }
		var elements = document.getElementsByClassName('user');

	    for (var i = 0; i < elements.length; i++){
	        elements[i].style.display = "block";
	    }

	    var s=document.getElementById('branch');
         if(s!=null)
        	 {
	      	for (var i = 0; i< s.options.length; i++)

	    	{ 
	      		
	    	if (s.options[i].value == ubran)

	    	{
	    		
	    		/* if(s.options[i].value=="Bowenpally")
	    	    	s.selectedIndex=i+1;
	    	    		else */
	    		 	s.selectedIndex=i;
	    	break;

	    	}
	    	} 
		}
         /* s.disabled="true"; */
		}
		/* if(role!=null && role=="3")
		{
		var elements = document.getElementsByClassName('userv');

	    for (var i = 0; i < elements.length; i++){
	        elements[i].style.display = "none";
	    }
		
		}	 */
		
		if(role!=null && role=="2")
		{
			var elements = document.getElementsByClassName('hide4branch');

	   		 for (var i = 0; i < elements.length; i++){
	        		elements[i].style.display = "none";
	    		}
	   		if(ubran!=null && ((ubran=="Workshop")||(ubran=="Barhi")))
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
	
	    
	 var h= $('.right_col').height()+150;
	 $('.right_col').animate({height:h}, 500);
	 $("select").change(function(){
	        $(this).find("option:selected").each(function(){
	            var optionValue = $(this).attr("value");
	           
	            if(optionValue){
	           
	                $(".bankdet").not("." + optionValue).hide();
	                $(".creditDet").not("." + optionValue).hide();           
	                $("." + optionValue).show();
	                
	            } else{
	                $(".bankdet").hide();
	                $(".creditDet").hide();	          
	            }
	            if(optionValue=='Credit')
	            	{
	               	$("#customername").prop('disabled', true);
	              	$("#customernumber").prop('disabled', true); 
	              	$("#creditCustId").prop('required',true);
	            		$("#creditCustId").val("");
	            		$("#customername").val("");
	            		$("#customernumber").val("");	            
	            		balcalc();
	            	}
	            else
	            	{
	             	$("#customername").prop('disabled', false);
	              	$("#customernumber").prop('disabled', false); 
	              	$("#creditCustId").prop('required',false);
	              	document.getElementById("creditMsg").innerHTML = "";
	            	}
	        });
	    }).change();
	var c=1;
	
$('.add').click(function() {
	 c++; 
   var s1="<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-4\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" style=\"padding: 0;\" name=\"code\" onchange=\"showState(this.value,"+c+")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-8\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-7\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-9\" >Sale Price:<span class=\"required\">*</span></label><div class=\"col-md-2 col-sm-2 col-xs-4\"><input id=\"costprice"+c+"\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"costprice\" onchange=\"calculate("+c+")\" ></div><label class=\"control-label col-md-1 col-sm-1 col-xs-9\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-4\"><input id=\"qty"+c+"\" class=\"form-control col-md-7 col-xs-12\" style=\"padding: 0;\" required=\"required\" type=\"number\" name=\"qty\" onchange=\"calculate("+c+")\"> </div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Total:</label><div class=\"col-md-1 col-sm-1 col-xs-4\"><input id=\"totalprice"+c+"\" class=\"form-control col-md-7 col-xs-12\"  type=\"text\" name=\"totalprice\" readonly=\"readonly\" ></div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-3\"><input type=\"text\" id=\"mac"+c+"\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-5\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-4\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Max Price:</label><div class=\"col-md-1 col-sm-1 col-xs-4\"><input id=\"mp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"maxprice\"disabled></div></div></div></div></div>";
    $('.codedetails:last').after(s1); 
/*  $('#main').after(s1); */
 var h= $('.right_col').height()+200;
 $('.right_col').animate({height:h}, 500);
});

/* $('.cls').click(function() {
c--;
alert(c);
}); */
/* if(role!=null && role=="3")
{
var elements = document.getElementsByClassName('userv');

for (var i = 0; i < elements.length; i++){
    elements[i].style.display = "none";
}
} */

 }); 
 $(window).load(function () {
		$(".se-pre-con").fadeOut("slow");
	});
 $(function() {
	    $("#branch").change(function() {
	       $('select[name=type]').val("");
	       document.getElementById("creditMsg").innerHTML = "";
	    });
	});
 

</script>
<!-- <script>
    // Run on page load
    window.onload = function() {

        // If sessionStorage is storing default values (ex. name), exit the function and do not restore data
        if (sessionStorage.getItem('name') == "name") {
            return;
        }

        // If values are not blank, restore them to the fields
        var name = sessionStorage.getItem('name');
        if (name !== null) $('#inputName').val(name);

        var email = sessionStorage.getItem('email');
        if (email !== null) $('#inputEmail').val(email);

        var subject= sessionStorage.getItem('subject');
        if (subject!== null) $('#inputSubject').val(subject);

        var message= sessionStorage.getItem('message');
        if (message!== null) $('#inputMessage').val(message);
    }

    // Before refreshing the page, save the form data to sessionStorage
    window.onbeforeunload = function() {
    	var i=$('#numb').val();
        sessionStorage.setItem("name", $('#inputName').val());
        sessionStorage.setItem("email", $('#inputEmail').val());
        sessionStorage.setItem("subject", $('#inputSubject').val());
        sessionStorage.setItem("message", $('#inputMessage').val());
    }
</script> -->
  </body>
</html>