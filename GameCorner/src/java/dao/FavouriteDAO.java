package dao;

import entities.Favourite;
import entities.Game;
import entities.User;
import java.util.List;

public interface FavouriteDAO extends GenericDAO<Favourite>{
    List<Game> getFavGames(User u);
    Favourite readFavouriteByGameNUser(Game game, User user);
}
