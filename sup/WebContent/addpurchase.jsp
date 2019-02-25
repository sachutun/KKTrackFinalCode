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
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
 <%@ page language="java" import="java.util.*" %>
  
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 
	  
    <title>KK Track- Add Purchase</title>

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
url += "?count=" +str;
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
	 document.getElementById("grp"+i).value=dv[5];
	 document.getElementById("pp"+i).value=dv[6];
	
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
<%   
String role=(String)session.getAttribute("role"); 
String uBranch=(String)session.getAttribute("ubranch");  
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
                <h1>Purchase <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>
           

     <div style=" float:right; margin-right: 10px; margin-top:-20px">

            <a href="addpurchase.jsp"><button type="button" class="btn btn-success">Add </button></a>

                  <a href="viewpurchase.jsp" style="color:white;">  <button type="button" class="btn btn-info">View </button></a>

                 <a href="editpurchase.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Edit</button></a>
                  <a href="returnpurchase.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Return</button></a>
             </div>  
             
                <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Add Purchase</h2>
               
                    <div class="clearfix"></div>
                    
                  </div>
                  <div >
                    <br />
                    <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" action="puradd.jsp" method="post" >
                    <div id="main">
                      <div class="form-group">
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Branch:<span class="required">*</span></label>
                        <%
                        		Properties props = new Properties();
							InputStream in = getClass().getClassLoader().getResourceAsStream("jdbc.properties");
							props.load(in);
							in.close();

							String environment = props.getProperty("jdbc.environment");
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%> 
                        <div class="col-md-3 col-sm-3 col-xs-3">
                          <select class="select2_single form-control" tabindex="-1" name="branch" required="required">
                            <option></option>
                       <!--        <option value="Bowenpally">Bowenpally</option>
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
                          <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                    <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>>
                        </div>
                      <!-- </div>
                       <div class="form-group"> -->
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
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="innumber">Invoice Number<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                          <input type="text" id="dcnumber" required="required" class="form-control col-md-7 col-xs-12" name="innumber">
                        </div>
                      <button class="add " type="button" style="background: #26B99A;color: white;border: 1px solid #169F85;width: 8%;line-height: 2;">Add Item</button>
                     
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
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input type="number" id="code" required="required" class="form-control col-md-7 col-xs-12" name="code" onchange="showState(this.value,1)" min=0>
                        </div>
                        <label  class="control-label col-md-1 col-sm-1 col-xs-2">Description:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="description1" class="form-control col-md-7 col-xs-12" type="text" name="description" disabled>
                        </div>
                          <label class="control-label col-md-1 col-sm-1 col-xs-2" >Cost Price:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                          <input id="costprice1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="costprice" onchange="calculate(1)" min=0>
                        </div>
                 <!--      </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" >Quantity:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="qty1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="qty" onchange="calculate(1)" min=0>
                        </div>
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Total:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="totalprice1" class="form-control col-md-7 col-xs-12"  type="text" name="totalprice" readonly="readonly" onchange="tot(1)">
                        </div>
                        
                      </div>
                    
                      
                      <div class="form-group" style="margin-top:2%; margin-bottom:2%; margin-left:-3%">
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="mac"> Mac:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input type="text" id="mac1"  class="form-control col-md-7 col-xs-12" name="mac" disabled>
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
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Previous Price:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="pp1" class="form-control col-md-7 col-xs-12"  type="text" name="prevprice" disabled>
                        </div>
                      <!-- </div>
                    
                      <div class="form-group"> -->
                    <!--     <label class="control-label col-md-1 col-sm-1 col-xs-2">Min Price:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="minprice1" class="form-control col-md-7 col-xs-12" required="required" type="text" name="minprice" disabled>
                        </div>
                      </div>
                     </div>-->
                      <label class="control-label col-md-1 col-sm-1 col-xs-2">USD:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="usd" class="form-control col-md-7 col-xs-12"  type="number" name="usd">
                        </div>
                     </div></div> </div>       </div>
                      
                      <div class="form-group"> 
                       <label class="control-label col-md-1 col-sm-2 col-xs-3">Total Price:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="total" class="form-control col-md-7 col-xs-12" type="number" name="total" readonly="readonly" style="
">
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
                          <input id="ftotal" class="form-control col-md-7 col-xs-12" type="number" name="ftotal" readonly="readonly" onchange="balcalc();" >
                        </div>
                      </div>
                      <div class="form-group" style="margin-top:2%;">
                        <label class="control-label col-md-2 col-sm-2 col-xs-3" >Supplier Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="suppliername" class="form-control col-md-7 col-xs-12" required="required" type="text" name="suppliername">
                        </div>
                        
                        <label class="control-label col-md-2 col-sm-2 col-xs-3">Supplier Number:
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="suppliernumber" class="form-control col-md-7 col-xs-12" type="number" name="suppliernumber" min=0>
                        </div> 
                      </div>
                      <div class="form-group" style="margin-top:2%;"> 
                         <label class="control-label col-md-2 col-sm-2 col-xs-3">Payment Mode:<span class="required">*</span></label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <select class="select2_single form-control" tabindex="-1" name="type" required="required">
                            <option></option>
                               <option value="Cash">Cash</option>
                            <option value="Neft">NEFT</option>
                            <option value="Cheque">Cheque</option>
                            <option value="Swipe">Swipe</option>
                            
                          </select>
                        </div>
                     <!--  </div>
                       <div class="form-group">  -->
                        <label class="control-label col-md-2 col-sm-2 col-xs-3">Amount Paid:<span class="required">*</span>
                        </label>
                        <div class="col-md-3 col-sm-3 col-xs-6">
                          <input id="amountpaid" class="form-control col-md-7 col-xs-12"  type="number" required="required" name="amountpaid" onchange="balcalc();" min=0>
                        </div>
                      </div>
                      <div class="form-group Cheque bankdet" style="margin-top:2%;">
                       <label class="control-label col-md-2 col-sm-2 col-xs-3" >Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                          <input id="bankname" class="form-control col-md-7 col-xs-12"  type="text" name="bankname">
                        </div>
                        
                        <label class="control-label col-md-1 col-sm-2 col-xs-3">Cheque Number:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                        <input id="chkno" class="form-control col-md-7 col-xs-12" type="text" name="chkno">
                        </div> 
                        <label class="control-label col-md-1 col-sm-2 col-xs-3">Cheque Date:<span class="required">*</span>
                        </label>
                       <div class="col-md-3" style="margin-left:-10px;">
                         <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text"  value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

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
                         <input id="cd" class="form-control col-md-7 col-xs-12" type="hidden" name="cd" >
                      </div>
                      </div>
                       <div class="form-group Neft bankdet" style="margin-top:2%;">
                       <label class="control-label col-md-3 col-sm-2 col-xs-3" >Supplier Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                          <input id="supbank" class="form-control col-md-7 col-xs-12"  type="text" name="supbank">
                        </div>
                        
                        <label class="control-label col-md-2 col-sm-2 col-xs-3">KK Bank Name:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-3 col-xs-6">
                        <input id="kkbank" class="form-control col-md-7 col-xs-12" type="text" name="kkbank">
                        </div> </div>
                         <div class="form-group"> 
                       <label class="control-label col-md-2 col-sm-2 col-xs-3">Comments:</label>
                       <div class="col-md-8 col-sm-7 col-xs-8">
                       <textarea id="comments" class="form-control col-md-7 col-xs-12" name="comments"></textarea>
                       </div>
                       </div>
                       <input id="balanceamount" class="form-control col-md-7 col-xs-12"  type="hidden" name="balanceamount">
                       <input id="numb" class="form-control col-md-7 col-xs-12"  type="hidden" name="numb">
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-4">
                          <button class="btn btn-primary" type="button">Cancel</button>
              <button class="btn btn-primary" type="reset">Reset</button>
                          <button type="submit" name="myButton" class="btn btn-success" >Submit</button>
                          
                          </div>
 
                 </div>

             </form>
           </div>
         </div>
         </div>
         

     </div>
     <br> 
   
     <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-6\" style= \"margin-top:-66%\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Inserted successfully in database.</strong></div>";
        if(r!=null)
        	out.println(succ);
     %> 
       
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
	 window.location.href="addpurchase.jsp";
 }
 function calculate(i)
 {
 	if(document.getElementById("qty"+i).value!=null)
 		{
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
     }
     
     if(document.getElementById("balanceamount").value!=null)
     	balcalc();
     
     if(!isNaN(document.getElementById('ftotal').value))
     	calculatetax();
     calculatedis();
 }
 function calculatetax()
 {
 	
 	document.getElementById('ftotal').value=parseInt(document.getElementById("tax").value)+parseInt( document.getElementById('total').value);
 	document.getElementById("amountpaid").max=document.getElementById('ftotal').value;
 }
 function calculatedis()
 {
 	
 	document.getElementById('ftotal').value=parseInt( document.getElementById('total').value)+parseInt(document.getElementById("tax").value)-parseInt(document.getElementById("dis").value);
 	document.getElementById("amountpaid").max=document.getElementById('ftotal').value;
 }
 function calculater(x)
 {
 	var i=x.substr(2);
 	document.getElementById("qty"+i).value=0;
 	document.getElementById("totalprice"+i).value=0;
 //	document.getElementById("id"+i).style.display='none';
 	
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
 	/* var i=x.substr(2);
 	var q=document.getElementById("qty"+i).value;
 	var amt=document.getElementById("totalprice"+i).value;
 	alert(q);
 	alert(amt);
 	   */
 	   
	   if(document.getElementById("balanceamount").value!=null)
	       	balcalc();
		   $('#id'+i).remove();	
   
  
 }

function tot(i)
{
	
	
}

function balcalc()
{
	document.getElementById("balanceamount").value=document.getElementById("ftotal").value-document.getElementById("amountpaid").value;
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
	 var h= $('.right_col').height()-200;
	 $('.right_col').animate({height:h}, 500);
}


 $(document).ready(function() {
	  $.getScript("js/rolePermissions.js");
	 var ubran=document.getElementById('ubran').value;
		var role=document.getElementById('urole').value;
		var s=document.getElementById('branch');
		/*var environment=document.getElementById('uenv').value;	
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
	 $("select").change(function(){
	        $(this).find("option:selected").each(function(){
	            var optionValue = $(this).attr("value");
	            if(optionValue){
	                $(".bankdet").not("." + optionValue).hide();
	                $("." + optionValue).show();
	            } else{
	                $(".bankdet").hide();
	            }
	        });
	    }).change();
	var c=1;
$('.add').click(function() {
	 c++; 
   var s1="<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value,"+c+")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Cost Price:<span class=\"required\">*</span></label><div class=\"col-md-2 col-sm-2 col-xs-4\"><input id=\"costprice"+c+"\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"costprice\" onchange=\"calculate("+c+")\"></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty"+c+"\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onchange=\"calculate("+c+")\"> </div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Total:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"totalprice"+c+"\" class=\"form-control col-md-7 col-xs-12\"  type=\"text\" name=\"totalprice\" readonly=\"readonly\" onchange=\"tot(c);\"></div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac"+c+"\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Previous Price:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"pp"+c+"\" class=\"form-control col-md-7 col-xs-12\"  type=\"text\" name=\"prevprice\"disabled></div><label class=\"control-label col-md-1 col-sm-1col-xs-2\">USD:</label><div class=\"col-md-1 col-sm-1col-xs-2\"><input id=\"usd"+c+"\" class=\"form-control col-md-7 col-xs-12\"  type=\"text\" name=\"usd\"></div></div></div></div>";
/*    $('.codedetails:last').before(s1); */
 $('#main').after(s1);
 var h= $('.right_col').height()+200;
 $('.right_col').animate({height:h}, 500);
});

 }); 
 $(window).load(function () {
		$(".se-pre-con").fadeOut("slow");
	});
</script>
  </body>
</html>