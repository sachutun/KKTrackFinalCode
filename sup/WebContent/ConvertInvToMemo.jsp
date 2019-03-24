<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Arrays"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.io.*"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*"%>
<%
	Connection conn = null;
	PreparedStatement ps = null;
	PreparedStatement ps2 = null;
	PreparedStatement ps3 = null;
	ResultSet resultSet = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement st = null;
	Statement st2 = null;
	Statement st3 = null;
	int Id = 0;
	;
%>
<%
	try {
		int i = 0;
		String recordtoupdate = request.getParameter("recordtoupdate");
		// System.out.println("recordtoupdate: " +recordtoupdate); 
		String dc = request.getParameter("dc");
		// System.out.println("dc: " +dc); 
		String sd = request.getParameter("sd");
		// System.out.println("sd: " +sd); 
		String branch = request.getParameter("branch");
		String qty = request.getParameter("qty");
		String cp = request.getParameter("cp");
		String code = request.getParameter("code");
		String notes = request.getParameter("notes");

		// System.out.println("branch: " +branch); 
		//  System.out.println("notes: " +notes); 
		// System.out.println("code: " +code);  
		//  System.out.println("qty: " +qty); 
		//  System.out.println("cp: " +cp); 
		int delimiter = notes.indexOf(",");
		String invNo = notes.substring(17, delimiter);
		delimiter = delimiter + 2;
		String date = notes.substring(delimiter);
		// System.out.println("invNo:" +invNo); 
		// System.out.println("date:" +date); 

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

		st = conn.createStatement();
		st2 = conn.createStatement();

		// Insert update in Sale with new inv number and inv dt

		// System.out.println("Select * from Sale where Date='"+date+"'and Branch='"+branch+"'and DCNumber='"+invNo+"'");   
		rs1 = st.executeQuery("Select * from Sale where Date='" + date + "'and Branch='" + branch
				+ "'and DCNumber='" + invNo + "'");
		double totalprice = 0;
		double balanceamount = 0;
		if (rs1.next()) {

			Id = rs1.getInt("Id");
			totalprice = rs1.getDouble("TotalPrice");
			balanceamount = rs1.getDouble("BalanceAmount");
			totalprice = totalprice - (Double.parseDouble(cp) * (Double.parseDouble(qty)));
			balanceamount = balanceamount - (Double.parseDouble(cp) * (Double.parseDouble(qty)));

			//System.out.println("Select * from BillDetails where dc='"+Id+"'and Code='"+code+"'and DCNumber='"+invNo+"'");
			rs2 = st2.executeQuery("Select * from BillDetails where dc='" + Id + "'and Code='" + code
					+ "'and DCNumber='" + invNo + "'");

			if (rs2.next()) {
				int invId = rs2.getInt("Id");
				// System.out.println("DELETE FROM BillDetails WHERE id = " +invId);
				ps = conn.prepareStatement("DELETE FROM BillDetails WHERE id = ?");
				ps.setInt(1, invId);
				ps.executeUpdate();
				//  System.out.println("UPDATE `BillDetails` SET `Notes`=?  WHERE Id=" +recordtoupdate);   	  	  
				ps2 = conn.prepareStatement("UPDATE `BillDetails` SET `Notes`=?  WHERE Id=?");
				ps2.setString(1, "");
				ps2.setString(2, recordtoupdate);
				ps2.executeUpdate();
			}
		}

		if (totalprice == 0) {
			//  System.out.println("DELETE FROM Sale WHERE id = " +Id);   
			ps3 = conn.prepareStatement("DELETE FROM Sale WHERE id = ?");
			ps3.setInt(1, Id);
			ps3.executeUpdate();
		} else {
			// System.out.println("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=? WHERE Id= "+totalprice +" " +balanceamount +" "+Id);

			ps3 = conn.prepareStatement("UPDATE `Sale` SET `TotalPrice`=?,`BalanceAmount`=? WHERE Id=?");
			ps3.setDouble(1, totalprice);
			ps3.setDouble(2, balanceamount);
			ps3.setInt(3, Id);
			ps3.executeUpdate();
		}

		response.sendRedirect("editsalindividual.jsp?res=3&branch=" + branch + "&dc=" + dc + "&sd=" + sd);
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		session.setAttribute("map", "");
		try {
			if (st != null)
				st.close();
			if (st2 != null)
				st2.close();
			if (ps != null)
				ps.close();
			if (ps2 != null)
				ps2.close();

			if (ps3 != null)
				ps3.close();
		} catch (SQLException e) {
		}
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
		}
	}
%>