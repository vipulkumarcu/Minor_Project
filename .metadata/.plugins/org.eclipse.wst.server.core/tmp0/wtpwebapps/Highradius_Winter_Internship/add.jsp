<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.sql.Date"%>
<%

String su_level=request.getParameter("level");
int u_level=Integer.parseInt(su_level);

String spage=request.getParameter("page");
int npage=0;
npage=Integer.parseInt(spage);

String a_status="";
String a_by="";

String order_id1=request.getParameter("order_id");
int o_id=Integer.parseInt(order_id1);

String order_date1=request.getParameter("order_date");

String c_name1=request.getParameter("c_name");

String c_number1=request.getParameter("c_number");
int c_id=Integer.parseInt(c_number1);

String o_amount1=request.getParameter("o_amount");
int order_amt=Integer.parseInt(o_amount1);

String notes_add1=request.getParameter("notes_add");

if(order_amt<=10000)
{
	a_status="Approved";
	a_by="David_Lee";
}
else 
{
	a_status="Awaiting Approval";
}


Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");
String sql="INSERT INTO order_details VALUES (?,?,?,?,?,?,?,?)";
PreparedStatement pst = con.prepareStatement(sql);
pst.setInt(1,o_id);
pst.setString(2,c_name1);
pst.setInt(3,c_id);
pst.setInt(4,order_amt);
pst.setString(5,a_status);
pst.setString(6,a_by);
pst.setString(7,notes_add1);
pst.setDate(8,Date.valueOf(order_date1));
pst.executeUpdate();
%>
<jsp:forward page="second.jsp">
   <jsp:param name="page" value="<%=npage %>"/>
   <jsp:param name="level" value="<%=u_level %>"/>
</jsp:forward> 
<%
%>
