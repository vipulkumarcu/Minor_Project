package com.minor.project;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;  
import java.util.ArrayList;  
import java.util.List;

/**
 * Servlet implementation class FacultyLoginServlet
 */
@WebServlet("/FacultyLoginServlet")
public class FacultyLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FacultyLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html");  
		PrintWriter out = response.getWriter();  
		try {
		Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment_management","root","root");  
        Statement ps=con.createStatement();  
        String username=request.getParameter("fusername");
        //System.out.println(username);
		String password=request.getParameter("fpassword");
		ResultSet rs=ps.executeQuery("select * from faculty_login where Faculty_ID='"+username+"' and Password="+password);
		
		if(rs.next()) {
			response.sendRedirect("Assignment_Dashboard.html?username="+username+"&level=1");
		}
		else {
			response.sendRedirect("Login.html?flag=1");
		}
		
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
