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
@Table(name = "platforms")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Platforms.findAll", query = "SELECT p FROM Platforms p")
    , @NamedQuery(name = "Platforms.findByPlatformID", query = "SELECT p FROM Platforms p WHERE p.platformID = :platformID")
    , @NamedQuery(name = "Platforms.findByPlatformName", query = "SELECT p FROM Platforms p WHERE p.platformName = :platformName")})
public class Platforms implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "platformID")
    private Integer platformID;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "platformName")
    private String platformName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "platformID")
    private List<Game> gameList;

    public Platforms() {
    }

    public Platforms(Integer platformID) {
        this.platformID = platformID;
    }

    public Platforms(Integer platformID, String platformName) {
        this.platformID = platformID;
        this.platformName = platformName;
    }

    public Integer getPlatformID() {
        return platformID;
    }

    public void setPlatformID(Integer platformID) {
        this.platformID = platformID;
    }

    public String getPlatformName() {
        return platformName;
    }

    public void setPlatformName(String platformName) {
        this.platformName = platformName;
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
        hash += (platformID != null ? platformID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Platforms)) {
            return false;
        }
        Platforms other = (Platforms) object;
        if ((this.platformID == null && other.platformID != null) || (this.platformID != null && !this.platformID.equals(other.platformID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return platformName;
    }

}
