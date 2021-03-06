<%@page import="java.util.*"%>
<%-- <%@page import="com.chest.web.db.ConnectManager"%> --%>
<%@page import="java.sql.*"%>
<%@page import="org.json.*"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page import="java.io.InputStream" %>
<%
// SELECT c.Code, c.HSNCode, c.Description,c.Machine, c.PartNo, c.Grp, c.MaxPrice, c.MinPrice, c.ARR, sum(n.Quantity) FROM NewInventory n INNER JOIN CodeList c ON n.Code=c.Code group by c.Code */
    String[] cols = { "Code", "Machine", "HSNCode", "PartNo", "Description","Grp","Quantity" };
    String table = "CodeList c inner join NewInventory n on n.Code=c.Code";
  /*   Class.forName("com.mysql.jdbc.Driver").newInstance();  
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");   */
    DataSource ds = null;
    Connection conn = null;
   
    JSONObject result = new JSONObject();
    JSONArray array = new JSONArray();
    int amount = 10;
    int start = 0;
    int echo = 0;
    int col = 0;
    String branch ="";
    String Branch="";
  

 
    String Code = "";
    String HSNCode = "";
    String Machine = "";
    String PartNo = "";
    String Description = "";
    String Grp = "";
    String MaxPrice = "";
    String MinPrice = "";
    String Quantity = "";
 
    String dir = "asc";
    String sStart = request.getParameter("iDisplayStart");
    String sAmount = request.getParameter("iDisplayLength");
    String sEcho = request.getParameter("sEcho");
    String sCol = request.getParameter("iSortCol_0");
    String sdir = request.getParameter("sSortDir_0");
     
  //  Branch = request.getParameter("sSearch_0");
  
   
    Code = request.getParameter("sSearch_0");
    HSNCode = request.getParameter("sSearch_1");
    Machine = request.getParameter("sSearch_2");
    PartNo = request.getParameter("sSearch_3");
    Description = request.getParameter("sSearch_4");
    Grp = request.getParameter("sSearch_5");
   
    Quantity = request.getParameter("sSearch_6");
      
     List<String> sArray = new ArrayList<String>();
 /*     if (branch!="" && branch!=null) {
         String sbranch = " Branch like '%" + branch + "%'";
         sArray.add(sbranch);
     }  */
     
     if (Branch!="" && Branch!=null) {
        String sBranch = " Branch like '%" + Branch + "%'";
        sArray.add(sBranch);
        //or combine the above two steps as:
        //sArray.add(" engine like '%" + engine + "%'");
        //the same as followings
    } 
    if (Code!="" && Code!=null) {
        String sCode = " n.Code ="+Code;
        sArray.add(sCode);
    }
  
    if (Machine!="" && Machine!=null) {
        String sMachine = " Machine like '%" + Machine + "%'";
        sArray.add(sMachine);
    }
    if (HSNCode!="" && HSNCode!=null) {
        String sHSNCode = " HSNCode like '%" + HSNCode + "%'";
        sArray.add(sHSNCode);
    }
    if (PartNo!="" && PartNo!=null) {
        String sPartNo = " PartNo like '%" + PartNo + "%'";
        sArray.add(sPartNo);
    } 
    if (Description!="" && Description!=null)
    sArray.add(" Description like '%" + Description + "%'");
   
    if (Grp!="" && Grp!=null)
        sArray.add(" Grp like '%" + Grp + "%'");

    
    if (Quantity!="" && Quantity!=null)
        sArray.add(" sum(Case When Quantity > 0 then Quantity else 0 end) like '%" + Quantity + "%'");
    

    String individualSearch = "";
    if(sArray.size()==1){
        individualSearch = sArray.get(0);
    }else if(sArray.size()>1){
        for(int i=0;i<sArray.size()-1;i++){
            individualSearch += sArray.get(i)+ " and ";
        }
        individualSearch += sArray.get(sArray.size()-1);
    }  
     
    if (sStart != null) {
        start = Integer.parseInt(sStart);
        if (start < 0)
            start = 0;
    }
   
    if (sEcho != null) {
        echo = Integer.parseInt(sEcho);
    }
    if (sCol != null) {
        col = Integer.parseInt(sCol);
        if (col < 0 || col > 9)
            col = 0;
    }
    if (sdir != null) {
        if (!sdir.equals("asc"))
            dir = "desc";
    }
    String colName = cols[col];
    int total = 0;
/*     Connection conn = ConnectManager.getConnection(); */
    try {
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
    	      String sql = "SELECT DISTINCT count(*) FROM "+table;
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            total = rs.getInt("count(*)");
        }
    	   // }
    }catch(Exception e){
         
    }
    int totalAfterFilter = total;
    //result.put("sEcho",echo);
 
    try {
        String searchSQL = "";
        String sql = "SELECT *,  sum(Case When Quantity > 0 then Quantity else 0 end) FROM "+table;
       
         String searchTerm = request.getParameter("sSearch");
        String globeSearch =  " where n.Code ="+searchTerm+ " or Description like '%"+searchTerm+"%'"+ " or PartNo like '%"+searchTerm+"%'"+ " or Grp like '%"+searchTerm+"%'"+ " or Machine like '%"+searchTerm+"%'"; 
      
        if(searchTerm!="" && searchTerm!=null)
        	searchSQL=globeSearch;
        
        if(searchTerm!="" && searchTerm!=null && individualSearch!=""){
            searchSQL = globeSearch + " and " + individualSearch;
        }
        else if(individualSearch!=""){
            searchSQL = " where " + individualSearch;
        }else if(searchTerm!=""){
            searchSQL=globeSearch;
        }  
         sql += searchSQL;
         if (sAmount != null) {
             amount = Integer.parseInt(sAmount);
             if (amount < 0 )
                 amount = total;
         }
     /*   sql += " order by " + colName + " " + dir; */
       sql+=" group by c.Code";
        sql += " limit " + start + ", " + amount;
       
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JSONArray ja = new JSONArray();
            
            ja.put(rs.getString("n.Code"));
            ja.put(rs.getString("Machine"));
            ja.put(rs.getString("HSNCode"));
            ja.put(rs.getString("PartNo"));
            ja.put(rs.getString("Description"));
            ja.put(rs.getString("Grp"));
            ja.put(rs.getString("sum(Case When Quantity > 0 then Quantity else 0 end)"));
            
            array.put(ja);
        }
         String sql2 = "SELECT DISTINCT count(*) FROM "+table;
        if (searchSQL != "") {
            sql2 += searchSQL;
            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                totalAfterFilter = rs2.getInt("count(*)");
            }
        }  
        result.put("iTotalRecords", total);
        result.put("iTotalDisplayRecords", totalAfterFilter);
        result.put("aaData", array);
        response.setContentType("application/json");
        response.setHeader("Cache-Control", "no-store");
        out.print(result);
        conn.close();
        
    } catch (Exception e) {
 
    }
    
%>