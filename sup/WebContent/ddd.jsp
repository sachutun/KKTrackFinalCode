<%@page import="java.sql.*"%>
<html>
<head>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js">
 </script>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">

function showData(value){ 
$.ajax({
    url : "dem.jsp?name="+value,
    type : "POST",
    async : false,
    success : function(data) {
//Do something with the data here
/* var dv=data.split(","); */

    	 document.getElementById("country").innerHTML=data;
    }
});
}
</script>
</head>
<body>
<input type="text" name="name" id="name" onkeyup="showData(this.value);"><br>
<div id=country>
</div>
</body>
</html>