package ma.bankati.dao.creditDao;

import ma.bankati.model.credit.DemandeCredit;
import ma.bankati.model.credit.EtatDemande;

import java.util.List;

public interface IDemandeCreditDao {
    void ajouter(DemandeCredit demande);
    void supprimer(Long id);
    void approuver(Long id);
    void refuser(Long id);
    void updateEtat(Long id, EtatDemande etat);
    DemandeCredit trouverParId(Long id);
    List<DemandeCredit> trouverParUtilisateur(Long userId);
    List<DemandeCredit> listerToutes();
}
