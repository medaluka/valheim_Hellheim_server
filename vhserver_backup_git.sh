#!/bin/bash
DateTime=`date +%F-%H.%M`
BackupCount=5
RemoveCount=`expr $BackupCount + 1`
world_dir=/home/vhserver/.config/unity3d/IronGate/Valheim/worlds_local
backup_dir=/home/vhserver/valheim_Hellheim_server/backup_latest
backup_old_dir=/home/vhserver/valheim_Hellheim_server/backup_old


echo "##### Stopping vhserver #####"
vhserver stop

echo "##### Moving previous backup #####"
mv ${backup_dir}/Hellheim.tar.gz ${backup_old_dir}/Hellheim-${DateTime}.tar.gz


echo "##### Removing old backups backup #####"
cd ${backup_old_dir}
ls -tp | grep -v '/$' | tail -n +$RemoveCount | xargs -I {} rm -- {}

echo "##### Creating new backup #####"
cd $world_dir
tar -czvf ${backup_dir}/Hellheim.tar.gz Hellheim.db Hellheim.fwl

echo "##### Pushing backup to git#####"
cd /home/vhserver/valheim_Hellheim_server
git add .
git commit -a -m "Adding backup Hellheim.tar.gz ${DateTime}, keeping last $BackupCount backups and deleting the rest"
git push

echo "##### Starting vhserver #####"
vhserver start

