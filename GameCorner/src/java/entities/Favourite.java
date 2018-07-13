package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;


@Entity
@Table(name = "favourite")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Favourite.findAll", query = "SELECT f FROM Favourite f")
    , @NamedQuery(name = "Favourite.findByFavouriteID", query = "SELECT f FROM Favourite f WHERE f.favouriteID = :favouriteID")})
public class Favourite implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "favouriteID")
    private Integer favouriteID;
    @JoinColumn(name = "userID", referencedColumnName = "userID")
    @ManyToOne(optional = false)
    private User userID;
    @JoinColumn(name = "gameID", referencedColumnName = "gameID")
    @ManyToOne(optional = false)
    private Game gameID;

    public Favourite() {
    }

    public Favourite(Integer favouriteID) {
        this.favouriteID = favouriteID;
    }

    public Integer getFavouriteID() {
        return favouriteID;
    }

    public void setFavouriteID(Integer favouriteID) {
        this.favouriteID = favouriteID;
    }

    public User getUserID() {
        return userID;
    }

    public void setUserID(User userID) {
        this.userID = userID;
    }

    public Game getGameID() {
        return gameID;
    }

    public void setGameID(Game gameID) {
        this.gameID = gameID;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (favouriteID != null ? favouriteID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Favourite)) {
            return false;
        }
        Favourite other = (Favourite) object;
        if ((this.favouriteID == null && other.favouriteID != null) || (this.favouriteID != null && !this.favouriteID.equals(other.favouriteID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return gameID.getGameName() + " is favourized by " + userID.getUsername();
    }
    
}
