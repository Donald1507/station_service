CREATE TABLE direction(
   id_direction BIGINT AUTO_INCREMENT,
   nom_direction VARCHAR(255),
   telephone_direction VARCHAR(255),
   adresse_direction VARCHAR(255),
   PRIMARY KEY(id_direction)
);

CREATE TABLE station(
   id_station BIGINT,
   nom_station VARCHAR(255) NOT NULL,
   adresse_station VARCHAR(255) NOT NULL,
   telephone_station VARCHAR(255) NOT NULL,
   type_paiement VARCHAR(255) NOT NULL,
   statutbis_station VARCHAR(255) NOT NULL,
   objectif VARCHAR(255) NOT NULL,
   besoin VARCHAR(255) NOT NULL,
   id_direction BIGINT NOT NULL,
   PRIMARY KEY(id_station),
   FOREIGN KEY(id_direction) REFERENCES direction(id_direction)
);

CREATE TABLE gerant(
   id_gerant BIGINT AUTO_INCREMENT,
   nom_gerant VARCHAR(255) NOT NULL,
   prenom_gerant VARCHAR(255) NOT NULL,
   adresse_gerant VARCHAR(255) NOT NULL,
   telephone_gerant VARCHAR(255) NOT NULL,
   mail_gerant VARCHAR(255),
   login VARCHAR(255) NOT NULL,
   id_station BIGINT NOT NULL,
   PRIMARY KEY(id_gerant),
   UNIQUE(login),
   FOREIGN KEY(id_station) REFERENCES station(id_station)
);

CREATE TABLE cuve(
   id_cuve BIGINT,
   capacite DOUBLE NOT NULL,
   statut VARCHAR(255) NOT NULL,
   id_station BIGINT NOT NULL,
   PRIMARY KEY(id_cuve),
   FOREIGN KEY(id_station) REFERENCES station(id_station)
);

CREATE TABLE produit(
   id_produit BIGINT AUTO_INCREMENT,
   nom VARCHAR(255) NOT NULL,
   reference VARCHAR(255) NOT NULL,
   prix DOUBLE NOT NULL,
   id_cuve BIGINT NOT NULL,
   PRIMARY KEY(id_produit),
   UNIQUE(id_cuve),
   FOREIGN KEY(id_cuve) REFERENCES cuve(id_cuve)
);

CREATE TABLE pompiste(
   Id_pompiste BIGINT AUTO_INCREMENT,
   nom_pompiste VARCHAR(255) NOT NULL,
   prenom_pompiste VARCHAR(255) NOT NULL,
   adrese_pompiste VARCHAR(255) NOT NULL,
   telephone_pompiste VARCHAR(255) NOT NULL,
   id_user BIGINT NOT NULL,
   login VARCHAR(255) NOT NULL,
   statut VARCHAR(255) NOT NULL,
   id_station BIGINT NOT NULL,
   PRIMARY KEY(Id_pompiste),
   FOREIGN KEY(id_station) REFERENCES station(id_station)
);

CREATE TABLE vente(
   Id_vente BIGINT,
   date_vente DATE NOT NULL,
   montant_vente DOUBLE NOT NULL,
   Id_pompiste BIGINT NOT NULL,
   id_station BIGINT NOT NULL,
   PRIMARY KEY(Id_vente),
   FOREIGN KEY(Id_pompiste) REFERENCES pompiste(Id_pompiste),
   FOREIGN KEY(id_station) REFERENCES station(id_station)
);

CREATE TABLE client_gerant(
   id_client_gerant BIGINT AUTO_INCREMENT,
   nom_client VARCHAR(255) NOT NULL,
   prenom_client VARCHAR(255) NOT NULL,
   telephone_client VARCHAR(255) NOT NULL,
   id_station BIGINT NOT NULL,
   PRIMARY KEY(id_client_gerant),
   FOREIGN KEY(id_station) REFERENCES station(id_station)
);

CREATE TABLE banque(
   id_banque BIGINT AUTO_INCREMENT,
   nom_banque VARCHAR(255) NOT NULL,
   adresse_banque VARCHAR(255) NOT NULL,
   id_direction BIGINT NOT NULL,
   PRIMARY KEY(id_banque),
   FOREIGN KEY(id_direction) REFERENCES direction(id_direction)
);

CREATE TABLE fournisseur(
   id BIGINT AUTO_INCREMENT,
   nom_fournisseur VARCHAR(255) NOT NULL,
   telephone_founisseur VARCHAR(255) NOT NULL,
   adresse_fournisseur VARCHAR(255) NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE chauffeur(
   id BIGINT,
   nom_chauffeur VARCHAR(255) NOT NULL,
   prenom_chauffeur VARCHAR(255) NOT NULL,
   telephone_chauffeur VARCHAR(255) NOT NULL,
   id_1 BIGINT NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_1) REFERENCES fournisseur(id)
);

CREATE TABLE stock(
   id BIGINT,
   stock_prod_1 DOUBLE NOT NULL,
   stock_prod_2 DOUBLE NOT NULL,
   id_produit BIGINT NOT NULL,
   Id_vente BIGINT NOT NULL,
   PRIMARY KEY(id),
   UNIQUE(id_produit),
   FOREIGN KEY(id_produit) REFERENCES produit(id_produit),
   FOREIGN KEY(Id_vente) REFERENCES vente(Id_vente)
);

CREATE TABLE client_direction(
   id_client_direction BIGINT AUTO_INCREMENT,
   nom_client VARCHAR(255) NOT NULL,
   prenom_client VARCHAR(255) NOT NULL,
   telephone_client VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_client_direction)
);

CREATE TABLE pompe(
   id_pompe BIGINT,
   libelle VARCHAR(255) NOT NULL,
   statut VARCHAR(255),
   Id_pompiste BIGINT NOT NULL,
   id_cuve BIGINT NOT NULL,
   PRIMARY KEY(id_pompe),
   FOREIGN KEY(Id_pompiste) REFERENCES pompiste(Id_pompiste),
   FOREIGN KEY(id_cuve) REFERENCES cuve(id_cuve)
);

CREATE TABLE camion(
   immatriculation VARCHAR(255),
   capacite BIGINT NOT NULL,
   id BIGINT NOT NULL,
   id_1 BIGINT NOT NULL,
   PRIMARY KEY(immatriculation),
   UNIQUE(id_1),
   FOREIGN KEY(id) REFERENCES chauffeur(id),
   FOREIGN KEY(id_1) REFERENCES fournisseur(id)
);

CREATE TABLE remboursement_gerant(
   id_gerant BIGINT,
   id_client_gerant BIGINT,
   date_remboursement DATE NOT NULL,
   heure_remboursement TIME NOT NULL,
   montant_remboursement DOUBLE NOT NULL,
   reliquat DOUBLE,
   PRIMARY KEY(id_gerant, id_client_gerant),
   FOREIGN KEY(id_gerant) REFERENCES gerant(id_gerant),
   FOREIGN KEY(id_client_gerant) REFERENCES client_gerant(id_client_gerant)
);

CREATE TABLE remboursement_direction(
   id_direction BIGINT,
   id_client_direction BIGINT,
   date_remboursement DATE NOT NULL,
   heure_remboursement TIME NOT NULL,
   montant_remboursement DOUBLE NOT NULL,
   reliquat DOUBLE,
   PRIMARY KEY(id_direction, id_client_direction),
   FOREIGN KEY(id_direction) REFERENCES direction(id_direction),
   FOREIGN KEY(id_client_direction) REFERENCES client_direction(id_client_direction)
);

CREATE TABLE versement(
   id_station BIGINT,
   id_banque BIGINT,
   date_versement DATE NOT NULL,
   heure_versement TIME NOT NULL,
   montant_versement DOUBLE NOT NULL,
   PRIMARY KEY(id_station, id_banque),
   FOREIGN KEY(id_station) REFERENCES station(id_station),
   FOREIGN KEY(id_banque) REFERENCES banque(id_banque)
);

CREATE TABLE credit_gerant(
   id_gerant BIGINT,
   id_client_gerant BIGINT,
   date_credit DATE NOT NULL,
   heure_credit TIME NOT NULL,
   montant_credit DOUBLE NOT NULL,
   PRIMARY KEY(id_gerant, id_client_gerant),
   FOREIGN KEY(id_gerant) REFERENCES gerant(id_gerant),
   FOREIGN KEY(id_client_gerant) REFERENCES client_gerant(id_client_gerant)
);

CREATE TABLE credit_direction(
   id_direction BIGINT,
   id_client_direction BIGINT,
   date_credit DATE NOT NULL,
   heure_credit TIME NOT NULL,
   montant_credit DOUBLE NOT NULL,
   PRIMARY KEY(id_direction, id_client_direction),
   FOREIGN KEY(id_direction) REFERENCES direction(id_direction),
   FOREIGN KEY(id_client_direction) REFERENCES client_direction(id_client_direction)
);

CREATE TABLE livraison(
   id_station BIGINT,
   id BIGINT,
   date_livraison DATE NOT NULL,
   heure_livraison TIME NOT NULL,
   produits_livraison VARCHAR(255),
   quantite_livraison DOUBLE NOT NULL,
   PRIMARY KEY(id_station, id),
   FOREIGN KEY(id_station) REFERENCES station(id_station),
   FOREIGN KEY(id) REFERENCES fournisseur(id)
);

CREATE TABLE commande(
   id_direction BIGINT,
   id BIGINT,
   date_commande DATE NOT NULL,
   heure_commande TIME NOT NULL,
   produits_commande VARCHAR(255) NOT NULL,
   quantitess_commande VARCHAR(255) NOT NULL,
   PRIMARY KEY(id_direction, id),
   FOREIGN KEY(id_direction) REFERENCES direction(id_direction),
   FOREIGN KEY(id) REFERENCES fournisseur(id)
);

CREATE TABLE relever(
   id_pompe BIGINT,
   Id_vente BIGINT,
   index_depart DOUBLE,
   index_fermeture DOUBLE NOT NULL,
   PRIMARY KEY(id_pompe, Id_vente),
   FOREIGN KEY(id_pompe) REFERENCES pompe(id_pompe),
   FOREIGN KEY(Id_vente) REFERENCES vente(Id_vente)
);
