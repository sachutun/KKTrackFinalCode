<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Arrays"%>
<%@page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.sql.*"%>
<%@ page language="java" import="java.io.*"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*"%>
<%
	/* String id = request.getParameter("userId"); */

	DataSource ds = null;
	Connection conn = null;
	PreparedStatement preparedStatement = null;
	PreparedStatement preparedStatement2 = null;
	PreparedStatement ps = null;
	PreparedStatement ps2 = null;
	ResultSet resultSet = null;
	Statement st = null;
	Statement st2 = null;
%>
<%
	try {

		String recordToUpdate = request.getParameter("payid");
		String branch = request.getParameter("branch");
		String dc = request.getParameter("dc");
		String tottx = request.getParameter("totaltax");
		String totp = request.getParameter("totalprice");
		String date = request.getParameter("date");
		String manname = request.getParameter("manname");

		String branchName = branch;
		String s1 = "";
		int Pid = 0;
		if (recordToUpdate != null) {
			Pid = Integer.parseInt(recordToUpdate);
		}

		float totaltax = 0;
		if (tottx != null) {
			totaltax = Float.parseFloat(tottx);
		}

		float totalprice = 0;
		if (totp != null) {
			totalprice = Float.parseFloat(totp);
		}

		int code = 0;
		float arr = 0;
		float oarr = 0;
		float oq = 0;
		float nq = 0;
		int manid = 0;

		String s4 = "SELECT * FROM ManDetails WHERE MNo=" + Pid;
		SimpleDateFormat df = new SimpleDateFormat("dd-MM-yyyy");
		Date startDate;

		startDate = df.parse(date);
		String dt = df.format(startDate);
		Date ndate = df.parse(dt);
		String nd = new SimpleDateFormat("yyyy-MM-dd").format(ndate);
 
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
		st2 = conn.createStatement();
		resultSet = st2.executeQuery(s4);

		while (resultSet.next()) {
			int sn = resultSet.getInt("Id");
			String newq = request.getParameter("nq" + sn);
			String newarr = request.getParameter("arr" + sn);
			String oldarr = request.getParameter("oarr" + sn);
			String oldq = request.getParameter("q" + sn);
			String totprice = request.getParameter("tp" + sn);
			String tx = request.getParameter("tax" + sn);
			String mid = request.getParameter("mid" + sn);
			String cod = request.getParameter("code" + sn);
			String oldftp = request.getParameter("otp");

			float tax = 0;
			if (tx != null) {
				tax = Float.parseFloat(tx);
			}
			float diffq = 0;
			code = Integer.parseInt(cod);
			arr = Float.parseFloat(newarr);
			oarr = Float.parseFloat(oldarr);
			oq = Float.parseFloat(oldq);
			nq = Float.parseFloat(newq);
			float oldftotalp = Float.parseFloat(oldftp);
			float newtotalp = 0;
			if (totprice != null) {
				newtotalp = Float.parseFloat(totprice);
			}
			manid = Integer.parseInt(mid);

			//if new quantity> q i.e. more items
			String s3 = "";
			if (nq > oq) {

				diffq = nq - oq;

				s3 = "UPDATE `NewInventory` SET `Quantity`=`Quantity`+ ? WHERE Code=? AND Branch=?";

			} else if (nq < oq) {

				diffq = oq - nq;

				s3 = "UPDATE `NewInventory` SET `Quantity`=`Quantity`- ? WHERE Code=? AND Branch=?";
			}

			st = conn.createStatement();

			s1 = "UPDATE `Manufacturing` SET `TotalPrice`=" + totalprice + ",`Tax`=" + (totaltax) + ", `Date`=" + nd + " WHERE Id="+ Pid;
			String s2 = "UPDATE `ManDetails` SET `TotalPrice`=" + newtotalp + ",`Qty`=" + nq + ",`ARR`=" + arr + ", `Tax`=" + tax + "  WHERE Id=" + manid;
			//System.out.println(s2 + "," + s2);

			preparedStatement = conn.prepareStatement("UPDATE `ManDetails` SET `TotalPrice`=?,`Qty`=?,`ARR`=?,`Tax`=? WHERE Id=?");
			preparedStatement.setFloat(1, newtotalp);
			preparedStatement.setFloat(2, nq);
			preparedStatement.setFloat(3, arr);
			preparedStatement.setFloat(4, tax);
			preparedStatement.setInt(5, manid);
			preparedStatement.executeUpdate();

			float LC = arr + tax;
			float minp = (float) (0.1 * LC) + LC;

			String s = "UPDATE `CodeList` SET `ARR`=?, `minprice`=?, `SUP`=? , `LC`=? WHERE Code=?";
			// System.out.println(s); 
			preparedStatement2 = conn.prepareStatement(s);
			preparedStatement2.setFloat(1, arr);
			preparedStatement2.setFloat(2, minp);
			preparedStatement2.setString(3, manname);
			preparedStatement2.setFloat(4, LC);
			preparedStatement2.setInt(5, code);
			preparedStatement2.executeUpdate();

			if (branch.equals("Workshop2"))
				branchName = "Workshop";
			if (nq != oq) {
				ps2 = conn.prepareStatement(s3);
				ps2.setFloat(1, diffq);
				ps2.setInt(2, code);
				ps2.setString(3, branchName);
				ps2.executeUpdate();

			}

		}

		//System.out.println(s1 + "," + s1);
		ps = conn.prepareStatement("UPDATE `Manufacturing` SET `TotalPrice`=?,`Tax`=?,`Date`=? WHERE Id=?");
		ps.setFloat(1, totalprice);
		ps.setFloat(2, totaltax);
		ps.setString(3, nd);
		ps.setInt(4, Pid);
		ps.executeUpdate();

		response.sendRedirect("editmanindividual.jsp?res=1&branch=" + branch + "&dc=" + dc + "&sd=" + nd);

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
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
		} catch (SQLException e) {
		}
		try {
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
		}
	}
%>