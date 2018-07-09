package dao;

import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;

public class GenericDAOImpl<T> implements GenericDAO<T>{

    private Session session;
    
    @Override
    public void persist(T obj) {
        
        session = util.HibernateUtil.getSessionFactory().openSession();
        Transaction t = null;
        try{
            
            t = session.beginTransaction();
            session.persist(obj);
            t.commit();
   
        }catch(HibernateException e) {
            t.rollback();
            e.printStackTrace();
        }finally{
            session.close();
        }
        
        
        
    }

    @Override
    public void update(T obj) {
           session = util.HibernateUtil.getSessionFactory().openSession();
        Transaction t = null;
        try{
            
            t = session.beginTransaction();
            session.update(obj);
            t.commit();
   
        }catch(HibernateException e) {
            t.rollback();
            e.printStackTrace();
        }finally{
            session.close();
        }
    }

    @Override
    public void delete(T obj) {
           session = util.HibernateUtil.getSessionFactory().openSession();
        Transaction t = null;
        try{
            
            t = session.beginTransaction();
            session.delete(obj);
            t.commit();
   
        }catch(HibernateException e) {
            t.rollback();
            e.printStackTrace();
        }finally{
            session.close();
        }
    }

    @Override
    public List<T> readAll(Class<T> c) {
        
        session = util.HibernateUtil.getSessionFactory().openSession();
        
        try{
            List<T> list = session.createCriteria(c).list();
            return list;
            
        }catch(HibernateException e){
            e.printStackTrace();
        }finally{
            session.close();
        }
        
        return null;
        
    } 
    
}