<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*"%>
<%
int f=0;
//Getting username from the UI
String username=request.getParameter("username");

session.putValue("username",username);

//Getting password from the UI
String password=request.getParameter("password");

//Establishing the connection to the data base
Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","root");
Statement st= con.createStatement();

//Selecting the data base of user details 
ResultSet rs=st.executeQuery("select * from user_details where username="+'"'+username+'"'+" AND password="+'"'+password+'"');
try
{
		if(!rs.next())
		{
			out.println("Invalid password or username."); 	
		}
		else
		{
			//Checking the username and password from the data base
			if(rs.getString(3).equals(password)&&rs.getString(2).equals(username))
			{
				int l=0;
				String level="";
				Class.forName("com.mysql.jdbc.Driver");
				java.sql.Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");
				Statement st1= con1.createStatement();
				ResultSet rs1=st1.executeQuery("select user_level from user_details where username="+'"'+username+'"');
				if(rs1.next())
				{
					level=rs1.getString(1);
				}	
				if(level.charAt(6)=='1')
				{
					l=1;	
				}
				else if(level.charAt(6)=='2')
				{
					l=2;
				}
				else if(level.charAt(6)=='3')
				{
					l=3;
				}
				%>
				<jsp:forward page="second.jsp">
				   <jsp:param name="page" value="1"/>
				   <jsp:param name="level" value="<%=l %>"/>
				</jsp:forward> 
				<% 
		}
}

}
catch (Exception e) {
e.printStackTrace();
}
%>
