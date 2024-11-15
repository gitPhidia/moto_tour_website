create table circuits (
    id int,
    nom varchar,
    Tarifs float,
    duree varchar,
    participant int,
    moto varchar,
    difficulté varchar,
    photo varchar,
    details varchar,
    remarque varchar
);

create table itinéraire (
    id int,
    idcircuit int,
    itinéraire varchar,
    remarque varchar
);

-- create table site (
--     id int,   
--     nom varchar
-- );

-- create table site_marquant(
--     id integer,
--     idcircuit integer,
--     idsite integer
-- );

create table (
    id integer,
    nom varchar,
);

insert into circuits (nom,tarifs, "durée", moto, "difficulté", photo, details, remarque,inserted_at,updated_at)
	VALUES ('les trois lacs en 6 jours',1890, '6 jours, dont 6 jours de moto, circuit de 900 km', ' KTM 350 – 450', 'Moyen à Difficile', '1.jpg', 
    'Parcours journalier,Région : Hauts plateaux', 'En quête d’aventure, sillonner les toits de Madagascar avec cet enduro de 6 jours sur les pistes des trois lacs. Ce parcours autour des hauts plateaux vous réservera : plusieurs kilomètres de routes, pistes, terres et boues. En partant de la capitale, découvrez la végétation le long de la RN2. Faites des rencontres avec la population aussi hospitalière, et découvrez les spécialités culinaires locales.
     Surtout, sur votre moto, profitez des magnifiques paysages, des rizières, cultures en terrasse et de la vue sur les sentiers volcaniques d’Ampefy.','15-11-2024','15-11-2024');

insert into circuits (nom,tarifs, "durée", moto, "difficulté", photo, details, remarque,inserted_at,updated_at)
	VALUES ('Les 2 lacs en 3 jours',990, '3 jours, dont 3 jours de moto, circuit de 450 km', '  KTM 350 – 450', ' Difficile à très difficile', '2.jpg', 
    'Parcours journalier,Région : Hauts plateaux', 'circuit sur les pistes des deux lacs en trois jours sera une grande aventure et des difficultés destinées aux enduristes confirmés.
Prendre la route pour arriver au bord du lac de Tsiazompaniry, le plus grand lac barrage du pays, puis continuer vers l’Est pour visiter le célèbre lac de Mantasoa et le village,
appréciez chaque instant en découvrant les multiples facettes des hauts plateaux. Pendant ce circuit, vous serez servis par la beauté des paysages naturelles des hautes terres.','15-11-2024','15-11-2024');

insert into circuits (nom,tarifs, "durée", "difficulté", photo, details, remarque,inserted_at,updated_at)
	VALUES ('La piste des Baobabs','3390','10 j - 11nuits (09 jours de moto)','Moyen + à Difficile','3.jpg','SITES MARQUANTS :
Lac de Mantasoa et forêt l’eucalyptus
Ville thermale Antsirabe
Passage du col de l’Itremo
Visite de l’Allée des Baobabs
Visite du parc et de la réserve de Kirindy
Dunes de sable et plages de Salary
 Ifaty – Tuléar
NOS PRESTATIONS COMPRENNENT :

Une KTM 350 EXCF 2017 enduro spécialement préparée pour votre voyage
L’assurance responsabilité civile en cas d’accident avec votre moto
Un guide expérimenté dans l’accompagnement de raids moto
Un véhicule 4*4 d’assistance avec chauffeur transportant vos bagages et l’équipement mécanique
L’hébergement en chambre double/twin (catégorie standard ou supérieure selon votre choix)
Les repas en pension complète (petit-déjeuner et dîner à l’hôtel, paniers-déjeuner pour le repas du midi)
Les droits d’entrée et de guidage pour la visite des parcs et monuments prévus durant votre voyage.
Les transferts aéroport – hôtel
Les taxes et vignettes touristiques.
NOS PRESTATIONS NE COMPRENNENT PAS :

Les assurances personnelles pour votre séjour à Madagascar, telles que l’assurance rapatriement
Les frais de visa
Les vols internationaux et nationaux et les taxes d’aéroport
Une caution de 2 000 euros en chèque ou espèces pour l’utilisation de votre moto
Les repas lors de jours de transfert
Les dépenses personnelles (boissons, pourboires, divers achats)
Les droits d’entrée aux monuments et parcs non prévus dans le programme du voyage.
Tarif sur base d’un groupe de 10 pilotes incluant : le transfert et l’hôtel à l’arrivé de l’aéroport , l’hébergement en pension complète, la location et le carburant de la moto, le guide Moto Accompagnateur, le 4×4 d’assistance avec son carburant et le vol interne province – Tananarive.',
'Bienvenue à Madagascar. Nous réservons ce périple de 9 jours aux motards ayant déjà une expérience de la moto tout-terrain. Aucune notion de vitesse dans nos circuits, mais il faut être d’esprit sportif, et avoir un minimum de technique pour apprécier en toute sécurité la piste et les paysages traversés. 
La variété hors normes de ce parcours Enduro qui part de la capitale Antananarivo située dans les hauts-plateaux, jusqu’aux pistes côtières longeant le Canal du Mozambique, 
justifie les efforts quotidiens. Beau mais pas facile, il faut gérer sur la longueur du circuit les pistes de latérite rouge, 
tantot dur comme du béton, tantot patinoire si la pluie se mêle de la partie, et les pistes de sables qui réclament un peu de technique. 
C’est ce circuit qui est à l’origine de l’Aventure Malgache qui continue depuis 25 ans…','15-11-2024','15-11-2024');

insert into circuits (nom,tarifs, "durée", "difficulté", photo, details, remarque,inserted_at,updated_at)
	VALUES ('Le Sud Sauvage',3690,'11 j - 11 nuits (10 jours de moto)','Très Difficile','4.jpg','SITES MARQUANTS :

Découverte d’Antsirabe
Ambositra capitale de l’artisanat malgache
Réserve de Ranomafana
Canal des Pangalanes
Fort Dauphin
Faux Cap / Lavanono
Réserve naturelle de Tsimanampetsotsa
Anakao
NOS PRESTATIONS COMPRENNENT :

 Une moto enduro spécialement préparée pour votre voyage
 L’assurance responsabilité civile en cas d’accident avec votre moto
Un guide expérimenté dans l’accompagnement de raids moto
Un véhicule 4*4 d’assistance avec chauffeur transportant vos bagages et l’équipement mécanique (pour 5 motard et plus)
L’hébergement en chambre double/twin (catégorie standard ou supérieure selon votre choix)
Les repas en pension complète (petit-déjeuner et dîner à l’hôtel, paniers-déjeuner pour le repas du midi)
Les droits d’entrée et de guidage pour la visite des parcs et monuments prévus durant votre voyage.
Les transferts aéroport – hôtel
Les taxes et vignettes touristiques.
 

NOS PRESTATIONS NE COMPRENNENT PAS :

Les assurances personnelles pour votre séjour à Madagascar, telles que l’assurance rapatriement
Les frais de visa
Les vols internationaux et nationaux et les taxes d’aéroport
Une caution de 1 000 euros en chèque ou espèces pour l’utilisation de votre moto
Les repas lors de jours de transfert
Les dépenses personnelles (boissons, pourboires, divers achats)
 Les droits d’entrée aux monuments et parcs non prévus dans le programme du voyage.
Tarif sur base d’un groupe de 10 pilotes incluant : le transfert et l’hôtel à l’arrivé de l’aéroport , 
l’hébergement en pension complète, la location et le carburant de la moto, le guide Moto Accompagnateur, le 4×4 d’assistance avec son carburant et le vol interne province – Tananarive.',
'Le Sud de Madagascar s’offre à vous : entre ciel et mer, au milieu d’un paysage de bush et de sable semi-désertique, vous découvrirez une culture et une nature à nul autre pareil. 
Cette descente progressive depuis les hautes terres jusqu’aux côtes de l’est vous permettra d’apprécier une multitude de paysages et de types de piste : sable, terre, boue ponctueront un parcours difficile mais somptueux.'