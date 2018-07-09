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
@Table(name = "developer")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Developer.findAll", query = "SELECT d FROM Developer d")
    , @NamedQuery(name = "Developer.findByDeveloperID", query = "SELECT d FROM Developer d WHERE d.developerID = :developerID")
    , @NamedQuery(name = "Developer.findByCompanyName", query = "SELECT d FROM Developer d WHERE d.companyName = :companyName")
    , @NamedQuery(name = "Developer.findByWebsite", query = "SELECT d FROM Developer d WHERE d.website = :website")
    , @NamedQuery(name = "Developer.findByContactEmail", query = "SELECT d FROM Developer d WHERE d.contactEmail = :contactEmail")})
public class Developer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "developerID")
    private Integer developerID;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "companyName")
    private String companyName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "website")
    private String website;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "contactEmail")
    private String contactEmail;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "developerID")
    private List<Game> gameList;

    public Developer() {
    }

    public Developer(Integer developerID) {
        this.developerID = developerID;
    }

    public Developer(Integer developerID, String companyName, String website, String contactEmail) {
        this.developerID = developerID;
        this.companyName = companyName;
        this.website = website;
        this.contactEmail = contactEmail;
    }

    public Integer getDeveloperID() {
        return developerID;
    }

    public void setDeveloperID(Integer developerID) {
        this.developerID = developerID;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getContactEmail() {
        return contactEmail;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
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
        hash += (developerID != null ? developerID.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Developer)) {
            return false;
        }
        Developer other = (Developer) object;
        if ((this.developerID == null && other.developerID != null) || (this.developerID != null && !this.developerID.equals(other.developerID))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Developer[ developerID=" + developerID + " ]";
    }

}
