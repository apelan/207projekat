package dao;

import entities.Favourite;
import entities.Game;
import entities.User;
import java.util.ArrayList;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import util.HibernateUtil;

public class FavouriteDAOImpl extends GenericDAOImpl<Favourite> implements FavouriteDAO {

    private Session session;

    @Override
    public List<Game> getFavGames(User u) {
        session = HibernateUtil.getSessionFactory().openSession();
        List<Game> games = new ArrayList<>();

        try {
            List<Favourite> favs = session.createCriteria(Favourite.class).add(Restrictions.eq("userID", u)).list();

            for (Favourite f : favs) {
                games.add((Game) session.createCriteria(Game.class).add(Restrictions.eq("gameID", f.getGameID().getGameID())).uniqueResult());
            }
            
            return games;
        } catch (HibernateException ex) {
            ex.printStackTrace();
        } finally {
            session.close();
        }
        
        return null;
    }
    
    @Override
    public Favourite readFavouriteByGameNUser(Game game, User user){
        session = HibernateUtil.getSessionFactory().openSession();
        Transaction t = null;

        try {
            t = session.beginTransaction();
            Favourite f = (Favourite)session.createCriteria(Favourite.class)
                    .add(Restrictions.and(Restrictions.eq("gameID", game), Restrictions.eq("userID", user))).uniqueResult();
            t.commit();
            return f;
        } catch (HibernateException x) {
            t.rollback();
            System.out.println(x.getMessage());
        } finally {
            session.close();
        }
        
        return null;
    }
}
