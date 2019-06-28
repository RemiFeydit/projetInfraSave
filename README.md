# Projet Infra SI Sauvegarde
FEYDIT Rémi
ANDRE-BRENNER Eve

**ATTENTION!!!**

Toutes les étapes à suivre pour ce projet doivent être faites sur Ubuntu !
# Installation NFS (dossier partagé)
---
### I) Pré-requis

#### 1) Matériel
Il vous faut disposer de 2 machines (machines physiques ou machines virtuelles)

#### 2) Avoir les droits d'administration sur les deux machines

Il vous faut pouvoir installer des paquets et pouvoir utiliser la commande `sudo`

#### 3) Avoir une connexion SSH

Il vous faut pouvoir ping les deux machines entre elle via le nom de domaine. Il vous faut assigner aux ip de votre carte en `host-only`un nom de domaine.

## II) Création d'un serveur NFS

Toutes les instructions qui vont suivre seront à faire sur le serveur.
### 1) Installer `nfs-kernel-server` 

Pour commencer la configuration de la machine qui vous servira de server, il faut que vous installiez le paquet `nfs-kernel-server` :
```bash
sudo apt install nfs-kernel-server
```
### 2) Configuration

La configuration d'une 'export' NFS se fait en éditant le fichier `/etc/exports`

```
/Dossier/à/partager <nom client>(rw, sync, no_subtree_check)
```
`rw` : permet la lecture et l'écriture sur un partage pour l'hôte défini (par défaut, les partages sont en mode ro; c'est-à-dire en lecture seule).

`sync` : est le contraire de async. Le serveur NFS respecte le protocole NFS.

`no_subtree_check`: Cette option neutralise la vérification de sous-répertoires, ce qui a des subtiles implications au niveau de la sécurité, mais peut améliorer la fiabilité dans certains cas.

### 3) Relancer le service

Après avoir éditer le `/etc/exports`, il suffit de relancer le service nfs
```bash
sudo service nfs-kernel-server reload
```
Et pour vérifier que l'export a bien eu lieu :
```bash
showmount -e
```


## III) Client NFS

### 1) Installer `nfs-common`

Pour commencer la configuration de la machine qui vous servira de client, il faut que vous installiez le paquet `nfs-common` :
```bash
sudo apt install nfs-common
```
### 2) Configuration

Il va d'abord falloir créer un dossier dans lequel NFS viendra se loger, pour que le script de sauvegarde marche il faudra que le dossier soit sur le chemin `/backup`
Donc tapez :
```bash
sudo mkdir /backup
```
Puis ensuite éditez le fichier `/etc/fstab` :
```
<nom de dommaine du serveur>:/backup /backup nfs defaults, user, auto, noatime, bg 0 0
```

# Borg

Sur le client, vous devez installer `borgbackup` :
```
sudo apt install borgbackup
```

Il ne vous reste plus qu'à donner les droit d'exécutions du script avec :
```bash
sudo chmod +x backup.sh
```
Pour effectuer vos sauvegardes ils ne vous reste plus qu'à exécuter le script !

Lorsque vous lancerez le script, il faudra rentrer une action :

* `list`: Pour afficher la liste de toutes les sauvegardes existantes
* `save`: Pour faire une sauvegarde d'une dossier ou fichier spécifié
* `restore`: Pour restaurer une sauvegarde sur un fichier ou dossier spécifié
* `delete`: Pour supprimer une sauvegarde spécifié
