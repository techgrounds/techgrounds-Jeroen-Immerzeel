# Techgrounds Linux
De gevraagde commando’s.

Ten eerste, als je meer wilt weten over een commando kan je (bijna) altijd het commando en --help gebruiken; dus bijvoorbeeld adduser --help
Daarnaast kan je via de man -pages informatie krijgen (dit zijn dan ook “manual pages”)
De gevraagde commando’s zijn, in willekeurige volgorde:
-	ls
-	cat
-	pwd
-	adduser
-	grep
-	echo
-	ps
-	usermod
-	passwd
-	chown
-	mkdir
-	cd
-	chgrp
-	systemctl

Termen die ook van belang zijn als onderdeel van de opdrachten en commando’s:
-	redirection
-	piping via een |
-	octal en symbolic modes
-	shebang
-	start, stop, pauze, restart, enable, disable
-	passwd, shadow, group files
-	visudo
-	Het verschil tussen > en >>


En ten slotte een paar links voor deze opdrachten:  
https://www.codecademy.com/learn/learn-the-command-line/modules/learn-the-command-line-navigation/cheatsheet > bespreekt de basis commando’s die gevraagd worden.
https://www.linuxfoundation.org/blog/blog/classic-sysadmin-understanding-linux-file-permissions > file permissions.   
https://www.pluralsight.com/guides/user-and-group-management-linux  > users and groups
https://www.codecademy.com/learn/bash-scripting/modules/bash-scripting/cheatsheet   > voor de laatste 2 opdrachten  
https://www.freecodecamp.org/news/cron-jobs-in-linux/  > specifiek voor de laatste opdracht.

# Extra Linux informatie
## File system
Linux kent een heel andere manier van het beheer van het filesystem dan Windows.
In linux de start van het filesystem heet de "root" en wordt genoteerd met \; vanaf hier loopt de directory structuur met als eerste directories een gestandardiseerde mapstructuur genaamd het "Filesystem Hiërarchy Standard" of "FHS".
Een aantal van de standaard mappen zijn:
/home: home-directory voor gebruikers
/usr: secundaire opslag voor user data
/bin: essential system binaries
/sbin: essentiële system binairies
/etc: locatie voor configuration files (soms als "etc" en soms als "edit to configure" uitgelegd)
/dev: voor device files (disks, ) 
/opt: voor optionele programma's
/boot: boot files
/lib: library bestanden voor binaries
/proc: pseudo filesystem dat device informatie bij houdt.
/var: variable files c.q. bestanden die snel veranderen
/mnt: mountpunt voor tijdelijke filesystems die geen onderdeel zijn van het standaard gebruikte filesystems
/media: mountpunt voor removable media als USB devices

Het filesystem kan een aantal typen filesysteem gebruiken waaronder NFS, Ext1 - 4, Fat, btrfs, XFS en Swap.
Van deze is swap een bijzonder types: dit is het filesystem dat gebruikt wordt als extra geheugen ter aanvulling van het RAM geheugen.

Voor het aansluiten van een (tijdelijk) filessysteem of wisselbare opslag als een USB stick wordt het /mount commando gebruikt. Door dit systeem kan er heel snel en simpel gebruik gemaakt worden van deze opslagplaatsen. 








