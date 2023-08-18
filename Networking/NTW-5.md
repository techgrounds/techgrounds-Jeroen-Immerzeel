# NTW-5 IP Adressen


## Key-terms

- IP adressing
- Public, private IP adressen
- NAT
- Statische en Dynamische IP adressen.
- IPv4, IPv6


# Opdracht
Deze opdracht gaat over het bestuderen van een aantal IP gerelateerde technologieën en het doen van een aantal opdrachten.
Deze opdracht kent deze deelopdrachten:  
**Bestudeer:**
- IP adressen
- IPv4 en IPv6
- Public en Private IP adressen
- NAT
- Statische en dynamische adressen

**Doen:**
- Ontdek wat je publieke IP adres is van je laptop en mobiel op wifi.
- Zijn de adressen hetzelfde of niet? Leg uit waarom.
- Ontdek wat je privé IP adres is van je laptop en mobiel op wifi.
- Zijn de adressen hetzelfde of niet? Leg uit waarom.
- Verander het privé IP adres van je mobiel naar dat van je laptop. Wat gebeurt er dan?
- Probeer het privé IP adres van je mobiel te veranderen naar een adres buiten je netwerk. Wat gebeurt er dan?


## Gebruikte bronnen
Het boek Comptia Network+ Study Guide Fifth Edition.  
https://www.menandmice.com/blog/ipv6-reference-multicast voor uitleg over IPv6 multicast.
## Ervaren problemen
- De opdrachten met de conflicterende adressen werkten niet omdat mijn netwerk terug kan vallen op IPv6; dit opgelost door de opdracht iets anders aan te pakken.

# Uitwerking

## Wat zijn IP adressen?
IP adressen zijn de logische netwerk adressen voor netwerk apparaten. Deze bestaan uit 2 generaties:
- IP4
- IPv6

## **IP4 Adressen**

IP4 bestaat uit een 32 bits adres waarbij er 2^32, oftewel 4.294.967.296 adressen mogelijk zijn.

Een IP4 adres bestaat uit 4 bytes, en elke byte kan bestaan uit de decimale cijfers 0 t/m 255. Een voorbeeld van een IP4 adres is:  
192.168.1.23

Doordat er slechts zo'n 4.3 miljard IP4 adressen mogelijk zijn en er veel meer netwerkapparaten zijn dan dat is er een tekort aan IP4 adressen, daarvoor zijn er een aantal oplossingen bedacht, waaronder: 
- NAT
- Private en public IP addressing
- IPv6

## **IPv6**
IPv6 is de opvolger van IP4 en kent een 128 bit adres waardoor er 2^128 oftewel ruim 340 miljard miljard miljard adressen mogelijk zijn. 

IPv6 kent een andere notering dan IP4 met daarin een aantal verbeteringen zoals het niet meer nodig zijn van private/public adressen, NAT. DHCP e.d., al worden deze ideeën wel gebruikt.
Een voorbeeld van een IPv6 adres is:   
2001:0db8:85a3:0000:0000:8a2e:0370:7334

Dit is heel wat complexer qua uiterlijk, maar qua indeling is dit ergens heel logisch, IPv6 adressen zijn namelijk ingedeeld in een prefix voor het netwerk en een willekeurig getal of verkregen via DHCPv6 host gedeelte. De prefix wordt bepaald aan de hand van de grootte van het subnet; een groot subnet heeft ook een grotere prefix.

Daarnaast heet IPv6 verschillende type adressen:
- Link Local: prefix: fe0::/10 (/64 in de praktijk): wordt gebruikt om verkeer binnen het directe lokale netwerk (local link) te versturen/ontvangen; is niet routable binnen de eigen site.
- Unique local: prefix fc00::/7: is als link local maar dan wel routable binnen de gehele eigen site.
- Global Unicast: prefix 200::/3 tot E000::/3 (111): is een "public" of globally routable address welke wel naar buiten het netwerk kan worden gerouteerd.
- Anycast en Multicast: adressen bedoeld voor meer geavanceerde functies als routing informatie (multicast)

![IPv6 addresses](/00_includes/Networking_Images/ip6_addresses.png)  
*IPv6 adres soorten*

**Bij de notatie van een IPv6 adres zijn er regels om deze in te korten:**
- Bytes bestaande uit 0-en kan je wegstrepen
- Bij meerdere 0-bytes mogen alleen de eerste reeks worden weggestreept, de volgende reeksen moeten met een 0 worden genoteerd
- Bij bytes bestaande uit meerdere 0-en alvorens een ander getal hoeven de 0-en niet genoteerd te worden


Dus een IPv6 adres als: 2001:0db8:85a3:0000:0000:8a2e:0370:7334 kan worden ingekort naar:
2001:db8:85a3:::8a2e:370:7334


En een adres als 2001:0db8:0000:0000:8a2e:0000:0370:7334 mag worden ingekort naar:
2001:0db8:::8a2e:0:0370:7334

## **Private en Public adressing**

Er is een tekort aan IP4 adressen en daarom zijn er meerdere technologieën bedacht om dit tekort het hoofd te bieden; 1 daarvan is de onderscheid tussen private en public adressen.

**Private adressen** zijn 3 reeksen, gereserveerde en non-routable address pools die men zelf kan gebruiken op het eigen interne netwerk. Deze bestaan uit een enkel classfull address* (A, B of C):
- 10.0.0.0/8 -10.255.255.255 heeft 16,7 miljoen mogelijke adressen
- 172.16.0.0/12 - 172.31.25.255 heeft 1 miljoen mogelijke adressen 
- 192.1680.0 - 192.168.255.255, heeft 65.536 mogelijke adressen.

Deze adressen mogen alleen binnen een privaat netwerk worden gebruikt en zijn niet naar het internet routable.

(*classfull adressen zijn een niet meer gebruikt systeem om de IP4 adres space te verdelen)

**Public IP adressen** zijn de IP adressen die wél over het internet bereikbaar zijn. Deze krijgt men van een ISP.  


## **NAT en PAT**


NAT staat voor **Network Address Translation**.  
Omdat de combinatie van veel private en weinig public adressen het hoofd te bieden is er een systeem bedacht waarbij men de gateway/router een private adres aan een public adres laat koppelen mocht een device met private adres toegang tot het internet nodig hebben. 

Echter kent dit het probleem dat als er 10 public adressen zijn en 100 devices zijn die internettoegang nodig hebben dat niet via NAT kan. Daarom heeft men *"NAT overloading"* of **PAT** bedacht wat staat voor *Port Address Translation*.

Binnen **PAT** worden niet alleen private adressen naar public adressen gekoppeld, maar ook aan emphemeral ports. Een met **PAT** gekoppeld adres is dan qua indeling IP:port, oftewel:   
77.135.27.1:62541

Gezien netwerkverkeer altijd van poort naar poort gaat is deze indeling de meest handige en elegante oplossing.

## **De toekomst**

Omdat we naar een IPv6 wereld toe gaan zal het gebruik van IP4 en de daarbij behorende oplossingen uiteindelijk verdwijnen.


## De praktijk opdracht:
*"1: Ontdek wat je publieke IP adres is van je desktop en mobiel op Wi-fi."* 
 
Dit kan je doen door naar https://whatismyipaddress.com  
Mobiel: 77.162.85.197  
Desktop: 77.162.85.197
![Wat is mijn IP adres?](/00_includes/Networking_Images/public_address.png)
*Public IP adres* 

*"2: Zijn de adressen hetzelfde of niet? Leg uit waarom."*  
Ja.   
Door NAT wordt 1 public IP adres gebruik voor buiten het netwerk en unieke private IP adressen voor binnen het interne netwerk.

*"3: Ontdek wat je privé IP adres is van je desktop en mobiel op Wi-fi"*   
Mobiel: 192.186.178.37  
Desktop: 192.186.178.20

*"4: Zijn de adressen hetzelfde of niet? Leg uit waarom."* 

Nee, want binnen een LAN worden private addresses gebruikt om zo het tekort aan IP adressen op te vangen en administratie makkelijker te maken.

![Overicht van device en hun private IP adressen](/00_includes/Networking_Images/private_addressing.png)
*Private IP adres* 

*"5: Verander het privé IP adres van je mobiel naar dat van je desktop. Wat gebeurt er dan?"*

Geen van beide devices kan verbinding maken met het netwerk.



*"6: Probeer het privé IP adres van je mobiel te veranderen naar een adres buiten je netwerk. Wat gebeurt er dan?"*

Niets... dit omdat de connectie op het IPv6 adres terugvalt.
Als er geen IPv6 connectie mogelijk zou zijn zou er geen connectie met het internet mogelijk zijn omdat de gateway dan niet bereikt kan worden. 



