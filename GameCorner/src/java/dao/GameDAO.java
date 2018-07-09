package dao;

import entities.Game;

public interface GameDAO extends GenericDAO<Game>{
    Game readById(int id);
}
