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
%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- Manufacturing</title>

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
              <div class="title_left">
                <h1>Manufacturing Edit <!-- <small>Some examples to get you started</small> --></h1>
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
            
     
           
           <%-- <label class="control-label col-md-1 col-sm-1 col-xs-2">Purchase Date</label> 
                   <div class="col-md-3" style="margin-left:-10px;">
                         <div class="daterangepicker dropdown-menu ltr single opensright show-calendar picker_3 xdisplay"><div class="calendar left single" style="display: block;"><div class="daterangepicker_input"><input class="input-mini form-control active" type="text"  value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th class="prev available"><i class="fa fa-chevron-left glyphicon glyphicon-chevron-left"></i></th><th colspan="5" class="month">Oct 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">25</td><td class="off available" data-title="r0c1">26</td><td class="off available" data-title="r0c2">27</td><td class="off available" data-title="r0c3">28</td><td class="off available" data-title="r0c4">29</td><td class="off available" data-title="r0c5">30</td><td class="weekend available" data-title="r0c6">1</td></tr><tr><td class="weekend available" data-title="r1c0">2</td><td class="available" data-title="r1c1">3</td><td class="available" data-title="r1c2">4</td><td class="available" data-title="r1c3">5</td><td class="available" data-title="r1c4">6</td><td class="available" data-title="r1c5">7</td><td class="weekend available" data-title="r1c6">8</td></tr><tr><td class="weekend available" data-title="r2c0">9</td><td class="available" data-title="r2c1">10</td><td class="available" data-title="r2c2">11</td><td class="available" data-title="r2c3">12</td><td class="available" data-title="r2c4">13</td><td class="available" data-title="r2c5">14</td><td class="weekend available" data-title="r2c6">15</td></tr><tr><td class="weekend available" data-title="r3c0">16</td><td class="available" data-title="r3c1">17</td><td class="today active start-date active end-date available" data-title="r3c2">18</td><td class="available" data-title="r3c3">19</td><td class="available" data-title="r3c4">20</td><td class="available" data-title="r3c5">21</td><td class="weekend available" data-title="r3c6">22</td></tr><tr><td class="weekend available" data-title="r4c0">23</td><td class="available" data-title="r4c1">24</td><td class="available" data-title="r4c2">25</td><td class="available" data-title="r4c3">26</td><td class="available" data-title="r4c4">27</td><td class="available" data-title="r4c5">28</td><td class="weekend available" data-title="r4c6">29</td></tr><tr><td class="weekend available" data-title="r5c0">30</td><td class="available" data-title="r5c1">31</td><td class="off available" data-title="r5c2">1</td><td class="off available" data-title="r5c3">2</td><td class="off available" data-title="r5c4">3</td><td class="off available" data-title="r5c5">4</td><td class="weekend off available" data-title="r5c6">5</td></tr></tbody></table></div></div><div class="calendar right" style="display: none;"><div class="daterangepicker_input"><input class="input-mini form-control" type="text" name="daterangepicker_end" value="" style="display: none;"><i class="fa fa-calendar glyphicon glyphicon-calendar" style="display: none;"></i><div class="calendar-time" style="display: none;"><div></div><i class="fa fa-clock-o glyphicon glyphicon-time"></i></div></div><div class="calendar-table"><table class="table-condensed"><thead><tr><th></th><th colspan="5" class="month">Nov 2016</th><th class="next available"><i class="fa fa-chevron-right glyphicon glyphicon-chevron-right"></i></th></tr><tr><th>Su</th><th>Mo</th><th>Tu</th><th>We</th><th>Th</th><th>Fr</th><th>Sa</th></tr></thead><tbody><tr><td class="weekend off available" data-title="r0c0">30</td><td class="off available" data-title="r0c1">31</td><td class="available" data-title="r0c2">1</td><td class="available" data-title="r0c3">2</td><td class="available" data-title="r0c4">3</td><td class="available" data-title="r0c5">4</td><td class="weekend available" data-title="r0c6">5</td></tr><tr><td class="weekend available" data-title="r1c0">6</td><td class="available" data-title="r1c1">7</td><td class="available" data-title="r1c2">8</td><td class="available" data-title="r1c3">9</td><td class="available" data-title="r1c4">10</td><td class="available" data-title="r1c5">11</td><td class="weekend available" data-title="r1c6">12</td></tr><tr><td class="weekend available" data-title="r2c0">13</td><td class="available" data-title="r2c1">14</td><td class="available" data-title="r2c2">15</td><td class="available" data-title="r2c3">16</td><td class="available" data-title="r2c4">17</td><td class="available" data-title="r2c5">18</td><td class="weekend available" data-title="r2c6">19</td></tr><tr><td class="weekend available" data-title="r3c0">20</td><td class="available" data-title="r3c1">21</td><td class="available" data-title="r3c2">22</td><td class="available" data-title="r3c3">23</td><td class="available" data-title="r3c4">24</td><td class="available" data-title="r3c5">25</td><td class="weekend available" data-title="r3c6">26</td></tr><tr><td class="weekend available" data-title="r4c0">27</td><td class="available" data-title="r4c1">28</td><td class="available" data-title="r4c2">29</td><td class="available" data-title="r4c3">30</td><td class="off available" data-title="r4c4">1</td><td class="off available" data-title="r4c5">2</td><td class="weekend off available" data-title="r4c6">3</td></tr><tr><td class="weekend off available" data-title="r5c0">4</td><td class="off available" data-title="r5c1">5</td><td class="off available" data-title="r5c2">6</td><td class="off available" data-title="r5c3">7</td><td class="off available" data-title="r5c4">8</td><td class="off available" data-title="r5c5">9</td><td class="weekend off available" data-title="r5c6">10</td></tr></tbody></table></div></div><div class="ranges" style="display: none;"><div class="range_inputs"><button class="applyBtn btn btn-sm btn-success" type="button">Apply</button> <button class="cancelBtn btn btn-sm btn-default" type="button">Cancel</button></div></div></div>

                        <fieldset>
                          <div class="control-group">
                            <div class="controls">
                              <div class="col-md-11 xdisplay_inputx form-group has-feedback">
                                <input onchange="dch('single_cal3')" name="dateval" type="text" class="form-control has-feedback-left" name="sd" id="single_cal3" aria-describedby="inputSuccess2Status3">
                                <span class="fa fa-calendar-o form-control-feedback left" aria-hidden="true"></span>
                                <span id="inputSuccess2Status3" class="sr-only">(success)</span>
                              </div>
                            </div>
                          </div>
                        </fieldset>
                         <input id="da1" class="form-control col-md-7 col-xs-12" type="hidden" name="StartDate" >
                          <%   sd = request.getParameter("StartDate");
                   if(sd==null)
                	   sd="";
                   %>
                        
                      </div>
                    
        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="dc"> Invoice Number:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="text" id="dc"  class="form-control col-md-7 col-xs-12" name="dc" >
                        </div>
                     <label class="control-label col-md-1 col-sm-1 col-xs-2"  for="branch" style="margin-left: 4%;">Branch</label>    
             <div class="col-md-3 col-sm-3 col-xs-3">
                          <select class="select2_single form-control" tabindex="-1" name="branch" id="branch"  >
                            <option value="Bowenpally">Select Another Branch</option>
                                  <option value="Bowenpally">Bowenpally</option>
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
                            <option value="Chittoor">Chittoor</option>
                          </select>
                        </div>
                        <button type="submit" class="btn btn-success" onclick="d()">Go </button>
                        <input id="b1" class="form-control col-md-7 col-xs-12" type="hidden"  >
                       
                        
                       <input id="das" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=sd%> > --%>
                      <!--   </form>  -->
                      </div>
                    </div> 
                    
                     </div>
                     <div style=" float:right; margin-right: 10px; margin-top:20px">

            <a href="addItem.jsp"><button type="button" class="btn btn-success">Add </button></a>

                  <a href="viewManufacturing.jsp" style="color:white;">  <button type="button" class="btn btn-info">View </button></a>

                 <a href="editmanufacturing.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Edit</button></a>
             </div>  
       <br/>              
 
     <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Manufacturing updated successfully.</strong></div></div>";
 String succ2="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Manufacturing deleted successfully.</strong></div></div>";
 %>
 <div id="successMsg" >
<%  if(r!=null && r.equals("1"))
       	out.println(succ);
 else if(r!=null && r.equals("2"))
	 out.println(succ2); 
    %>
    </div>
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
        <form action="manedit.jsp">   
             <%--    <input type="hidden" id="sno" name="sno" value=<%=sno%> > --%>
        <div class="table-responsive"> 
       <table class="table  dt-responsive" width="100%">
               
                        <tbody>
                        <%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");
statement=connection.createStatement(); */
String dc=request.getParameter("dc");
/* System.out.println(dc); */
String cn=request.getParameter("sd");
/* System.out.println(cn);
System.out.println(branch); */
/* st=connection.createStatement(); */

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
    st = conn.createStatement();
String sql1 ="SELECT DISTINCT * FROM Manufacturing";
String whr=" where";

	whr+=" Manufacturing.Branch='"+branch+"'";

	whr+=" and Manufacturing.InvoiceNumber='"+dc+"'";

	if(cn!=null && cn.length()!=0)
	{
	whr+=" and Manufacturing.Date='"+cn+"'";
	}
	else
		whr+=" and Manufacturing.Date='"+cn+"'";

sql1+=whr;

if(branch!=null && dc!=null && cn!=null)
{
resultSet = st.executeQuery(sql1);

while(resultSet.next()){
	String sql2="SELECT ManDetails.Id,ManDetails.Code, CodeList.Description, CodeList.Machine, CodeList.PartNo,CodeList.Grp, CodeList.MaxPrice, ManDetails.ARR, ManDetails.Qty, ManDetails.TotalPrice, ManDetails.Tax FROM ManDetails inner join CodeList on ManDetails.Code=CodeList.Code where Mno=";
	int	primaryKey = resultSet.getInt("Manufacturing.Id");
	String whr2=primaryKey+"";
	sql2+=whr2;
	
	   st2 = conn.createStatement();
	   st3 = conn.createStatement();
	rs = st2.executeQuery(sql2);
	Date date=resultSet.getDate("Date");
%>
                                        <tr class="odd gradeX">
<td width="5%"><strong> Branch: </strong><%=resultSet.getString("Branch") %></td>
<td width="10%"><strong> Date: </strong><input class="col-md-12" type="text" id="date" name="date" value="<%=new SimpleDateFormat("dd-MM-yyyy").format(date) %>" ></td>
<td width="15%"><strong> Manufacturer Memo Number: </strong><%=resultSet.getString("InvoiceNumber") %></td>
<td width="10%"><strong>Manufacturer Name: </strong><%=resultSet.getString("ManufacturerName") %></td>
<td width="20%"><strong>TotalPrice with tax:</strong><input class="col-md-8" type="number"  readOnly id="totalprice" name="totalprice" value=<%=resultSet.getString("TotalPrice") %>></td>
<td width="10%"><strong>Total Tax:</strong> <input class="col-md-8" type="number"  readOnly id="totaltax" name="totaltax" value=<%=resultSet.getString("Tax") %>></td></tr>

                      </tbody>
                    </table>
                    <table  class="table table-striped table-bordered">
                      <thead>
                        <tr>
                            <tr>
                                            <th>M.no</th>
                                            <th>Code</th>
                                            <th>Description</th>
                                            <th>Machine</th>
                                            <th>Part Number</th>
                                            <th>Group</th>
                                            <th>ARR</th>
                                            <th>Quantity</th>
                                             <th>Total Price</th>
                                            <th>Tax per unit</th>
                                             <th>
                                            <input type=checkbox name='selectAllCheck' onClick='funcSelectAll()' value='Select All'></input>
                                            Delete All
                                          </th>
                                            <!--   <th>Delete Item</th>
                                           <th>Damaged Qty</th>
                                            <th>Excess Qty</th> -->
                                          

                                        </tr>
                      </thead>
                        <tbody >
                          <tr class="odd gradeX">
                          <%   //System.out.println("i values: ");
                       // create map to store
                          Map<Integer, List<String>> map = new HashMap<Integer, List<String>>(); 
                       while(rs.next())
{
                    	 	  List<String> list = new ArrayList<String>();
                        	  float bqty=rs.getFloat("ManDetails.Qty") ;
                        	   i=rs.getInt("ManDetails.Id") ;
                        	  // System.out.println(i);
	%>

<td><%=sno%></td>
<td><%=rs.getString("ManDetails.Code") %></td>
<td><%=rs.getString("Description") %></td>
<td><%=rs.getString("Machine") %></td>
<td><%=rs.getString("PartNo") %></td>
<td><%=rs.getString("Grp") %></td>
<td><input style="width: 100px;" type="number" id="arr<%=i %>" name="arr<%=i %>" value="<%=rs.getString("ManDetails.ARR")%>" onchange="calculatetax(<%=i %>);"></td>
<td><input style="width: 100px;" type="number" id="nq<%=i %>" name="nq<%=i %>" step="any" value=<%=bqty%> onchange="calculateTotal(<%=i %>);"></td>
<td><input style="width: 100px;" type="number" readOnly id="tp<%=i %>" name="tp<%=i %>" value=<%=rs.getString("ManDetails.TotalPrice")%> >
<td><input style="width: 100px;" type="number" readOnly id="tax<%=i %>" name="tax<%=i %>" value=<%=rs.getString("ManDetails.Tax")%> > 
               <%--  <input type="number" id="dq<%=i %>" name="dq<%=i %>" value="0" style="width: 80%;margin-left: 7%;" min="0" max="<%=bqty%>">  --%>
                <%--  <input type="hidden" id="ap" name="ap" value=<%=resultSet.getString("AmountPaid")%> > 
                <input type="hidden" id="ba" name="ba" value=<%=resultSet.getString("BalanceAmount")%> > --%>
                <input type="hidden" id="q<%=i %>" name="q<%=i %>" value=<%=bqty%> > 
               <%--  <input type="hidden" id="cp<%=i %>" name="cp<%=i %>" value=<%=rs.getString("InvoiceDetails.Price")%> > --%>
                 <input type="hidden" id="mid<%=i %>" name="mid<%=i %>" value=<%=i%> >
                 <input type="hidden" id="code<%=i %>" name="code<%=i %>" value=<%=rs.getString("ManDetails.Code")%> >
                 
                <input type="hidden" id="payid" name="payid" value=<%=primaryKey %> > 
                <input type="hidden" id="branch" name="branch" value=<%=branch %> > 
                <input type="hidden" id="oarr<%=i %>" name="oarr<%=i %>" value=<%=rs.getString("ManDetails.ARR")%> > 
                <input type="hidden" id="otp" name="otp" value=<%=resultSet.getFloat("TotalPrice") %> > 
                   <input type="hidden" id="manname" name="manname" value=<%=resultSet.getString("ManufacturerName") %> > 
                <input type="hidden" id="i" name="i">  
                <input type="hidden" id="date" name="date" value=<%=cn%> >  
                  <input type="hidden" id="cn" name="cn" value=<%=cn%> > 
                <input type="hidden" id="dc" name="dc" value=<%=resultSet.getString("InvoiceNumber")%> > 
                  <input type="hidden"  name="ids[]" class="manIds"  value="<%=i %>" />
</td>
<%-- <td style="width: 10%;"><a href="delpur.jsp?deleteid=<%=primaryKey %>&branch=<%=branch %>&ba=<%=resultSet.getString("BalanceAmount")%>&code<%=i %>=<%=rs.getString("InvoiceDetails.Code")%>&q<%=i %>=<%=bqty%>&cp<%=i %>=<%=rs.getString("InvoiceDetails.Price")%>&bid<%=i %>=<%=i %>&tp=<%=resultSet.getFloat("TotalPrice") %>&i=<%=i %>&dc=<%=dc%>&sd=<%=cn%>" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a> </td> --%>
  <td>  <input type="checkbox" class="chkbox" name="checkboxRow" value="<%=i %>">   </td>   
</tr>
 <%
 list.add(String.valueOf(primaryKey));
 list.add(branch);
 //list.add(resultSet.getString("BalanceAmount"));
 list.add(rs.getString("ManDetails.Code"));
 list.add(String.valueOf(bqty));
 list.add(rs.getString("ManDetails.ARR"));
 list.add(rs.getString("ManDetails.Tax"));
 list.add(rs.getString("ManDetails.TotalPrice"));
 list.add(String.valueOf(i));
 list.add(dc); 
 list.add(cn);
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
 %>
</tbody> 
</table>
   <input type="hidden" id="mapValues" name="<%=map%>">  
<label for="com" style="float:left;"><strong> Comments: </strong></label><input class="col-md-4" type="text" id="com" name="com" style="margin-left:10px;" value="<%=resultSet.getString("Comments") %>">  
<button id="deleteButton" onclick="deleteCheckedRecords()" type="button" style="float:right" class="btn btn-danger" data-toggle="modal" data-target=".bs-example-modal-sm"><i class="fa fa-trash-o"></i> Delete</button>
 
<button type="submit" class="btn btn-success" style="float:right" onclick="chsn(<%=i%>)">Save</button>
 <a href="addmanedit.jsp?branch=<%=branch %>&pid=<%=primaryKey%>&dc=<%=dc%>&sd=<%=cn%>"><button type="button" class="btn btn-success" style="float:right">Add More Items</button></a> 
<input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                   <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
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

	var array = $('input:hidden.manIds').map(function(){
        return $(this).val()
    }).get();
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
function calculatetax(i)
{
	//document.getElementById('tp'+i).value=parseFloat(document.getElementById("arr"+i).value)*parseFloat(document.getElementById("nq"+i).value);
	var arr=document.getElementById("arr"+i).value;
	if(arr!=null)
		{
		document.getElementById('tax'+i).value=0.18*parseFloat(arr);
	calculateTotal(i);
	
		}
	/* var billId=0;
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
	balcalc(); */
}

function calculateTotal(i)
{
	if(document.getElementById("nq"+i).value!=null)
		{
		document.getElementById('tp'+i).value=parseFloat(document.getElementById("arr"+i).value)*parseFloat(document.getElementById("nq"+i).value);
		
		  var totalprice=0.0;
		  var totaltax=0.0;
		  var manId;
		  
		  for(var j = 0; j < array.length; j++) 
			  {
				  //if(document.getElementById("id"+x)!=null)
				  //{
					  manId=array[j];
		
			  //tot+=parseFloat(document.getElementById("nq"+billId).value);
			  totalprice+=parseFloat(document.getElementById("tp"+manId).value);
			  totaltax+=parseFloat(document.getElementById("tax"+manId).value)*parseFloat(document.getElementById("nq"+manId).value);
				 // }
			  }
		  totalprice=totalprice+totaltax;
		  document.getElementById("totalprice").value=totalprice;
		  document.getElementById("totaltax").value=totaltax;
		}

}
$("#deleteButton").click(function() {
	 $('#successMsg').hide();
	  //var count_checked = $("[name='checkboxRow[]']:checked").length; // count the checked rows
	  var count_checked = $('input[type="checkbox"]:checked').length;
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
function deleteCheckedRecords(){
	//var did=document.getElementById("did").value;
	var pk=document.getElementById("payid").value;
	var branch=document.getElementById("branch").value;
	var dc=document.getElementById("dc").value;
	var cn=document.getElementById("cn").value;
	//alert(pk);
	//alert(branch);
	//alert(dc);
	//alert(cn);
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

		document.getElementById('did').href=('BulkDeleteManufacturing.jsp?selectedItems='+selectedItems+'&deleteid='+pk+'&branch='+branch+'&dc='+dc+'&sd='+cn);
	}
}

 $(document).ready(function() {
	 $.getScript("js/rolePermissions.js");
		var ubran=document.getElementById('ubran').value;
		var role=document.getElementById('urole').value;
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
		  if($(this).attr('type')!="checkbox")
		  {
		  //$('.cboxes').attr('disabled', 'disabled');
		 $('#deleteButton').attr('disabled', 'disabled');
		  }
	  });
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

  </body>
</html>