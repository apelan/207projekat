<%@page import="entities.Game"%>
<%@page import="dao.FavouriteDAOImpl"%>
<%@page import="dao.FavouriteDAO"%>
<%@page import="entities.Favourite"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="entities.State"%>
<%@page import="entities.Gender"%>
<%@page import="dao.GenericDAOImpl"%>
<%@page import="dao.GenericDAOImpl"%>
<%@page import="dao.GenericDAO"%>
<%@page import="entities.User"%>
<%@page import="entities.Role"%>
<%@page import="dao.UserDAOImpl"%>
<%@page import="dao.UserDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Favourites</title>
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
            <img class="w3-image" src="res/pics/header.png" alt="Architecture" width="1500" height="600">
            <div class="w3-display-middle w3-margin-top w3-center">
                <h1 class="w3-xxlarge w3-text-white"><span class="w3-padding w3-black w3-opacity-min"><b>Game</b></span> <span class="w3-hide-small w3-text-light-grey">Corner</span></h1>
                <h1><span class="w3-hide-small w3-text-light-grey">Place to find best games</span></h1>
            </div>
        </header>

        <!-- Page content -->
        <div class="w3-content w3-padding" style="max-width:1564px">
            <%
                User user = (User) session.getAttribute("user");
                List<Game> favourites  = null;
                

                //ne mzoe da pristupi ako nije ulogovan,ako je ulogovan ucitava se lista favorita
                if (user == null)
                {
                   %>
                   <jsp:forward page="index.jsp"/>   
                <%}else{ 
                   FavouriteDAO dao = new FavouriteDAOImpl();

                   favourites = dao.getFavGames(user);
    }%>
            <div>    
                <!-- Favourites Section -->
                <div class="w3-container w3-padding-32" id="favourites">
                    <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Favourites</h3>
                </div>
                <%
                    //Prikazuje samo ako lista nije prazna
                    if (!favourites.isEmpty())
                    {
                %>
                <div>
                    <ul style="width: 100%;">  
                        <%    for (Game favGame : favourites)
                            {
                        %> 
                        <li style="width: 50%; float: left;">
                            <%
                                if (favGame.getImage().equals("nopic"))
                                {
                            %>
                            <img src="res/pics/game.png" alt="Game picture" width="200" height="200">
                            <%
                            } else
                            {
                                String imagePathGame = "res\\pics" + favGame.getImage();
                            %>
                            <img width="200" height="200" src="<%= imagePathGame%>" alt="<%= imagePathGame%>">
                            <%  }%>
                            <h4><%= favGame.getGameName() %></h4>
                            <p>Description: <%= favGame.getDescription() %></p>
                            <p >Release date: <%= favGame.getReleaseDate()%></p>
                            <p>Developer: <a href="<%= favGame.getDeveloperID().getWebsite()%>"> <%= favGame.getDeveloperID().getCompanyName()%></a></p>
                            <br>
                            <h4>Tags: <%= favGame.getTypeID().getTypeName()%>, <%= favGame.getGenreID().getGenreName()%></h4>
                            <%
                                if (favGame.getPrice() == 0)
                                {
                            %>
                            <h3 style="color:orange;">FREE</h3>
                            <% } else
                            {%>
                            <h4 style="color:orange;">Price: <%= favGame.getPrice()%>$</h4>
                            <% }%>

                            <!-- SHOW GAMEPLAY/TRAILER-->
                            <form action="home.jsp?action=showGameplay" method="POST">
                                <input type="hidden" name="gameIDshowGameplay" value="<%= favGame.getGameID()%>"/>
                                <input class="w3-button" type="submit" value="Show gameplay">
                            </form>    
                        </li>
                        <%}%> 
                    </ul>
                </div>

                <%} else
                {%>
                <h1>No favourites.</h1>
                <%}%>
            </div> 
        </div> 
        <br>
        <!-- FOOTER ZEZA,NECE LEPO DA SE POSTAVI!-->
        <!-- Footer 
        <footer class="w3-center w3-black w3-padding-16">
            <p>Copyright © NoName 2018</p>
        </footer>  
        -->
    </body>
</html>
