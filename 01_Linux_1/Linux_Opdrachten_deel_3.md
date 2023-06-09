# LNX-08 Cron Jobs

Deze opdracht gaat over het aanmaken van cron-jobs.

Binnen deze opdracht worden de volgende 3 deelopdrachten gevraagd:

- Create a Bash script that writes the current date and time to a file in your home directory.
- Register the script in your crontab so that it runs every minute.
- Create a script that writes available disk space to a log file in ‘/var/logs’. Use a cron job so that it runs weekly.

### *"Welke bronnen heb ik gebruikt?"*
Het boek *LPIC-1 Study Guide fifth edition* voor de meeste onderdelen.  

En deze websites:  
https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/   
https://crontab.guru/every-1-minute
https://opensource.com/article/18/7/how-check-free-disk-space-linux


### *"Welke problemen ben ik tegengekomen?"*
Het aanmaken van een cron-job dat elke minuut draait was iets wat ik echt even voor moest zoeken. 

### *"1: Create a Bash script that writes the current date and time to a file in your home directory."*

Dit gaat zoals met alle andere scripts maak je het scriptfile aan met de shebang bovenaan, voeg je het script toe en geef je het bestand execute rechten met **chmod u+x**.

Het commando om de tijd en datum te tonen is  **date**, dus het commando binnen de sccript in deze is: 
```
time=$(date)  
echo $time
```




### *"2: Register the script in your crontab so that it runs every minute."* 

Hiervoor moet je de cron-tab aanpassen; dit doe je met **crontab -e**.
Hierbinnen wordt eerst de tijd waarop een job moet worden uitgevoerd noteren en vervolgens het absolute path naar het script wat er uitgevoerd moet worden.
Voor de tijd geldt dat crontab een geheel eigen, maar relijk simpele syntax kent:  
**m h dom, mon, dow:**  
- m -> Minuut (0-59)
- h -> Uur (0-23)
- dom -> dag van de maand (0-31)
- mon -> welke maand (0-11)
- dow -> dag van de week (0-7) (sunday=0 en 7)

En elke optie die niet gebruikt wordt kan met een * worden aangegeven. Als alle opties met \* worden aangegeven wordt een job elke minuut uitgevoerd.

In deze is de regel die er toevoegd moet worden dus:  
**\* \* \* \* \* /home/jeroen_/scripts/time.sh**

![Het crontab](/00_includes/crontab_time.png)
*crontab entry voor het date commando*

![Het script](/00_includes/time_sh.png)
*Het script voor de tijdsmeldin*

![De tijds melding](/00_includes/time_log.png)
*De tijdsmelding zelf*

### *"3: Create a script that writes available disk space to a log file in ‘/var/logs’. Use a cron job so that it runs weekly."* 

#### *1: "Create a script that write avalaible disk space to a log file in '/var/'logs'.*
Het controleren van de disk space kan via het **df** commando. Deze geeft per filesystem de grootte aan en hoeveel er gebruikt wordt in zowel bytes als percentage.
Om dit op te slaan in */var/log/syslog* kan je simpelweg het **logger** commando gebruiken en deze als [message].

Het script wordt dan:
```
#!/bin/bash
disk_usage=$(date)
logger The current disk usage is: $disk_usage 
```

![Het script](/00_includes/df_sh.png)
*het df script*  

![De output van het df script](/00_includes/disksize.png)
*de diskusage*

#### *2: "Use a cron job so that it runs weekly."*

Om het aangemaakt script elke week te draaien is het nodig om met **crontab -e** de crontab te openen, en daarbinnen een zin toe te voegen met deze inhoud:  
**\* \* \* \* \* 1 /home/jeroen_/scripts/df.sh**

Hiermee zal cron op de maandag het **df.sh** script draaien.


![crontab entry](/00_includes/crontab_time.png)  
*crontab entry*  


![de output](/00_includes/df_sh.png)  
*het df script*