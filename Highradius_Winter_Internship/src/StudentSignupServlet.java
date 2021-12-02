
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
 * Servlet implementation class StudentSignupServlet
 */
@WebServlet("/StudentSignupServlet")
public class StudentSignupServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentSignupServlet() 
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
		try 
		{
		Class.forName("com.mysql.jdbc.Driver");
    	java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/assignment_management","root","root");   
		String sID=request.getParameter("studentID");
		String studentMail=request.getParameter("sMail");
		String studentGender=request.getParameter("sGender");
		String studentSemester=request.getParameter("sSemester");
		String studentPassword=request.getParameter("sPassword");

		PreparedStatement stmt=con.prepareStatement("insert into student_login (`Student_ID`, `Student_E-mail`, `Gender`, `Semester`, `Password`) values(?,?,?,?,?)");
		 
		stmt.setString(1,sID);
		stmt.setString(2,studentMail); 
		stmt.setString(3,studentGender);
		stmt.setString(4,studentSemester);
		stmt.setString(5,studentPassword);
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
