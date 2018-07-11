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
@Table(name = "gametype")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Gametype.findAll", query = "SELECT g FROM Gametype g")
    , @NamedQuery(name = "Gametype.findByTypeID", query = "SELECT g FROM Gametype g WHERE g.typeID = :typeID")
    , @NamedQuery(name = "Gametype.findByTypeName", query = "SELECT g FROM Gametype g WHERE g.typeName = :typeName")})
public class Gametype implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "typeID")
    private Integer typeID;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "typeName")
    private String typeName;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "typeID")
    private List<Game> gameList;

    public Gametype() {
    }

    public Gametype(Integer typeID) {
        this.typeID = typeID;
    }

    public Gametype(Integer typeID, String typeName) {
        this.typeID = typeID;
        this.typeName = typeName;
    }

    public Integer getTypeID() {
        return typeID;
    }

    public void setTypeID(Integer typeID) {
        this.typeID = typeID;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
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
        hash += (typeID != null ? typeID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Gametype)) {
            return false;
        }
        Gametype other = (Gametype) object;
        if ((this.typeID == null && other.typeID != null) || (this.typeID != null && !this.typeID.equals(other.typeID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Gametype[ typeID=" + typeID + " ]";
    }

}
