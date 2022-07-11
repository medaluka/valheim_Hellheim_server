#!/bin/bash
DateTime=`date +%F-%H.%M`
vhserver stop
tar -czvf /home/vhserver/valheim_Hellheim_server/backup/Hellheim-${DateTime}.tar.gz /home/vhserver/.config/unity3d/IronGate/Valheim/worlds/*
cd /home/vhserver/valheim_Hellheim_server
git add .
git commit -m "Adding backup Hellheim-${DateTime}.tar.gz"
git push
vhserver start
