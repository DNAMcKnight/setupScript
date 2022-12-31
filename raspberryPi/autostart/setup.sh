#! /bin/sh

tput setaf 3;
echo "moving autoKnightbot.sh to /etc/init.d"
sudo mv autoKnightbot.sh /etc/init.d/

echo "adding execution permissions to bot.py"
sudo chmod +x /home/pi/KnightBot/bot.py
echo "adding execution permissions to autoKnightbot.sh"
sudo chmod +x /etc/init.d/autoKnightbot.sh

sudo update-rc.d autoKnightbot.sh defaults
echo "update-rc.d updated."
echo "please reboot or run this command to start the script"
tput setaf 5; echo "sudo /etc/init.d/autoKnightbot.sh start"