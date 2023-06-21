# SEC-02 Firewalls

# Key-terms
- Webserver
- Apache2 
- Firewall rules
- Uncomplicated Firewall

# Opdracht

De opdracht vraag het volgende:
- Installeer een webserver op je VM.
- Bekijk de standaardpagina die met de webserver geïnstalleerd is.
- Stel de firewall zo in dat je webverkeer blokkeert, maar wel ssh-verkeer toelaat.
- Controleer of de firewall zijn werk doet.


# Gebruikte bronnen
Deze websites om de UFW opdracht te doen: https://ubuntu.com/server/docs/security-firewall

# Ervaren problemen
Ik wilde de Apache2 default page bekijken met ```curl http://localhost/``` maar dat werkt niet op de goed manier. Een teamgenoot wees mij richting de browser op mijn desktop. 
# Resultaat
## *"1: Installeer een webserver op je VM."* 

Een simpele webserver is apache2. Deze is in een eerdere opdracht al geinstalleerd. Mocht deze wel geinstalleerd moeten worden is het commando:  
```apt install apache2 -y```
___
##*"2 Bekijk de standaardpagina die met de webserver geïnstalleerd is."*  
Dit wordt gedaan in een webbrowser door naar je local host of je IP adres en port te browsen. Ook kan dit worden gedaan met ```curl http://localhost/```, echter krijg je dan de bron in rauwe HTML en niet de opmaak te zien.

![De apache2 default page](/00_includes/Networking_Images/apache2_pagina.png)
*De apache 2 default page*
___
*"3: Stel de firewall zo in dat je webverkeer blokkeert, maar wel ssh-verkeer toelaat."*  
Ubuntu komt met het **Uncomplicated Firewall** programma. Hierin is de syntax best simpel:   
```ufw [COMMAND] [PORT]```  

Waarbij COMMAND de volgende belangrijke opties kent:
```
- allow ARGS: add allow rule (allow 80 om toegang tot port 80 goed te keuren)
- deny ARGS add deny rule (deny 80 om toegang tot port 80 te blokkeren )
- enable: zet UFW aan
- disable: zet UFW uit
- reload: reload UFW
- reset: reset UFW
- status: shows the status of UFW
```

Nu heeft HTTP port 80 en HTTPS port 443 nodig om webverkeer mogelijk te maken. En SSH heeft port 22 nodig.  
Hierdoor kan je met eerst via het commando ```allow 22``` ssh toestaan om vervolgens via de commando's ```deny 80``` en ```deny 443``` al het webverkeer blokkeren.
___

## *"4: Controleer of de firewall zijn werk doet."*  
Nadat je eerst ```allow 22``` hebt opgegeven en daarna pas ```deny 80``` en ```deny 443``` kan je bijvoorbeeld de Apache2 default page proberen te laden. Deze request zal blijven hangen en een timeout geven omdat UFW deze requests dan blokkeert.

![UWF deny 80 en 443](/00_includes/Networking_Images/ufw_deny.png)  
*port 80 en 433 geblokkeerd*

![Apache2 time-out](/00_includes/Networking_Images/apache2_pagina_timeout.png)
*De Apache Default page geeft nu een time-out*

Nadat je ```ufw allow 80``` en ```ufw allow 443``` hebt gebruikt zal het webverkeer weer worden toegestaan.

![UFW allow 80 en 443](/00_includes/Networking_Images/ufw_allow.png)  
*port 80 en 443 toegestaan*


