<%@page import="java.util.*"%>
<%-- <%@page import="com.chest.web.db.ConnectManager"%> --%>
<%@page import="java.sql.*"%>
<%@page import="org.json.*"%>
<%
    String[] cols = { "Branch","Code", "HSNCode", "Machine", "PartNo", "Description","Grp","MaxPrice","MinPrice","Quantity","LC" };
    String table = "CodeList inner join NewInventory on NewInventory.Code=CodeList.Code";
    Class.forName("com.mysql.jdbc.Driver").newInstance();  
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:8889/KKTrack","root","root");  
    JSONObject result = new JSONObject();
    JSONArray array = new JSONArray();
    int amount = 10;
    int start = 0;
    int echo = 0;
    int col = 0;
     
    String Branch = "";
    String Code = "";
    String HSNCode = "";
    String Machine = "";
    String PartNo = "";
    String Description = "";
    String Grp = "";
    String MaxPrice = "";
    String MinPrice = "";
    String Quantity = "";
    String LC="";
 
    String dir = "asc";
    String sStart = request.getParameter("iDisplayStart");
    String sAmount = request.getParameter("iDisplayLength");
    String sEcho = request.getParameter("sEcho");
    String sCol = request.getParameter("iSortCol_0");
    String sdir = request.getParameter("sSortDir_0");
     
    Branch = request.getParameter("sSearch_0");
    Code = request.getParameter("sSearch_1");
    HSNCode = request.getParameter("sSearch_2");
    Machine = request.getParameter("sSearch_3");
    PartNo = request.getParameter("sSearch_4");
    Description = request.getParameter("sSearch_5");
    Grp = request.getParameter("sSearch_6");
    MaxPrice = request.getParameter("sSearch_7");
    MinPrice = request.getParameter("sSearch_8");
    Quantity = request.getParameter("sSearch_9");
    LC = request.getParameter("sSearch_10");
      
/*     List<String> sArray = new ArrayList<String>();
    if (!Branch.equals("")) {
        String sBranch = " Branch like '%" + Branch + "%'";
        sArray.add(sBranch);
        //or combine the above two steps as:
        //sArray.add(" engine like '%" + engine + "%'");
        //the same as followings
    }
    if (!Code.equals("")) {
        String sCode = " Code like '%" + Code + "%'";
        sArray.add(sCode);
    }
    if (!HSNCode.equals("")) {
        String sHSNCode = " HSNCode like '%" + HSNCode + "%'";
        sArray.add(sHSNCode);
    }
    if (!Machine.equals("")) {
        String sMachine = " Machine like '%" + Machine + "%'";
        sArray.add(sMachine);
    }
    if (!PartNo.equals("")) {
        String sPartNo = " PartNo like '%" + PartNo + "%'";
        sArray.add(sPartNo);
    } 
    if (!Description.equals(""))
    sArray.add(" Description like '%" + Description + "%'");
    if (!Grp.equals(""))
        sArray.add(" Grp like '%" + Grp + "%'");
    if (!Description.equals(""))
        sArray.add(" Description like '%" + Description + "%'");
    if (!MaxPrice.equals(""))
        sArray.add(" MaxPrice like '%" + MaxPrice + "%'");
    if (!MinPrice.equals(""))
        sArray.add(" MinPrice like '%" + MinPrice + "%'");
    if (!Quantity.equals(""))
        sArray.add(" Quantity like '%" + Quantity + "%'");
    if (!LC.equals(""))
        sArray.add(" LC like '%" + LC + "%'");
    
    String individualSearch = "";
    if(sArray.size()==1){
        individualSearch = sArray.get(0);
    }else if(sArray.size()>1){
        for(int i=0;i<sArray.size()-1;i++){
            individualSearch += sArray.get(i)+ " and ";
        }
        individualSearch += sArray.get(sArray.size()-1);
    }  */
     
    if (sStart != null) {
        start = Integer.parseInt(sStart);
        if (start < 0)
            start = 0;
    }
    if (sAmount != null) {
        amount = Integer.parseInt(sAmount);
        if (amount < 10 )
            amount = 10;
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
        String sql = "SELECT count(*) FROM "+table;
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            total = rs.getInt("count(*)");
        }
    }catch(Exception e){
         
    }
    int totalAfterFilter = total;
    //result.put("sEcho",echo);
 
    try {
        String searchSQL = "";
        String sql = "SELECT * FROM "+table;
        
         String searchTerm = request.getParameter("sSearch");
       /* String globeSearch =  " where (Branch like '%"+searchTerm+"%'"
                                + " or Code like '%"+searchTerm+"%'"
                                + " or Description like '%"+searchTerm+"%'"
                                + " or PartNo like '%"+searchTerm+"%'"
                                + " or Grp like '%"+searchTerm+"%'"
                                + " or Machine like '%"+searchTerm+"%')";
        if(searchTerm!=""&&individualSearch!=""){
            searchSQL = globeSearch + " and " + individualSearch;
        }
        else if(individualSearch!=""){
            searchSQL = " where " + individualSearch;
        }else if(searchTerm!=""){
            searchSQL=globeSearch;
        }  
       /*  sql += searchSQL;
        sql += " order by " + colName + " " + dir; */
        sql += " limit " + start + ", " + amount;
 
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JSONArray ja = new JSONArray();
            ja.put(rs.getString("Branch"));
            ja.put(rs.getString("Code"));
            ja.put(rs.getString("HSNCode"));
            ja.put(rs.getString("Machine"));
            ja.put(rs.getString("PartNo"));
            ja.put(rs.getString("Description"));
            ja.put(rs.getString("Grp"));
            ja.put(rs.getString("MaxPrice"));
            ja.put(rs.getString("MinPrice"));
            ja.put(rs.getString("Quantity"));
            ja.put(rs.getString("LC"));
            array.put(ja);
        }
       /*  String sql2 = "SELECT count(*) FROM "+table;
        if (searchTerm != "") {
            sql2 += searchSQL;
            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) {
                totalAfterFilter = rs2.getInt("count(*)");
            }
        }  */
        result.put("iTotalRecords", total);
        result.put("iTotalDisplayRecords", totalAfterFilter);
        result.put("aaData", array);
        response.setContentType("application/json");
        response.setHeader("Cache-Control", "no-store");
        out.print(result);
        System.out.println(searchTerm);
        conn.close();
    } catch (Exception e) {
 
    }
%>