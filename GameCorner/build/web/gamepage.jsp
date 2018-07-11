<%@page import="java.util.List"%>
<%@page import="dao.GenericDAO"%>
<%@page import="dao.GenericDAOImpl"%>
<%@page import="entities.Game"%>
<%@page import="entities.User"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="dao.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<title>Gameplay</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="res/css/style.css">
</head>

<body>
<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <a href="#home" class="w3-bar-item w3-button"><b>Game</b> Corner</a> 
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <a href="home.jsp" class="w3-bar-item w3-button">Back</a>
    </div>
  </div>
</div>

<!-- Header -->
<header class="w3-display-container w3-content w3-wide" style="max-width:1500px;" id="home">
</header>
<% 
    Game gameplayGame = (Game)request.getSession().getAttribute("gameplayGame");
%>
<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:1564px">
    <iframe width="1500" height="900" src="<%= gameplayGame.getVideo() %>"></iframe>
</div>       
<!-- Footer -->
<footer class="w3-center w3-black w3-padding-16">
  <p>Copyright © NoName 2018</p>
</footer>
</body>
</html>
