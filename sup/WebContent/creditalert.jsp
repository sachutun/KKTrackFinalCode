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
} */

Statement st = null;
Statement st2 = null;
DataSource ds = null;
Connection conn = null;
Statement st3 = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs2 = null;
%>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 

    <title>KK Track- Sales</title>

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
  </head>
 <style>
td.highlight {
        font-weight: bold;
        color: #ce1a1a;
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
                <h1>Sales <!-- <small>Some examples to get you started</small> --></h1>
              </div>
            <div class="clearfix"></div>

            <div>
         
           <form id="FormId" action="creditalert.jsp" method="post" class="form-horizontal form-label-left">
             <div class="col-md-4 col-sm-6 col-xs-12">
                        <div id="reportrange_right" class="pull-left" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                          <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                          <span id="daterange"></span> <b class="caret"></b>
                            <input id="std" name="std" class="form-control col-md-7 col-xs-12" type="hidden" > 
                  <input id="end" name="end" class="form-control col-md-7 col-xs-12" type="hidden" > 
                        </div>
                      </div>
                      <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
             <div class="col-md-3 col-sm-3 col-xs-4">
                          <select class="select2_single form-control admin" tabindex="-1" name="branch" id="branch">
                            <option value="">Select Another Branch</option>
                            <option value="All">All Branches</option>
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
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> </form>
                     <br/>
                     <br/>
                           <br/>
            <div class="clearfix"></div>
    
<%  String branch = request.getParameter("branch");
if(branch!=null && branch.equals("All"))
    branch="";
if(role!=null && !(role.equals("1")))
	   branch=uBranch; 
String std=request.getParameter("std");
 String end=request.getParameter("end");	

                   %>
                             <div style=" float:right; margin-right: 10px; margin-top:-50px">

            <a href="addsale.jsp"><button type="button" class="btn btn-success">Add New Sale</button></a>

                  <a href="viewsale.jsp" style="color:white;">  <button type="button" class="btn btn-info">View Sale</button></a>

                 <a href="editSale.jsp" style="color:white;">   <button type="button" class="btn btn-warning admin">Edit Sale</button></a>
                  <a href="saleReturn.jsp" style="color:white;">   <button type="button" class="btn btn-info" style="background: #f19292;border: 1px solid #f19292;">Return Sale</button></a>
             </div>   
        <div class="table-responsive"> 
                  <table class="table" >
       
        <tbody>
          
            <tr id="filter_col" >
         
                <td align="center">Date: <input type="text" class="column_filter" id="col1_filter" data-column="1"></td>
        
          <!--   </tr>
            <tr id="filter_col4" data-column="4"> -->
               <!--  <td>Date</td> -->
                <td align="center">DC Number: <input type="text" class="column_filter" id="col2_filter" data-column="2"></td>
              
            <!-- </tr>
            <tr id="filter_col5" data-column="5"> -->
               <!--  <td>Type</td> -->
                <td align="center">Customer Name: <input type="text" class="column_filter" id="col3_filter" data-column="3"></td>
               
           <!--  </tr>
            <tr id="filter_col6" data-column="6"> -->
                <!-- <td>Description</td> -->
               <!--  <td align="center">Type: <input type="text" class="column_filter" id="col8_filter" data-column="8"></td> -->
  
       
  
            </tr>
        </tbody></table></div>

          <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>View Credit Sale</h2>
                 
                       <%--  <label style="float:right" ><%= branch %></label> --%>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  
       <div class="table-responsive"> 
                    <table id="ex" class="table table-striped table-bordered dt-responsive" width="100%">
                      <thead>
                        <tr>
                            <tr>
                                            
                                             <th>Branch</th>
                                            <th>Date</th>
                                            <th>DC Number</th>
                                            <th>Customer Name</th>
                                            <th>Customer Number</th>
                                            <th>Total price</th>
                                            <th>Amount Paid</th>
                                            <th>Balance Amount</th>
                                            <th>No.Of Days</th>
                                            <th>Bill Details</th> 
                                            <th>Previous Payment Details</th> 
                                            <th>New Payment</th>  
                                           
                                        </tr>
                      </thead>
                                  <tfoot>
            <tr>
                <th colspan="7" style="text-align:right">Total Amount to be Collected:</th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
                <th></th>
            </tr>
        </tfoot>
                        <tbody>
                        <%
try{ 
/* connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");
statement=connection.createStatement(); */

String dc=request.getParameter("dc");
String cn=request.getParameter("cn");

/* st=connection.createStatement(); */
 
/* Context context = new InitialContext();
  Context envCtx = (Context) context.lookup("java:comp/env");
  ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
  if (ds != null) {
    conn = ds.getConnection(); */
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
     //conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
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

    conn = DriverManager.getConnection(url, username, password);
    st = conn.createStatement();
String sql1 ="SELECT *,DATEDIFF(CURRENT_DATE, Date) as 'days' FROM Sale WHERE BalanceAmount>0 and DATEDIFF(CURRENT_DATE, Date)>50";
String whr="";
if(branch!=null && branch.length()!=0 )
{
	whr+=" and Sale.Branch='"+branch+"'";
}
if(dc!=null && dc.length()!=0 )
{
	whr+=" and Sale.DCNumber='"+dc+"'";
}
if(cn!=null && cn.length()!=0 )
{
	whr+=" and Sale.CustomerName='"+cn+"'";
}
/* if(std!=null && std.length()!=0)
{
	whr+=" and Date between '"+std+"' and '"+end+"'";
	//sql3+=w;
} */
/* else
{
	whr+=" and Month(Date) in( Month(CURDATE()))";
} */
sql1+=whr;

resultSet = st.executeQuery(sql1);

while(resultSet.next()){
	String sql2="SELECT BillDetails.Id, BillDetails.Code, CodeList.Description, CodeList.Machine, CodeList.PartNo, CodeList.Grp, CodeList.LC, CodeList.MaxPrice, BillDetails.CostPrice, BillDetails.Qty, BillDetails.Total FROM BillDetails inner join CodeList on BillDetails.Code=CodeList.Code where DC=";
	int	primaryKey = resultSet.getInt("Sale.Id");
	String whr2=primaryKey+"";
	sql2+=whr2;
    st2 = conn.createStatement();
    st3 = conn.createStatement();
	rs = st2.executeQuery(sql2);
	int sno=1;
	String b=resultSet.getString("Branch");
	Date date=resultSet.getDate("Date");
%>
                                        <tr class="odd gradeX">
                                          
<td><%=resultSet.getString("Branch") %></td>
<td width="10%"><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>
<td><%=resultSet.getString("DCNumber") %></td>
<td><%=resultSet.getString("CustomerName") %></td>
<td><%=resultSet.getString("CustomerNumber") %></td>
<td><%=resultSet.getDouble("TotalPrice") %></td>
<td><%=resultSet.getString("AmountPaid") %></td>
<td><%=resultSet.getString("BalanceAmount") %></td>
<td><%=resultSet.getString("days") %></td>

 <td><table id="" class="table table-striped table-bordered">
                      <thead>
                        <tr>
                            <tr>
                                            <th>S.no</th>
                                            <th>Code</th>
                                            <th>Description</th>
                                            <th>Machine</th>
                                            <th>Part No</th>
                                            <th>Group</th>
                                            <th>Quantity</th> 
                                            <th>Sale Price</th>
                                            <th>Total</th>
                                            <th class="admin">LC</th> 
                                            <th>Max Price</th>

                                        </tr>
                      </thead>
                        <tbody >
                          <tr class="odd gradeX">
                          <% while(rs.next())
{
	%>

<td><%=sno++%></td>
<td><%=rs.getString("BillDetails.Code") %></td>
<td><%=rs.getString("Description") %></td>
<td><%=rs.getString("Machine") %></td>
<td><%=rs.getString("PartNo") %></td>
<td><%=rs.getString("Grp") %></td>
<td><%=rs.getInt("BillDetails.Qty") %></td>
<td><%=rs.getInt("BillDetails.CostPrice") %></td>
<td><%=rs.getInt("BillDetails.Total") %></td>
<td class="admin"><%=rs.getInt("LC") %></td>
<td><%=rs.getDouble("MaxPrice") %></td>
</tr>
 <% }%>
</tbody> </table></td> 
<% 
   rs2 = st3.executeQuery("SELECT * FROM SaleCredit where Ino="+primaryKey);
                         
if(!rs2.isLast() && ((rs2.getRow() != 0) || rs2.isBeforeFirst()))
{

                        	%>
                        <td width="100%"><table id="" class="table table-striped table-bordered">
                                              <thead>
                                                <tr>
                                                     <tr> 
                                                                    
                                                                    <th>Amount</th>
                                                                    <th>Discount</th>
                                                                    <th>Date</th>
                                                                    

                                                                </tr>
                                              </thead>
                                                <tbody >
                                                  <tr class="odd gradeX">
                                                  <%while(rs2.next()){
                                                		 %>
                                                  <td><%=rs2.getInt("Amount") %></td>
                                                  <td><%=rs2.getInt("Discount") %></td>
                        <td><%=rs2.getString("Date") %></td>
                       </tr>
                      <%}
                                                  %>
                                                   </tbody> </table></td><% } 
                      else
                      {
                    	 
                      %>
                      <td></td>
                      <%} %>
<td>
<!--                        
                            <a href="#" class="btn btn-info btn-xs"><i class="fa fa-pencil"></i> Edit </a> -->
                            <div class="form-group">
                           <form action="balancepay.jsp?branch=<%=resultSet.getString("Branch") %>">
                   <div class="col-md-4 col-sm-3 col-xs-4 ">
               <label for="pay"> Amount:</label>
                <input type="text" id="pay" name="pay" style="margin-left: 7%;width: 40%;" min="0" max=<%=resultSet.getString("BalanceAmount")%>> 
             </div>
             <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="dis"> Discount:</label>
                <input type="text" id="dis" value="0" name="dis" style="margin-left: 7%;width: 50%;"> 
             </div>
               <div class="col-md-3 col-sm-3 col-xs-4 ">
               <label for="pdate"> Date:</label>
                <input type="text" id="pdate" name="pdate" style="margin-left: 7%;width: 60%;"> 
             </div>
               
                 <input type="hidden" id="ap" name="ap" value=<%=resultSet.getString("AmountPaid")%> >
                  <input type="hidden" id="ba" name="ba" value=<%=resultSet.getString("BalanceAmount")%> > 
                   <input type="hidden" id="payid" name="payid" value=<%=primaryKey %> > 
                   <input type="hidden" id="branch" name="branch" value=<%=branch %> > 
                 <% 
                 String pay=request.getParameter("pay"); 
                 String ap=resultSet.getString("AmountPaid") ;
                 String ba=resultSet.getString("BalanceAmount");
                 String s=pay+","+ap+","+ba;
                 %>
              <button type="submit" class="btn btn-success" style="margin-bottom: 1px;margin-left: 2%;" >Pay </button>
      </form>
                </div>
          <!--   <button onclick="f()" type="button" class="btn btn-primary" data-toggle="modal" data-target=".bs-example-modal-sm">Small modal</button> -->

               
               </td>

                                        </tr>
                               
                                        
                  
                                        <%
                                        whr2="";
}
  //}
} catch (Exception e) {
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



                      </tbody>
                    </table>
                  </div>
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
    <script src="http://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.2/modernizr.js"></script>


<script type='text/javascript'>
function filterColumn ( i ) {
    $('#ex').DataTable().column( i ).search(
        $('#col'+i+'_filter').val()
    ).draw();
}
$(document).ready(function() {
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
	   
	var table=$('#ex').DataTable( {
		     
		        "iDisplayStart":0,
		        "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
		        "order": [[ 8, "desc" ]],
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
		                  .column( 7 )
		                  .data()
		                  .reduce( function (a, b) {
		                      return intVal(a) + intVal(b);
		                  }, 0 );
		   
		              // Total over this page
		              pageTotal = api
		                  .column( 7, { page: 'current'} )
		                  .data()
		                  .reduce( function (a, b) {
		                      return intVal(a) + intVal(b);
		                  }, 0 );
		   
		              // Update footer
		              $( api.column( 7 ).footer() ).html(
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
			        "createdRow": function ( row, data, index ) {
				         if($('td', row).eq(8).html()>=60)
				        	 {
		                $('td', row).addClass('highlight');
				        	 }
			        }, 
		      
		        dom: 'lfrtip'/* ,
		        buttons: [
		            'copy', 'excel', 'pdf', 'print'
		        ] */
		    } );
	
	$('input.column_filter').on( 'keyup click', function () {
	    filterColumn( $(this).attr('data-column') );
	} );
	} );
</script> 
<script src="http://www.datejs.com/build/date.js" type="text/javascript"></script>

<script type='text/javascript'>

function d(){

	 	var dr=document.getElementById('daterange').innerHTML;
    	if(dr!="Select Date Range")
    		{
    	var drv=dr.split('-');
    	var sdate = new Date(drv[0]);
    	var std = sdate.toString("yyyy-MM-dd");
    	var edate = new Date(drv[1]);
    	var end = edate.toString("yyyy-MM-dd");
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
	 document.getElementById('daterange').innerHTML=localStorage.getItem("daterange"); 
	 document.getElementById('std').value=localStorage.getItem("std"); 
	 document.getElementById('end').value=localStorage.getItem("end"); 
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
	     	localStorage.setItem("daterange", "Select Date Range"); 
	  /*   	localStorage.setItem("sd", ""); */
	  /*   	localStorage.setItem("dc", ""); */
/* 	document.getElementById('branch').value=localStorage.getItem("branch"); */
});
</script> 
  </body>
</html>