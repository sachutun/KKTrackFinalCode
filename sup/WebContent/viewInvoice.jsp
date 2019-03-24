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
                <h1>View Invoice <!-- <small>Some examples to get you started</small> --></h1>
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
                     
       <br/>  <%
       String branch = request.getParameter("branch");
       String memodc = request.getParameter("memodc");
       String memodate = request.getParameter("memodate");
       String memopk = request.getParameter("memopk");
       String dc=request.getParameter("dc");
       String callingPage=request.getParameter("callingPage");
// System.out.println(callingPage); 
String cn=request.getParameter("sd");
String pk=request.getParameter("pk");%>            
 <div style=" float:right; margin-right: 10px; margin-top:-20px">

<%if(callingPage.equals("editsalindividual.jsp")) 
{%>
                  <a href="viewsale.jsp" style="color:white;">  <button type="button" class="btn btn-info">View Sale</button></a>
			
                 <a href="editsalindividual.jsp?dc=<%=memodc %>&sd=<%=memodate %>&branch=<%=branch %>&pk=<%=memopk %>" style="color:white;">   <button type="button" class="btn btn-warning">Go Back to Memo</button></a>
 <%}if(callingPage.equals("ViewCollections.jsp")){  %>         
             <a href="ViewCollections.jsp" style="color:white;">  <button type="button" class= "btn btn-info">View Collections</button></a>
   <%} %>        
             </div>   
 

          <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  
<%--                   <%  String branch = request.getParameter("branch"); %> --%>
                 
                    <div class="clearfix"></div>
                  
                  <div class="x_content">
                 
        <form >   
        
             <%--    <input type="hidden" id="sno" name="sno" value=<%=sno%> > --%>
                         <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>>
                  <input id="uenv" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=environment %>>
              <div class="table-responsive"> 
       <table class="table  dt-responsive" width="100%">
               
                        <tbody>
                        <%
try{ 
 
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

if(branch!=null && dc!=null && cn!=null)
{
resultSet = st.executeQuery(sql1);

while(resultSet.next()){
	String sql2="SELECT BillDetails.Code,BillDetails.Id, CodeList.Description, CodeList.Machine, CodeList.PartNo,  CodeList.Grp,CodeList.MinPrice, CodeList.MaxPrice, BillDetails.CostPrice, BillDetails.Qty, BillDetails.Total, BillDetails.Notes FROM BillDetails inner join CodeList on BillDetails.Code=CodeList.Code where DC=";
	int	primaryKey = resultSet.getInt("Id");
	String whr2=primaryKey+"";
	sql2+=whr2;
	String type=resultSet.getString("Type");
	   st2 = conn.createStatement();
	   st3 = conn.createStatement();
	rs = st2.executeQuery(sql2);
	Date date=resultSet.getDate("Date");
	  String gst = resultSet.getString("GST");
	  
	
%>
                                        <tr class="odd gradeX">


<td><strong> Branch: </strong><br/> <%=resultSet.getString("Branch") %></td>
<td><strong> Date: </strong><br/><%=new SimpleDateFormat("dd-MM-yyyy").format(date) %></td>

<td><strong> DCNumber: </strong><br/><%=resultSet.getString("DCNumber") %></td>
<%String custId="";
String discount=resultSet.getString("Discount");
if(discount==null)
	discount="";
if(resultSet.getString("CustID")!=null && resultSet.getString("CustID")!="")
{
	custId=resultSet.getString("CustID");
	%>
	<td width="10%"><strong> Credit CustId: </strong><br/><%=custId %></td>
	<% 
}
%>
<td><strong> Customer Name: </strong><br/><%=resultSet.getString("CustomerName") %></td>
<td><strong> Customer No: </strong><br/><%=resultSet.getString("CustomerNumber") %></td>
<td><strong> TotalPrice: </strong><br/> <%=resultSet.getDouble("TotalPrice") %></td>
<td><strong> Amount Paid: </strong><br/><%=resultSet.getString("AmountPaid") %></td>
<td><strong> Tax Amount: </strong><br/><%=resultSet.getString("Tax") %></td>
<td><strong> Discount: </strong><br/><%=discount %></td></tr>

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
                                           
             
                                        </tr>
                      </thead>
                        <tbody >
                          <tr class="odd gradeX">
                          <% 
                                       
                          while(rs.next())
						{
                        	 
                        	  List<String> list = new ArrayList<String>();
                        	  float bqty=rs.getFloat("BillDetails.Qty") ;
                        	   i=rs.getInt("BillDetails.Id") ;
                        	  // System.out.println(i);
                        	   
	%>

<td><%=sno%></td>
<td><%=rs.getString("BillDetails.Code") %></td>
<td><%=rs.getString("CodeList.Description") %></td>
<td><%=rs.getString("CodeList.Machine") %></td>
<td><%=rs.getString("CodeList.PartNo") %></td>
<td><%=rs.getString("CodeList.Grp") %></td>
<td><%=rs.getString("BillDetails.CostPrice")%> </td>
<td><%=bqty%>   
 
    
</tr>
 <%
 
} 
                        
 %>

</tbody> 
</table>
 
<%String comments=resultSet.getString("Comments");
if(comments==null) 
	comments=""; 
if(gst==null)
 gst="";%>
<label for="com" style="float:left;"><strong> Comments: </strong></label> &nbsp; &nbsp;&nbsp; <%=comments %>    

 <br/> 
 <br/> 
<div class="form-group " >
                       		
<label for="gst" style="float:left;"><strong> GST No: </strong></label> &nbsp; &nbsp;&nbsp; <%=gst %> 

<br/>
<br/>

                         <div class="form-group creditDet" style="display:none;">               		
  <label for="creditCustId" style="float:left;"><strong> Credit Customer ID: </strong></label><input class="col-md-4" type="text" id="creditCustId" name="creditCustId" style="margin-left:10px;" onfocusout="showCustomer(this.value)">                       		

  </div>                      
<br/>
 <p id="creditMsg"></p> 
 <input id="CrediCustStatus" class="form-control col-md-7 col-xs-12" type="hidden" name="CrediCustStatus" >
 

                         </div>
                          
         
                      
<br/> 


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
</script>
 <script type="text/javascript">

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

 
$(document).ready(function() {
	
	 $.getScript("js/rolePermissions.js");
	var ubran=document.getElementById('ubran').value;
	var role=document.getElementById('urole').value;
	
	
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
} ); 
  $("#FormId").submit( function(e) {
	  loadAjax();
	  e.returnValue = false;
	  return false;
	});  

</script>



  </body>
</html>