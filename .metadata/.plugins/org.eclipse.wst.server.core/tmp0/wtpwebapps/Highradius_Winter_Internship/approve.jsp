<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.sql.Date"%>

<%

String su_level=request.getParameter("level");
int u_level=Integer.parseInt(su_level);

String spage=request.getParameter("page");
int npage=0;
npage=Integer.parseInt(spage);

int oid=0;
String str = request.getParameter("order_id_dummy");;


oid=Integer.parseInt(str);


Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");
String sql="UPDATE order_details set Approval_Status='Approved' WHERE Order_ID=?";
PreparedStatement pst = con.prepareStatement(sql);
pst.setInt(1,oid);
pst.executeUpdate();
%>
<jsp:forward page="second.jsp">
   <jsp:param name="page" value="<%=npage %>"/>
   <jsp:param name="level" value="<%=u_level %>"/>
</jsp:forward> 