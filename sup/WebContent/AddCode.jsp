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
<%
/* String id = request.getParameter("userId"); */
/* String driverName = "com.mysql.jdbc.Driver"; */

// Testing Github push 
/* try {
Class.forName(driverName);
} 
catch (ClassNotFoundException e) {
e.printStackTrace();
}*/


//test 2 githib

DataSource ds = null;
Connection conn = null;
Statement st = null;

%>
 
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 
	  
    <title>KK Track- AddCode</title>

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
  </head>

 <body class="nav-md">
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
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
             <div class="menu_section">
              
                     <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home </a>
                    
                  </li>
                  <li><a><i class="fa fa-inr"></i> Expenses <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="expenseform.jsp">Add New Expense</a></li>
                      <li><a href="expenses.jsp">View Expenses</a></li>
                    </ul>
                  </li>
                <li class="admin"><a><i class="fa fa-shopping-cart"></i> Purchase <span class="fa fa-chevron-down"></span></a>
                  <ul class="nav child_menu">
                      <li><a href="addpurchase.jsp">Add New Purchase</a></li>
                      <li><a href="viewpurchase.jsp">View Purchase</a></li>
                      <li><a href="creditpurchase.jsp">Credit Purchase</a></li>
                      <li><a>Purchase Returns</a>
                      <ul class="nav child_menu">
                      <li><a href="viewpurchasereturn.jsp">View Returned Purchase items</a></li>
                      <li><a href="purchasereturn.jsp">Enter Returned Purchase items</a></li>
                    </ul>
                      </li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-table"></i> Sales <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="addsale.jsp">Add New Sale</a></li>
                      <li><a href="viewsale.jsp">View Sale</a></li>
                      <li><a href="creditsale.jsp">Credit Sale</a></li>
                      <li><a href="creditalert.jsp">Credit Alert</a></li>
                      <li><a>Sale Returns <span class="fa fa-chevron-down"></span></a>
                      <ul class="nav child_menu">
                      <li><a href="viewsalereturn.jsp">View Returned Sale items</a></li>
                      <li><a href="saleReturn.jsp">Enter Returned Sale items</a></li>
                    </ul>
                      </li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart-o"></i> Inventory <span class="fa fa-chevron-down"></span></a>
                   <ul class="nav child_menu">
                   <li><a href="viewinventory.jsp">View Stock</a></li>
                  <li class="admin"><a href="viewinvbal.jsp">View Overall Stock</a></li>
                  <li><a href="CodeList.jsp">View Code List</a></li>
                   <li><a href="inventoryAdjustment.jsp">Inventory Adjustment</a></li>
                      <li class="admin"><a href="AddCode.jsp">Add New Code</a></li>
                      </ul>
                  </li>
                  <li><a><i class="fa fa-truck"></i> Branch Transfer <span class="fa fa-chevron-down"></span></a>
                     <ul class="nav child_menu">
                      <li><a href="ibtform.jsp">IBT Form</a></li>
                      <li><a href="viewIBT.jsp">View IBT</a></li>
                      <li><a href="printingibt.jsp">Print IBT</a></li>
                    </ul>
                 </li>
                
                </ul>
              </div>

            </div>
       
          </div>
        </div>
<%   
String uBranch=(String)session.getAttribute("ubranch");
String role=(String)session.getAttribute("role");
 String user=(String)session.getAttribute("user");  
if(user==null)
	response.sendRedirect("login.jsp");
session.setAttribute("user",user);
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
                <h1>Inventory <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>

            <div style=" float:right; margin-right: 10px;">

                   <a href="AddCode.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="inventory.jsp"> <button type="button" class="btn btn-info">View </button></a>
             </div> 
             <br/><br/><br/>
             
                <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Add Code</h2>
                 <!--    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul> -->
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" action="AddCode.jsp" method="post">
                 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="code"> Code <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="code" required="required" class="form-control col-md-7 col-xs-12" name="code">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="hsncode">HSN Code </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="hsncode" class="form-control col-md-7 col-xs-12" name="hsncode">
                        </div>
                      </div>
                  <!--     <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Date <span class="required">*</span>
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
                    </div>  -->
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="mac"> Mac </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="mac" class="form-control col-md-7 col-xs-12" name="mac">
                        </div>
                      </div>
                      <div class="form-group">
                        <label  class="control-label col-md-3 col-sm-3 col-xs-12">PartNo</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="partno" class="form-control col-md-7 col-xs-12" type="text" name="partno">
                        </div>
                      </div>
                      <div class="form-group">
                        <label  class="control-label col-md-3 col-sm-3 col-xs-12">Description</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="description" class="form-control col-md-7 col-xs-12" type="text" name="description">
                        </div>
                      </div>
                      <div class="form-group">
                        <label  class="control-label col-md-3 col-sm-3 col-xs-12">Group</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="group" class="form-control col-md-7 col-xs-12" type="text" name="group">
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Max Price </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="maxprice" class="form-control col-md-7 col-xs-12"  type="number" name="maxprice" min=0>
                        </div>
                      </div>
                    
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Min Price </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="minprice" class="form-control col-md-7 col-xs-12"  type="number" name="minprice" min=0>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">LC </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="qty" class="form-control col-md-7 col-xs-12" type="number" name="LC" min=0>
                        </div>
                      </div>
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="btn btn-primary" type="button">Cancel</button>
              <button class="btn btn-primary" type="reset">Reset</button>
                          <button type="submit" class="btn btn-success">Submit</button>
          <%
          String code = request.getParameter("code");
    String hsncode = request.getParameter("hsncode");
   String mac = request.getParameter("mac");
    String date = request.getParameter("date"); 
  
   /* String date="2017-07-18"; */
   String partno = request.getParameter("partno");
   String maxprice = request.getParameter("maxprice");
   String minprice = request.getParameter("minprice");
   String description = request.getParameter("description");
   String group = request.getParameter("group");
  /*  String branch = request.getParameter("branch"); */
   String LC = request.getParameter("LC");
 /*  int max=Integer.parseInt(maxprice);
  int min=Integer.parseInt(minprice); */
  /*  String connectionURL = "jdbc:mysql://localhost:8889/KKTrack"; */
   // declare a connection by using Connection interface 

 // declare object of Statement interface that uses for executing sql statements.
/* PreparedStatement pstatement = null; */
  // Load JBBC driver "com.mysql.jdbc.Driver"
/* Class.forName("com.mysql.jdbc.Driver").newInstance(); */
   int updateQuery = 0;

	 // check if the text box is empty

              try {
       /* Create a connection by using getConnection()
       method that takes parameters of string type 
       connection url, user name and password to connect 
	to database. */
	
    /*    connection = DriverManager.getConnection(connectionURL, "root", "root"); */
    
                     // sql query to insert values in the secified table.
                     
     /*   Statement st=connection.createStatement(); */
  if(code!=null){   
/*      Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) { */
	  Class.forName("com.mysql.jdbc.Driver").newInstance();  
   conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
   // conn = ds.getConnection();
    st = conn.createStatement();
  
       int i=st.executeUpdate("insert into CodeList(Code, HSNCode, Machine, PartNo, Description, Grp, MaxPrice, MinPrice,LC ) values ('"+code+"','"+hsncode+"','"+mac+"','"+partno+"','"+description+"','"+group+"','"+maxprice+"','"+minprice+"','"+LC+"')");
       
  %>
                 </div>
               </div>

             </form>
           </div>
         </div>
       </div>
     </div>
     <br>
    <div class="col-md-10" style= " margin-top:-56%;">
           <div class="alert alert-success alert-dismissible fade in" role="alert">
             <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
             </button>
             <strong>Inserted successfully in database.</strong>
           </div>
       
     </div> 
  
       <%
      /*  out.println("Inserted successfully in database."); */
    // } 
  }     }         
     catch (Exception ex) {
     out.println("Code already exists!");
     System.out.println(ex);

        }
              finally {
            	     try {
            	       if (st != null)
            	        st.close();
            	       }  catch (SQLException e) {}
            	       try {
            	        if (conn != null)
            	         conn.close();
            	        } catch (SQLException e) {}
            	    }
  

%>
       
        <!-- /page content -->
</div>
</div>
</div>

</div>
</div>

        <!-- footer content -->
         <!-- <footer>
          <div class="pull-right">
            Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
          </div>
          <div class="clearfix"></div>
        </footer> -->
        <!-- /footer content -->
        <!-- /footer content -->
    

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
$(document).ready(function() {
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	if(role!=null && role!="1")
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
	
	}});
function dch() { 
  var d=document.getElementById("single_cal3").value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
  document.getElementById('da').value=da;
}
$(document).ready(function() {
var h= $('.right_col').height()+100;
$('.right_col').animate({height:h}, 500);
});
</script>
  </body>
</html>

</html>