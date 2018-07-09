<%@page import="dao.GameDAOImpl"%>
<%@page import="dao.GameDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page import="entities.Review"%>
<%@page import="entities.Platforms"%>
<%@page import="entities.Gametype"%>
<%@page import="entities.Gamegenre"%>
<%@page import="entities.Developer"%>
<%@page import="java.util.List"%>
<%@page import="dao.GenericDAO"%>
<%@page import="entities.Game"%>
<%@page import="dao.GenericDAOImpl"%>
<%@page import="entities.User"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Game Corner</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="res/css/style.css">
    </head>
    <body>

        <%
            //Ako nema korisnika vracamo ga na index
            User user = (User) session.getAttribute("user");
            if (user == null) {
        %>
        <jsp:forward page="index.jsp"></jsp:forward>
        <%}
        %>

        <!-- Navbar (sit on top) -->
        <div class="w3-top">
            <div class="w3-bar w3-white w3-wide w3-padding w3-card">
                <a href="#home" class="w3-bar-item w3-button"><b>Game</b> Corner</a>
                <!-- Float links to the right. Hide them on small screens -->
                <div class="w3-right w3-hide-small">
                    <a href="#games" class="w3-bar-item w3-button">Games</a>
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

            <!-- Games Section -->
            <div class="w3-container w3-padding-32" id="games">
                <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Games</h3>
            </div>

            <div>
                <table>
                    <%
                        if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("logout")) {
                            session.invalidate();
                            out.println("Logged out");
                            response.sendRedirect("home.jsp");
                        }

                        GameDAO gameDao = new GameDAOImpl();
                        List<Game> games = gameDao.readAll(Game.class);
                        //DEFAULT USER
                        if (user.getRoleID().getRoleID() == 2) {
                            for (Game game : games) {
                    %>
                    <tr>                
                        <td style="border: 1px solid gray; padding: 30px;"> 
                            <h3><%= game.getGameName()%></h3>
                            <p><%= game.getDescription()%></p>
                            <p>Release date: <%= game.getReleaseDate()%></p>
                            <br>
                            <h4><%= game.getTypeID().getTypeName()%> <%= game.getGenreID().getGenreName()%></h4>
                            <%
                                if (game.getPrice() == 0) {
                            %>
                            <h4 class="price">FREE</h4>
                            <% } else {%>
                            <h4 class="price">Price: <%= game.getPrice()%>$</h4>
                            <% } %>
                        </td>
                    </tr>
                    <%
                }%> 
                </table>
            </div>
            <%
                //ADMIN CRUD
            } else if (user.getRoleID().getRoleID() == 1) {
                //logika za dodavanje igre u bazu

                //Dao za svaku klasu da bi izvukao liste iz baze da dodam u select(drop down menu)
                GenericDAO<Developer> gdDeveloper = new GenericDAOImpl<Developer>();
                GenericDAO<Gamegenre> gdGenre = new GenericDAOImpl<Gamegenre>();
                GenericDAO<Gametype> gdType = new GenericDAOImpl<Gametype>();
                GenericDAO<Platforms> gdPlatforms = new GenericDAOImpl<Platforms>();

                // Stefan's code
                GenericDAO<Gamegenre> gameGenreDAO = new GenericDAOImpl<Gamegenre>();
                GenericDAO<Platforms> platformDAO = new GenericDAOImpl<Platforms>();
                GenericDAO<Gametype> gameTypeDAO = new GenericDAOImpl<Gametype>();
                GenericDAO<Developer> developerDAO = new GenericDAOImpl<Developer>();

                //kreiranje listi iz dao
                List<Developer> developers = gdDeveloper.readAll(Developer.class);
                List<Gamegenre> genres = gdGenre.readAll(Gamegenre.class);
                List<Gametype> types = gdType.readAll(Gametype.class);
                List<Platforms> platforms = gdPlatforms.readAll(Platforms.class);

                if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addgame")) {
                    Game gameToAdd = new Game();
                    gameToAdd.setGameName(request.getParameter("gameName"));
                    gameToAdd.setDescription(request.getParameter("gameDescription"));
                    gameToAdd.setPrice(Double.valueOf(request.getParameter("price")));
                    gameToAdd.setReviewID(new Review(1));
                    gameToAdd.setDeveloperID(new Developer(Integer.valueOf(request.getParameter("developer"))));
                    gameToAdd.setGenreID(new Gamegenre(Integer.valueOf(request.getParameter("genre"))));
                    gameToAdd.setTypeID(new Gametype(Integer.valueOf(request.getParameter("type"))));
                    gameToAdd.setPlatformID(new Platforms(Integer.valueOf(request.getParameter("platform"))));

                    String date = request.getParameter("releaseDate");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date d = sdf.parse(date);
                    gameToAdd.setReleaseDate(d);
                    gameDao.persist(gameToAdd);
                    response.sendRedirect("home.jsp");

                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("deletegame")) {
                    Integer id = Integer.parseInt(request.getParameter("gameID"));
                    Game gameToDelete = gameDao.readById(id);
                    gameDao.delete(gameToDelete);
                    response.sendRedirect("home.jsp");
                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addGenre")) {

                    Gamegenre genre = new Gamegenre();

                    genre.setGenreName(request.getParameter("genre"));
                    gameGenreDAO.persist(genre);
                    response.sendRedirect("home.jsp");

                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addPlatform")) {

                    Platforms platform = new Platforms();

                    platform.setPlatformName(request.getParameter("platform"));
                    platformDAO.persist(platform);
                    response.sendRedirect("home.jsp");

                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addGameType")) {

                    Gametype gametype = new Gametype();

                    gametype.setTypeName(request.getParameter("gametype"));
                    gameTypeDAO.persist(gametype);
                    response.sendRedirect("home.jsp");

                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addDeveloper")) {

                    Developer developer = new Developer();

                    developer.setCompanyName(request.getParameter("company"));
                    developer.setWebsite(request.getParameter("website"));
                    developer.setContactEmail(request.getParameter("contactEmail"));

                    developerDAO.persist(developer);
                    response.sendRedirect("home.jsp");

                }


            %>

            <h3 style="color: orange;" > ADD GAME </h3>
            <form id="addGameForm" action="home.jsp?action=addgame" method="POST">
                <input type="text" name="gameName" placeholder="Game name" required/> <br>
                <textarea maxlength="200" rows="4" cols="50" form="addGameForm" name="gameDescription" required>Game description...</textarea> <br>
                <input type="text" name="price" placeholder="Price" required/> <br>
                <label>Release date: </label><br>
                <input type="date" name="releaseDate"/><br>

                <!-- SELECT DEVELOPER -->
                <label>Developer:</label><br>
                <select name="developer">
                    <%                        for (Developer dev : developers) {
                    %>
                    <option value="<%= dev.getDeveloperID()%>"><%= dev.getCompanyName()%></option>
                    <% } %>
                </select> <br>

                <!-- SELECT GENRE -->
                <label>Genre:</label><br>
                <select name="genre">
                    <%
                        for (Gamegenre gen : genres) {
                    %>
                    <option value="<%= gen.getGenreID()%>"><%= gen.getGenreName()%></option>
                    <% } %>
                </select> <br>

                <!-- SELECT TYPE -->
                <label>Type:</label><br>
                <select name="type">
                    <%
                        for (Gametype typ : types) {
                    %>
                    <option value="<%= typ.getTypeID()%>"><%= typ.getTypeName()%></option>
                    <% } %>
                </select> <br>

                <!-- SELECT PLATFORM -->
                <label>Platform:</label><br>
                <select name="platform">
                    <%
                        for (Platforms plat : platforms) {
                    %>
                    <option value="<%= plat.getPlatformID()%>"><%= plat.getPlatformName()%></option>
                    <% } %>
                </select> <br><br>
                <input type="submit" value="Add game"/>
            </form>


            <br>

            <h2>Add Game Genre</h2>
            <form class="form" method="POST" action="home.jsp?action=addGenre">

                <input maxlength="50" type="text" name="genre" placeholder="Enter genre " required><br><br>           
                <button class="w3-button" type="submit" id="login-button">Add genre</button>
            </form>

            <br>

            <h2>Add Platform</h2>
            <form class="form" method="POST" action="home.jsp?action=addPlatform">

                <input maxlength="50" type="text" name="platform" placeholder="Enter platform " required><br><br>           
                <button class="w3-button" type="submit" id="login-button">Add platform</button>
            </form>

            <br>

            <h2>Add Game Type</h2>
            <form class="form" method="POST" action="home.jsp?action=addGameType">

                <input maxlength="50" type="text" name="gametype" placeholder="Enter game type " required><br><br>           
                <button class="w3-button" type="submit" id="login-button">Add game type</button>
            </form>

            <br>

            <h2>Add Developer</h2>
            <form class="form" method="POST" action="home.jsp?action=addDeveloper">

                <input maxlength="50" type="text" name="company" placeholder="Enter company name " required><br><br> 
                <input maxlength="50" type="text" name="website" placeholder="Enter developer website" required><br><br> 
                <input maxlength="50" type="text" name="contactEmail" placeholder="Enter developer email " required><br><br> 
                <button class="w3-button" type="submit" id="login-button">Add developer</button>
            </form>

            <br>                





            <hr>
            <table>
                <% for (Game game : games) {%>
                <tr>
                    <td style="border: 1px solid gray; padding: 30px;"> 
                        <h3><%= game.getGameName()%></h3>
                        <p style=" overflow-wrap: break-word; max-width: 500px;" ><%= game.getDescription()%></p>
                        <p>Release date: <%= game.getReleaseDate()%></p>
                        <br>
                        <h4><%= game.getTypeID().getTypeName()%> <%= game.getGenreID().getGenreName()%></h4>
                        <%
                            if (game.getPrice() == 0) {
                        %>
                        <h4 class="price">FREE</h4>
                        <% } else {%>
                        <h4 class="price">Price: <%= game.getPrice()%>$</h4>
                        <% }%>
                        <form action="home.jsp?action=deletegame" method="POST">
                            <input type="hidden" name="gameID" value="<%= game.getGameID()%>"/>
                            <input type="submit" value="Delete"/>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </table>
            <!-- Profile Section -->
            <div class="w3-container w3-padding-32" id="profile">
                <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Profile</h3>
            </div>
            <div class="profilediv">
                <div class="profilediv">
                    <div class="profilediv">
                        <img src="res/pics/user.png" alt="User" style="width:100%">
                        <h3>${user.username}</h3>
                        <p class="w3-opacity">${user.firstName} ${user.lastName}</p>
                        <p>${user.email}</p>
                        <form action="home.jsp?action=logout" method="POST">
                            <p><button type="submit" name="logoutBtn" class="w3-button w3-light-grey w3-block">Logout</button></p>
                        </form>
                    </div>
                </div>
            </div>
            <!-- End page content -->

            <%
                //LOGOUT

            %>

        </div>

        <!-- Footer -->
        <footer class="w3-center w3-black w3-padding-16">
            <p>Copyright © NoName 2018</p>
        </footer>
    </body>
</html>
