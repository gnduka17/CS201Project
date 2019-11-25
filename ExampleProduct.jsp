<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Product Details Page</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<script>
$.ajax({
	type: 'GET',
	url: "GetProductDetails",
	data:{
		productID: "2"
	},
	success: function(html) {
		$("html").empty();
		var $html = $(html);
	    var nonscripts = $html.filter(function() { return !$(this).is('script'); });
	    var scripts = $html.filter(function() { return !$(this).is('script'); });
	    $("html").append(nonscripts).append(scripts);
	}
})
</script>
</body>
</html>