<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,java.sql.Date"%>
<%
String su_level=request.getParameter("level");
int u_level=Integer.parseInt(su_level);

String spage=request.getParameter("page");
int npage=0;
npage=Integer.parseInt(spage);

String oid1=request.getParameter("order_id_edit");
int oid=Integer.parseInt(oid1);

String o_amount1=request.getParameter("o_amount_edit");
int order_amt=Integer.parseInt(o_amount1);

String notes=request.getParameter("notes_edit");

String aby = request.getParameter("a_by");

String a_status="Approved";
if(order_amt>10000)
{
	a_status="Awaiting Approval";
}
Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");

String sql="UPDATE order_details set Order_Amount=? , Notes=? , Approved_By=? , Approval_Status=? WHERE Order_ID=?";
PreparedStatement pst = con.prepareStatement(sql);
pst.setInt(1,order_amt);
pst.setString(2,notes);
pst.setString(3,aby);
pst.setString(4,a_status);
pst.setInt(5,oid);
pst.executeUpdate();
%>
<jsp:forward page="second.jsp">
   <jsp:param name="page" value="<%=npage %>"/>
   <jsp:param name="level" value="<%=u_level %>"/>
</jsp:forward> 
<%
%>
    