

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class EditAssignment
 */
@WebServlet("/EditAssignment")
public class EditAssignment extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditAssignment() 
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
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html");  
		PrintWriter out = response.getWriter();  
		try {
		Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment_management","root","root");   
    	int assignmentOrder=Integer.parseInt(request.getParameter("aOrder"));
        String assignmentName2=request.getParameter("asgnName2");
        Date assignedDate=Date.valueOf(request.getParameter("assignedDate"));
		String sID2=request.getParameter("studentID2");
		String studentMail2=request.getParameter("sMail2");
		String facultyMail2=request.getParameter("fMail2");
		String score=request.getParameter("score");

		PreparedStatement stmt=con.prepareStatement("update assignment set Assignment_Name=?, Assigned_Date=?, Student_ID=?, `Student_E-mail`=?, `Faculty_E-mail`=?, Score=? where S_No=?");
		 
		stmt.setString(1,assignmentName2);
		stmt.setDate(2,assignedDate);
		stmt.setString(3,sID2);
		stmt.setString(4,studentMail2); 
		stmt.setString(5,facultyMail2);
		stmt.setString(6,score);
		stmt.setInt(7,assignmentOrder);

		int i=stmt.executeUpdate();   
		  
		con.close();	
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
