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
<%@ page import="java.io.InputStream" %>
<%
/* String id = request.getParameter("userId"); */
/* String driverName = "com.mysql.jdbc.Driver";


try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
} */
DataSource ds = null;
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 
	  
    <title>KK Track- Expenses</title>

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
        <!-- top navigation -->
        

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h1>Expenses <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>

            <div style=" float:right; margin-right: 10px;">

                   <a href="expenseform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="expenses.jsp"> <button type="button" class="btn btn-info">View </button></a>

                 <a href="editexpense.jsp"><button type="button" class="btn btn-warning">Edit</button></a>
                  <a href="CashTransfer.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Cash Transfers</button></a>
             </div> 
             <br/><br/><br/>
             
                <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Add Expense</h2>
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
                    <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" action="expenseform.jsp" method="get" onsubmit="myButton.disabled = true;">
                         <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                   <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>> 
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-6">Branch<span class="required">*</span></label>
                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                          <select class="select2_single form-control admin" tabindex="-1" name="branch">
                            <option></option>
                            
                            <option value="KKExpenses">KK Expenses</option>
                              <!-- <option value="Bowenpally">Bowenpally</option>
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
                     <input type="text" id="br" class="form-control col-md-7 col-xs-12 user" name="br" style="display:none;" value=<%=uBranch %> disabled> 
                        </div>
                      </div>
                      <div class="form-group">
                     
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" for="voucherNo"> Voucher No <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input type="text" id="voucherNo" required="required" class="form-control col-md-7 col-xs-12" name="voucherNo">
                        </div>
                      </div>
                      <div class="form-group">
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
                    </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12" >Type<span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-6">
                          <select class="select2_single form-control" required="required" tabindex="-1" name="type">
                            <option></option>
                            <option value="Rent">Rent</option>
                            <option value="Salary">Salary</option>
                            <option value="Conveyance">Conveyance</option>
                            <option value="Refreshments">Refreshments</option>
                            <option value="Food&Water">Food & Water</option>
                            <option value="TelephoneBill">Telephone Bill</option>
                            <option value="Transport">Transport</option>
                            <option value="VehicleService">Vehicle Service</option>
                            <option value="TourExpense">Tour Expenses</option>
                            <option value="Labour&Hamali">Labour Or Hamali</option>
                            <option value="Stationery">Stationery</option>
                            <option value="Steel">Steel</option>
                             <option value="Repair">Repair</option>
                            <option value="Commission">Commission</option>
                            <option value="ElectricityBill">Electricity Bill</option>
                            <option value="Courier">Courier</option>
                            <option value="Purchase">Purchase</option>
                            <option value="CashTransfer">Cash Transfer</option>
                            <option value="Interest">Interest On Loans</option>
                            <option value="CreditCard">Credit Card Expenses</option>
                            <option value="Building">Building Maintenance</option>
                            <option value="Medical">Medical</option>
                            <option value="Others">Others</option>
                          </select>
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="control-label col-md-3 col-sm-3 col-xs-12">Amount <span class="required">*</span>
                        </label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="amount" class="form-control col-md-7 col-xs-12" required="required" type="number" name="amount" min=0>
                        </div>
                      </div>
                      <div class="form-group">
                        <label  class="control-label col-md-3 col-sm-3 col-xs-12">Description</label>
                        <div class="col-md-6 col-sm-6 col-xs-12">
                          <input id="description" class="form-control col-md-7 col-xs-12" type="text" name="description">
                        </div>
                      </div>
                    
                      
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="btn btn-primary" type="button">Cancel</button>
              <button class="btn btn-primary" type="reset">Reset</button>
                          <button type="submit" name="myButton" class="btn btn-success">Submit</button>
          <%
          String branch = request.getParameter("branch");
          if(!role.equals("1"))
        	  branch=uBranch;
       /*    System.out.println(role+branch); */
   String voucherNo = request.getParameter("voucherNo");
    String date = request.getParameter("date"); 
/*   System.out.println(branch); */
   /* String date="2017-07-18"; */
   String type = request.getParameter("type");
   String description = request.getParameter("description");
   String amount = request.getParameter("amount");
   /* Create string of connection url within specified 
   format with machine name, 
    port number and database name. Here machine name id 
    localhost and database name is student. */
  /*   String connectionURL = "jdbc:mysql://localhost:8889/KKTrack"; */
          // declare a connection by using Connection interface 
    
        // declare object of Statement interface that uses for executing sql statements.
     PreparedStatement pstatement = null;
         // Load JBBC driver "com.mysql.jdbc.Driver"
     /* Class.forName("com.mysql.jdbc.Driver").newInstance(); */
          int updateQuery = 0;
     
     	 // check if the text box is empty
	 if(voucherNo!=null && branch!=null ){
	 		 // check if the text box having only blank spaces
	     if(voucherNo!="" && branch!="") {
	                 try {
              /* Create a connection by using getConnection()
              method that takes parameters of string type 
              connection url, user name and password to connect 
		to database. */
        /*       connection = DriverManager.getConnection(connectionURL, "root", "root"); */
                            // sql query to insert values in the secified table.
  
/*   Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
	  connection = ds.getConnection(); */
	  //Class.forName("com.mysql.jdbc.Driver").newInstance();  
	   //  connection = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");
	 if (driver != null) {
        Class.forName(driver).newInstance();  
    }
	  
    connection = DriverManager.getConnection(url, username, password);
              Statement st=connection.createStatement();

              String s="insert into Expenses (Branch, VoucherNo, Date, Type, Description, Amount)values('"+branch+"','"+voucherNo+"','"+date+"','"+type+"','"+description+"','"+amount+"')";
              if(type.equals("CashTransfer"))
            	  s="insert into CashTransfer (Branch, Name, Date, Type, Description, Amount)values('"+branch+"','"+voucherNo+"','"+date+"','"+type+"','"+description+"','"+amount+"')";
          /*   System.out.println(s); */
          else  if(type.equals("Steel") || type.equals("Repair"))
            	  s="insert into PurchaseCost (Branch, Name, Date, Type, Description, Amount)values('"+branch+"','"+voucherNo+"','"+date+"','"+type+"','"+description+"','"+amount+"')";
          
                int i=st.executeUpdate(s);
         %>
                        </div>
                      </div>

                    </form>
                  </div>
                </div>
              </div>
            </div>
            <br>
	       <div class="col-md-6" style= margin-left:280px">
                  <div class="alert alert-success alert-dismissible fade in" role="alert" style="margin-top: -110%;">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span>
                    </button>
                    <strong>Inserted successfully in database.</strong>
                  </div>
              
            </div> 
         
              <%
             /*  out.println("Inserted successfully in database."); */
          //  } 
	                 }
            catch (Exception ex) {
            out.println("Unable to connect to database.");
            System.out.println(ex);
   
               }
            finally {
                // close all the connections.
               
                connection.close();
            }
	  }
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
     <script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>
      <script>
    var ubran=document.getElementById('ubran').value;
    var role=document.getElementById('urole').value;
    var environment=document.getElementById('uenv').value;
    var path = window.location.pathname;
    var callingJSP = path.split("/").pop();
</script>
<script>
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
    		var elements = document.getElementsByClassName('user');

    	    for (var i = 0; i < elements.length; i++){
    	        elements[i].style.display = "block";
    	    }
	
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

});
function dch() { 
  var d=document.getElementById("single_cal3").value.toString();
var dv=d.split("/");
var da=dv[2]+'-'+dv[0]+'-'+dv[1];
  document.getElementById('da').value=da;
}

$(window).load(function () {
	$(".se-pre-con").fadeOut("slow");
});
</script>
  </body>
</html>

</html>