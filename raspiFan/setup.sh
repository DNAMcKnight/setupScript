#! /bin/sh

tput setaf 1; 
echo "moving fancontrol.sh to /etc/init.d"
sudo mv fancontrol.sh /etc/init.d/
echo "moving fancontrol.py to /usr/local/bin"
sudo mv fancontrol.py /usr/local/bin/

echo "adding execution permissions to fancontroler.py"
sudo chmod +x /usr/local/bin/fancontrol.py
echo "adding execution permissions to fancontroler.sh"
sudo chmod +x /etc/init.d/fancontrol.sh

sudo update-rc.d fancontrol.sh defaults
echo "update-rc.d updated."
echo "please reboot or run this command to start the script"
tput setaf 5; echo "sudo /etc/init.d/fancontrol.sh start"