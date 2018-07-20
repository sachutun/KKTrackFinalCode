<html>
<head>
    <title>Create Elements Dynamically using jQuery</title>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.1/jquery-ui.min.js">
            </script>
    <style>
        body {
            font: 13px verdana;
            font-weight: normal;
        }
    </style>
</head>
<body>
    <div id="main">
        <input type="button" id="btAdd" value="Add Element" class="bt" />
        <input type="button" id="btRemove" value="Remove Element" class="bt" />
        <input type="button" id="btRemoveAll" value="Remove All" class="bt" /><br />
    </div>
</body>
<script>
    $(document).ready(function() {

        var iCnt = 0;
        // CREATE A "DIV" ELEMENT AND DESIGN IT USING jQuery ".css()" CLASS.
        var container = $(document.createElement('div')).css({
            padding: '5px', margin: '20px', width: '170px', border: '1px dashed',
            borderTopColor: '#999', borderBottomColor: '#999',
            borderLeftColor: '#999', borderRightColor: '#999'
        });

        $('#btAdd').click(function() {
            if (iCnt <= 19) {

                iCnt = iCnt + 1;

                // ADD TEXTBOX.
                var s1="<div class=\"codedetails\"><ul class=\"nav navbar-right panel_toolbox\"><li><a class=\"collapse-link\"><i class=\"fa fa-chevron-up\"></i></a></li><li><a class=\"close\" onclick=cls\"()\"><i class=\"fa fa-close\"></i></a></li></ul><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value)\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Sale Price:<span class=\"required\">*</span></label><div class=\"col-md-2 col-sm-2 col-xs-4\"><input id=\"costprice\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"costprice\"></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onblur=\"calculate()\"> </div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Total:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"totalprice\" class=\"form-control col-md-7 col-xs-12\"  type=\"text\" name=\"totalprice\" readonly=\"readonly\"></div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Max Price:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"mp\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"text\" name=\"maxprice\"disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Min Price:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"minprice\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"text\" name=\"minprice\" disabled></div></div></div></div></div>";
                $(container).append("<div class=\"codedetails\" id="+iCnt+ "><ul class=\"nav navbar-right panel_toolbox\"><li><a class=\"collapse-link\"><i class=\"fa fa-chevron-up\"></i></a></li><li><a class=\"close\" onclick=cls\"()\"><i class=\"fa fa-close\"></i></a></li></ul><div class=\"x_content\" style=\"padding-left: 38px; padding-right: 50px;padding-top: 20px;border: 1px solid rgba(128, 128, 128, 0.2);margin-bottom: 2%; background-color: rgb(247, 247, 247);\"><div class=\"form-group\" style=\"margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"code\"> Code:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"code\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"code\" onchange=\"showState(this.value)\"></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Description:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"description\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"description\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Sale Price:<span class=\"required\">*</span></label><div class=\"col-md-2 col-sm-2 col-xs-4\"><input id=\"costprice\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"costprice\"></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" >Quantity:<span class=\"required\">*</span></label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"qty\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"number\" name=\"qty\" onblur=\"calculate()\"> </div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Total:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"totalprice\" class=\"form-control col-md-7 col-xs-12\"  type=\"text\" name=\"totalprice\" readonly=\"readonly\"></div> </div><div class=\"form-group\" style=\"margin-top:2%; margin-bottom:2%; margin-left:-3%\"><label class=\"control-label col-md-1 col-sm-1 col-xs-2\" for=\"mac\"> Mac:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input type=\"text\" id=\"mac\" required=\"required\" class=\"form-control col-md-7 col-xs-12\" name=\"mac\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">PartNo:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"partno\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"partno\" disabled></div><label  class=\"control-label col-md-1 col-sm-1 col-xs-2\">Group:</label><div class=\"col-md-2 col-sm-2 col-xs-3\"><input id=\"grp\" class=\"form-control col-md-7 col-xs-12\" type=\"text\" name=\"grp\" disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Max Price:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"mp\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"text\" name=\"maxprice\"disabled></div><label class=\"control-label col-md-1 col-sm-1 col-xs-2\">Min Price:</label><div class=\"col-md-1 col-sm-1 col-xs-2\"><input id=\"minprice\" class=\"form-control col-md-7 col-xs-12\" required=\"required\" type=\"text\" name=\"minprice\" disabled></div></div></div></div></div>");

                // SHOW SUBMIT BUTTON IF ATLEAST "1" ELEMENT HAS BEEN CREATED.
                if (iCnt == 1) {

                    var divSubmit = $(document.createElement('div'));
                    $(divSubmit).append('<input type=button class="bt"' + 
                        'onclick="GetTextValue()"' + 
                            'id=btSubmit value=Submit />');

                }

                // ADD BOTH THE DIV ELEMENTS TO THE "main" CONTAINER.
                $('#main').after(container, divSubmit);
            }
            // AFTER REACHING THE SPECIFIED LIMIT, DISABLE THE "ADD" BUTTON.
            // (20 IS THE LIMIT WE HAVE SET)
            else {      
                $(container).append('<label>Reached the limit</label>'); 
                $('#btAdd').attr('class', 'bt-disable'); 
                $('#btAdd').attr('disabled', 'disabled');
            }
        });

        // REMOVE ONE ELEMENT PER CLICK.
        $('#btRemove').click(function() {
            if (iCnt != 0) { $('#'+iCnt).remove(); iCnt = iCnt - 1; }
        
            if (iCnt == 0) { 
                $(container)
                    .empty() 
                    .remove(); 

                $('#btSubmit').remove(); 
                $('#btAdd')
                    .removeAttr('disabled') 
                    .attr('class', 'bt');
            }
        });

        // REMOVE ALL THE ELEMENTS IN THE CONTAINER.
        $('#btRemoveAll').click(function() {
            $(container)
                .empty()
                .remove(); 

            $('#btSubmit').remove(); 
            iCnt = 0; 
            
            $('#btAdd')
                .removeAttr('disabled') 
                .attr('class', 'bt');
        });
    });

    // PICK THE VALUES FROM EACH TEXTBOX WHEN "SUBMIT" BUTTON IS CLICKED.
    var divValue, values = '';

    function GetTextValue() {

        $(divValue) 
            .empty() 
            .remove(); 
        
        values = '';

        $('.input').each(function() {
            divValue = $(document.createElement('div')).css({
                padding:'5px', width:'200px'
            });
            values += this.value + '<br />'
        });

        $(divValue).append('<p><b>Your selected values</b></p>' + values);
        $('body').append(divValue);
    }
</script>
</html>