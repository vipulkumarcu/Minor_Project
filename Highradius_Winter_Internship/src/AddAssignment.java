          

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class AddAssignment
 */
@WebServlet("/AddAssignment")
@MultipartConfig(
		  fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		  maxFileSize = 1024 * 1024 * 10,      // 10 MB
		  maxRequestSize = 1024 * 1024 * 100   // 100 MB
		)
public class AddAssignment extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddAssignment() 
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
	        String assignmentName=request.getParameter("asgnName");
	        long millis=System.currentTimeMillis(); 
	        Date submissionDate=new Date(millis);
			String fID=request.getParameter("facultyID");
			String facultyMail=request.getParameter("fMail");
			String sID=request.getParameter("studentID");
			String studentMail=request.getParameter("sMail");
			Part filePart = request.getPart("file");
		    String fileName = filePart.getSubmittedFileName();
		    String filePath="E:\\New\\Highradius_Winter_Internship-20210806T133134Z-001\\Highradius_Winter_Internship\\WebContent\\Assignments\\" + fileName;
		    for (Part part : request.getParts()) {
		      part.write(filePath);
		    }
			PreparedStatement stmt=con.prepareStatement("insert into assignment (`Assignment_Name`, `Faculty_ID`, `Submission_Date`, `Faculty_E-mail`, `Student_ID`, `Student_E-mail`,`File_Path`) values(?,?,?,?,?,?,?)");
			 
			stmt.setString(1,assignmentName);
			stmt.setString(2,fID);
			stmt.setDate(3,submissionDate);
			stmt.setString(4,facultyMail); 
			stmt.setString(5,sID);
			stmt.setString(6,studentMail);
			stmt.setString(7, filePath);
			
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
