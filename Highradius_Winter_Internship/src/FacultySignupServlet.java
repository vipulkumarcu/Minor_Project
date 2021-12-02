

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FacultySignupServlet
 */
@WebServlet("/FacultySignupServlet")
public class FacultySignupServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FacultySignupServlet() 
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
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		response.setContentType("text/html");  
		PrintWriter out = response.getWriter();  
		try 
		{
		Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment_management","root","root");   
		String fID=request.getParameter("facultyID");
		String facultyMail=request.getParameter("fMail");
		String facultyGender=request.getParameter("fGender");
		String facultyPassword=request.getParameter("fPassword");

		PreparedStatement stmt=con.prepareStatement("insert into faculty_login (`Faculty_ID`, `Faculty_E-mail`, `Gender`, `Password`) values(?,?,?,?)");
		 
		stmt.setString(1,fID);
		stmt.setString(2,facultyMail); 
		stmt.setString(3,facultyGender);
		stmt.setString(4,facultyPassword);
		
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
