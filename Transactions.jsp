<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cs201Project.Database" %>
<%@ page import="cs201Project.Transaction" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transactions</title>
	<link rel="stylesheet" href="main.css">
	<link href="open-iconic/font/css/open-iconic.css" rel="stylesheet">
<%
	HttpSession sesh = request.getSession(false);
	int userID = 0;
	if(sesh.getAttribute("userID") != null ) {
		userID = (int)sesh.getAttribute("userID");
	}

	List<Transaction> sellerList = Database.getSellingTransactions((Integer)session.getAttribute("userID"));
	List<Transaction> buyerList = Database.getBuyingTransactions((Integer)session.getAttribute("userID"));
%>
<script>
	function accept(listingID, productID){
		var xhttp = new XMLHttpRequest();
		var link = "TransactionServlet?productID="+productID;
		xhttp.open("POST", link, false);
		xhttp.send();
		if (xhttp.responseText.trim().length > 0) {
			document.getElementById("sellmsg").innerHTML= xhttp.responseText;
			alert(xhttp.responseText);
			document.getElementById(listingID).style.display="none";
			return false;
		}
		return true;
	}
	function reject(listingID, userID, productID, buyerID){
		var xhttp = new XMLHttpRequest();
		var link = "TransactionServlet?productID="+productID+"&buyerID="+buyerID;
		xhttp.open("GET", link, false);
		xhttp.send();
		if (xhttp.responseText.trim().length > 0) {
			document.getElementById("sellmsg").innerHTML= xhttp.responseText;
			alert(xhttp.responseText);
			document.getElementById("p"+listingID+"u"+userID).style.display="none";
			return false;
		}
		return true;
	}
	function cancel(listingID, productID, buyerID){
		var xhttp = new XMLHttpRequest();
		var link = "TransactionServlet?productID="+productID+"&buyerID="+buyerID;
		xhttp.open("GET", link, false);
		xhttp.send();
		if (xhttp.responseText.trim().length > 0) {
			document.getElementById("buymsg").innerHTML= xhttp.responseText;
			alert(xhttp.responseText);
			document.getElementById("b"+listingID).style.display="none";
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<div id="navbar">
		<div id="menuToggle">
			<input type="checkbox" id="button" />

			<span></span>
			<span></span>
			<span></span>

			<ul id="menu">
				<a class="menuItem" href="homepage.jsp"><li>Home</li></a>
				<% if(!username.equalsIgnoreCase("guest")) { %>
					<a class="menuItem" href="GetUser?userID=<%=userID%>" ><li>My Profile</li></a>
					<a class="menuItem" href="addItemPage.jsp"><li>Add Item</li></a>
					<a class="menuItem" href="Transactions.jsp"><li>Transactions</li></a>
					<a id="signOutButton" href="Signout">LOG OUT</a>
				<% } else { %>
					<a id="signOutButton" href="login.jsp">LOG IN</a>
				<% } %>
				
			</ul> <!-- #menu -->
		</div> <!-- #menuToggle -->

		

		<form id="searchForm">
			<input id="searchBar" type="text" name="searchInput" placeholder="Search for products">
			<button id="submit" type="submit" name="submit"><span class="oi" data-glyph="magnifying-glass"></span></button>
		</form>
		
		<a href="notifications.jsp">
			<div id="notificationIcon">
				<span class="oi" data-glyph="bell"></span>
			</div>
		</a>
		
	</div> <!-- #navbar -->
	
	<div style="margin: 10%">
	<h1 style="margin-bottom: 50px"><%=session.getAttribute("name") %>'s transactions</h1>
	<h2>Items I'm Selling</h2>
	<div id="sellmsg" style="color:red"></div>
	<table>
		<tr><th style="padding-right:25em">Item Name</th><th style="padding-right:8em">Price</th><th style="padding-right:10em">Requested By</th></tr>
	<%for(int i = 0; i < sellerList.size(); i++) {%>
		<tr id="<%= i%>"><td><a href="GetProductDetails?productID=<%= sellerList.get(i).getProductID()%>"><%= sellerList.get(i).getProductName()%></a></td><td>$<%= sellerList.get(i).getPrice()%></td>
		<td><table>
		<%
		int j = 0;
		for(Map.Entry<Integer,String> entry : sellerList.get(i).getUser().entrySet()) {%>
			<tr id="p<%=i%>u<%=j%>">
				<td><a href="GetUser?userID=<%= entry.getKey()%>"><%= entry.getValue()%></a></td>
				<td><form action="rating.jsp" onsubmit="accept(<%= i%>,<%= sellerList.get(i).getProductID()%>)">
						<input type="submit" value="Accept">
						<input type="hidden" name="sellerID" value="<%= session.getAttribute("userID")%>">
						<input type="hidden" name="buyerID" value="<%= entry.getKey()%>">
					</form>
					<form action="javascript:void(0);" onsubmit="reject(<%= i%>,<%=j%>,<%= sellerList.get(i).getProductID()%>,<%= entry.getKey()%>)">
						<input type="submit" value="Reject">
					</form>
				</td>
			</tr>
		<%
			j++;
		} %>
		</table></td>
		</tr>
	<%} %>
	</table>
	<h2>Items I'm Buying</h2>
	<div id="buymsg" style="color:red"></div>
	<table>
		<tr><th style="padding-right:25em">Item Name</th><th style="padding-right:8em">Price</th><th style="padding-right:10em">Sold By</th></tr>
	<%for(int i = 0; i < buyerList.size(); i++) {%>
		<tr id="b<%=i%>"><td><a href="GetProductDetails?productID=<%= buyerList.get(i).getProductID()%>"><%= buyerList.get(i).getProductName()%></a></td><td>$<%= buyerList.get(i).getPrice()%></td>
		<td><table>
		<%for(Map.Entry<Integer,String> entry : buyerList.get(i).getUser().entrySet()) {%>
			<tr>
				<td><a href="GetUser?userID=<%= entry.getKey()%>"><%= entry.getValue()%></a></td>
				<td>
					<form action="javascript:void(0);" onsubmit="cancel(<%= i%>,<%= buyerList.get(i).getProductID()%>,<%= entry.getKey()%>)">
						<input type="submit" value="Cancel">
					</form>
				</td>
			</tr>
		<%} %>
		</table></td>
		</tr>
	<%} %>
	</table>
	<%-- <table>
		<tr><th style="padding-right:25em">Item Name</th><th style="padding-right:8em">Price</th><th style="padding-right:10em">Sold By</th></tr>
	<%for(int i = 1; i <= 3; i++) {%>
		<tr><td>Fried Chicken <%=i %></td><td>$<%=i %></td>
		<td><table>
		<%for(int j = 0; j < 3; j++) {%>
		<tr>
			<td>Jack</td>
			<td>
				<form action="rating.jsp" onsubmit="accept()">
					<input type="submit" value="Accept">
				</form>
				<form action="rating.jsp" onsubmit="accept()">
					<input type="submit" value="Reject">
				</form>
			</td>
		</tr>
		<%} %>
		</table></td>
		</tr>
	<%} %>
	</table> --%>
	</div>
</body>
</html>