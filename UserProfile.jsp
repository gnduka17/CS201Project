<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>User Profile</title>

	<link rel="stylesheet" href="main.css">
	<link href="open-iconic/font/css/open-iconic.css" rel="stylesheet">

	<style>
		#main-container {
			width: 800px;
			margin: 0px auto;
			padding-top: 100px;
		}
		#profile-container {
			width: 600px;
			margin: 0px auto;
		}
		#profilePicture {
			width: 200px;
			height: 200px;
			background-color: gray;
			border-radius: 100px;
			float: left;
		}
		#profileDetails {
			padding-left: 40px;
			width: 360px;
			float: left;
		}
		#profileName {
			font-size: 2.2em;
			font-weight: bold;
			margin-bottom: 20px;
			margin-top: 40px;
		}
		#profileEmail, #profileRating {
			font-size: 1.2em;
			font-weight: bold;
		}
		.details {
			display: inline;
			font-weight: normal;
		}
		#products-container {
			margin-top: 80px;
		}
	</style>

</head>

<%
	String name = (String)request.getAttribute("name");
	String email = (String)request.getAttribute("email");
	double rating = (double)request.getAttribute("rating");
	int userID = (int)request.getAttribute("userID");
%>
<%@ page import="final_project.GetUserItems"%>
<%@ page import="final_project.Product"%>
<%@ page import="java.util.ArrayList" %>
<body>
	
	<div id="navbar">
		<div id="menuToggle">
			<input type="checkbox" id="button" />

			<span></span>
			<span></span>
			<span></span>

			<ul id="menu">
				<a class="menuItem" href="#"><li>Shop Page</li></a>
				<a class="menuItem" href="#"><li>My Profile</li></a>
				<a class="menuItem" href="#"><li>Add Item</li></a>
				<a id="signOutButton" href="#">LOG OUT</a>
			</ul> <!-- #menu -->
		</div> <!-- #menuToggle -->

		<form id="searchForm">
			<input id="searchBar" type="text" name="search" placeholder="Search for products">
			<button id="submit" type="submit" name="submit"><span class="oi" data-glyph="magnifying-glass"></span></button>
		</form>
	</div> <!-- #navbar -->


	<div id="main-container">
		<div id="profile-container">
			<div id="profilePicture">
			</div>

			<div id="profileDetails">
				<p id="profileName"><%=name%></p>

				<div id="profileEmail">Email:
					<p class="details"><%=email%></p>
				</div>

				<div id="profileRating">Rating:
					<p class="details"><%=rating%>/5.0</p>
				</div>
			</div>
		</div>

		<div class="clearfloat"></div>

		<div id="products-container">
			<h2>Products <%=name%> is selling</h2>
			<hr>
			<!-- for loop for all products here -->
			<% 
			GetUserItems user = new GetUserItems();
			ArrayList<Product> items = user.getItems(userID);
			for(int i=0; i<items.size(); i++){
			%>
				<table style="border-bottom: 1px solid black;">
					<div id="profileProducts">
						<tr>
							<td>
								<img src="" alt="Item Picture" style="border-style:solid;">
							</td>
							<td>
								<p id="profileName">Product name: <%=items.get(i).getProductName()%> </p>
								<em>
									<p class="details">Seller: <%=items.get(i).getSellerName()%> </p>
								</em>
								<br>
								<p class="details">Price: <%=items.get(i).getProductPrice()%> </p>
							</td>
						</tr>
					</div> <!-- #profileProducts -->
			<% 
			} 
			%>
				
			</table>
		</div>
	
	</div> <!-- #main-container -->

</body>
</html>