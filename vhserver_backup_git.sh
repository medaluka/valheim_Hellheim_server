#!/bin/bash
DateTime=`date +%F-%H.%M`
BackupCount=2
RemoveCount=`expr $BackupCount + 1`
world_dir=/home/vhserver/.config/unity3d/IronGate/Valheim/worlds_local
backup_dir=/home/vhserver/valheim_Hellheim_server/backup

vhserver stop

cd $world_dir
tar -czvf ${backup_dir}/Hellheim-${DateTime}.tar.gz Hellheim.db Hellheim.fwl

cd /home/vhserver/valheim_Hellheim_server/backup/
ls -tp | grep -v '/$' | tail -n +$RemoveCount | xargs -I {} rm -- {}

cd /home/vhserver/valheim_Hellheim_server
git add .
git commit -a -m "Adding backup Hellheim-${DateTime}.tar.gz, keeping last $BackupCount backups and deleting the rest"
git push

vhserver start

