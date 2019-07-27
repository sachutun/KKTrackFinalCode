/*------------------------------------------------------------------------------------------------------
 Javascript that displays JSP elements based on roles.

Role No : Description
-----------------------
 0      : superAdm
 1      : admin
 2      : branch
 3      : manager
 4      : store
 5      : accountant
--------------------------------------------------------------------------------------------------------- */
//disable shortcuts for view source

/* 	   S No  Command  	-   KeyCode (Mac)
		1.   shift    	-    16
	    2.   control  	-    17
		3.	 alt/option 	-	 18
		4.	 command		-	 91
		5.	 u			-	 85              */

/*document.onkeydown = function(e) 
{
   //alert(e.keyCode);
	// Disable Alt+Command+U shortcut for viewsource in mac
    	if(e.altKey && (e.keyCode === 91 || e.keyCode === 85))
    	{
       // alert('not allowed');  		
        return false;
    }
    	// Disable Contol+U shortcut for viewsource in windows
    	if(e.ctrlKey && e.keyCode === 85)
    	{
    		return false;
    	}
    	//Do nothing if the above shortcuts are not used
    else
    	{
    return true; 
    	}
    	
};

//disable right click on page
if (document.addEventListener) {
    document.addEventListener('contextmenu', function (e) {
        e.preventDefault();
    }, false);
} else {
    document.attachEvent('oncontextmenu', function () {
        window.event.returnValue = false;
    });
}*/

//display menu based on roles
if (environment != null && environment == "local") 
{
	$('.site_title').css('background-color', 'red');
} 
else 
{
	$('.site_title').css('background-color', '');
}


if (role != null && role == "1") 
{
	$('[class*="superAdm"]').hide();
	$('[class*="admin"]').show();
}

if (role != null && role != "0" && role != "1") 
{
	$('[class*="admin"]').hide();
	$('[class*="superAdm"]').hide();
	if(callingJSP == "hidepricesale.jsp" || callingJSP == "viewsaletry.jsp" )
    	{
    		if(ubran!='Workshop' && ubran!='All')
       	{   
       	  document.getElementById('wedit').style.display="none";
       	}
    	}
    else
    	{
    		if (ubran != 'Workshop' && ubran != 'Barhi' && ubran != 'All') 
    	 	{
    	 		if (document.getElementById('wedit') != null) 
    	 		{
    	 			document.getElementById('wedit').style.display = "none";
    	 		}
    	 	}
    	}
	 if(callingJSP == "creditpurchase.jsp" || callingJSP == "creditsale.jsp" || callingJSP == "viewpurchase.jsp" || callingJSP == "viewsalereturn.jsp")
	 {
		 if(role!="3")
		 {
			 $( '[class*="currentBranch"]' ).show();
		 }
	 }

}

if (role != null && role == "2") 
{
	if (callingJSP == "ibtform.jsp") 
	{
		if(ubran!=null && ubran!="Bowenpally" && ubran!="Workshop")
		{
			$( '[class*="branch"]' ).hide();
   			var elements = document.getElementsByClassName('user');

   		 	for (var i = 0; i < elements.length; i++)
   		 	{
        			elements[i].style.display = "block";
    			}
   		 	
		}
		if(ubran!=null && ubran=="Bowenpally" && ubran=="Workshop")
			document.getElementById('fromBranchName').style.display="none";
	}
	else
	{
		$('[class*="branch"]').hide();
		var elements = document.getElementsByClassName('user');
	
		if(elements!=null)
		{
			for (var i = 0; i < elements.length; i++) 
			{
				elements[i].style.display = "block";
			}
		}
	
		if (callingJSP == "AddCode.jsp" || callingJSP == "addibtedit.jsp" || callingJSP == "addsaleedit.jsp") 
		{
			if (ubran != null && ubran == "Workshop")
			{
				document.getElementById("invAdj").style.display = "block";
			}
		} 
		else 
		{
			if (callingJSP == "inventoryAdjustment.jsp" || callingJSP == "modification.jsp" || callingJSP == "viewinventory.jsp") 
			{
				if(ubran!=null && ((ubran=="Workshop")||(ubran=="Barhi")||(ubran=="Tekkali")|| (ubran=="Vishakapatnam")||(ubran=="Bowenpally")))
				{
					document.getElementById("invAdj").style.display="block";
				}
			}
			else		
			{
				if (ubran != null && ((ubran == "Workshop") || (ubran == "Barhi")))
				{
					document.getElementById("invAdj").style.display = "block";
				}
			}
		}
	}

	
	if (ubran != null && ((ubran == "Workshop") || (ubran == "Workshop2"))) 
	{
		document.getElementById("mod").style.display = "block";
		document.getElementById("grping").style.display = "block";
	}
	if (ubran != null && ubran == "Workshop") 
	{
		document.getElementById("viewService").style.display = "block";
	}

}

if (role != null && role == "3") 
{
	$('[class*="man"]').hide();
}

if (role != null && role == "4") 
{
	$('[class*="store"]').hide();
	if (callingJSP == "viewinventory.jsp") 
	{
	   document.getElementById("exp").style.display="none";
		document.getElementById("br").style.display="block";
		document.getElementById("bup").style.display="inline";
	}

}

if (role != null && role == "5") 
{
	$('[class*="acc"]').hide();
	if (callingJSP == "CashTransfer.jsp" || callingJSP == "expenses.jsp" || callingJSP == "PurchaseCost.jsp" || callingJSP == "ViewCollections.jsp" || callingJSP == "viewinventory.jsp") 
	{
		document.getElementById("br").style.display = "block";
	}
}
