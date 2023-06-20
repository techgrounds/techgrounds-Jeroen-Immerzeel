# SEC-06 Public Key Infrastructure

# Key-terms
- Certificates
- Certificate Authority


# Opdracht

De opdracht vraag het volgende:
- Create a self-signed certificate on your VM.
- Analyze some certification paths of known websites (ex. techgrounds.nl / google.com / ing.nl).
- Find the list of trusted certificate roots on your system (bonus points if you also find it in your VM).


# Gebruikte bronnen
https://linuxize.com/post/creating-a-self-signed-ssl-certificate/ voor het aanmaken van een self-signed certificate
https://prod.docs.oit.proofpoint.com/installation_guide/finding_the_path_to_the_trusted_certificates.htm de certificatie roots bij opdracht 3.

# Ervaren problemen

# Resultaat
*"1: Create a self-signed certificate on your VM."*

Dit gaat via openssl.
Het commando om een cerificate aan te maken is in deze:
**sudo openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out techgrounds.crt -keyout techgrounds.key**

Dit geeft na het opgeven van benodigde informatie over de uitgever, een certificate en een key als output. De .cert file is de public key, de .key file de private key; logischerwijs wordt het .crt-file gedeeld en het .key-file geheim gehouden. 
Beiden bestaan uit een RSA key en dus een lange reeks tekens.

![RSA key voor het certificaat](/00_includes/Networking_Images/cert_text.png)


*"2: Analyze some certification paths of known websites (ex. techgrounds.nl / google.com / ing.nl)"*

Dit is redelijk simpel. Binnen chrome klik je op het slotje en kies je voor "Verbinding is Beveiligd" en daarna voor "Certificaat is geldig" om het certificaat te bekijken.

Een paar voorbeelden van deze cerficaten:  

**Techgrounds:**   
![Certificaat van techgrounds.nl](/00_includes/Networking_Images/tech_cert.png)

**Rijksoverheid.nl:**  
![Certificaat va rijksoverheid.nl](/00_includes/Networking_Images/rijks_cert.png)

**amazon.com:**  
![Certificaat van amazon.com](/00_includes/Networking_Images/amazon_cert.png)

De tabs in de screenshots bevatten de meest belangrijke informatie. Onder de details tab is echter nog meer informatie te vinden waaronder de openbare sleutel en informatie over de uitgever van het certificaat, oftewel de Certificate Authority.


*"3: Find the list of trusted certificate roots on your system (bonus points if you also find it in your VM)."* 

De eerste opdracht was erg makkelijk; Windows kent de certlm.msc tool voor het bekijken van certicaten. 

![certlm.msc tool](/00_includes/Networking_Images/certlm.png)

De tweede opdracht, het vinden van de certificate root op Linux, was niet echt moeilijk; ik heb even gezocht op "linux certificate root" en had zo een goede bron.

De benodigde stappen zijn:  
```openssl version -d```: dit geeft het PATH met de directory voor de certificaten aan; in dit geval **/usr/lib/ssl**
Hierna zoek je binnen deze directory naar de directory **/certs**; hierin staan alle certificaten.


![De lijst met de certificates](/00_includes/Networking_Images/ssl_certs_1.png)  
... ingekort ... 
![De lijst met de certificates](/00_includes/Networking_Images/ssl_certs_2.png)  
... ingekort ...   
![De lijst met de certificates](/00_includes/Networking_Images/ssl_certs_3.png)  
*De lange lijst met certificates* 