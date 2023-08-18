# SEC-03 Identity and Access Management

# Key-terms
- Authenticatie
- MFA
- 3 Factoren van authenticatie
- Wireshark

# Opdracht

De opdracht vraag het volgende: 

*Study the following:* 
- The difference between authentication and authorization.
- The three factors of authentication and how MFA improves security.
- What the principle of least privilege is and how it improves security.


# Gebruikte bronnen
Deze website voor de 3 principles en MFA https://www.cisa.gov/MFA  
Deze website voor de principle of least privilege: https://www.paloaltonetworks.com/cyberpedia/what-is-the-principle-of-least-privilege   
Deze website voor de definitie van het begrip "attack surface" https://csrc.nist.gov/glossary/term/attack_surface


# Ervaren problemen
Weinig. Moest even zoeken wat het ook al weer precies was maar het meeste wist ik nog wel van eerdere opleiding.

# Resultaat

## *"1: The difference between authentication and authorization."* 

Authenticatie is het vaststellen of een gebruiker wel de persoon is welke deze claimt te zijn. Dit gaat via een **wachtwoord** en/of via een **MFA** oplossing zoals een token.
Autorisatie is het toegang verlenen tot data op basis van vooraf vastgestelde rechten.

Hiernaast is er ook nog identificatie. Deze stap komt voor authenticatie en stelt de identiteit van de gebruiker vast; dit meestal via een username.

De 3 stappen voor Identity and Access management zijn:
- Identificatie: wie wilt inloggen?
- Authenticatie: is de entiteit die in wilt loggen echt?
- Autorisatie: wat zijn de rechten die de entiteit krijgt/heeft?

___
## *"2:  The three factors of authentication and how MFA improves security."*  
**De 3 factoren voor autentcatie**  
Dit zijn de 3 manieren waarop authenticatie kan plaatsvinden:
- Dat wat je weet: wachtwoord of PIN.  
- Dat wat je hebt: een token of smartcard.   
- Dat wat je bent: biometrie dus bijvoorbeeld een vingerafdruk of irisscan. 

Authenticatie kan door 1 van de factoren worden gedaan, maar ook door meerdere factoren; dan spreken we over Multifactor Authetication. 

**MFA**  
MFA is het gebruik van meer dan 1 factor of authetication. Bijvoorbeeld zowel een wachtwoord als een code van een token op je mobiel. 
Dit verbeterd de beveiliging omdat de kans dat een bad actor meerdere factoren kan controleren klein is. Zo is het wel mogelijk dat een wachtwoord gestolen is, maar een vingerafdruk is niet zomaar te stelen.
Hierbij is het wel belangrijk om te weten dat niet alle oplossingen even stevig zijn; zo is SMS verificatie nog altijd breekbaar door fishing en sim swapping. 

___
## *"3: What the principle of least privilege is and how it improves security."*

Dit is het idee dat gebruikers alleen die rechten krijgen die ze nodig hebben voor hun werk. Dit om zo een netwerk op aantal punten te beveiligen:
- Verkleinen van de "attack surface"
- De kans op malware te verkleinen
- Het gebruik van system resources te verlagen
- Kan op menselijke fouten te verkleinen 


Een **"attack surface"** wordt door het NIST gedefinieerd als:  
*"The set of points on the boundary of a system, a system element, or an environment where an attacker can try to enter, cause an effect on, or extract data from, that system, system element, or environment. "* 

Of om dit in een simpele Nederlandse definitie te stellen:  
*"Die delen van een netwerk of systeem welke een cybercrimineel kan misbruiken."* 

Dit principe kan worden bereikt door maatregelen te nemen zoals het sluiten van ongebruikte netwerkpoorten en services en een degelijk autorisatie plan. Dit valt ook onder het idee van **system hardening**. 

**Malware** kan worden gestopt doordat gebruikers bij aanwezigheid van de juiste rechten, geen toegang hebben tot bekende bronnen van malware. Denk hierbij aan het blokkeren van bepaalde websites via het verplichte gebruik van webproxy servers.

**System resource** gebruik wordt verlaagd doordat het verkleinen van de rechten tot een minimum ook het gebruik van autorisatiestappen verkleind wordt én systemen zo kunnen worden ontworpen dat resources via een "tiered" systeem opgeslagen worden. Hierbij worden veelgebruikte resources op een snellere tier geplaatst (SSDs bijv.) en weinig gebruikte resources op een gecomprimeerde opslag staan (zoals een HDD); dit versneld het proces in de breedte en verlaagd de totale overhead.

**Menselijke fouten** zijn er op meerdere manieren. Het openen van een e-mail waar malware in staat is een bekend voorbeeld, maar ook het per ongeluk wissen van kritische data is iets dat met goede autorisatie onmogelijk wordt gemaakt.

Ook het voorlichten van de gebruikers om awareness te creëren over wat hun (online) gedrag voor gevolgen kan hebben is hier een stap. 