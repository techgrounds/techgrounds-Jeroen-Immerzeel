# SEC-08 Detection Response and Analysis

# Key-terms


# Opdracht

De opdracht vraag het volgende:
**Study:**
- IDS and IPS.
- Hack response strategies.
- The concept of systems hardening.
- Different types of disaster recovery options.


**Exercise:**  
A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?  

An automatic failover to a backup web server has been configured for a website. Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website?


# Gebruikte bronnen
https://www.okta.com/identity-101/ids-vs-ips/ voor informatie over IDS en IPS
https://beaglesecurity.com/blog/article/how-to-respond-to-a-cyber-attack.html over wat te doen bij een hack.
https://ubuntu.com/blog/what-is-system-hardening-definition-and-best-practices voor systems hardening
DRP options  
RPO//RTO:  
https://blog.quest.com/recovery-time-and-recovery-point-objective-everything-you-need-to-know/
Disaster Recovery
https://www.vmware.com/topics/glossary/content/disaster-recovery.html
# Ervaren problemen
Het RTO en RPO gedeeldte was wat moeilijk, en opdracht 4 was geheel onduidelijk.

# Resultaat
** Sudy part:** 

## *"1: What are IDS and IPS?*  
**IDS**
Een IDS is een "Intrusin Detection System"; een systeem dat het netwerkverkeer controleerd op de tekenen van bekende aanvallen en een waarschuwing geeft mocht er een (mogelijke) aanval worden gedetecteerd.

Een IDS zal zelf dus geen acties ondernemen.

**IPS**
Een IPS is een "Intrusion Protection System"; deze controleert ook het netwerkverkeer op mogelijke aanvallen, maar als er een (mogelijke) aanval wordt gedetecteerd zal deze het netwerkverkeer blokkeren en evetueel acties ondernemen.
Een IPS kan als acties uitvoeren mocht er een mogelijke aanval worden gedetecteerd: 
- het sluiten van sessies, dit om zo indringers te stoppen
- het versterken van de Firewall door extra regels in te voeren en zo eventuele misbruikte zwakheden op te vangen   
- het opruimmen van malware

In een moderne omgeving worden IPS en IDS veelal gecombineerd en tezamen met een SIEM, een System Information and Event Management systeem, werken om zo de beheerders van het netwerk te informeren en eventuele geautomatiseerde handelingen uit te voeren.

--- 

## *"2: What are common Hack response strategies?*"
Bij een hack is het nodig om een aantal standaard stappen te doorlopen.
De meest belangrijke stappen zijn:
- Identify
- Contain
- Record
- Disclose

**Identify**
Bij het identificeren van een hack worden er een aantal belangrijke vragen beantwoord, waaronder:
- Waar bestaat de hack uit
- Welke data is er (mogelijk) gestolen
- Wie zijn er geraakt door de hack
- Welke credentials zijn er misbruikt of aangepast
- Hoe was het netwerk tijdens de hack
- Zijn er restproblemen nadat de hack gestopt is

Ook kunnen er tijdens het onderzoek meer dingen aan het licht komen, zoals de schaal van de aanval (alleen dit netwerk, of meer slachtoffers)



**contain**
Als de aanval geidentificeerd is, is het tijd om deze te stoppen, of in ieder geval te limiteren.
Dit kan door:
- Het afsluiten van delen van het netwerk die wel/niet geraakt zijn
- De routing naar en toegang tot de verschillende onderdelen van het netwerk aanpassen of onmogelijk maken
- Het aanpassen van de credentials en de toegang tot de systemen in het algemeen

Het meest belangrijke is uiteindelijk dat de data beschermd wordt door toegang tot deze gelimiteerd wordt. 

**Record**
Terwijl de aanval geïdentificeerd en gelimiteerd wordt is het nodig om elke stap en handeling nauwkeurig te omschrijven. 
Dit is zowel om te leren van de situatie, als voor gerechtelijke redenen; alle informatie over een eventuele datalek zal in zijn geheel moeten worden vrijgegeven, en dit is inclusief een gedetailleerde omschrijving van de handelingen om de hack te stoppen.

**Disclosure**
Het vrijgeven van de informatie dat er een hack heeft plaatsgevonden is wettelijk verplicht en belangrijk voor het vertrouwen van de klant.
De wettelijke verplichting in Nederland is dat elke datalek met risico voor betrokken derden bij de Autoriteit Persoonsgegevens gemeld moet worden. Is er bij een lek geen sprake van een situatie waarbij 'de rechten en vrijheden van betrokkenen' niet wordt geschonden is het niet nodig om deze te melden volgens de AVG.


Echter, is het altijd nog belangrijk om het lek te melden aan belanghebbenden; deze zijn dan wettelijk gezien geen slachtoffer, maar wel de partijen die baat hebben bij deze melding.

---
## *"3: What does the concept of systems hardening entail?"*
Bij systems hardening wordt een systeem zo aangepast dat deze een kleinere attack surface heeft oftwel minder kans heeft om aangevallen te worden doordat zwakke plekken worden voorkomen.

Bij system hardening worden maatregelen genomen waarbij hardware en software worden aangepast.
Een aantal voorbeelden van het aanpassen van de hardware zijn:
- Het updaten van het BIOS
- Het afsluiten van ongebruikte USB poorten
- Het versleutelen van de disks

Een aantal voorbeelden van het aanpassen van de software zijn:
- Het uitvoeren van updates
- Het sluiten van netwerkpoorten
- Het regelmatig scannen met anti-malware software
- Het verwijderen van ongebruikte software 

Dit alles leidt tot een kleinere kans op misbruik van systeemonderdelen door bad actors.

---

## *"4: What are different types of disaster recovery options?"*  

Disaster recovery is de methode waarop men de bedrijfsfuncties na het uitvallen weer kan activeren. Dit wordt in een Disaster Recovery Plan gedetailleerd uiteengezet.

Een aantal opties in deze zijn:
- Backups: logische eerste stap die voor elk systeem zou moeten gelden.
- Cold/warm/hot/cloud -sites: een uitwijkmogelijkheid waar vandaan de systemen weer kunnen worden gedraaid.
- Data Recovery as a service(DraaS): deze kan gebruikt worden voor het terughalen van functionaliteit bij ramsomware of dataloss


Voor de "sites" geldt dat ze verschillende karakteristieken kennen:  
**Cold site**  
Een cold site is een uitval locatie waar geen enkele hard- of software aanwezig is. Dit zijn meestal lege ruimtes met hoogstens wat bureau's waarin men de werkzaamheden kan gaan vervolgen nadat deze in zijn geheel zijn opgebouwd. 

**Warm site**  
Een warm site is een uitval locatie waar er wel al hard- en software aanwezig is maar niet de laatste updates. Deze kan qua IT systemen in gebruik worden genomen na de nodige updates.

**Hot site**  
Een hot site is een 100% copy van de productie site en zal alles direct kunnen overnemen mocht er zich een calamiteit voordoen welke de business operations negatief beïnvloed. Dit ook veruit de duurste optie en wordt tegenwoordig steeds meer in de cloud gehost in welk geval deze ook wel een "cloud site" wordt genoemd.

---
## **Exercise part:**

### *"1: A Company makes daily backups of their database. The database is automatically recovered when a failure happens using the most recent available backup. The recovery happens on a different physical machine than the original database, and the entire process takes about 15 minutes. What is the RPO of the database?"*

Over de RPO zegt de Quest Blog website:  

*"Think of your recovery point objective as the point in time back to which you want to be able to recover your data. A recovery point is essentially the time at which a data backup was completed successfully."* 

Gezien de RPO bestaat uit de tijd dat er voor het laatst een backup heeft plaatsgevonden, is het in deze casus een RPO van maximaal 24 uur.

___
### *"2: An automatic failover to a backup web server has been configured for a website. Because the backup has to be powered on first and has to pull the newest version of the website from GitHub, the process takes about 8 minutes. What is the RTO of the website?"* 

Over de RTO zegt de Quest Blog:   
*"RTO is the amount of time it takes to recover data for use again in production"*

Omdat in deze de RTO bepaald hoelang het hele proces voor het terugzetten van de backup duurt, is deze in dit voorbeeld 8 minuten.