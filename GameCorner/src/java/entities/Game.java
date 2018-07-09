package entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


@Entity
@Table(name = "game")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Game.findAll", query = "SELECT g FROM Game g")
    , @NamedQuery(name = "Game.findByGameID", query = "SELECT g FROM Game g WHERE g.gameID = :gameID")
    , @NamedQuery(name = "Game.findByGameName", query = "SELECT g FROM Game g WHERE g.gameName = :gameName")
    , @NamedQuery(name = "Game.findByDescription", query = "SELECT g FROM Game g WHERE g.description = :description")
    , @NamedQuery(name = "Game.findByPrice", query = "SELECT g FROM Game g WHERE g.price = :price")
    , @NamedQuery(name = "Game.findByReleaseDate", query = "SELECT g FROM Game g WHERE g.releaseDate = :releaseDate")})
public class Game implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "gameID")
    private Integer gameID;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "gameName")
    private String gameName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "description")
    private String description;
    @Basic(optional = false)
    @NotNull
    @Column(name = "price")
    private double price;
    @Basic(optional = false)
    @NotNull
    @Column(name = "releaseDate")
    @Temporal(TemporalType.DATE)
    private Date releaseDate;
    @JoinColumn(name = "genreID", referencedColumnName = "genreID")
    @ManyToOne(optional = false)
    private Gamegenre genreID;
    @JoinColumn(name = "platformID", referencedColumnName = "platformID")
    @ManyToOne(optional = false)
    private Platforms platformID;
    @JoinColumn(name = "developerID", referencedColumnName = "developerID")
    @ManyToOne(optional = false)
    private Developer developerID;
    @JoinColumn(name = "typeID", referencedColumnName = "typeID")
    @ManyToOne(optional = false)
    private Gametype typeID;
    @JoinColumn(name = "reviewID", referencedColumnName = "reviewID")
    @ManyToOne(optional = false)
    private Review reviewID;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "gameID")
    private List<Favourite> favouriteList;

    public Game() {
    }

    public Game(Integer gameID) {
        this.gameID = gameID;
    }

    public Game(Integer gameID, String gameName, String description, double price, Date releaseDate) {
        this.gameID = gameID;
        this.gameName = gameName;
        this.description = description;
        this.price = price;
        this.releaseDate = releaseDate;
    }

    public Integer getGameID() {
        return gameID;
    }

    public void setGameID(Integer gameID) {
        this.gameID = gameID;
    }

    public String getGameName() {
        return gameName;
    }

    public void setGameName(String gameName) {
        this.gameName = gameName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public Gamegenre getGenreID() {
        return genreID;
    }

    public void setGenreID(Gamegenre genreID) {
        this.genreID = genreID;
    }

    public Platforms getPlatformID() {
        return platformID;
    }

    public void setPlatformID(Platforms platformID) {
        this.platformID = platformID;
    }

    public Developer getDeveloperID() {
        return developerID;
    }

    public void setDeveloperID(Developer developerID) {
        this.developerID = developerID;
    }

    public Gametype getTypeID() {
        return typeID;
    }

    public void setTypeID(Gametype typeID) {
        this.typeID = typeID;
    }

    public Review getReviewID() {
        return reviewID;
    }

    public void setReviewID(Review reviewID) {
        this.reviewID = reviewID;
    }

    @XmlTransient
    public List<Favourite> getFavouriteList() {
        return favouriteList;
    }

    public void setFavouriteList(List<Favourite> favouriteList) {
        this.favouriteList = favouriteList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (gameID != null ? gameID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Game)) {
            return false;
        }
        Game other = (Game) object;
        if ((this.gameID == null && other.gameID != null) || (this.gameID != null && !this.gameID.equals(other.gameID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Game[ gameID=" + gameID + " ]";
    }

}
