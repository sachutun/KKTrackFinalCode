<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %>
<%@ page import= "java.util.*" %>

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
url += "?count=" +str+"&branch="+document.getElementById("fb").value;
xmlHttp.onreadystatechange = stateChange;
xmlHttp.open("GET", url, true);
xmlHttp.send(null);
}
 function stateChange(){   
 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
	 var data=xmlHttp.responseText;
	 var dv=data.split(",");
	// alert(document.getElementById("numb").value);
	 var i=document.getElementById("numb").value;
	 document.getElementById("mac"+i).value=dv[0];
	 document.getElementById("description"+i).value=dv[1];
	 document.getElementById("partno"+i).value=dv[2];
	/*  document.getElementById("minprice"+i).value=dv[3]; */
	/*  document.getElementById("mp"+i).value=dv[4]; */
	 document.getElementById("grp"+i).value=dv[5];
	 document.getElementById("qty"+i).max=dv[7]; 
	document.getElementById("existQty" +i).innerHTML=dv[7];
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
                           <label class="control-label col-md-1 col-sm-1 col-xs-2" style="width:125px;">General IBT:</label>
                        		<div class="col-md-2 col-sm-2 col-xs-3" style="margin-top: 0.7%;">
                          		<input type="radio" onclick="javascript:ibtCheck();" name="IBTtype" id="generalIBT" value="general" checked="checked">
                        		</div>
                        
                       		 <label class="control-label col-md-2 col-sm-2 col-xs-3" style="width:100px;">Tax IBT:</label>
                       		 <div class="col-md-3 col-sm-3 col-xs-3" style="margin-top: 0.7%;">
                        			<input type="radio" onclick="javascript:ibtCheck();" name="IBTtype" id="taxIBT" value="tax">
                       		 </div> 
                   <br>
                   <br>
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
                        
                         <label class="taxElements control-label col-md-1 col-sm-1 col-xs-2" style="display:none;">IBT Price:<span class="required">*</span>
                        </label>
                        <div class="taxElements col-md-2 col-sm-2 col-xs-4" style="display:none;">
                          <input id="saleprice1" class="salepr form-control col-md-7 col-xs-12" type="number" name="saleprice" onblur="calculateTotalPrice(1)">
                        </div> 
                        
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" >Quantity:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-2">
                          <input id="qty1" class="form-control col-md-7 col-xs-12" required="required" type="number" name="qty"  min=0 onblur="calculate(1)">
                          <p id="existQty1"></p> 
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
                        
                         <label class="taxElements control-label col-md-2 col-sm-2 col-xs-3" style="display:none;">Tax:</label>
                        <div class="taxElements col-md-2 col-sm-2 col-xs-3" style="display:none;">
                          <input id="tax" class="form-control col-md-7 col-xs-12"  type="text" name="tax"  min="0" readonly="readonly">
<!--                           <p id="taxmsg"></p>  -->
                        </div>
                         
                         <label class="taxElements control-label col-md-2 col-sm-2 col-xs-3" style="display:none;">Total Price:</label>
                        <div class="taxElements col-md-2 col-sm-2 col-xs-3" style="display:none;">
                          <input id="totalprice" class="form-control col-md-7 col-xs-12"  type="text" name="totalprice" readonly="readonly">
                        </div>
                     
                      </div></div>
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
		if(document.getElementById("id"+x)!=null)
		{
	  		var qty=parseInt(document.getElementById("qty"+x).value);	 
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
//  alert(document.getElementById("numb").value);
  var totPrice=0;
	  for(var x=1;x<=itemc;x++)
	  {
		  
		  if(document.getElementById("id"+x)!=null)
		  {
			  var salePrice=parseFloat(document.getElementById("saleprice"+x).value);
			 // alert(salePrice);
			  var qty=parseFloat(document.getElementById("qty"+x).value);
			//  alert(qty);
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
			
	if (role != null && role == "2") {
		 $( '[class*="branch"]' ).hide();
							if (ubran != null && ubran == "Workshop")
								document.getElementById("invAdj").style.display = "block";
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

						if (role != null && role == "4") {
							 $( '[class*="store"]' ).hide();

						}
						if (role != null && role == "5") {
							 $( '[class*="acc"]' ).hide();

							document.getElementById("br").style.display = "block";
						} */
						var c = 1;
						$('.add')
								.click(
										function() {
											c++;

											var s1 = "<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value,"
													+ c
													+ ")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"taxElements control-label col-md-1 col-sm-1 col-xs-2\" style=\"display:none;\">IBT Price:<span class=\"required\">*</span></label><div class=\"taxElements col-md-2 col-sm-2 col-xs-4\" style=\"display:none;\"><input id=\"saleprice"+c+"\" class=\"salepr form-control col-md-7 col-xs-12\" type=\"number\" name=\"saleprice\" onblur=\"calculateTotalPrice("+c+")\"></div> <label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty"
													+ c
													+ "\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onblur=\"calculate("
													+ c
													+ ")\"> <p id=\"existQty"+c+"\"></p> </div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac"+c+"\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div></div></div></div></div>";
											$('.codedetails:last').after(s1);
											/*  $('#main').after(s1); */
											var h = $('.right_col').height() + 200;
											$('.right_col').animate({
												height : h
											}, 500);
											 ibtCheck();
										});

					});
	$(window).load(function() {
		$(".se-pre-con").fadeOut("slow");
	});
</script>
  </body>
</html>