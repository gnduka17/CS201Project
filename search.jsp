<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.HashMap" import="java.util.Iterator" import="java.util.Map;"%>
    
<% 
	HashMap<Integer, Product> results = (HashMap<Integer, Product>)request.getAttribute("results");
%>
    
<!DOCTYPE html>
<html>
<head>
	<title>Search results</title>

	<link rel="stylesheet" href="main.css">
	<link href="open-iconic/font/css/open-iconic.css" rel="stylesheet">

	<style>
		.clearfloat {
			clear: both;
		}
		#topBar {
			width: 1200px;
			margin: 0px auto;
		}
		#searchFor {
			padding-top: 30px;
			margin: 0px 10px 0px 0px;
			display: block;
			font-size: 1.6em;
			font-weight: bold;
			float: left;
		}
		#resultCount {
			padding-top: 40px;
			margin: 0px;
			display: block;
			float: left;
		}
		#filterSearch {
			height: 50px;
			width: 100px;
			border: 1px solid black;
			margin: 20px 0px;
			overflow: hidden;
			line-height: 50px;
			font-size: 1.1em;
			padding: 0px 20px;
			transition: all 0.2s;
		}
		#filterSearch:hover {
			width: 100%;
		}
		#searchFilters {
			margin-left: 30px;
			display: inline;
		}
		#filterIcon {
			display: inline;
			font-size: 0.8em;
			line-height: 50px;
			margin-right: 10px;
		}
		#searchFilters > label {
			margin-left: 10px;
		}

		#main-container {
			width: 1200px;
			margin: 0px auto;
		}
		.searchResult {
			width: 280px;
			height: 420px;
			margin: 8px;
			border: 1px solid white;
			float: left;
			color: black;

		}
		.searchResult:hover {
			margin: 8px;
			border: 1px solid black;
		}
		.productPicture {
			width: 280px;
			height: 280px;
			background-color: whitesmoke;
			float: left;
		}
		.productTitle {
			width: 280px;
			margin: 20px 10px 10px 10px;
			float: left;
			font-size: 1.1em;
		}
		.productSeller {
			color: gray;
			margin: 0px 10px;
			width: 280px;
			float: left;
		}
		.productPrice {
			margin: 10px 10px 20px 10px;
			width: 280px;
			float: left;
			color: gray;
		}
	</style>
</head>

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

	<div id="topBar">
		<div id="topTopBar">
			<p id="searchFor">Results for "test search"</p><p id="resultCount">(6 ITEMS)</p>
		</div>

		<div class="clearfloat"></div>

		<div id="filterSearch">
			<span id="filterIcon" class="oi" data-glyph="ellipses"></span><strong>FILTERS</strong>
			<form id = "searchFilters">
				<label for="priceFilter">PRICE</label>
				<select id="priceFilter">
					<option value="highToLow">HIGH TO LOW</option>
					<option value="lowToHigh">LOW TO HIGH</option>
				</select>

				<label for="nameFilter">NAME</label>
				<select id="nameFilter">
					<option value="aToZ">A TO Z</option>
					<option value="zToA">Z TO A</option>
				</select>
				<label for = "booksCategory">BOOKS</label>
				<input id = "booksCategory" type="checkbox" name="books">
				<label for = "furnitureCategory">FURNITURE</label>
				<input id = "furnitureCategory" type="checkbox" name="furniture">
				<label for = "ticketsCategory">TICKETS</label>
				<input id = "ticketsCategory" type="checkbox" name="tickets">
				<label for = "clothingCategory">CLOTHING</label>
				<input id = "clothingCategory" type="checkbox" name="clothing">
				<label for = "housingCategory">HOUSING</label>
				<input id = "housingCategory" type="checkbox" name="housing">
				<label for = "miscCategory">MISC</label>
				<input id = "miscCategory" type="checkbox" name="misc">
			</form>
		</div> <!-- #filterSearch -->

	</div> <!-- #topBar -->

	<div id="main-container">
		<%
		Iterator resultsIterator = results.entrySet().iterator();  
		while(resultsIterator.hasNext()) {
			Map.Entry mapElement = (Map.Entry)resultsIterator.next(); 
			Product entry = (Product)mapElement.getValue();
			
			int productID = entry.getProductID();
			String productName = entry.getProductName();
			double productPrice = entry.getProductPrice();
			String productCondition = entry.getProductCondition();
			String productDescription = entry.getProductDescription();
			String productCategory = entry.getProductCategory();
			int userID = entry.getUserID();
			String sellerName = entry.getSellerName();
		%>
			<a href="DetailsServlet?productID=<%=productID%>">
			<div class="searchResult">
				<div class="productPicture"></div>
				<p class="productTitle"><%=productName%></p>
				<p class="productSeller"><%=sellerName%></p>
				<p class="productPrice"><%=productPrice%></p>

				<div class="clearfloat"></div>
			</div></a> <!-- #searchResult -->
		<% } %>

	</div> <!-- #main-container -->
</body>
</html>