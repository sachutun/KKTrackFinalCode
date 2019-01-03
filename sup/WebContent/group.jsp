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
<%-- 
<%
/* String id = request.getParameter("userId"); */
String driverName = "com.mysql.jdbc.Driver";


try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%> --%>
  
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" type="image/png" href="images/log.png"> 
	  
    <title>KK Track- Adjustment</title>

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
              <script language="javascript">var p = false;
              </script>
 <script language="javascript" type="text/javascript">  
 var xmlHttp
 var xmlHttp1
 var xmlHttp2
 
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
var url="value2.jsp";
url += "?count=" +str+"&branch="+document.getElementById("branch").value;
	
xmlHttp.onreadystatechange = stateChange;
xmlHttp.open("GET", url, true);
xmlHttp.send(null);
}

 function stateChange(){   
	 if (xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){   
		 var data=xmlHttp.responseText;
		 var dv=data.split(",");
	
			 {
			 var i=document.getElementById("numb").value;
			 document.getElementById("mac"+i).value=dv[0];
			 document.getElementById("description"+i).value=dv[1];
			 document.getElementById("partno"+i).value=dv[2];
			
			 document.getElementById("grp"+i).value=dv[5];
			  document.getElementById("qmax").value=dv[7];
			 document.getElementById("qty"+i).max=dv[7]; 
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
                <h1>Grouping <!-- <small>Some examples to get you started</small> --></h1>
              </div>

          

            <div class="clearfix"></div>

             <br/>
        
                <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Group Items</h2>
               
                    <div class="clearfix"></div>
                  </div>
                  <div >
                    <br />
                  <form id="demo-form2" data-parsley-validate="" class="form-horizontal form-label-left" action="grouping.jsp" method="post" novalidate="" onsubmit="return(p)">
                    <div id="main">
                      <div class="form-group">
                        <label class="control-label col-md-1 col-sm-1 col-xs-2">Branch:<span class="required">*</span></label>
                        <%
							ResourceBundle resources =ResourceBundle.getBundle("branches");
							Enumeration resourceKeys = resources.getKeys();
							ArrayList<String> listOfBranches = new ArrayList<String>();
						%>
                        <div class="col-md-3 col-sm-3 col-xs-10">
                          <select class="select2_single form-control admin" tabindex="-1" id="branch" name="branch" required="required">
                            <option></option>
                          
                            
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
                        
                         <input id="ubran" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=uBranch %>> 
                  <input id="urole" class="form-control col-md-7 col-xs-12" type="hidden" value=<%=role %>> 
                      <!-- </div>
                       <div class="form-group"> -->
                
                      <button class="add col-md-1 col-xs-3" type="button" style="background: #26B99A;color: white;border: 1px solid #169F85; line-height: 2;">Add Item</button>
                     
                      <label class="control-label col-md-2 col-sm-1 col-xs-2" for="newcode">Grouped Code:</label>
                        <div class="col-md-2 col-sm-2 col-xs-3">
                          <input type="number" id="newcode"  class="form-control col-md-7 col-xs-12" name="newcode" >
                   
                      </div>
                     
                      </div>
                      
                      <div class="codedetails" id="id1">
                      <ul class="nav navbar-right panel_toolbox">
                      <li style="float: right;"><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
                    
                    </ul>
                      <div class="x_content" style="padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);">
                      <a style="float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer" class="cls" onclick="cls(this);"><i class="fa fa-close"></i></a>
                      <div class="form-group" style="margin-left:-5%"> 
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="code"> Code:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-4">
                          <input type="number" id="code"  style="padding:0" class="form-control col-md-7 col-xs-12" name="code" onchange="showState(this.value,1)">
                        </div>
                        <label class="control-label col-md-1 col-sm-1 col-xs-8">Description:</label>
                        <div class="col-md-2 col-sm-2 col-xs-6">
                          <input id="description1" class="form-control col-md-7 col-xs-12" type="text" name="description" disabled="" style="padding: 0;">
                        </div>
                       
                 <!--      </div>
                      <div class="form-group"> -->
                     
                
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" for="mac" style="margin-left: -4%;"> Mac:</label>
                        <div class="col-md-1 col-sm-1 col-xs-3">
                          <input type="text" id="mac1"  class="form-control col-md-7 col-xs-12" name="mac" disabled="" style="padding: 0;">
                        </div>
                     <!--  </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" style="margin-left: -3%;">PartNo:</label>
                        <div class="col-md-2 col-sm-2 col-xs-5">
                          <input id="partno1" class="form-control col-md-7 col-xs-12" type="text" name="partno" disabled="" style="padding: 0;">
                        </div>
                   <!--    </div>
                      <div class="form-group"> -->
                        <label class="control-label col-md-1 col-sm-1 col-xs-2" style="margin-left: -3%;">Group:</label>
                        <div class="col-md-2 col-sm-2 col-xs-4">
                          <input id="grp1" class="form-control col-md-7 col-xs-12" type="text" name="grp" disabled="" style="padding: 0;">
                        </div>
                 
                    </div>
                      <div class="form-group" style="margin-left: -5%;"> 
                 
                    <input id="qmax" class="form-control col-md-7 col-xs-12" type="hidden" name="qmax" value="0">
                        <label class="control-label col-md-1 col-sm-1 col-xs-9">Quantity:<span class="required">*</span>
                        </label>
                        <div class="col-md-1 col-sm-1 col-xs-4">
                          <input id="qty1" class="form-control col-md-7 col-xs-12" style="padding:0" required="required" type="number" name="qty" onchange="calculate(1)" >
                        </div>
                      </div>
                     </div></div></div>
                      
                 
                    
                    <br/>
                     
                        <br/>
                          
                    
                      
                        <br/>
                 
                            <input id="numb" class="form-control col-md-7 col-xs-12" type="hidden" name="numb" value="1">
                      <div class="ln_solid"></div>
                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-4">
                         <button class="btn btn-primary" onClick = "ref()">Reset</button>
  
                         <button type="submit" name="myButton" class="btn btn-success" onClick = "javascript: p=true;" >Group</button> 
                         

  

                          </div>
 
                 </div>

             </form>
           </div>
         </div>
       </div>
     </div>
     <br> 
     <% String r=request.getParameter("res");
  
 String succ="<div class=\"col-md-6\" style= \" margin-top:-71%\"><div class=\"alert alert-success alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Grouped successfully.</strong></div>";
 String err="<div class=\"col-md-6\" style= \" margin-top:-71%\"><div class=\"alert alert-error alert-dismissible fade in\" role=\"alert\"><button type=\"button\" class=\"close\" onclick=\"ref()\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">×</span></button><strong>Please try again  </strong></div>";
 
 if(r!=null && r.equals("1"))
        	out.println(succ);
  else if(r!=null && r.equals("2"))
 	System.out.println(err);	%>
        	

       
        <!-- /page content -->
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
 function dch1() 
 { 
  var d=document.getElementById("single_cal4").value.toString();
 var dv=d.split("/");
 var cd=dv[2]+'-'+dv[0]+'-'+dv[1];
  document.getElementById('cd').value=cd;
 } 
 function ref()
 {
	 window.location.href="group.jsp";
 }

 function cls(elt)
 {
 	
     // Traverse up until root hit or DIV with ID found
 	while (elt && (elt.tagName != "DIV" || !elt.id))
 	    elt = elt.parentNode;
 	if (elt) // Check we found a DIV with an ID
 	  /*   alert(elt.id);  */
 	var r=elt.id;
 	 $('#'+r).remove(); 
 	
 	/* document.getElementById(); */
 	 var h= $('.right_col').height()-200;
 	 $('.right_col').animate({height:h}, 500);
 } 

 $(document).ready(function() {
	 	
	 $(window).keydown(function(event){
		    if(event.keyCode == 13) {
		      event.preventDefault();
		      return false;
		    }
		  });
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
		/* if(role!=null && role=="3")
		{
		var elements = document.getElementsByClassName('userv');

	    for (var i = 0; i < elements.length; i++){
	        elements[i].style.display = "none";
	    }
		
		}	 */
		
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
	
	    
	 var h= $('.right_col').height()+150;
	 $('.right_col').animate({height:h}, 500);
	 
	var c=1;
	
$('.add').click(function() {
	 c++; 
	// alert(c);
   var s1="<div class=\"codedetails\" id=id"+c+"><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"> <a style=\"float:right; margin-right:-4%; margin-top:-1%;color: rgba(169, 68, 66, 0.6);font-size: large; cursor:pointer\" class=\"cls\" onclick=\"cls(this);\"><i class=\"fa fa-close\"></i></a><div class=\"form-group\" style=\"margin-left:-5%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-4\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" style=\"padding: 0;\" name=\"code\" onchange=\"showState(this.value,"+c+")\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-8\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-7\"><input id=\"description"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\" style=\"margin-left:-4%\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-3\"><input type=\"text\" id=\"mac"+c+"\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\" style=\"margin-left:-3%\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-5\"><input id=\"partno"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\" style=\"margin-left:-3%\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-4\"><input id=\"grp"+c+"\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div></div><div class=\"form-group\" style=\"margin-left: -5%;\"> <label class=\"control-label col-md-1 col-sm-1 col-xs-9\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-4\"><input id=\"qty"+c+"\" class=\"form-control col-md-7 col-xs-12\" style=\"padding: 0;\" required=\"required\" type=\"number\" name=\"qty\" onchange=\"calculate("+c+")\"> </div></div></div></div></div></div>";
    $('.codedetails:last').after(s1); 
/*  $('#main').after(s1); */
 var h= $('.right_col').height()+200;
 $('.right_col').animate({height:h}, 500);
});


/* if(role!=null && role=="3")
{
var elements = document.getElementsByClassName('userv');

for (var i = 0; i < elements.length; i++){
    elements[i].style.display = "none";
}
} */

 }); 
 $(window).load(function () {
		$(".se-pre-con").fadeOut("slow");
	});
 $(function() {
	    $("#branch").change(function() {
	       $('select[name=type]').val("");
	       document.getElementById("creditMsg").innerHTML = "";
	    });
	});
 

</script>
<!-- <script>
    // Run on page load
    window.onload = function() {

        // If sessionStorage is storing default values (ex. name), exit the function and do not restore data
        if (sessionStorage.getItem('name') == "name") {
            return;
        }

        // If values are not blank, restore them to the fields
        var name = sessionStorage.getItem('name');
        if (name !== null) $('#inputName').val(name);

        var email = sessionStorage.getItem('email');
        if (email !== null) $('#inputEmail').val(email);

        var subject= sessionStorage.getItem('subject');
        if (subject!== null) $('#inputSubject').val(subject);

        var message= sessionStorage.getItem('message');
        if (message!== null) $('#inputMessage').val(message);
    }

    // Before refreshing the page, save the form data to sessionStorage
    window.onbeforeunload = function() {
    	var i=$('#numb').val();
        sessionStorage.setItem("name", $('#inputName').val());
        sessionStorage.setItem("email", $('#inputEmail').val());
        sessionStorage.setItem("subject", $('#inputSubject').val());
        sessionStorage.setItem("message", $('#inputMessage').val());
    }
</script> -->
  </body>
</html>