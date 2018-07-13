<%@page import="dao.FavouriteDAOImpl"%>
<%@page import="dao.FavouriteDAO"%>
<%@page import="entities.Favourite"%>
<%@page import="java.io.File"%>
<%@page import="entities.State"%>
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
<!DOCTYPE jsp>
<html>
    <head>
        <title>Game Corner</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="res/css/style.css">
    </head>
    <body>
        <%
            //Ako nema korisnika vracamo ga na index(login)
            User user = (User) session.getAttribute("user");
            FavouriteDAO favouriteDAO = new FavouriteDAOImpl();
            List<Game> favourites = favouriteDAO.getFavGames(user);

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
                    <%
                        if (user.getRoleID().getRoleID() == 1) {
                    %>
                    <a href="#options" class="w3-bar-item w3-button">Options</a>
                    <% }%>

                    <% if (user.getRoleID().getRoleID() == 2) {%>
                    <a href="favourites.jsp" class="w3-bar-item w3-button">Favourites</a>
                    <%}%>
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
            <div>
                <%
                    //LOGOUT AND REDIRECT TO INDEX(LOGIN) PAGE
                    if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("logout")) {
                        session.invalidate();
                        out.println("Logged out");
                        response.sendRedirect("index.jsp");
                    }

                    GameDAO gameDao = new GameDAOImpl();
                    List<Game> games = gameDao.readAll(Game.class);
//********************* DEFAULT USER ********************* 
                    if (user.getRoleID().getRoleID() == 2) { %>

                <!-- Games Section -->
                <div class="w3-container w3-padding-32" id="games">
                    <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Games</h3>
                </div>
                <%
                    //If there is no games
                    if (games.isEmpty()) {
                %>
                <h1>Sorry. There is no games yet.</h1>
                <%} else {%>

                <div>
                    <ul style="width: 100%;">  
                        <%    for (Game game : games) {
                        %> 
                        <li style="width: 50%; float: left;">
                            <%
                                if (game.getImage().equals("nopic")) {
                            %>
                            <img src="res/pics/game.png" alt="Game picture" width="200" height="200">
                            <%
                            } else {
                                String imagePathGame = "res\\pics" + game.getImage();
                            %>
                            <img width="200" height="200" src="<%= imagePathGame%>" alt="<%= imagePathGame%>">
                            <%  }%>
                            <h4><%= game.getGameName()%></h4>
                            <p>Description: <%= game.getDescription()%></p>
                            <p >Release date: <%= game.getReleaseDate()%></p>
                            <p>Developer: <a href="<%= game.getDeveloperID().getWebsite()%>"> <%= game.getDeveloperID().getCompanyName()%></a></p>
                            <p>Platform: <%= game.getPlatformID().getPlatformName() %></p>
                            <br>
                            <h4>Tags: <%= game.getTypeID().getTypeName()%>, <%= game.getGenreID().getGenreName()%></h4>
                            <%
                                if (game.getPrice() == 0) {
                            %>
                            <h3 style="color:orange;">FREE</h3>
                            <% } else {%>
                            <h4 style="color:orange;">Price: <%= game.getPrice()%>$</h4>
                            <% } %>
                            <%

                            %>
                            <table>
                                <tr>
                                    <td>
                                        <%
                                            //Ako vec nije favorizavana ne prikazujemo dugme "Add to favourites"
                                            if(!favourites.contains(game)){
                                        %>
                                        <form action="home.jsp?action=addFavourite" method="POST">
                                            <input type="hidden" name="gameIDtoFavourite" value="<%= game.getGameID()%>"/>
                                            <input class="w3-button" type="submit" value="Add to favourites">
                                        </form> 
                                        <% //A ako je favorizovana prikazujemo dugme "Remove from favourites"
                                           }else{
                                        %>
                                        <form action="home.jsp?action=removeFavourite" method="POST">
                                            <input type="hidden" name="gameIDtoUnfavourite" value="<%= game.getGameID()%>"/>
                                            <input class="w3-button" type="submit" value="Remove from favourites">
                                        </form> 
                                        <% }%>
                                    </td>
                                    <td>
                                        <!-- SHOW GAMEPLAY/TRAILER-->
                                        <form action="home.jsp?action=showGameplay" method="POST">
                                            <input type="hidden" name="gameIDshowGameplay" value="<%= game.getGameID()%>"/>
                                            <input class="w3-button" type="submit" value="Show gameplay">
                                        </form> 
                                    </td>
                                </tr>        
                            </table>     
                        </li>
                        <%
                                }
                            }%> 

                    </ul>
                </div>
            </div><br>

            <%

                if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addFavourite")) {
                    Favourite favourite = new Favourite();
                    favourite.setGameID(new Game(Integer.parseInt(request.getParameter("gameIDtoFavourite"))));
                    favourite.setUserID(user);
                    favouriteDAO.persist(favourite);
                    response.sendRedirect("home.jsp");
                    response.flushBuffer();
                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("removeFavourite")) {
                    Integer gameIDtoUnfavourite = Integer.parseInt(request.getParameter("gameIDtoUnfavourite"));
                    Game gUnfav = gameDao.readById(gameIDtoUnfavourite);
                    Favourite favToDelete = favouriteDAO.readFavouriteByGameNUser(gUnfav, user);
                    favouriteDAO.delete(favToDelete);
                    response.sendRedirect("home.jsp");
                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("showGameplay")) {
                    Integer id = Integer.parseInt(request.getParameter("gameIDshowGameplay"));
                    Game gameplayGame = gameDao.readById(id);
                    request.getSession().setAttribute("gameplayGame", gameplayGame);
                    response.sendRedirect("gamepage.jsp");
                }
                
//********************* ADMIN ********************* 
            } else if (user.getRoleID().getRoleID() == 1) {
                //logika za dodavanje igre u bazu

                //Dao za svaku klasu da bi izvukao liste iz baze da dodam u select(drop down menu)
                GenericDAO<Developer> gdDeveloper = new GenericDAOImpl<Developer>();
                GenericDAO<Gamegenre> gdGenre = new GenericDAOImpl<Gamegenre>();
                GenericDAO<Gametype> gdType = new GenericDAOImpl<Gametype>();
                GenericDAO<Platforms> gdPlatforms = new GenericDAOImpl<Platforms>();
                GenericDAO<State> gdState = new GenericDAOImpl<State>();

                // Stefan's code <-- Laze :D
                GenericDAO<Gamegenre> gameGenreDAO = new GenericDAOImpl<Gamegenre>();
                GenericDAO<Platforms> platformDAO = new GenericDAOImpl<Platforms>();
                GenericDAO<Gametype> gameTypeDAO = new GenericDAOImpl<Gametype>();
                GenericDAO<Developer> developerDAO = new GenericDAOImpl<Developer>();

                //kreiranje listi iz dao
                List<Developer> developers = gdDeveloper.readAll(Developer.class);
                List<Gamegenre> genres = gdGenre.readAll(Gamegenre.class);
                List<Gametype> types = gdType.readAll(Gametype.class);
                List<Platforms> platforms = gdPlatforms.readAll(Platforms.class);
                List<State> states = gdState.readAll(State.class);

                if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("addgame")) {
                    Game gameToAdd = new Game();
                    gameToAdd.setGameName(request.getParameter("gameName"));
                    gameToAdd.setDescription(request.getParameter("gameDescription"));
                    gameToAdd.setPrice(Double.valueOf(request.getParameter("price")));
                    gameToAdd.setDeveloperID(new Developer(Integer.valueOf(request.getParameter("developer"))));
                    gameToAdd.setGenreID(new Gamegenre(Integer.valueOf(request.getParameter("genre"))));
                    gameToAdd.setTypeID(new Gametype(Integer.valueOf(request.getParameter("type"))));
                    gameToAdd.setPlatformID(new Platforms(Integer.valueOf(request.getParameter("platform"))));
                    gameToAdd.setImage("nopic");
                    gameToAdd.setVideo(request.getParameter("gameVideo"));

                    String date = request.getParameter("releaseDate");
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date d = sdf.parse(date);
                    gameToAdd.setReleaseDate(d);
                    gameDao.persist(gameToAdd);
                    response.sendRedirect("home.jsp");

                } else if (request.getMethod().equalsIgnoreCase("post") && request.getParameter("action") != null && request.getParameter("action").equals("deleteGame")) {
                    Integer id = Integer.parseInt(request.getParameter("gameIDtoDelete"));
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
                    developer.setNumOfEmployees(Integer.parseInt(request.getParameter("numOfEmployees")));
                    developer.setStateID(new State(Integer.parseInt(request.getParameter("state"))));

                    developerDAO.persist(developer);
                    response.sendRedirect("home.jsp");

                }
            %>
            <!-- Options Section -->
            <div class="w3-container w3-padding-32" id="options">
                <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Options</h3>
            </div>
            <%
                //Ako developer,genre,type i platforma ne postoje onda ne dajemo mogucnost da se unosi igra.
                if (!developers.isEmpty() && !genres.isEmpty() && !types.isEmpty() && !platforms.isEmpty()) {
            %>

            <!-- ADD GAMES  UI-->
            <div class="mdivwrapper">
                <div class="mdivcenter">
                    <h1> Add Game </h1>
                    <form id="addGameForm" action="home.jsp?action=addgame" method="POST">
                        <input type="text" name="gameName" placeholder="Game name" required/> <br><br>
                        <textarea maxlength="200" rows="4" cols="50" form="addGameForm" name="gameDescription" required>Game description...</textarea> <br><br>
                        <input type="text" name="gameVideo" placeholder="Video URL(embed)" required/> <br><br>
                        <input type="text" name="price" placeholder="Price" required/> <br><br>
                        <label>Release date: </label>
                        <input type="date" name="releaseDate" required/><br><br>

                        <!-- SELECT DEVELOPER -->
                        <label>Developer: </label>
                        <select name="developer">
                            <%
                                for (Developer dev : developers) {
                            %>
                            <option value="<%= dev.getDeveloperID()%>"><%= dev.getCompanyName()%></option>
                            <% } %>
                        </select> <br><br>

                        <!-- SELECT GENRE -->
                        <label>Genre: </label>
                        <select name="genre">
                            <%
                                for (Gamegenre gen : genres) {
                            %>
                            <option value="<%= gen.getGenreID()%>"><%= gen.getGenreName()%></option>
                            <% } %>
                        </select> <br><br>

                        <!-- SELECT TYPE -->
                        <label>Type: </label> 
                        <select name="type">
                            <%
                                for (Gametype typ : types) {
                            %>
                            <option value="<%= typ.getTypeID()%>"><%= typ.getTypeName()%></option>
                            <% } %>
                        </select> <br><br>

                        <!-- SELECT PLATFORM -->
                        <label>Platform: </label> 
                        <select name="platform">
                            <%
                                for (Platforms plat : platforms) {
                            %>
                            <option value="<%= plat.getPlatformID()%>"><%= plat.getPlatformName()%></option>
                            <% } %>
                        </select> <br><br>
                        <input class="w3-button" type="submit" value="Add game"/>
                    </form>
                </div>
            </div>
            <br>
            <% } else {%>
            <h3>Currently you can't add games.</h3>
            <p>You have first to add platforms,types etc.</p>
            <p>
                Genres: <%= gdGenre.readAll(Gamegenre.class)%><br>
                Platforms: <%= gdPlatforms.readAll(Platforms.class)%><br>
                Types: <%= gdType.readAll(Gametype.class)%><br>
                Developers: <%= gdDeveloper.readAll(Developer.class)%><br>
            </p>
            <%}%>
            <hr>


            <table style="width:100%; border: 1px solid #dddddd; text-align: center; padding: 8px;">
                <tr>
                    <th><h1>Add genre</h1></th>
                    <th><h1>Add platform</h1></th>
                    <th><h1>Add type</h1></th>
                    <th><h1>Add developer</h1></th>
                </tr>
                <tr>
                    <td>
                        <form class="form" method="POST" action="home.jsp?action=addGenre">
                            <input maxlength="50" type="text" name="genre" placeholder="Enter genre " required><br><br>           
                            <button class="w3-button" type="submit" id="login-button">Add genre</button>
                        </form>
                    </td>
                    <td>
                        <form class="form" method="POST" action="home.jsp?action=addPlatform">
                            <input maxlength="50" type="text" name="platform" placeholder="Enter platform " required><br><br>           
                            <button class="w3-button" type="submit" id="login-button">Add platform</button>
                        </form>
                    </td>

                    <td>
                        <form class="form" method="POST" action="home.jsp?action=addGameType">
                            <input maxlength="50" type="text" name="gametype" placeholder="Enter game type " required><br><br>           
                            <button class="w3-button" type="submit" id="login-button">Add game type</button>
                        </form>
                    </td>
                    <td>
                        <form class="form" method="POST" action="home.jsp?action=addDeveloper">
                            <input maxlength="50" type="text" name="company" placeholder="Enter company name " required><br><br> 
                            <input maxlength="50" type="text" name="website" placeholder="Enter developer website" required><br><br> 
                            <input maxlength="50" type="text" name="contactEmail" placeholder="Enter developer email " required><br><br> 
                            <input maxlength="50" type="number" name="numOfEmployees" placeholder="Number of employees" required><br><br>
                            <label>State: </label>
                            <select name="state">
                                <%
                                    for (State s : states) {
                                %>
                                <option value="<%= s.getStateID()%>"><%= s.getStateName()%></option>
                                <%}%>
                            </select>
                            <br><br>
                            <button class="w3-button" type="submit" id="login-button">Add developer</button>
                        </form>
                    </td>
                </tr>

            </table>  
            <!-- Games Section -->
            <div class="w3-container w3-padding-32" id="games">
                <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Games</h3>
            </div>
            <%
                //If there is no games
                if (games.isEmpty()) {
            %>
            <h1>No games.</h1>
            <%} else {
            %>
            <div>
                <ul style="width: 100%;">  
                    <% for (Game game : games) {%>
                    <li style="width: 50%; float: left;">
                        <%
                            if (game.getImage().equals("nopic")) {
                        %>
                        <img width="200" height="200" src="res/pics/game.png" alt="Game">
                        <form action="UploadPictureGame" method="POST" enctype="multipart/form-data">
                            <p>Select image to upload:</p>
                            <input type="hidden" name="gameIDPicUpload" value="<%= game.getGameID()%>">
                            <input type="file" name="image">
                            <input class="w3-button" type="submit" value="Upload">
                            <br><br>
                        </form>
                        <%
                        } else {
                            String imagePathGame = "res\\pics" + game.getImage();
                        %>
                        <img width="200" height="200" src="<%= imagePathGame%>" alt="<%= imagePathGame%>">
                        <% }%>
                        <h4><%= game.getGameName()%></h4>
                        <p>Description: <%= game.getDescription()%></p>
                        <p >Release date: <%= game.getReleaseDate()%></p>
                        <p>Developer: <a href="<%= game.getDeveloperID().getWebsite()%>"> <%= game.getDeveloperID().getCompanyName()%></a></p>
                        <p>Platform: <%= game.getPlatformID().getPlatformName() %></p>
                        <br>
                        <h4>Tags: <%= game.getTypeID().getTypeName()%>, <%= game.getGenreID().getGenreName()%></h4>
                        <%
                            if (game.getPrice() == 0) {
                        %>
                        <h3 style="color:orange;">FREE</h3>
                        <% } else {%>
                        <h4 style="color:orange;">Price: <%= game.getPrice()%>$</h4>
                        <% }%>
                        <form method="POST" action="home.jsp?action=deleteGame">
                            <input type="hidden" name="gameIDtoDelete" value="<%= game.getGameID()%>"/>
                            <input class="w3-button" type="submit" value="Delete game">
                        </form>
                    </li>
                    <%}%>
                </ul>
            </div>
            <%
                }%>
            <%}%>
            <!-- Profile Section -->
            <div class="w3-container w3-padding-32" id="profile">
                <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">Profile</h3>
            </div>
            <div class="profilediv">
                <div class="profilediv">
                    <div class="profilediv">
                        <%
                            if (user.getImage().equals("nopic")) {
                        %>

                        <img src="res/pics/user.png" alt="User" style="width:100%">
                        <form action="UploadPicture" method="POST" enctype="multipart/form-data">
                            <p>Select image to upload:</p>
                            <input type="file" name="image">
                            <input class="w3-button" type="submit" value="Upload">
                            <br><br>
                        </form>
                        <%
                        } else {
                            String imagePath = "res\\pics" + user.getImage();
                        %>
                        <img width="300" height="300" src="<%= imagePath%>" alt="<%= imagePath%>" style="width:100%">
                        <%  }%>
                        <%  //AKo nije admin ne prikazujemo mu favorite. ADmin ne moze da doda favoritne igre,mora da radi svoj posao ;(
                            if(user.getRoleID().getRoleID() == 2){ %>
                        <a href="favourites.jsp"><button class="w3-button">Favourite games</button></a> 
                        <% }%>
                        <h3>${user.firstName} ${user.lastName}</h3>
                        <p class="w3-opacity">${user.username}</p>
                        <p>Email: ${user.email}</p>
                        <p>State: <%= user.getStateID().getStateName()%></p>
                        <%
                            String userGenderText = "";
                            if (user.getGenderID().getGenderID() == 1) {
                                userGenderText = "Male";
                            } else {
                                userGenderText = "Female";
                            }
                        %>
                        <p>Gender: <%= userGenderText%></p>
                        <p>Birth date: ${user.birthDate}</p>
                        <form action="home.jsp?action=logout" method="POST">
                            <p><button type="submit" name="logoutBtn" class="w3-button w3-light-grey w3-block">Logout</button></p>
                        </form>
                    </div>
                </div>
            </div>
            <!-- End page content -->

        </div>

        <!-- Footer -->
        <footer class="w3-center w3-black w3-padding-16">
            <p>Copyright © NoName 2018</p>
        </footer>
    </body>
</html>
