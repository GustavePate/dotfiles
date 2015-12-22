#!/bin/bash
# Les ; en fin de certaines lignes sont indispensables.
# mount ~/webshare_ot
sleep 3
# On tue les instances de conky déjà lancées.
# Utile pour relancer le tout.
killall conky
# On lance conky, -d pour daemon, -c suivi du fichier de config.
conky -d -c ~/bin/conky-work/.conkyrc;
# On lance un autre fichier de config.
#conky -d -c ~/sync/bin/conky-work/.conkyrc-todo;
conky -d -c ~/bin/conky-work/.conkyrc-date;
conky -d -c ~/bin/conky-work/.conky-desktop;

# Et on quitte proprement le script.
exit
