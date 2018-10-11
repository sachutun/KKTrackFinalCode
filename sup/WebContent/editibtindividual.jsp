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
Statement statement = null;
Statement st = null;
Statement st2 = null;
Statement st3 = null;
DataSource ds = null;
Connection conn = null;
ResultSet resultSet = null;
ResultSet rs = null;
ResultSet rs2 = null;

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

    <title>KK Track- IBT</title>

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
                <h1>IBT Edit <!-- <small>Some examples to get you started</small> --></h1>
              </div>
               <div style="overflow: auto">
             <div class="row">

            <div class="clearfix"></div>
          
                      </div>
                    </div> 
                    
                     </div>
                                 <div style=" float:right; margin-right: 10px;">

              <a href="ibtform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="viewIBT.jsp"> <button type="button" class="btn btn-info">View </button></a>
                   <a href="editIBT.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Edit</button></a>
             </div>   
       <br/>              
 
     <% String r=request.getParameter("res");
 String succ="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>IBT updated successfully.</strong></div></div>";
 String succ2="<div class=\"col-md-12\" style= margin-left:280px\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>IBT deleted successfully.</strong></div></div>";
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
                  
                  <%  String branch = request.getParameter("fbranch"); %>
                 
                    <div class="clearfix"></div>
                  
                  <div class="x_content">
        <form action="ibtedit.jsp">   
        <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
        
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
   
    //Class.forName("com.mysql.jdbc.Driver").newInstance();  
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

    conn = DriverManager.getConnection(url, username, password);
     statement=conn.createStatement();
    st = conn.createStatement();
String sql1 ="SELECT DISTINCT * FROM IBT";
String wher=" where";

	wher+=" FromBranch='"+branch+"'";

	wher+=" and IBTNo='"+dc+"'";

	if(cn!=null && cn.length()!=0)
	{
	wher+=" and Date='"+cn+"'";
	}
	else
		wher+=" and Date='"+cn+"'";

sql1+=wher;

if(branch!=null && dc!=null && cn!=null)
{
resultSet = statement.executeQuery(sql1);
int sno=1;
while(resultSet.next()){
	
	String sql2="SELECT IBTDetails.Code, CodeList.HSNCode, CodeList.Description, CodeList.Machine, CodeList.PartNo, CodeList.Grp, CodeList.MinPrice, IBTDetails.Qty, IBTDetails.Id FROM IBTDetails inner join CodeList on IBTDetails.Code=CodeList.Code where IBTDetails.IBT=";
	int	primaryKey = resultSet.getInt("Id");
	String whr=primaryKey+"";
	sql2+=whr;
	int sno2=1;
	rs = st.executeQuery(sql2);
	Date date=resultSet.getDate("Date");

%>
 <tr class="odd gradeX">

<%-- <td><%=sno%></td>      --%>                                     
<td width="3%"><strong> IBT Number: </strong><input class="" type="text" id="ibtno" name="ibtno" value=<%=resultSet.getString("IBTNo") %> readonly="readonly" style="border:none"></td>
<td width="2%"><strong> Date: </strong><input class="" type="text" id="date" name="date" value=<%=new SimpleDateFormat("dd-MM-yyyy").format(date) %> ></td>
<td width="3%"><strong> From Branch: </strong><input class="" type="text" id="fbranch" name="fbranch" value=<%=resultSet.getString("FromBranch") %> readonly="readonly" style="border:none"></td>
<td width="3%"><strong> To Branch: </strong><input class="" type="text" id="tbranch" name="tbranch" value=<%=resultSet.getString("ToBranch") %> readonly="readonly" style="border:none"></td>
<td width="3%"><strong> Total Qty: </strong><%=resultSet.getInt("TotalQty") %></td>

</tr></tbody></table>
<table id="" class="table table-striped table-bordered dt-responsive">
                      <thead>
                        <tr>
                            <tr>
                                            <th>Sno</th>
                                            <th>Code</th>
                                            <th>HSNCode</th>
                                            <th>Description</th>
                                            <th>Machine</th>
                                            <th>Part No</th>
                                            <th>Group</th>
                                            <th>IBT Price</th>
                                            <th>Quantity</th>
										   <!-- 	<th>Delete Item</th> -->
											<th>
                                            <input type=checkbox name='selectAllCheck' onClick='funcSelectAll()' value='Select All'></input>
                                            Delete All
                                          </th>
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
                        	  i=rs.getInt("IBTDetails.Id") ;
                        	  //System.out.println(i);
	%>
<td><%=sno2++%></td> 
<td><%=rs.getString("IBTDetails.Code") %></td>
<td><%=rs.getString("CodeList.HSNCode") %></td>
<td width="80%"><%=rs.getString("Description") %></td>
<td width="80%"><%=rs.getString("Machine") %> </td>
<td width="80%"><%=rs.getString("PartNo") %></td>
<td><%=rs.getString("Grp") %></td>
<td><%=rs.getDouble("MinPrice") %></td> 
<td><input class="col-md-12" type="text" id="nq<%=i %>" name="nq<%=i %>" value=<%=rs.getInt("IBTDetails.Qty") %> >
<input type="hidden" id="i" name="i">  
 <input type="hidden" id="code<%=i %>" name="code<%=i %>" value=<%=rs.getString("IBTDetails.Code")%> >
 <input type="hidden" id="q<%=i %>" name="q<%=i %>" value=<%=rs.getString("IBTDetails.Qty")%> >
  <input type="hidden" id="payid" name="payid" value=<%=primaryKey %> > 
    <input type="hidden" id="branch" name="branch" value=<%=branch %> > 
  <input type="hidden" id="sd" name="sd" value=<%=cn %> > 
     <input type="hidden" id="dc" name="dc" value=<%=dc %> > 
  
</td>
<%-- 
<td style="width: 10%;"><a href="delibt.jsp?deleteid=<%=primaryKey %>&fbranch=<%=branch %>&tbranch=<%=resultSet.getString("ToBranch") %>&ibt=<%=resultSet.getString("IBTNo") %>&bid<%=i %>=<%=i %>&sd=<%=cn%>&code<%=i %>=<%=rs.getString("IBTDetails.Code")%>&q<%=i %>=<%=rs.getString("IBTDetails.Qty")%>&i=<%=i %>" class="btn btn-danger btn-xs"><i class="fa fa-trash-o"></i></a> </td> 
--%>
  <td>  <input type="checkbox" name="checkboxRow" value="<%=i %>">   </td> 
</tr>
 <%
 list.add(String.valueOf(primaryKey));
 list.add(branch);
 list.add(resultSet.getString("ToBranch"));
 list.add(resultSet.getString("IBTNo"));
 list.add(String.valueOf(i));
 list.add(cn);
 list.add(rs.getString("IBTDetails.Code"));
 list.add(rs.getString("IBTDetails.Qty"));
 list.add(String.valueOf(i));
 map.put(i, list);
 sno++;
} 
                          //System.out.println("Fetching Keys and corresponding [Multiple] Values n");
                          for (Map.Entry<Integer, List<String>> entry : map.entrySet()) {
                              int key = entry.getKey();
                              List<String> values = entry.getValue();
                             // String bv=values.get(9);
                              //System.out.println("Key = " + key);
                              //System.out.println("Values = " + values + "n");
                              
                              //System.out.println("bv = " + bv);
                          }
                          session.setAttribute("map", map);
 %>
</tbody> 
</table>
 <input type="hidden" id="mapValues" name="<%=map%>">  
 <button id="deleteButton" onclick="deleteCheckedRecords()" type="button" style="float:right" class="btn btn-danger btn-sm" data-toggle="modal" data-target=".bs-example-modal-sm"><i class="fa fa-trash-o"></i>Delete</button>
 
<button type="submit" class="btn btn-success" style="float:right" onclick="chsn(<%=i%>)">Edit</button>
 <a href="addibtedit.jsp?pid=<%=primaryKey%>&fbranch=<%=branch %>&tbranch=<%=resultSet.getString("ToBranch") %>&ibt=<%=resultSet.getString("IBTNo") %>&bid<%=i %>=<%=i %>&sd=<%=cn%>"><button type="button" class="btn btn-success" style="float:right">Add More Items</button></a> 
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
function funcSelectAll()
{
   if(document.forms[0].selectAllCheck.checked==true)
   {
            for (var a=0; a < document.forms[0].checkboxRow.length; a++)        {
                 document.forms[0].checkboxRow[a].checked = true;            
           }
     }
     else
     {
           for (var a=0; a < document.forms[0].checkboxRow.length; a++)        {
                  document.forms[0].checkboxRow[a].checked = false;           
           }
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
	//alert("hi");
	//var did=document.getElementById("did").value;
	var pk=document.getElementById("payid").value;
	//alert(pk);
	var branch=document.getElementById("branch").value;
	//alert(branch);
	var dc=document.getElementById("dc").value;
	//alert(dc);
	var cn=document.getElementById("sd").value;
	//alert(did);

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

	if(selectedItems=="" || selectedItems==null)
		{
		//alert("if");
		 return;
		}
	else
		{
		//alert("else");
		
		
	document.getElementById('did').href=('BulkDeleteIBT.jsp?selectedItems='+selectedItems+'&deleteid='+pk+'&fbranch='+branch+'&dc='+dc+'&sd='+cn);
	}
}
function chsn(i)
{
	document.getElementById("i").value=i;
}
 $(document).ready(function() {
		var ubran=document.getElementById('ubran').value;
		var role=document.getElementById('urole').value;
		if(role!=null && role!="1")
		{
			var elements = document.getElementsByClassName('admin');

	    		for (var i = 0; i < elements.length; i++){
	        		elements[i].style.display = "none";
	    		}
		
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