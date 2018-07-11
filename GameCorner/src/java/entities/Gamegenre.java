package entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;


@Entity
@Table(name = "gamegenre")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Gamegenre.findAll", query = "SELECT g FROM Gamegenre g")
    , @NamedQuery(name = "Gamegenre.findByGenreID", query = "SELECT g FROM Gamegenre g WHERE g.genreID = :genreID")
    , @NamedQuery(name = "Gamegenre.findByGenreName", query = "SELECT g FROM Gamegenre g WHERE g.genreName = :genreName")})
public class Gamegenre implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "genreID")
    private Integer genreID;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "genreName")
    private String genreName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "genreID")
    private List<Game> gameList;

    public Gamegenre() {
    }

    public Gamegenre(Integer genreID) {
        this.genreID = genreID;
    }

    public Gamegenre(Integer genreID, String genreName) {
        this.genreID = genreID;
        this.genreName = genreName;
    }

    public Integer getGenreID() {
        return genreID;
    }

    public void setGenreID(Integer genreID) {
        this.genreID = genreID;
    }

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }

    @XmlTransient
    public List<Game> getGameList() {
        return gameList;
    }

    public void setGameList(List<Game> gameList) {
        this.gameList = gameList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (genreID != null ? genreID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Gamegenre)) {
            return false;
        }
        Gamegenre other = (Gamegenre) object;
        if ((this.genreID == null && other.genreID != null) || (this.genreID != null && !this.genreID.equals(other.genreID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Gamegenre[ genreID=" + genreID + " ]";
    }

}
