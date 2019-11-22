<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link class="jsbin" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" /> -->
<script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.0/jquery-ui.min.js"></script>
<meta charset="UTF-8">
<title>Add Item</title>
<style>
#productIMG{
width:50px;
}
#productDesc{
width:180px;
height: 300px;
}
#productName{
width:200px;
}
#price{
width:150px;
}
#conditionDropDown{
width:200px;
}
#categoryDropDown{
width:200px;
}
#leftmost{
float:left;
width:300px;
}
#middle{
float:left;
width:300px;
}
#rightmost{
float:left;
width:300px;
}
#content{
margin-left:auto;
margin-right:auto;
width:920px;
}
#addButt{
height:40px;
width:150px;
}
#blankspot{
margin-top:20px;
width:150px;
height:250px;
background-color:grey;
display:flex;
align-items:center;
justify-content:center;
}
</style>
	<link rel="stylesheet" href="main.css">
	<link href="open-iconic/font/css/open-iconic.css" rel="stylesheet">
</head>

<body>
<div id="navbar">
		<div id="menuToggle">
			<input type="checkbox" id="button" />

			<span></span>
			<span></span>
			<span></span>

			<ul id="menu">
				<a class="menuItem" href="homepage.html"><li>Home</li></a>
				<a class="menuItem" href="profile.html"><li>My Profile</li></a>
				<a class="menuItem" href="addItemPage.jsp"><li>Add Item</li></a>
				<a id="signOutButton" href="#">LOG OUT</a>
			</ul> <!-- #menu -->
		</div> <!-- #menuToggle -->

		

		<form id="searchForm" action = "SearchServlet">
			<input id="searchBar" type="text" name="searchInput" placeholder="Search for products">
			<button id="submit" type="submit" name="submit"><span class="oi" data-glyph="magnifying-glass"></span></button>
		</form>
		
		<a href="notifications.jsp">
			<div id="notificationIcon">
				<span class="oi" data-glyph="bell"></span>
			</div>
		</a>
		
	</div> <!-- #navbar -->
	<h1>Add Item</h1>
<div id = "content">

<form id = addItemForm method="GET" action="insertItemServlet">
<div id="leftmost">
Name<br/>
<input type="text" name = "productName" id="productName"/>
<br/><br/><br/><br/>
Price<br/>
$ <input id="price" type="number" name= "prodprice" min="0.00" step="0.01" max="2500" value="0.00" />
<br/><br/><br/><br/>
Condition<br/>
<select name="condition" id="conditionDropDown">
<option value="selectOne">Select a Condition</option>
<option value="new">New</option>
<option value="good">Good</option>
<option value="used">Used</option>
</select>
<br/><br/><br/><br/>
Category<br/>
<select name="category" id="categoryDropDown">
<option value="selectOne">Select a Category</option>
<option value="books">Textbooks</option>
<option value="furniture">Furniture</option>
<option value="technology">Technology</option>
<option value="tickets">Tickets</option>
<option value="clothing">Clothing/Fashion</option>
<option value="food">Food</option>
<option value="housing">Housing</option>
<option value="other">Misc.</option>
</select>
<br/><br/><br/><br/>
</div>
<div id="middle">
Product Description<br/>
<textarea id="productDesc" name = "productDesc" form ="addItemForm"></textarea>
</div>
<div id="rightmost">
<div id="blankspot">
<img id="productIMG" src="camIMG.png" alt="Upload your Product Image">

</div>



<br/>
<input type="file" onchange="readURL(this);"/>
<br/><br/><br/>

<input id="addButt" type="submit" value="Add Item"/>
</div>

</form>
</div>

</body>
<script>
function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#productIMG')
                .attr('src', e.target.result)
                .width(150)
                .height(250);
        };
        reader.readAsDataURL(input.files[0]);
    }
}
</script>
</html>