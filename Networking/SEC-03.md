# SEC-03 Identity and Access Management

# Key-terms
- Autenticatie
- MFA
- 3 Factoren
- Wireshark

# Opdracht

De opdracht vraag het volgende: 

*Study the following:* 
- The difference between authentication and authorization.
- The three factors of authentication and how MFA improves security.
- What the principle of least privilege is and how it improves security.


# Gebruikte bronnen
Deze website voor de 3 principles en MFA https://www.cisa.gov/MFA  
Deze website voor de principle of least priviledge: https://www.paloaltonetworks.com/cyberpedia/what-is-the-principle-of-least-privilege   
Deze website voor de definitie van het begrip "attack surface" https://csrc.nist.gov/glossary/term/attack_surface


# Ervaren problemen
Weinig. Moest even zoeken wat het ook al weer precies was maar het meeste wist ik nog wel van eerdere opleiding.

# Resultaat

*"1: The difference between authentication and authorization."* 

Autenticatie is het vaststellen of een gebruiker wel de persoon is dat deze claimt te zijn. Dit gaat via een **wachtwoord** of via een **MFA** oplossing zoals een token.
Autorisatie is het toegang verlenen op basis van vastgestelde rechten.

___
*"2:  The three factors of authentication and how MFA improves security."*  
**De 3 factoren voor autentcatie**
Dit zijn de 3 manieren waarop autenticatie kan plaatsvinden:
- Dat wat je weet: wachtwoord of PIN.  
- Dat wat je hebt: een token of smartcard.   
- Dat wat je bent: biometrie dus bijvoorbeeld een vingerafdruk of irisscan.  

**MFA**  
MFA is het gebruik van meer dan 1 factor of authetication. Bijvoorbeeld zowel een wachtwoord als een code van een token op je mobiel. 
Dit verbeterd de beveiliging omdat de kans dat iemand meerdere factoren kan controleren klein is. Zo is het wel mogelijk dat een wachtwoord gestolen is, maar een vingerafdruk is niet zomaar te stelen.
Hierbij is het wel belangrijk om te weten dat niet alle oplossingen even stevig zijn; zo is SMS verificatie nog altijd breekbaar door fishing en simswapping. 

___
*"3: What the principle of least privilege is and how it improves security."*

Dit is het idee dat gebruikers alleen die rechten krijgen die ze nodig hebben voor hun werk, om zo een netwerk op aantal punten te beveiligen:
- Verkleinen van de "attack surface"
- De kans op malware te verkleinen
- Het gebruik van system resources te verlagen
- Kan op menselijke fouten te verkleinen 


Een **"attack surface"** wordt door het NIST gedefinieerd als:  
*"The set of points on the boundary of a system, a system element, or an environment where an attacker can try to enter, cause an effect on, or extract data from, that system, system element, or environment. "* 

Of om dit in een simpele Nederlandse defintie te stellen:  
*"Die delen van een netwerk of systeem welke een cybercrimineel kan misbruiken."* 

Dit principe kan worden bereikt door maatregelen te nemen zoals het sluiten van ongebruikte netwerkpoorten en services en een degelijk autorisatie plan. Dit valt ook onder het idee van **system hardening**. 

**Malware** kan worden gestopt doordat gebruikers bij aanwezigheid van de juiste rechten, geen toegang hebben tot bekende bronnen van malware. Denk hierbij aan het blokkeren van bepaalde webites via het verplichte gebruik van webproxyservers.

**System resource** gebruik wordt verlaagd doordat het verkleinen van de rechten tot een minimum ook het gebruik van autorisatiestappen verkleind wordt én systemen zo kunnen worden ontworpen dat resources via een "tiered" systeem opgeslagen worden. Hierbij worden veelgebruikte resources op een snellere tier geplaatst (SSDs bijv.) en weinig gebruikte resources op een gecomprimeerde opslag staan (zoals een HDD); dit versneld het proces in de breedte en verlaagd de totale overhead.

**Menselijke fouten** zijn er op meerdere manieren. Het openen van een e-mail waar malware in staat is een bekend voorbeeld, maar ook het per ongeluk wissen van kritische data is iets dat met goede autorisate onmogelijk wordt gemaakt.

Ook het voorlichten van de gebruikers om awareness te creëeren over wat hun (online) gedrag voor gevolgen kan hebben is hier een stap. 