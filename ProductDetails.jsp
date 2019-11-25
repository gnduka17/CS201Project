<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Product Details</title>
	
	
	<link rel="stylesheet" href="main.css">
	<link href="open-iconic/font/css/open-iconic.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<style>
		body {
			margin-top: 100px;
		}
		#back-button {
			position: absolute;
			text-decoration: none;
			color: black;
			font-size: 1.1em;
			margin-left: 50px;
		}
		#main-container {
			padding-top: 100px;
			width: 800px;
			height:200px;
			margin: 0px auto;
		}
		#thumbnail-container {
			float: left;
			width: 200px;
			height: 340px;
		}
		#thumbnailPicture {
			display: block;
			width: 196px;
			height: 276px;
			border: 2px solid black;
			background-color: gray;
		}
		#buyButton {
			margin-top: 20px;
			display: block;
			text-align: center;
			height: 40px;
			width: 194px;
			font-size: 1.2em;
			text-decoration: none;
			font-weight: bold;
			line-height: 40px;
			color: black;
			background-color: white;
			border: 3px solid black;
			transition: all 0.2s;
		}
		#buyButton:hover {
			color: white;
			background-color: black;
		}
		#details-container {
			width: 600px;
			float: right;
		}
		#productName {
			font-size: 2em;
			margin-left: 40px;
			margin-top: 20px;
			font-weight: bold;
		}
		#productSeller, #productCategory, #productCondition, #productDescription, #productPrice {
			margin: 10px 0px 10px 40px;
			font-size: 1.2em;
		}
		.productDetails {
			display: inline;
		}
	</style>
</head>

<%
	int productID = (int)request.getAttribute("productID");
	String name = (String)request.getAttribute("productName");
	String description = (String)request.getAttribute("productDescription");
	double price = (double)request.getAttribute("productPrice");
	String condition = (String)request.getAttribute("productCondition");
	String category = (String)request.getAttribute("productCategory");
	int sellerID = (int)request.getAttribute("sellerID");
	String sellerName = (String)request.getAttribute("sellerName");
	int buyerID = 1;  //get session attribute
%>
<body onload="loadButton()">
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

	<a id="back-button" href="" onclick="history.back()"><span id="backArrow"class="oi" data-glyph="arrow-left"></span> GO BACK</a>

	<div id="main-container">

		<div id="thumbnail-container">
			<img id="thumbnailPicture" src="" alt="thumbnail">
			<a id="buy_button" onclick="addRequest()" style="display:none; border-style:solid; position:relative; top:20px; cursor: pointer;">BUY</a>
			<a id="rem_button" onclick="removeRequest()" style="display:none; border-style:solid; position:relative; top:20px; cursor: pointer;">REMOVE</a>
		</div> <!-- #thumbnail-container -->

		<div id="details-container">
			<div id="productName"><%=name%></div>
			
			<i>
				<div id="productSeller">Seller: 
					<p class="productDetails" id="demo" style="cursor: pointer;"><%=sellerName%></p>
				</div>
			</i>
			
			<div id="productPrice">Price: 
				<p class="productDetails"><%=price%></p>
			</div>

			<div id="productCategory">Category: 
				<p class="productDetails"><%=category%></p>
			</div>

			<div id="productCondition">Condition: 
				<p class="productDetails"><%=condition%></p>
			</div>

			<br>

			<div id="productDescription">Description: 
				<p class="productDetails"><%=description%></p>
			</div>
				
		</div> <!-- #details-container -->

	</div> <!-- #main-container -->

<script>
function loadButton(){
	var xhttp= new XMLHttpRequest();
	var buyerID = <%=buyerID%>;
	var productID = <%=productID%>;
	xhttp.open("GET","CheckRequest?buyerID=" + buyerID + "&productID=" + productID, false);
	xhttp.send();
	if(xhttp.responseText.trim().length>0){  //already exists
		document.getElementById("rem_button").style.display = "inline";
	}
	else{  //doesnt exist 
		document.getElementById("buy_button").style.display = "inline";
	}
}
function addRequest(){
	var logged = <%= session.getAttribute("logged")%>;
	var buyerID = <%=buyerID%>;
	var sellerID = <%=sellerID%>;
	var productID = <%=productID%>;
	if(logged==null || logged==""){  //not logged in
		alert("Need to log in");
	}
	else{   //logged in
		$.ajax({
			url: "UpdateRequest",
			data:{
				buyerID: buyerID,
				sellerID: sellerID,
				productID: productID,
				index: "1"
			},
			success: function(){
				alert("Successfully added");
			}
		})
	}
}
function removeRequest(){
	var buyerID = <%=buyerID%>;
	var sellerID = <%=sellerID%>;
	var productID = <%=productID%>;
	$.ajax({
		url: "UpdateRequest",
		data:{
			buyerID: buyerID,
			sellerID: sellerID,
			productID: productID,
			index: "2"
		},
		success: function(){
			alert("Successfully removed");
		}
	})
}
document.getElementById("demo").addEventListener("click", sendtoUser);
function sendtoUser(){
	var sellerID = <%=sellerID%>;
	console.log(sellerID);
	$.ajax({
		url: "GetUser",
		data:{
			userID: sellerID
		},
		success: function(response){
			$("html").empty();
			$("html").append(response);
		}
	})
}
</script>
</body>
</html>