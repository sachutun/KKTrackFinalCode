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

  <% int count=1; %>
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
url += "?count=" +str+"&branch="+document.getElementById("fb").value;
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
 }   
 }
  
 </script>  
 <body  class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="viewinventory.jsp" class="site_title"><i class="fa fa-line-chart"></i> <span>KK Track</span></a>
            </div>

            <div class="clearfix"></div>


            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
               <div class="menu_section">
              
                     <ul class="nav side-menu">
                  <li><a><i class="fa fa-home"></i> Home </a>
                    
                  </li>
                  <li class="hide4store"><a><i class="fa fa-inr"></i> Expenses <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                         <li class="hide4acc&store" ><a href="expenseform.jsp">Add New Expense</a></li>
                      <li class="hide4store"><a href="expenses.jsp">View Expenses</a></li>
                      <li class="hide4store"><a href="PurchaseCost.jsp">View Purchase Costs</a></li>
                       <li class="hide4store"><a href=CashTransfer.jsp>View Cash Transfers</a></li>
                    </ul>
                  </li>
                 <li class="hide4acc&store"><a><i class="fa fa-shopping-cart"></i> Purchase <span class="fa fa-chevron-down"></span></a>
                  <ul class="nav child_menu">
                      <li class="admin"><a href="addpurchase.jsp">Add New Purchase</a></li>
                      <li  class="hide4store"><a href="viewpurchase.jsp">View Purchase</a></li>
                      <li  class="hide4store"><a href="creditpurchase.jsp">Credit Purchase</a></li>
                      <li  class="hide4store"><a href="printpurchase.jsp">Print Purchase</a></li>
                      <li  class="admin"><a href="printpurchaseRecord.jsp">Print Purchase Admin</a></li>
                      <li class="hide4store"><a>Purchase Returns</a>
                      <ul class="nav child_menu">
                      <li class="hide4store"><a href="viewpurchasereturn.jsp">View Returned Purchase items</a></li>
                      <li class="admin"><a href="purchasereturn.jsp">Enter Returned Purchase items</a></li>
                    </ul>
                      </li>
                    </ul>
                  </li>
                  <li class="hide4store"><a><i class="fa fa-table"></i> Sales <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li class="hide4acc&store"><a href="addsale.jsp">Add New Sale</a></li>
                      <li  class="hide4store"><a href="viewsale.jsp">View Sale</a></li>
                      <li class="hide4acc&store"><a href="creditsale.jsp">Credit Sale</a></li>
                      <li class="hide4acc&store"><a href="creditalert.jsp">Credit Alert</a></li>
                      <li class="hide4acc&store"><a href="printsale.jsp">Print Sale</a></li>
                      <li class="hide4acc&store"><a>Sale Returns <span class="fa fa-chevron-down"></span></a>
                      <ul class="nav child_menu">
                      <li><a href="viewsalereturn.jsp">View Returned Sale items</a></li>
                      <li><a href="saleReturn.jsp">Enter Returned Sale items</a></li>
                    </ul>
                      </li>
                    </ul>
                  </li>
                  <li><a><i class="fa fa-bar-chart-o"></i> Inventory <span class="fa fa-chevron-down"></span></a>
                   <ul class="nav child_menu">
                   <li ><a href="viewinventory.jsp">View Stock</a></li>
                   <li class="hide4branch"><a href="viewinvbal.jsp">View Overall Stock</a></li>
                   <li ><a href="CodeList.jsp">View Code List</a></li>
                   <li class="hide4acc" ><a href="inventoryAdjustment.jsp">Inventory Adjustment</a></li>
                      <li class="admin"><a href="AddCode.jsp">Add New Code</a></li>
                      </ul>
                  </li>
                  <li><a><i class="fa fa-truck"></i> Branch Transfer <span class="fa fa-chevron-down"></span></a>
                     <ul class="nav child_menu">
                      <li class="hide4acc"><a href="ibtform.jsp">IBT Form</a></li>
                      <li><a href="viewIBT.jsp">View IBT</a></li>
                      <li class="hide4acc"><a href="printingibt.jsp">Print IBT</a></li>
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
                <h1>IBT <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>

            <div style=" float:right; margin-right: 10px;">

                   <a href="ibtform.jsp"><button type="button" class="btn btn-success">Add </button></a>

                   <a href="viewIBT.jsp"> <button type="button" class="btn btn-info">View </button></a>
                   <a href="editIBT.jsp" style="color:white;">   <button type="button" class="btn btn-warning">Edit</button></a>
             </div> 
             <br/><br/><br/> 
              <%
             String pid=request.getParameter("pid");
             String dc=request.getParameter("ibt");
             String fbranch=request.getParameter("fbranch");
             String tbranch=request.getParameter("tbranch");
             String sd=request.getParameter("sd");
             %>
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
                    <form id="demo-form2" data-parsley-validate class="form-horizontal form-label-left" action="ibtaddedit.jsp" method="post">
                    <div id="main">
                      <div class="form-group">
                      <input type="hidden" name="fbranch" id="fb" value=<%=fbranch %>>
                      <input type="hidden" name="tbranch" value=<%=tbranch %>>
                      <input type="hidden" name="pid" value=<%=pid %>>
                      <input type="hidden" name="sd" value=<%=sd %>>
                    <input type="hidden" name="ibt" value=<%=dc %>>
                      <!-- </div>
                       <div class="form-group"> -->
                       
                      <button class="add " type="button" style="background: #26B99A;color: white;border: 1px solid #169F85;width: 10%;line-height: 2;margin-left: 15%;">Add Item</button>
                     
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
                         <!--  <label class="control-label col-md-1 col-sm-1 col-xs-2" >Sale Price:<span class="required">*</span>
                        </label>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                          <input id="costprice1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="costprice">
                        </div> -->
                 <!--      </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" >Quantity:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="qty1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="qty"  min=0 onblur="calculate(1)">
                        </div>
                        <!-- <label class="control-label col-md-1 col-sm-1 col-xs-2">Total:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="totalprice1" class="form-control col-md-7 col-xs-12"  type="text" name="totalprice" readonly="readonly" onchange="tot(1)">
                        </div> -->
                        
                      </div>
                    
                      
                      <div class="form-group" style="margin-top:2%; margin-bottom:2%; margin-left:-3%">
                      
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="mac"> Mac:</label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input type="text" id="mac1" class="form-control col-md-7 col-xs-12" name="mac" disabled>
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
                      
                        <div style="margin-top:20%">
                      <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-3">Total No.of Items:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input id="totalq" class="form-control col-md-7 col-xs-12"  type="text" name="totalq" readonly="readonly">
                        </div>
                     
                      </div></div>
                     <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
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

  var itemc=document.getElementById("numb").value;
  var tot=0;
  
	  for(var x=1;x<=itemc;x++)
	  {
		  if(document.getElementById("id"+x)!=null)
	  tot+=parseInt(document.getElementById("qty"+x).value);
	 
	  }
   /*  var result2 = parseInt(txtSNumberValue) + parseInt(txtS2NumberValue); */
   var result2=tot;
    if (!isNaN(result2)) {
        document.getElementById('totalq').value = result2;
    }
}

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
				var elements1 = document.getElementsByClassName('hide4acc');

				for (var j = 0; j < elements1.length; j++){
		    			elements1[j].style.display = "none";
			    }
			    
				document.getElementById("br").style.display="block";
			}
	var c=1;
$('.add').click(function() {
	 c++; 
	 
   var s1="<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value,"+c+")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty"+c+"\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onblur=\"calculate("+c+")\"> </div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac"+c+"\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div></div></div></div></div>";
   $('.codedetails:last').after(s1); 
/*  $('#main').after(s1); */
 var h= $('.right_col').height()+200;
 $('.right_col').animate({height:h}, 500);
});

 }); 
</script>
  </body>
</html>