## Préréquis

- Nodejs : https://nodejs.org/en/
- Système de BDD (MySQLWorkbench, PhpMyAdmin)

## Installer le projet

### Le front-end

Dans le dossier front-end, ouvrir un terminal de commande
- Tapez : "npm install"
- Tapez : "npm run serve"

Ouvrir le navigateur sur le lien donné.

### Le back-end

Dans le dossier back-end

- Créez un fichier .env

- Ajoutez les valeurs suivantes : 
HOST=VotreNomDhote
NAME_DATABASE=VotreNomDeBDD
USER_DATABASE=VotreNomDutilisateurDeBDD
PASSWORD_DATABASE=VotreMotDePasseDeBDD
TOKEN=VotreToken

- Importer les données dans votre système de BDD qui se trouvent dans Docs -> groupomania.sql

Enfin,

1. Ouvrir un terminal de commande dans le dossier backend
2. Tapez : nodemon
