<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Arrays"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.io.*"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*"%>
<%
	/* String id = request.getParameter("userId"); */

	DataSource ds = null;
	Connection conn = null;
	PreparedStatement preparedStatement = null;
	PreparedStatement ps = null;
	PreparedStatement ps2 = null;
	PreparedStatement ps4 = null;
	ResultSet resultSet = null;
	Statement st = null;
	Statement st2 = null;
%>
<%
	try {
		int i = 0;
		String recordToUpdate = request.getParameter("deleteid");

		String branch = request.getParameter("branch");
		String branchName = branch;
		String dc = request.getParameter("dc");

		String sd = request.getParameter("sd");

		String selectedItems = request.getParameter("selectedItems");

		String[] selectedItemsArray = selectedItems.split(",");

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
		for (i = 0; i < selectedItemsArray.length; i++) {
			//System.out.println("Fetching Keys and corresponding [Multiple] Values n");
			Map<Integer, List<String>> map = (HashMap<Integer, List<String>>) session.getAttribute("map");

			for (Map.Entry<Integer, List<String>> entry : map.entrySet()) {
				int key = entry.getKey();
				//System.out.println("Key = " + key);
				//System.out.println(selectedItemsArray[i]);
				if (Integer.parseInt(selectedItemsArray[i]) == key) {
					List<String> values = entry.getValue();

					//System.out.println("Values = " + values + "n");

					int d = Integer.parseInt(recordToUpdate);

					float ftot = 0;
					int code = 0;
					float arr = 0;
					float qty = 0;
					int nq = 0;
					float newtotal = 0;
					int billid = 0;
					
					String s4 = "SELECT * FROM ManDetails WHERE MNo=" + d;
					
					String cod = values.get(2);
					String q = values.get(3);
					String arrval = values.get(4);
					String tx = values.get(5);
					String totp = values.get(6);
					String bid = values.get(7);

					code = Integer.parseInt(cod);
					arr = Float.parseFloat(arrval);
					qty = Float.parseFloat(q);
					nq = 0;
					float tax = Float.parseFloat(tx);
					billid = Integer.parseInt(bid);

					//totalprice is total price of item being deleted
					float totalprice = Float.parseFloat(totp);
					tax = tax * qty;

					totalprice = (arr * qty) + tax;
					String s3 = "";


					st = conn.createStatement();

					String s2 = "DELETE FROM ManDetails WHERE id =" + billid;

					ps = conn.prepareStatement("DELETE FROM ManDetails WHERE id = ?");
					ps.setInt(1, billid);
					ps.executeUpdate();
					//System.out.println(s2);

					if (branch.equals("Workshop2"))
						branchName = "Workshop";
					//s3 = "UPDATE `NewInventory` SET `Quantity`=`Quantity`-" + qty + " WHERE Code=" + code + " AND Branch=" + branchName;
					ps2 = conn.prepareStatement("UPDATE `NewInventory` SET `Quantity`=`Quantity`-? WHERE Code= ? AND Branch=?");
					ps2.setFloat(1, qty);
					ps2.setInt(2, code);
					ps2.setString(3, branchName);
					ps2.executeUpdate();
					System.out.println(s3);

					String s1 = "UPDATE `Manufacturing` SET `TotalPrice`=`TotalPrice`-" + totalprice + ",`Tax`=`Tax`-" + tax + " WHERE Id=" + d;
					preparedStatement = conn.prepareStatement("UPDATE `Manufacturing` SET `TotalPrice`=`TotalPrice`-?,`Tax`=`Tax`-? WHERE Id=?");
					preparedStatement.setFloat(1, totalprice);
					preparedStatement.setFloat(2, tax);
					preparedStatement.setInt(3, d);
					preparedStatement.executeUpdate();
					//System.out.println(s1);
					//System.out.println("SELECT count(*) as c FROM Manufacturing m inner join ManDetails md on m.Id=md.MNo where m.Id="+ d);

					st2 = conn.createStatement();
					resultSet = st2.executeQuery("SELECT count(*) as c FROM Manufacturing m inner join ManDetails md on m.Id=md.MNo where m.Id="+ d);

					while (resultSet.next()) {
						int c = resultSet.getInt("c");

						if (c == 0) {
							ps4 = conn.prepareStatement("DELETE FROM Manufacturing WHERE Id = ?");
							ps4.setInt(1, d);
							ps4.executeUpdate();
							//System.out.println("DELETE FROM Manufacturing WHERE Id = " + d);
						}
					}
				}
			}
		}

		response.sendRedirect("editmanindividual.jsp?res=2&branch=" + branch + "&dc=" + dc + "&sd=" + sd);

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		session.setAttribute("map", "");
		try {
			if (st != null)
				st.close();
			if (st2 != null)
				st2.close();
			if (preparedStatement != null)
				preparedStatement.close();
			if (ps != null)
				ps.close();
			if (ps2 != null)
				ps2.close();

			if (ps4 != null)
				ps4.close();
		} catch (SQLException e) {
		}
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
		}
	}
%>