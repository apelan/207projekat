package dao;

import entities.User;

public interface UserDAO extends GenericDAO<User>{
    
    User checkUser(String username, String password);
        //TODO: throws user exceptions
}
