<%@page import="java.sql.*"%>
 <html>
 <head>  
 <script language="javascript" type="text/javascript">  
//AJAX call for autocomplete 
 $(document).ready(function(){
 	$("#search-box").keyup(function(){
 		$.ajax({
 		type: "POST",
 		url: "codefile.php",
 		data:'keyword='+$(this).val(),
 		beforeSend: function(){
 			$("#search-box").css("background","#FFF url(LoaderIcon.gif) no-repeat 165px");
 		},
 		success: function(data){
 			$("#suggesstion-box").show();
 			$("#suggesstion-box").html(data);
 			$("#search-box").css("background","#FFF");
 		}
 		});
 	});
 });
 //To select country name
 function selectCountry(val) {
 $("#search-box").val(val);
 $("#suggesstion-box").hide();
 }
 </script>  
 </head>  
 <body>  
<div class="frmSearch">
	<input type="text" id="search-box" placeholder="Country Name" />
	<div id="suggesstion-box"></div>
</div>
 </body> 
 </html>