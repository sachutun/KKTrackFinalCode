<%@page import="java.util.*"%>
<%-- <%@page import="com.chest.web.db.ConnectManager"%> --%>
<%@page import="java.sql.*"%>
<%@page import="org.json.*"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page import="java.io.InputStream" %>
<%
String role=request.getParameter("role");
/* System.out.println("role="+role); */
    String[] cols = { "CustID","CustomerName","Mobile","Aadhaar", "GST", "OB"};
    
   
  /*   	 String[] cols2= { "Branch","Code","Machine", "HSNCode",  "PartNo", "Description","Grp","MaxPrice","MinPrice","Quantity"}; */
    
    String table = "Debtors";
    DataSource ds = null;
    Connection conn = null;
    JSONObject result = new JSONObject();
    JSONArray array = new JSONArray();
    int amount = 10;
    int start = 0;
    int echo = 0;
    int col = 0;

  /*   
    System.out.println("Branch="+Branch+" branch="+branch+ "role="+role);  */
    String CustID = "";
    String CustomerName = "";
    String Mobile = "";
    String Aadhaar = "";
    String GST = "";
    String OB = "";
 
  
    String dir = "asc";
    String sStart = request.getParameter("iDisplayStart");
    String sAmount = request.getParameter("iDisplayLength");
    String sEcho = request.getParameter("sEcho");
    String sCol = request.getParameter("iSortCol_0");
    String sdir = request.getParameter("sSortDir_0");
   
   
    CustID = request.getParameter("sSearch_0");
    CustomerName = request.getParameter("sSearch_1");
    Mobile = request.getParameter("sSearch_2");
    Aadhaar = request.getParameter("sSearch_3");
    GST = request.getParameter("sSearch_4");
    OB = request.getParameter("sSearch_5");
 
  
      
     List<String> sArray = new ArrayList<String>();
     
  /*     if (branch!="" && branch!=null) {
         String sbranch = " Branch like '%" + branch + "%'";
         sArray.add(sbranch);
     } 
     
     if (Branch!="" && Branch!=null) {
        String sBranch = " Branch like '%" + Branch + "%'";
        sArray.add(sBranch);
        //or combine the above two steps as:
        //sArray.add(" engine like '%" + engine + "%'");
        //the same as followings
    }  */
    if (CustID!="" && CustID!=null) {
        String sCustID = "CustID like '%"+CustID + "%'";
        sArray.add(sCustID);
    }
    if (CustomerName!="" && CustomerName!=null) {
        String sCustomerName = " CustomerName like '%" + CustomerName + "%'";
        sArray.add(sCustomerName);
    }
    if (Mobile!="" && Mobile!=null) {
        String sMobile = " Mobile like '%" + Mobile + "%'";
        sArray.add(sMobile);
    }
    if (Aadhaar!="" && Aadhaar!=null) {
        String sAadhaar = " Aadhaar like '%" + Aadhaar + "%'";
        sArray.add(sAadhaar);
    } 
    if (GST!="" && GST!=null)
    {
    	String sGST = " GST like '%" + GST + "%'";
    sArray.add(sGST);
    }
   
    if (OB!="" && OB!=null)
    {
    	String sOB = " OB like '%" + OB + "%'";
        sArray.add(sOB);
    }
   
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
        if (col < 0 || col > 7)
            col = 0;
    }
    if (sdir != null) {
        if (!sdir.equals("asc"))
            dir = "desc";
    }
    
    String colName = cols[col];
    
   /*  if(role!="1")
    	colName = cols2[col]; */
    
   
    int total = 0;
/*     Connection conn = ConnectManager.getConnection(); */
    try {
  /*   	 Context context = new InitialContext();
 	    Context envCtx = (Context) context.lookup("java:comp/env");
 	    ds =  (DataSource)envCtx.lookup("jdbc/KKTrack");
 	    if (ds != null) { */
 	      // Class.forName("com.mysql.jdbc.Driver").newInstance();  
 	     //conn = DriverManager.getConnection("jdbc:mysql://kkheavydb.ceiyzsxhqtzy.us-east-2.rds.amazonaws.com:3306/KKTrack","root","Test1234");  
 	     // conn = ds.getConnection();
 	     
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
        //}
    }
    }catch(Exception e){
         
    }
    int totalAfterFilter = total;
    //result.put("sEcho",echo);
 
    try {
        String searchSQL = "";
        String sql = "SELECT * FROM "+table;
        
         String searchTerm = request.getParameter("sSearch");
        String globeSearch =  " where CustID like '%"+searchTerm+"%'"+ " or CustomerName like '%"+searchTerm+"%'"+ " or Mobile like '%"+searchTerm+"%'"+ " or Aadhaar like '%"+searchTerm+"%'"+ " or GST like '%"+searchTerm+"%'"+ " or OB like '%"+searchTerm+"%'"; 
      
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
         sql += " limit " + start + ", " + amount; 
      //  System.out.println(sql);  
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            JSONArray ja = new JSONArray();
            ja.put(rs.getString("CustID"));
            ja.put(rs.getString("CustomerName"));
            ja.put(rs.getString("Mobile"));
            ja.put(rs.getString("Aadhaar"));
            ja.put(String.valueOf(rs.getInt("GST")));
            //System.out.println(rs.getString("CustID") + " -> " + rs.getInt("OB"));
            ja.put(String.valueOf(rs.getInt("OB")));
      
            
            array.put(ja);
            
        }
       // System.out.println("array" +array);
         String sql2 = "SELECT count(*) FROM "+table;
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
        System.out.println("---------------");	
        out.print(result);
        conn.close();
    } catch (Exception e) {
 
    }
%>