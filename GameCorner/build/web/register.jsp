<%@page import="entities.User"%>
<%@page import="entities.Role"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="dao.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<title>Gamery</title>
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
      <a href="#profile" class="w3-bar-item w3-button">Profile</a>
    </div>
  </div>
</div>

<!-- Header -->
<header class="w3-display-container w3-content w3-wide" style="max-width:1500px;" id="home">
  <img class="w3-image" src="res/pics/header.png" alt="Architecture" width="1500" height="600">
  <div class="w3-display-middle w3-margin-top w3-center">
    <h1 class="w3-xxlarge w3-text-white"><span class="w3-padding w3-black w3-opacity-min"><b>Game</b></span> <span class="w3-hide-small w3-text-light-grey">Corner</span></h1>
    <h1><span class="w3-hide-small w3-text-light-grey">Place to find best games</span></h1>
  </div>
</header>

<!-- Page content -->
<div class="w3-content w3-padding" style="max-width:1564px">

  <!-- Profile Section -->
<div class="" id="profile">
	<h3 class="">Profile</h3>
</div>
<div>
    
    <%
            UserDAO userDao = new UserDAOImpl();

            if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action").equals("register")) {
                User u = new User();

                try {
                    Role role = new Role();
                    role.setRoleID(2);
                    u.setRoleID(role);
                    u.setFirstName(request.getParameter("firstName"));
                    u.setLastName(request.getParameter("lastName"));
                    u.setEmail(request.getParameter("email"));
                    u.setUsername(request.getParameter("username"));
                    u.setPassword(request.getParameter("password"));

                    userDao.persist(u);
                    %>
                    <div class="centertext">
                        <p>Registration successful.</p>
                        <h3 class="logreg"> <a href="index.jsp">Login</a> </h3>
                    </div>
                    <%
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
    %>
	<div class="container">
		<h2>Register</h2>
		<form class="form" action="register.jsp?action=register" method="post">
                        <input maxlength="50" type="text" name="firstName" placeholder="First Name" required><br><br>
                        <input maxlength="50" type="text" name="lastName" placeholder="Last Name" required><br><br>
			<input maxlength="50" type="text" name="email" placeholder="Email" required><br><br>
			<input maxlength="50" type="text" name="username" placeholder="Username" required><br><br>
			<input maxlength="50" type="password" name="password" placeholder="Password" required><br><br>
			<button class="w3-button" type="submit" id="login-button">Register</button>
		</form>
		<div class="logreg">
                    <a href="index.jsp">Already have account?</a>
		</div>
	</div>
<!-- End page content -->
</div>
</div>
<!-- Footer -->
<footer class="w3-center w3-black w3-padding-16">
  <p>Copyright © NoName 2018</p>
</footer>
</body>
</html>
