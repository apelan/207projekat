package dao;

import entities.Game;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;


public class GameDAOImpl extends GenericDAOImpl<Game> implements GameDAO{

    private Session session;
    
    @Override
    public Game readById(int id) {
        session = util.HibernateUtil.getSessionFactory().openSession();

        try {
            Game g = (Game)session.createCriteria(Game.class).add(Restrictions.eq("gameID", id)).uniqueResult();
            if(g != null){
                return g;
            }

        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            session.close();
        }

        return  null;
    }

}
