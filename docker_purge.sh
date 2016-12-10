#!/usr/bin/bash

#On liste tous les jobs docker termines pour ensuite les supprimer
JOBS=`for container in $(docker ps -a | grep -v "CONTAINER ID" | awk -F " " '{print $1}'); do echo $container; done`

if [ "${JOBS}" == "" ]; then echo "Aucun job docker a supprimer." && exit 0; fi

#Suppression des jobs recuperes pour nettoyage avant suppression d'images par exemple
echo "Suppression des jobs docker en cours..."
for job in $JOBS; do
    docker rm $job >/dev/null
    if [ $? = 0 ]; then
        echo "job ${job} supprime avec succes"
    fi
done

#En dernier lieu on affiche quand meme la liste des jobs pour verifier
echo "" && docker ps -a

exit 0
