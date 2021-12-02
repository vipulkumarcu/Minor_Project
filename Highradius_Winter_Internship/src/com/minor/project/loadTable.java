package com.minor.project;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class loadTable
 */
@WebServlet("/loadTable")
public class loadTable extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public loadTable() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		response.setContentType("application/json");  
		PrintWriter out = response.getWriter();  
		List<Assignment> list=new ArrayList<Assignment>();
		try 
		{
		Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment_management","root","root");  
        Statement ps=con.createStatement();  
        String username=request.getParameter("username");
        int level=Integer.parseInt(request.getParameter("level"));
        String query="";
        if(level==0) {
        	query="select * from assignment where Student_ID='"+username+"'";
        }
        else if(level==1) {
        	query="select * from assignment where Faculty_ID='"+username+"'";
        }
		ResultSet rs=ps.executeQuery(query);
		while(rs.next())
		 {  
		    Assignment e=new Assignment();  
		    e.setS_No(rs.getString(1));  
		    e.setAssignment_Name(rs.getString(2));
		    e.setSubmission_Date(rs.getString(3));
		    e.setAssigned_Date(rs.getString(4));
		    e.setFaculty_ID(rs.getString(5));
		    e.setFaculty_Email(rs.getString(6));
		    e.setStudent_ID(rs.getString(7));
		    e.setStudent_Email(rs.getString(8));
		    e.setScore(rs.getString(9));
		    e.setFile_Path(rs.getString(10));
		    list.add(e);
		 }
		Gson gson = new Gson();
	    JsonElement element = gson.toJsonTree(list, new TypeToken<List<Assignment>>() {}.getType());
	    JsonArray jsonArray = element.getAsJsonArray();
	    response.getWriter().print(jsonArray);
		}
		
		catch(Exception e) 
		{
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
