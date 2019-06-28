#!/bin/bash
if [ ! -f "/backup/config" ]
then
sudo borg init -e none /backup
fi

echo "Rentrez l'action souhaitée (list, save, backup ou delete) :"
read action

if test $action = "list"
then
sudo borg list /backup

elif test $action = "save"
then
echo "Entrez le nom que vous voulez donner à votre sauvegarde :"
read nomDeLaSauvegarde
echo "Entrez le chemin du dossier à sauvegarder :"
read cheminDuDossier
sudo borg create /backup::$nomDeLaSauvegarde $cheminDuDossier
sudo borg list /backup
elif test $action = "delete"
then
echo "Entrez le nom de la sauvegarde à supprimer :"
read nomDeLaSauvegarde
sudo borg delete /backup::$nomDeLaSauvegarde
sudo borg list /backup

elif test $action = "backup"
then
echo "Entrez le nom de la sauvegarde à récupérer :"
read nomDeLaSauvegarde
sudo borg extract /backup::$nomDeLaSauvegarde

else
echo "Veuillez rentrez un argument valide !!"
fi
