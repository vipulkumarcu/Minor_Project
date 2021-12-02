<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*,java.util.*,com.highradius.internship.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<link type="text/css" href="css/styles1.css" rel="stylesheet">
<script defer src="js/script_add.js"></script>
<script defer src="js/script_edit.js"></script>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>User Level</title>
<link rel="stylesheet" href="css/index.css">
<link rel="stylesheet" href="css/main.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<script type="text/javascript" src="js/materialize.min.js"></script> 
<script src="https://use.fontawesome.com/releases/v5.15.1/js/all.js" data-auto-replace-svg="nest"></script>
<script src="js/search_bar.js"></script>
<script src="js/enable.js"></script>
</head>
<body>
<img class="image1" src="images/hrc-logo.svg" alt="highradius-logo">
<img class="image_ABC" src="images/abc-logo.png" alt="ABC Product">
<br>
<div class="container1" style="border:.4rem solid #e3e5e8; margin: .75rem .75rem .75rem .75rem; padding: 1.25rem;">
<%

//Getting user level from previous page
String su_level=request.getParameter("level");
int u_level=Integer.parseInt(su_level);

//If the user level is 1 then its reflecting add and edit button
if(u_level==1)
{
%>
	<button onclick="togglePopup()" id="buttons">ADD</button>
	<button onclick="togglePopup_edit()" id="buttons1" disabled="disabled" >EDIT</button>
	<div class="search-wrapper">
	 <img src="images/magnifying-glass.svg" class="search-icon"/>
     <input type="text" id="myinput" class="search-input" placeholder="Search" onkeyup="myFunction()" />
    </div>
<%}

//If the user level is 2 or 3 then its reflecting approve and reject button
else
{
    %>
    <button id="buttons1" disabled="disabled" onclick="enableButton_ar()">APPROVE</button>
	<button id="buttons2" disabled="disabled" onClick="enableButton_ar1()">REJECT</button>
	<div class="search-wrapper">
	 <img src="images/magnifying-glass.svg" class="search-icon"/>
     <input type="text" id="myinput" class="search-input" placeholder="Search" onkeyup="myFunction()" />
    </div>
<%} %>

	<br><br>
	
	<table id="mytable" >
	<div class="table">
		<tr class="tbody tr" style="border-bottom: .19rem solid orange;">
			<th>&nbsp;</th>
			<th>Order Date</th>
			<th>Approved By</th>
			<th>Order Id</th>
			<th>Company Name</th>
			<th>Company Id</th>
			<th>Order Amount</th>
			<th>Approval Status</th>
			<th>Notes</th>
		</tr> 
	</div>
	
	<%
	
	//Getting the page no from previous call
	String spageid=request.getParameter("page");
	int pageid=Integer.parseInt(spageid);
	int p=pageid;
	
	if(u_level==1)
	{
	//In one page there are total 8 rows
	int total=8;
	int row_count=0;
	
	//Connecting to data base
	Class.forName("com.mysql.jdbc.Driver");
	java.sql.Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");
	Statement st1= con1.createStatement();
	
	//Counting total number of rows 
	ResultSet rs1=st1.executeQuery("select count(*) from order_details");
	try{
	if(rs1.next())
	{
		//Getting total number of rows 
		row_count=Integer.parseInt(rs1.getString(1));
	}
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	
	if(pageid==1){}  
	else{  
	    pageid=pageid-1;  
	    pageid=pageid*total+1;  
	}
	
	//getting the specific number of records from the data base 
	List<demo1> list=demo2.getRecords(pageid,total,u_level); 
	
	int j=0;
	
	//showing the records in my grid UI
	for(demo1 e:list){
		%>
		<tr class="rows">
		<td><input type="checkbox" name="select" class="chb" id="chb1" onClick="enableButton(<%=j%>,<%=u_level %>)" /></td>
		<td><%= e.getOrder_date() %></td>
		<td><%= e.getApproved_by() %></td>
		<td><%= e.getOrder_id() %></td>
		<td><%= e.getCustomer_name() %></td>
		<td><%= e.getCustomer_id() %></td>
		<td><%= e.getOrder_amount() %></td>
		<td><%= e.getApproval_status() %></td>
		<td><%= e.getNotes() %></td>
		</tr>
		<%
		j++;	
	} 
	
	//Counting total number of pages
	int lim=row_count/total;
	if(row_count%total!=0)
	{
		lim=lim+1;
	}
	int next=p;
	int prev=p;
	
	if(p==1)
		prev=1;
	else
		prev=prev-1;
	
	if(p==lim)
		next=lim;
	else
		next=next+1;
	
	int start=(total*p)-(total-1);
	int end=(total*p);
	
	if(end>row_count)
		end=row_count;
	
	%>
	</table>
	<br>
	<div class="bottom">
    	<button  onclick="window.location.href='second.jsp?page=1&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-double-left" ></i></button> &nbsp;
    	<button onclick="window.location.href='second.jsp?page=<%=prev %>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-left" ></i></button> &nbsp;
    	<span style="font-size:1rem;">page</span>&nbsp;
    	<button disabled="disabled" onclick="window.location.href='second.jsp?page=<%=p%>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;color:black;"><%=p%></button> &nbsp;
    	<span style="font-size:1rem;">of <%=lim%></span>&nbsp;
		<button  onclick="window.location.href='second.jsp?page=<%=next %>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-right" ></i></button> &nbsp;
    	<button onclick="window.location.href='second.jsp?page=<%=lim%>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-double-right" ></i></button> &nbsp; &nbsp;
		
		
		<p style="margin-right:1rem;">Customers <%=start %>-<%=end %> of <%=row_count %></p>
	</div>
<%} 
	else if(u_level==2)
	{
		//In one page there are total 8 rows
		int total=8;
		int row_count=0;
		
		//Connecting to data base
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");
		Statement st1= con1.createStatement();
		
		//Counting total number of rows 
		ResultSet rs1=st1.executeQuery("select count(*) from order_details where Order_Amount between 10000 AND 50001");
		try{
		if(rs1.next())
		{
			//Getting total number of rows 
			row_count=Integer.parseInt(rs1.getString(1));
		}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		if(pageid==1){}  
		else{  
		    pageid=pageid-1;  
		    pageid=pageid*total+1;  
		}
		
		//getting the specific number of records from the data base 
		List<demo1> list=demo2.getRecords(pageid,total,u_level); 
		
		int j=0;
		
		//showing the records in my grid UI
		for(demo1 e:list){
			%>
			<tr class="rows">
			<td><input type="checkbox" name="select" class="chb" id="chb1" onClick="enableButton(<%=j%>,<%=u_level %>)" /></td>
			<td><%= e.getOrder_date() %></td>
			<td><%= e.getApproved_by() %></td>
			<td><%= e.getOrder_id() %></td>
			<td><%= e.getCustomer_name() %></td>
			<td><%= e.getCustomer_id() %></td>
			<td><%= e.getOrder_amount() %></td>
			<td><%= e.getApproval_status() %></td>
			<td><%= e.getNotes() %></td>
			</tr>
			<%
			j++;	
		} 
		
		//Counting total number of pages
		int lim=row_count/total;
		if(row_count%total!=0)
		{
			lim=lim+1;
		}
		int next=p;
		int prev=p;
		
		if(p==1)
			prev=1;
		else
			prev=prev-1;
		
		if(p==lim)
			next=lim;
		else
			next=next+1;
		
		int start=(total*p)-(total-1);
		int end=(total*p);
		
		if(end>row_count)
			end=row_count;
		
		%>
		</table>
		<br>
		<div class="bottom">
	    	<button  onclick="window.location.href='second.jsp?page=1&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-double-left" ></i></button> &nbsp;
	    	<button onclick="window.location.href='second.jsp?page=<%=prev %>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-left" ></i></button> &nbsp;
	    	<span style="font-size:1rem;">page</span>&nbsp;
	    	<button disabled="disabled" onclick="window.location.href='second.jsp?page=<%=p%>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;color:black;"><%=p%></button> &nbsp;
	    	<span style="font-size:1rem;">of <%=lim%></span>&nbsp;
			<button  onclick="window.location.href='second.jsp?page=<%=next %>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-right" ></i></button> &nbsp;
	    	<button onclick="window.location.href='second.jsp?page=<%=lim%>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-double-right" ></i></button> &nbsp; &nbsp;
			
			
			<p style="margin-right:1rem;">Customers <%=start %>-<%=end %> of <%=row_count %></p>
		</div>
	
	<%
	}
	else if(u_level==3)
	{
		//In one page there are total 8 rows
		int total=8;
		int row_count=0;
		
		//Connecting to data base
		Class.forName("com.mysql.jdbc.Driver");
		java.sql.Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/winter_internship","root","atul123@");
		Statement st1= con1.createStatement();
		
		//Counting total number of rows 
		ResultSet rs1=st1.executeQuery("select count(*) from order_details where Order_Amount > 50000");
		try{
		if(rs1.next())
		{
			//Getting total number of rows 
			row_count=Integer.parseInt(rs1.getString(1));
		}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		if(pageid==1){}  
		else{  
		    pageid=pageid-1;  
		    pageid=pageid*total+1;  
		}
		
		//getting the specific number of records from the data base 
		List<demo1> list=demo2.getRecords(pageid,total,u_level); 
		
		int j=0;
		
		//showing the records in my grid UI
		for(demo1 e:list){
			%>
			<tr class="rows">
			<td><input type="checkbox" name="select" class="chb" id="chb1" onClick="enableButton(<%=j%>,<%=u_level %>)" /></td>
			<td><%= e.getOrder_date() %></td>
			<td><%= e.getApproved_by() %></td>
			<td><%= e.getOrder_id() %></td>
			<td><%= e.getCustomer_name() %></td>
			<td><%= e.getCustomer_id() %></td>
			<td><%= e.getOrder_amount() %></td>
			<td><%= e.getApproval_status() %></td>
			<td><%= e.getNotes() %></td>
			</tr>
			<%
			j++;	
		} 
		
		//Counting total number of pages
		int lim=row_count/total;
		if(row_count%total!=0)
		{
			lim=lim+1;
		}
		int next=p;
		int prev=p;
		
		if(p==1)
			prev=1;
		else
			prev=prev-1;
		
		if(p==lim)
			next=lim;
		else
			next=next+1;
		
		int start=(total*p)-(total-1);
		int end=(total*p);
		
		if(end>row_count)
			end=row_count;
		
		%>
		</table>
		<br>
		<div class="bottom">
	    	<button  onclick="window.location.href='second.jsp?page=1&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-double-left" ></i></button> &nbsp;
	    	<button onclick="window.location.href='second.jsp?page=<%=prev %>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-left" ></i></button> &nbsp;
	    	<span style="font-size:1rem;">page</span>&nbsp;
	    	<button disabled="disabled" onclick="window.location.href='second.jsp?page=<%=p%>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;color:black;"><%=p%></button> &nbsp;
	    	<span style="font-size:1rem;">of <%=lim%></span>&nbsp;
			<button  onclick="window.location.href='second.jsp?page=<%=next %>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-right" ></i></button> &nbsp;
	    	<button onclick="window.location.href='second.jsp?page=<%=lim%>&level=<%=u_level %>';" style="background-color: #dbf8ff;border:none;height:1.35rem;width:1.35rem;border-radius:.3rem;"> <i class="fas fa-angle-double-right" ></i></button> &nbsp; &nbsp;
			
			
			<p style="margin-right:1rem;">Customers <%=start %>-<%=end %> of <%=row_count %></p>
		</div>
	<%
	}
%>
</div>
<div class="popup1" id="popup-1">
  <div class="overlay1"></div>
  <div class="content1">
  <form action="add.jsp?page=<%=p %>&level=<%=u_level %>" method="post">
    <div class="modal-header">
	    <div class="title" style="border-bottom: 3px solid #f58442;font-size:20px;margin-bottom:-19px;"><h5 style="color:#a8a7a7;">ADD ORDER</h5></div>
	    <div class="close-btn1" style="margin-top:-18px;" onclick="togglePopup()">&times;</div>
    </div>
    <div class="modal-body">
    <hr style="height:2px;border-width: 0;color:gray;background-color:gray;margin-top: -1.5px;">
    <table >
	   <tr>
		<td style="text-align: left;">Order Id </td>
		<td><input class="oid" id="order_id" name="order_id" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Order Date </td>
		<td><input class="oid" id="order_date" name="order_date" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Customer Name </td>
		<td><input class="oid" id="c_name" name="c_name" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Customer Number </td>
		<td><input class="oid" id="c_number" name="c_number" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Order Amount </td>
		<td><input class="oid" id="o_amount" name="o_amount" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Notes </td>
		<td><input class="oid" id="notes_add" name="notes_add" type="text"></td>
	   </tr>
	  </table>
	  <br>
	  <input id="submit_b" type="submit" value="ADD"> 
    </div>
    </form>
  </div>
</div>
<div class="popup1" id="popup-2">
  <div class="overlay1"></div>
  <div class="content1">
  <form action="edit.jsp?page=<%=p %>&level=<%=u_level %>" method="post">
    <div class="modal-header">
	    <div class="title" style="border-bottom: 3px solid #f58442;font-size:20px;margin-bottom:-30px;"><h5 style="color:#a8a7a7;">EDIT ORDER</h5></div>
	    <div class="close-btn1" style="margin-top:-16px;" onclick="togglePopup_edit()">&times;</div>
    </div>
    <br>
    <hr style="height:2px;border-width: 0;color:gray;background-color:gray;margin-top: -1.5px;">
    <div class="modal-body">
    <table>
	   <tr>
		<td style="text-align: left;">Order Id </td>
		<td><input class="oid" id="order_id_edit" name="order_id_edit" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Order Amount </td>
		<td><input class="oid" id="o_amount_edit" name="o_amount_edit" type="text" onKeyup="approvedBy()"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Notes </td>
		<td><input class="oid" id="notes_edit" name="notes_edit" type="text"></td>
	   </tr>
	   <tr>
		<td style="text-align: left;">Approved By </td>
		<td><input class="oid" id="a_by" name="a_by" type="text"></td>
	   </tr>
	  </table>
	  <br>
	  <input id="submit_b" type="submit" value="SUBMIT"> 
    </div>
    </form>
  </div>
</div>
<form action="approve.jsp?page=<%=p %>&level=<%=u_level %>" id="myForm" method="post">
<input type="hidden" id="order_id_dummy" name="order_id_dummy" type="text">
</form>
<form action="reject.jsp?page=<%=p %>&level=<%=u_level %>" id="rejectForm" method="post">
<input type="hidden" id="order_id_dummy_r" name="order_id_dummy_r" type="text">
</form>
<script>
function enableButton(rowN,level)
{
	var n=rowN;
	var row = document.getElementsByClassName('rows');
	var cb = document.getElementsByClassName('chb');
	if(cb[rowN].checked==false){
		if(rowN%2!=0)
			row[rowN].style = "background-color : #FFFFFF";
		else
			row[rowN].style = "background-color : #dbf8ff";
		document.getElementById("buttons1").disabled = true;
		return;
	}
	for(var i=0;i<row.length;i++){
		if(i%2!=0)
			row[i].style = "background-color : #FFFFFF";
		else
			row[i].style = "background-color : #dbf8ff";
	}
	for(var i=0;i<cb.length;i++){
		cb[i].checked = false;
	}
	cb[rowN].checked = true;
	row[rowN].style = "background-color : #fed8b1";
	document.getElementById("buttons1").disabled = false;
	document.getElementById('order_id_edit').value = (row[rowN].getElementsByTagName('td')[3]).textContent;
	document.getElementById('order_id_dummy').value = (row[rowN].getElementsByTagName('td')[3]).textContent;
	document.getElementById('order_id_dummy_r').value = (row[rowN].getElementsByTagName('td')[3]).textContent;
	if (level==2 || level==3)
	           document.getElementById("buttons2").disabled = false;
}
function approvedBy()
{
	var val = document.getElementById('o_amount_edit').value;
	if(val<=10000)
		document.getElementById('a_by').value = "David_Lee";
	else if(val<=50000)
		document.getElementById('a_by').value = "Laura_Smith";
	else
		document.getElementById('a_by').value = "Mathhew_Vance";
}

</script>
</body>
</html>
