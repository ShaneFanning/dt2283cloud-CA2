<%@ page contentType="text/html;charset=UTF-8" session="true" language="java" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory"%>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService"%> 
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="java.io.IOException"%>
<%@ page import="java.security.Principal"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.jdo.Query" %> 
<%@ page import="ie.dit.fanning.shane.DBInfo" %>
<%@ page import="ie.dit.fanning.shane.PMF" %>
<%@ page import="ie.dit.fanning.shane.Picture" %>
<%@ page import="javax.jdo.PersistenceManager" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService(); %>

<% UserService userService = UserServiceFactory.getUserService(); %>
<% Principal myPrincipal = request.getUserPrincipal(); %>
<% String emailAddress = null; %>

<% String thisURL = request.getRequestURI(); %>
<% String URL = userService.createLoginURL(thisURL); %>

<!DOCTYPE html>
<html>
	<head>
		<title>PictureBox</title>
 	</head>
 	<body>
 		<h1>HomePage</h1>
 		<div id="login">
			<% String username = null; %>
			<%try
			{
				username = myPrincipal.getName();
			}
			catch(NullPointerException e)
			{
				username = "Guest";
			}%>
			

			<% if (username == "Guest") 
			{%>
				<b>You are not Logged in!<b><br>
				<a id="links" href="<%= userService.createLoginURL(URL).toString() %>"><b>Login</b></a><br>
		  	<%}
			else 
		  	{%>
		  		Logged in as <%= "<b>" + username + "</b>" %><br>
				<a id="links" href="<%= userService.createLogoutURL(URL).toString() %>"><b>Logout</b></a><br>
			<%} %>
		</div>
		
		<div>
			<%if (username != "Guest")
			{%>
				<form action="<%= blobstoreService.createUploadUrl("/addpicture") %>"method="post" enctype="multipart/form-data">
					<input type="file" accept="image/*" name="myPicture">
					Private Image <input type="checkbox" name="Private" value="private"
					<%if(userService.isUserAdmin()) out.println("checked"); %>><br>
					<input type="submit" value="AddPicture"></form>
			<%}%>
		</div>
		<div>
			<%
				PersistenceManager pm = PMF.get().getPersistenceManager();  
			  	Query query = pm.newQuery("select from " + Picture.class.getName());  
			  	List<Picture> pictures = (List<Picture>) query.execute(); 
			  	if (pictures.isEmpty())
			  	{
			%>
			
			<table class="items">    
			  	<tr class="lightBlue"><td class="actions" colspan=100%>  
			   		<p>No items were found.</p>  
			  	</td></tr>  
			</table>	<%
				}
				else
				{   
					  int row = 0;  
					  String rowClass = null;  
					for (Picture i : pictures)   
		            {  
						if (i.getPriv() == true && username != "Guest")
						{%>
							<A href="<%= "/serve?blob-key=" + i.getImgKey() %>">
							<img id="img" src="<%= "/serve?blob-key=" + i.getImgKey() %>"/></a><br>
						<%}  
					}
				}%>  
			</div>
 	</body> 
</html>