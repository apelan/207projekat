package dao;

import java.util.List;

public interface GenericDAO<T> {
    
    void persist(T obj);
    void update(T obj);
    void delete(T obj);
    List<T> readAll(Class<T> c); 
    
}
