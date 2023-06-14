# NTW-06 Subnetting


## Key-terms

- Subnetting
- Private Subnet
- Public Subnet
- AWS VPC
- NAT gateway
- Internet Gateway
- Network Diagrams

# Opdracht

Maak een netwerkarchitectuur die voldoet aan de volgende eisen:
- 1 private subnet dat alleen van binnen het LAN bereikbaar is. Dit subnet moet minimaal 15 hosts kunnen plaatsen.
- 1 private subnet dat internet toegang heeft via een NAT gateway. Dit subnet moet minimaal 30 hosts kunnen plaatsen (de 30 hosts is exclusief de NAT gateway).
- 1 public subnet met een internet gateway. Dit subnet moet minimaal 5 hosts kunnen plaatsen (de 5 hosts is exclusief de internet gateway).
Plaats de architectuur die je hebt gemaakt inclusief een korte uitleg in de Github repository die je met de learning coach hebt gedeeld.


## Gebruikte bronnen
De docs website van aws en YouTube voor informatie over de NAT gateway en Internet gateway:
- https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html
- https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html  
- https://www.youtube.com/watch?v=u7obme-h3bc&t  

Een wesbite met subnet calculator:
- https://www.calculator.net/ip-subnet-calculator.html?

Het in de opdracht gedeelde online tool "https://app.diagrams.net/"

## Ervaren problemen

Het punt van "30 hosts exclusief NAT gateway" en "de 5 hosts is exclusief de internet gateway" was wat vaag. Dit omdat zowel een NAT Gateway als een Internet gateway geen onderdeel zijn van de subnets waarom gevraagd werd... Dit was wat verwarrend, maar na goed lezen en een hint van een teamgenoot snapte ik de vraag wel goed.

# Uitwerking
Ik ga in deze er vanuit dat we 1 VPC hebben met als private IP adres: 10.0.0.0 en het Elastic IP adres 172.16.52.63/16

Voor beide subnets moet het aantal nodes worden berekend door het aantal hosts aan te vullen met een broadcastadres en een netwerkadres/gateway. 

## Subnetten: hoe en wat?
Een subnet is een netwerk dat via het subnetmasker een deel van het adresspace van het hele netwerk gebruikt om een separaat netwerk te maken dat kleiner is dan het totale netwerk.    
Voor een subnet wordt het hele IP adres opgeknipt in kleinere netwerken. 

Als voorbeeld als het 192.168.1.0/27 netwerk in 8 subnets van elk 32 adressen wordt opgedeeld, dan zijn deze subnets mogelijk:
```
192.168.1.0 - 192.168.1.31
192.168.1.31 - 192.168.1.63
192.168.1.64 - 192.168.1.95
192.168.1.96 - 192.168.1.127
192.168.1.128 - 192.168.1.159
192.168.1.160 - 192.168.1.191
192.168.1.192 - 192.168.1.223
192.168.1.224 - 192.168.1.255
```

Ook is het mogelijk om te werken met *Variable Lenght  Subnet Subnetmasking*, **VLSM**, waarbij elk subnetwerk een ander subnetmasker kent. Het voordeel hierbij is dat je netwerken kan creëeren die tussen de 2 en 126 hosts groot zijn zonder dat je vast zit aan gelijke hoeveelheden; 2 en 128 hosts kan dan even goed als 30, 62 en 126 hosts.

# De subnets:
Hier een overzicht van de subnet die gevraagd worden:

**Eerste subnet:**  
*"1 private subnet dat alleen van binnen het LAN bereikbaar is. Dit subnet moet minimaal 15 hosts kunnen plaatsen."* 

15 hosts betekent minimaal 17 nodes/adressen. Dit is het meest efficient door een /27 CIDR te gebruiken, deze geeft 32 adressen(/28 geeft met 16 adressen net 1 adres te weinig)  

In deze neem ik het subnet 10.0.1.0/27.   
Deze heeft 32 mogelijke adressen:
- 10.0.1.0 - 10.0.1.31 
- Netwerkadres: 10.0.1.0
- Broadcastadres: 10.0.1.31
- Hosts: 10.0.1.1 - 10.0.1.30
 
Dit netwerk is in het diagram met groen gekleurd.

 **Tweede subnet**  
*"1 private subnet dat internet toegang heeft via een NAT gateway. Dit subnet moet minimaal 30 hosts kunnen plaatsen (de 30 hosts is exclusief de NAT gateway)."* 

Een NAT gateway zit in een public subnet en heeft der halve geen eigen public IP adres nodig. Deze heeft dus geen invloed op het aantal te gebruiken adressen.   

Dan zijn er 30 hosts, een gateway en een broadcast adres; dus 32 adressen, oftewel minimaal een /27 netwerk.  
In deze neem ik het subnet 10.0.2.0/27, en deze heeft 32 mogelijke adressen:
 - 10.0.2.0 - 10.0.2.31
- Netwerkadres: 10.0.2.0
- Broadcastadres: 10.0.2.31
- Hosts: 10.0.2.1 - 10.0.2.31


Dit netwerk is in het diagram met blauw gekleurd.

 **Derde Subnet**  
*"1 public subnet met een internet gateway. Dit subnet moet minimaal 5 hosts kunnen plaatsen (de 5 hosts is exclusief de internet gateway)"* 

In deze leeft het Internet Gateway buiten de subnets en heeft deze een eigen EIP adres (*Elastic IP adres*) nodig, en gebruikt deze geen IP adres van het public subnet

Voor een Public IP adres geldt dat deze verkregen wordt door de ISP; in deze is dat AWS en ik neem hiervoor het 172.16.52.63/16 adres.

In deze moet het Public subnet 8 adressen groot zijn en dus minimaal een /29 netwerk.  
In deze is het dus het 172.16.52.0 subnet en deze heeft deze 8 mogelijke adressen: 
- 172.16.52.0 - 172.16.52.7
- Netwerkadres: 172.16.52.0
- Broadcastadres: 172.16.52.7
- Hosts: 172.16.52.1 - 172.16.52.6

Dit netwerk is in het diagram met geel gekleurd.

## Het diagram:

![Screenshot van het Diagram](/00_includes/Networking_Images/network_diagram.png)

