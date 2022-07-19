#!/bin/bash
DateTime=`date +%F-%H.%M`
BackupCount=7
RemoveCount=`expr $BackupCount + 1`
vhserver stop
tar -czvf /home/vhserver/valheim_Hellheim_server/backup/Hellheim-${DateTime}.tar.gz /home/vhserver/.config/unity3d/IronGate/Valheim/worlds_local/Hellheim*
cd /home/vhserver/valheim_Hellheim_server/backup/
ls -tp | grep -v '/$' | tail -n +$RemoveCount | xargs -I {} rm -- {}
cd /home/vhserver/valheim_Hellheim_server
git add .
git commit -a -m "Adding backup Hellheim-${DateTime}.tar.gz, keeping last $BackupCount backups and deleting the rest"
git push
vhserver start
