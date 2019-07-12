<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.Arrays"%>
<%@page import="java.sql.*, javax.sql.*, javax.naming.*"%>
<%@ page language="java" import="java.util.*"%>
<%@ page import="java.io.InputStream"%>
<%
	DataSource ds = null;
	Connection connection = null;
	Statement statement = null;
	Statement st = null;
	Statement st2 = null;
	Statement st3 = null;
	PreparedStatement preparedStatement = null;
	PreparedStatement preparedStatement2 = null;
	PreparedStatement preparedStatement3 = null;
	ResultSet resultSet = null;

	String[] code = request.getParameterValues("code");

	String innumber = request.getParameter("dc");
	String date = request.getParameter("sd");

	String[] arrValues = request.getParameterValues("arr");
	String branch = request.getParameter("branch");
	String[] qty = request.getParameterValues("qty");
	String[] totalprice = request.getParameterValues("totalprice");
	String[] taxValues = request.getParameterValues("tax");
	String[] totntax = request.getParameterValues("totntax");
	String total = request.getParameter("ftotal");
	String totalARR = request.getParameter("totalARR");
	String manName = request.getParameter("manName");
	String branchName = branch;
	float[] q = new float[qty.length];

	for (int i = 0; i < qty.length; i++) {
		q[i] = Float.parseFloat(qty[i]);
	}
	float[] tax = new float[taxValues.length];

	for (int i = 0; i < taxValues.length; i++) {
		tax[i] = Float.parseFloat(taxValues[i]);
	}

	float[] arr = new float[arrValues.length];

	for (int i = 0; i < arrValues.length; i++) {
		arr[i] = Float.parseFloat(arrValues[i]);
	}

	float totaltax = Float.parseFloat(total) - Float.parseFloat(totalARR);

	String sqlb = "";
	int updateQuery = 0;

	try {
  
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

		connection = DriverManager.getConnection(url, username, password);

		String id = request.getParameter("pid");

		st2 = connection.createStatement();
		st3 = connection.createStatement();

		int count = code.length;
		String qparts = "";
		String sq = "";
		float ft = 0;
		for (int i = 0; i < count; i++) {

			qparts += " ('" + innumber + "'," + code[i] + "," + q[i] + "," + arr[i] + "," + totalprice[i] + "," + id + "," + tax[i] + ")";

			sq = "INSERT INTO NewInventory (Code, Branch, Quantity) VALUES (?,?,?) ON DUPLICATE KEY UPDATE Quantity=Quantity+?";
			if (branch.equals("Workshop2"))
				branchName = "Workshop";
			//System.out.println("sq: "+sq);
			preparedStatement = connection.prepareStatement(sq);
			preparedStatement.setString(1, code[i]);
			preparedStatement.setString(2, branchName);
			preparedStatement.setFloat(3, q[i]);
			preparedStatement.setFloat(4, q[i]);
			preparedStatement.executeUpdate();

			float LC = arr[i] + tax[i];
			float minp = (float) (0.1 * LC) + LC;

			String s = "UPDATE `CodeList` SET `ARR`=?, `minprice`=?, `LC`=? WHERE Code=?";

			//System.out.println("s: "+s);
			preparedStatement3 = connection.prepareStatement(s);
			preparedStatement3.setString(1, arrValues[i]);
			preparedStatement3.setString(2, String.valueOf(minp));
			preparedStatement3.setString(3, String.valueOf(LC));
			preparedStatement3.setString(4, code[i]);
			preparedStatement3.executeUpdate();

			if (i != (count - 1))
				qparts += ",";

		}

		String isql = "INSERT INTO ManDetails (`InvoiceNo`, `Code`, `Qty`, `ARR`, `TotalPrice`, `Mno`, `Tax`) VALUES" + qparts;
		//System.out.println("isql: "+isql);
		int y = st2.executeUpdate(isql);
		ft += Float.parseFloat(total);
		String s = "UPDATE `Manufacturing` SET `TotalPrice`=`TotalPrice`+?,`Tax`=`Tax`+? WHERE Id=?";

		//System.out.println("s: "+s);
		preparedStatement2 = connection.prepareStatement(s);
		preparedStatement2.setFloat(1, ft);
		preparedStatement2.setFloat(2, totaltax);
		preparedStatement2.setString(3, id);
		preparedStatement2.executeUpdate();

		response.sendRedirect("editmanindividual.jsp?res=1&branch=" + branch + "&dc=" + innumber + "&sd=" + date);

	} catch (Exception ex) {
		out.println("Unable to connect to database.");
		System.out.println(ex);

	} finally {
		try {
			if (st != null)
				st.close();
			if (statement != null)
				statement.close();
			if (st2 != null)
				st2.close();
			if (st3 != null)
				st3.close();
			if (preparedStatement != null)
				preparedStatement.close();
		} catch (SQLException e) {
		}
		try {
			if (connection != null)
				connection.close();
		} catch (SQLException e) {
		}
	}
%>