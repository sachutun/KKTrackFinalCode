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

  <% int count=1; 
    
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
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 
	  
    <title>KK Track- IBT </title>

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
 
 <script language="javascript" type="text/javascript">  
 var xmlHttp  
 var xmlHttp
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
var role=document.getElementById("urole").value;
var uBranch=document.getElementById("ubran").value;
var branchName;
if( role!=null && role=="2" && uBranch!="Bowenpally" && uBranch!="Workshop")
	branchName = document.getElementById("fromBranchName").value;
else
	branchName = document.getElementById("frombranch").value;
var ibtnumber=document.getElementById("ibtcode").value+document.getElementById("ibtnumber").value;
url += "?count=" +str+"&branch="+branchName+"&dt="+document.getElementById("da").value+"&ibt="+ibtnumber;
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
	/*  document.getElementById("mp"+i).value=dv[4]; */
	 document.getElementById("grp"+i).value=dv[5];
	 document.getElementById("qty"+i).max=dv[7]; 
	document.getElementById("existQty" +i).innerHTML=dv[7];

	 if(dv[9]==2)
		 {
		 alert("IBT already exists for same date, branch and IBT number! Please verify in view IBT or please enter a different IBT number!");
		 document.getElementById("ibtnumber").value="";
		 document.getElementById("ibtnumber").focus();
		 }
 }   
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
                <h1>IBT <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>

            <div style=" float:right; margin-right: 10px;">

                   <a href="ibtform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="viewIBT.jsp"> <button type="button" class="btn btn-info">View </button></a>
                   <a href="editIBT.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Edit</button></a>
             </div> 
             <br/><br/><br/> 
                 <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-6\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Inserted successfully in database.</strong></div></div>";
        if(r!=null)
        	out.println(succ);
     %>
                <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>IBT Form</h2>
               
                    <div class="clearfix"></div>
                  </div>
                  <div >
                    <br />
                    <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" action="ibtadd.jsp" method="post" onsubmit="myButton.disabled = true;">
                    <div id="main">
                      <div class="form-group" style="width: 50%;margin-left: 30%;">
                      <label class="control-label col-md-1 col-sm-1 col-xs-2" style="width:125px;">General IBT:</label>
                        		<div class="col-md-2 col-sm-2 col-xs-3" style="margin-top: 0.7%;">
                          		<input type="radio" onclick="javascript:ibtCheck();" name="IBTtype" id="generalIBT" value="general" checked="checked">
                        		</div>
                        
                       		 <label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:100px;">Tax IBT:</label>
                       		 <div class="col-md-3 col-sm-3 col-xs-3" style="margin-top: 0.7%;">
                        			<input type="radio" onclick="javascript:ibtCheck();" name="IBTtype" id="taxIBT" value="tax">
                       		 </div> 
                       		 </div>
                   <br>
                   <br>
                       <div class="form-group" style="margin-left: 15%;"> 
                       
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Date:<span class="required">*</span>
                        </label>
                      <div class="col-md-3" style="margin-left:-10px;">
                         <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text"  value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-11 xdisplay_inputx form-group has-feedback">
                                <input onchange="dch()" name="dateval" type="text" class="form-control has-feedback-left" id="single_cal3" aria-describedby="inputSuccess2Status3">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>
                         <input id="da" class="form-control col-md-7 col-xs-12" type="hidden" name="date" >
                      </div>
                    <!-- </div>
                    <div class="form-group"> -->
                        <label class="control-label col-md-2 col-sm-2 col-xs-3" for="ibtnumber">IBT Number<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                            <input type="text" id='ibtcode' name="ibtcode" class="form-control col-md-7 col-xs-12" style="width:30px;display:none;" readOnly>
                          <input type="text" id="ibtnumber" required="required" class="form-control col-md-7 col-xs-12" style="width:190px;"name="ibtnumber">
                        </div>
                        </div>
                         <div class="form-group" style="margin-left: 6.5%;">
                          <label class="control-label col-md-2 col-sm-1 col-xs-2">From Branch:<span class="required">*</span></label>
                        <div class="col-md-3 col-sm-3 col-xs-3">
                        <%--   <input class="" type="text" id="fbranch" name="fbranch" value=<%=uBranch%> readonly="readonly" style="border:none"> --%>

                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
                          <select class="select2_single form-control hide4branch" tabindex="-1" id="frombranch" name="frombranch" onchange="ibtCheck()">

                 
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

                          <input type="text" id="fromBranchName" class="form-control col-md-7 col-xs-12 user" name="fromBranchName" style="display:none;" value=<%=uBranch%> disabled>

                          <%-- <input type="text" id="name" class="form-control col-md-7 col-xs-12 user" name="br" style="display:none;" value=<%=uBranch%> disabled> --%>

                        </div>
                          <label class="control-label col-md-2 col-sm-2 col-xs-3" style="margin-left: -4%;" >To Branch:<span class="required">*</span></label>
                         
                        <div class="col-md-3 col-sm-3 col-xs-3">
                          <select class="select2_single form-control" tabindex="-1" name="tobranch" required="required" style="margin-left: -5.5%;">
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

                      </div>
                 
                        <div class="form-group " style="margin-left:2%;">
                       		
                       		<!--  <label id="GSTLabel" style="visibility:hidden;width:150px;" class="control-label col-md-2 col-sm-2 col-xs-3">Customer GST No:*</label>
                        		<div id="GSTdiv" style="visibility:hidden" class="col-md-3 col-sm-3 col-xs-6">
                        			<input id="GST" style=";width:200px; "class="form-control col-md-7 col-xs-12" type="text" name="GST">
                       		 </div> -->
                     <button class="add " type="button" style="background: #26B99A;color: white;border: 1px solid #169F85;width: 10%;line-height: 2;margin-left: 82%;margin-top: -4%;">Add Item</button>
                         		
                        </div>
                     
                      <div class="codedetails" id="id1" >
                      <ul class="nav navbar-right panel_toolbox">
                      <li style="float: right;"><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                    
                    </ul>
                      <div class="x_content" style="padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);">
                      <a style="float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer" class="cls" onclick="cls(this);"><i class="fa fa-close"></i></a>
                      <div class="form-group" style="margin-left:-3%"> 
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="code"> Code:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input type="number" id="code" required="required" class="form-control col-md-7 col-xs-12" name="code" onchange="showState(this.value,1)">
                        </div>
                        <label  class="control-label col-md-1 col-sm-1 col-xs-2">Description:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="description1" class="form-control col-md-7 col-xs-12" type="text" name="description" disabled>
                        </div>
                       
                 <!--      </div>
                      <div class="form-group"> -->
                      
                          <label class="taxElements control-label col-md-1 col-sm-1 col-xs-2" style="display:none;">IBT Price:<span class="required">*</span>
                        </label>
                        <div class="taxElements col-md-2 col-sm-2 col-xs-4" style="display:none;">
                          <input id="saleprice1" class="salepr form-control col-md-7 col-xs-12" type="number" name="saleprice" onblur="calculateTotalPrice(1)">
                        </div> 
                        
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" >Quantity:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="qty1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="qty" step="any"  min=0 onblur="calculate(1)">
                               <p id="existQty1"></p> 
                        </div>
                    
                      
                       
                      </div>
                    
                      
                      <div class="form-group" style="margin-top:2%; margin-bottom:2%; margin-left:-3%">
                      
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="mac"> Mac:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input type="text" id="mac1" required="required" class="form-control col-md-7 col-xs-12" name="mac" disabled>
                        </div>
                     <!--  </div>
                      <div class="form-group"> -->
                        <label  class="control-label col-md-1 col-sm-1 col-xs-2">PartNo:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="partno1" class="form-control col-md-7 col-xs-12" type="text" name="partno" disabled>
                        </div>
                   <!--    </div>
                      <div class="form-group"> -->
                        <label  class="control-label col-md-1 col-sm-1 col-xs-2">Group:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="grp1" class="form-control col-md-7 col-xs-12" type="text" name="grp" disabled>
                        </div>
                   <!--    </div>
                      <div class="form-group"> -->
                       <!--  <label class="control-label col-md-1 col-sm-1 col-xs-2">Max Price:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="mp1" class="form-control col-md-7 col-xs-12" required="required" type="text" name="maxprice"disabled>
                        </div> -->
                      <!-- </div>
                    
                      <div class="form-group"> -->
                    <!--     <label class="control-label col-md-1 col-sm-1 col-xs-2 admin">Min Price:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="minprice1" class="form-control col-md-7 col-xs-12 admin" required="required" type="text" name="minprice" disabled>
                        </div> -->
                      </div>
                     </div></div></div>
                      
                      <!-- <div class="form-group"> 
                        <label class="control-label col-md-2 col-sm-2 col-xs-3">Total Price:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="total" class="form-control col-md-7 col-xs-12"  type="text" name="total" readonly="readonly">
                        </div> -->
                      
                        <div >
                      <div class="form-group">
                    
                          <label class="control-label col-md-2 col-sm-2 col-xs-3">Total No.of Items:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="totalq" class="form-control col-md-7 col-xs-12"  type="text" name="totalq" readonly="readonly">
                        </div>
                       
                         <label class="taxElements control-label col-md-2 col-sm-2 col-xs-3" style="display:none;">Tax:</label>
                        <div class="taxElements col-md-2 col-sm-2 col-xs-3" style="display:none;">
                          <input id="tax" class="form-control col-md-7 col-xs-12"  type="text" name="tax"  min="0" readonly="readonly">
<!--                           <p id="taxmsg"></p>  -->
                        </div>
                         
                         <label class="taxElements control-label col-md-2 col-sm-2 col-xs-3" style="display:none;">Total Price:</label>
                        <div class="taxElements col-md-2 col-sm-2 col-xs-3" style="display:none;">
                          <input id="totalprice" class="form-control col-md-7 col-xs-12"  type="text" name="totalprice" readonly="readonly">
                        </div>
                   
                      </div>
                      
                      
                      </div>
                       <input id="finaltotal" class="form-control col-md-7 col-xs-12" type="hidden" >
                     <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                   <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
                       <input id="numb" class="form-control col-md-7 col-xs-12"  type="hidden" name="numb">
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-4">
                          <button class="btn btn-primary" type="button">Cancel</button>
              <button class="btn btn-primary" type="reset">Reset</button>
                          <button type="submit" class="btn btn-success" >Submit</button>
                          
                          </div>
 
                 </div>

             </form>
           </div>
         </div>
       </div>
     </div>
     <br> 
  
 
       
        <!-- /page content -->
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
    var ubran=document.getElementById('ubran').value;
    var role=document.getElementById('urole').value;
    var environment=document.getElementById('uenv').value;
    var path = window.location.pathname;
    var callingJSP = path.split("/").pop();
</script>
   
<script>
function addInvoiceCode()
{
	var code;
	if( role!=null && role=="2" && ubran!="Bowenpally" && ubran!="Workshop")
		branch = document.getElementById("fromBranchName").value;
	else
		var branch = document.getElementById("frombranch").value;
		

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
	  document.getElementById("ibtcode").value = code;
	  if(code!="")
		 {
		  document.getElementById("ibtcode").style.display="block";
		  document.getElementById("ibtnumber").style.width = "160px";
		 }
	  else
		  {
		  document.getElementById("ibtcode").style.display="none";
		  document.getElementById("ibtnumber").style.width = "190px";
		  
		  }
}
function ibtCheck() {

    if (document.getElementById('taxIBT').checked) {
    		var elements = document.getElementsByClassName('taxElements');    	
		if(elements!=null)
		{
			for (var i = 0; i < elements.length; i++) 
			{
				elements[i].style.display = "block";
			}
		}
 		var elements = document.getElementsByClassName('salepr');   	
		if(elements!=null)
		{
			for (var i = 0; i < elements.length; i++) 
			{
				elements[i].required = 'true';
			}
		}
		addInvoiceCode();
		document.getElementById("ibtcode").style.display="block";
		  document.getElementById("ibtnumber").style.width = "160px";
    	}
    	else {
         document.getElementById('tax').value = '';
         document.getElementById('totalprice').value = '';
     	 var elements = document.getElementsByClassName('taxElements');  	
		if(elements!=null)
		{
			for (var i = 0; i < elements.length; i++) 
			{
				elements[i].style.display = "none";
			}
		}
		var elements = document.getElementsByClassName('salepr');   	
		if(elements!=null)
		{
			for (var i = 0; i < elements.length; i++) 
			{
				elements[i].removeAttribute("required");
				elements[i].value='';
			}
		}
		  document.getElementById("ibtcode").value = "";
			document.getElementById("ibtcode").style.display="none";
			  document.getElementById("ibtnumber").style.width = "190px";
    	}
}
 function dch() 
{ 
 var d=document.getElementById("single_cal3").value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
 document.getElementById('da').value=da;
} 
 function ref()
 {
	 window.location.href="ibtform.jsp";
 }
function calculate(i)
{
	calculateTotalPrice(i);
  	var itemc=document.getElementById("numb").value;
  	var tot=0;
	for(var x=1;x<=itemc;x++)
	{
		//alert(document.getElementById("id"+x).value);
		if(document.getElementById("id"+x)!=null)
		 {
			var qty=parseFloat(document.getElementById("qty"+x).value);
			if(isNaN(qty))
				tot+=0;
			else
			  	tot+=qty;
		 }	
	}
   	/*  var result2 = parseInt(txtSNumberValue) + parseInt(txtS2NumberValue); */
   	var result2=tot;
    	if (!isNaN(result2)) {
        document.getElementById('totalq').value = result2;
    }
    calculateTotalPrice(i);
}

function calculateTotalPrice(i)
{
  	var itemc=document.getElementById("numb").value;
  	var totPrice=0;
	for(var x=1;x<=itemc;x++)
	{
		//alert(document.getElementById("id"+x).value);
		if(document.getElementById("id"+x)!=null)
		{
			var salePrice=parseFloat(document.getElementById("saleprice"+x).value);
			var qty=parseFloat(document.getElementById("qty"+x).value);			 
			var price=salePrice*qty;
			  //alert(price);
			if(isNaN(price))
				totPrice+=0;
			else
			  	totPrice+=price;
		}	
	 }
   	/*  var result2 = parseInt(txtSNumberValue) + parseInt(txtS2NumberValue); */
   	var result2=totPrice;
    	if (!isNaN(result2)) {
    		document.getElementById('finaltotal').value = result2;       
    }
    var tax;
	tax=0.18*totPrice;
	if(!isNaN(tax))
		//document.getElementById("taxmsg").innerHTML=tax;
		document.getElementById("tax").value=tax;
    if(isNaN(tax))
    	 	document.getElementById('totalprice').value = 0+result2;
    else
   	 document.getElementById('totalprice').value = tax+result2;
}

/* function calculatetax()
{
	 calculateTotalPrice(i);
	 document.getElementById('totalprice').value=parseInt(document.getElementById("tax").value)+parseInt(document.getElementById("finaltotal").value);

} */
function tot(i)
{
	
	
}

function balcalc()
{
	document.getElementById("balanceamount").value=document.getElementById("total").value-document.getElementById("amountpaid").value;
}	

function cls(elt)
{
	
    // Traverse up until root hit or DIV with ID found
	while (elt && (elt.tagName != "DIV" || !elt.id))
	    elt = elt.parentNode;
	if (elt) // Check we found a DIV with an ID
	/*     alert(elt.id); */
	var r=elt.id;
	var c=r.substr(2);
	$('#'+r).remove();
	calculate(c);
	
	 var h= $('.right_col').height()-200;
	 $('.right_col').animate({height:h}, 500);
}


 $(document).ready(function() {
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
				if(ubran!=null && ubran!="Bowenpally" && ubran!="Workshop")
				{
					$( '[class*="branch"]' ).hide();
		   			var elements = document.getElementsByClassName('user');

		   		 	for (var i = 0; i < elements.length; i++)
		   		 	{
		        			elements[i].style.display = "block";
		    			}
		   		 	
				}
				if(ubran!=null && ubran=="Bowenpally" && ubran=="Workshop")
					document.getElementById('fromBranchName').style.display="none";
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
	var c=1;
$('.add').click(function() {
	 c++; 
	 
   //var s1="<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value,"+c+")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty"+c+"\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onblur=\"calculate("+c+")\"> </div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac"+c+"\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div></div></div></div></div>";
   var s1="<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value,"+c+")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"taxElements control-label col-md-1 col-sm-1 col-xs-2\" style=\"display:none;\">IBT Price:<span class=\"required\">*</span> </label> <div class=\"taxElements col-md-2 col-sm-2 col-xs-4\" style=\"display:none;\"> <input id=\"saleprice"+c+"\" class=\"salepr form-control col-md-7 col-xs-12\" type=\"number\" name=\"saleprice\" onblur=\"calculateTotalPrice("+c+")\"></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty"+c+"\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onblur=\"calculate("+c+")\">   <p id=\"existQty"+c+"\"></p></div></div>  <div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac"+c+"\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div></div></div></div></div>";
   
   $('.codedetails:last').after(s1); 
/*  $('#main').after(s1); */
 var h= $('.right_col').height()+200;
 $('.right_col').animate({height:h}, 500);
 ibtCheck();
});

 }); 
 $(window).load(function () {
		$(".se-pre-con").fadeOut("slow");
	});
</script>
  </body>
</html>