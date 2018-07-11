package dao;

import entities.Game;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;


public class GameDAOImpl extends GenericDAOImpl<Game> implements GameDAO{

    private Session session;
    
    @Override
    public Game readById(int id) {
        session = util.HibernateUtil.getSessionFactory().openSession();
        Transaction t = null;
        try {
            t = session.beginTransaction();
            Game g = (Game)session.createCriteria(Game.class).add(Restrictions.eq("gameID", id)).uniqueResult();
            t.commit();
            if(g != null){
                return g;
            }
        } catch (HibernateException e) {
            t.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }

        return  null;
    }

}
