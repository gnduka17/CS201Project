<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Temp</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
<script>
$.ajax({
	url: "GetUser",
	data:{
		userID: "1"
	},
	success: function(response){
		$("html").empty();
		$("html").append(response);
	}
})
</script>
</body>
</html>