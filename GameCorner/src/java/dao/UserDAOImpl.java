package dao;

import entities.User;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;

public class UserDAOImpl extends GenericDAOImpl<User> implements UserDAO {

    private Session session;

    @Override
    public User checkUser(String username, String password) {
        session = util.HibernateUtil.getSessionFactory().openSession();

        try {

            User u = (User) session.createCriteria(User.class)
                    .add(Restrictions.and(
                            Restrictions.or(
                                    Restrictions.eq("username", username),
                                    Restrictions.eq("email", username)
                            ),
                            Restrictions.eq("password", password)
                    )).uniqueResult();
            if(u != null){
                return u;
            }

        } catch (HibernateException e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return null;
    }
}