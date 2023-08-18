# Opdracht Git-02  
*Het bestuderen van de Markdown Language en de keyterms zoals beschreven in de opdracht.*

## De Key-terms bij deze opdracht.
- Markdown
- WYSIWYG
- WYSIWYM
- Headings
- Codeblocks
- Bold tekst
- urls

# De Opdracht:   
## Gebruikte bronnen voor de opdracht:  
De website <http://markdownguide.org/>; deze had alle benodigde informatie voor deze opdracht.  



## Ervaren problemen
Ik kwam weinig echte problemen tegen. De gebruikte website (https://markdownguide.org/) had alle informatie voor de opdracht. Al was het formateren soms wat lastig doordat het breken van de code bij de voorbeelden soms niet makkelijk ging; wat de kracht van een markdown language goed laat zien.

### Samenvatting van de opdracht:
De opdracht vraagt om 3 termen te bestuderen en te omschrijven:  
- Wat is Markdown?  
- Wat betekenen de afkortingen WYSIWYG en WYSIWYM?  

Daarnaast vraagt de opdracht om het aanmaken van dit document met daarin de volgende elementen:
- Headers
- Codeblocks
- Bold tekst
- urls


## Wat is markdown?
Markdown is een markup language bedoeld voor het formatteren van tekst met een plain-texteditor.
De GitHub versie van Markdown wordt sinds 2009 gebruikt en kent extra features zoals nesting block content en het automatisch linken naar GitHub features.   
Sinds 2017 is er een officiële specificatie van markdown voor GitHub onder de naam "GitHub Flavoured markdown".  
<

## Wat betekenen de afkortingen WYSIWYG en WYSIWYM?
De afkortingen WYSIWYG en WYSIWYM staan voor *What You See Is What You Get* en *What You See Is What You Mean*. 
- WYSIWYGet is het systeem waarbij een texteditor de volledige opmaak direct laat zien. Een voorbeeld hiervan is de manier waarop Microsoft Word de opmaak van een word-file renderd.
- WYSIWYMean is het systeem waarbij tekst doormiddel van markeringen van betekenis wordt voorzien. Voorbeelden hiervan zijn markdown en HTML. Hierbij is het ook mogelijk om met style sheets de tekst van opmaak te voorzien. 

# Voorbeelden van de gevraagde elementen:
## Headings:
Headings zijn eigenlijk kopteksten met een groter lettertype dat ook een groter aantal pixels kent en dus "bold" is.
Deze worden aangemaakt met of een x aantal #.  
Met 1 \# maak je een level 1 heading en met 6 \#\#\#\#\#\# een level 6 heading.

Hierbij is het een best practice, en vaak nodig, om een spatie te plaatsen tussen de \# en de tekst van de heading.

## Codeblocks:
Codeblocks worden toegevoegd door "Fenced Code Blocks" te creëren. Dit kan door een code block te plaatsen tusse 3 backticks of tildes (\` of ~).
Dus bijvoorbeeld:

\~\~\~  
some code  
\~\~\~   

wordt:
~~~  
some code
~~~  

## Bold tekst
Voor bold tekst worden er 2 \* voor en na de tekst geplaatst.
Dus \*\* dit is bold tekst\*\* wordt gerenderd als **dit is bold tekst**.

## Het toevoegen van urls:
Om op een snelle manier een url toevoegen gebeurt door de url tussen punthaakjes oftewel < > te plaatsen; vaak is een volledige url echter ook al voldoende.


Een url toevoegen als een tekst wordt gedaan door de tekst die als link fungeert tussen blokhaakjes oftewel [ ] te plaatsen en de url zelf tussen haakjes ( ).

Als voorbeeld:
**[deze link gaat naar google.com](url naar google)** wordt gerenderd als [deze link gaat naar google.com](https://google.com/)

# Extraas:
## Het toevoegen van schuine tekst:
Voor schuine tekst wordt een enkele \* voor en na een tekst gebruikt.
\*deze tekst wordt schuin gerenderd\* zal dus gerenderd worden als *deze tekst wordt schuin gerenderd*.

## Het "escapen" van tekens.
Doordat sommige tekens worden gebruikt als onderdeel van de codeertaal en dusdanig een bepaaldse betekenis kennen is het soms nodig om deze betekenis via "escaping" te voorkomen. In markdown wordt hier de \\ voor gebruikt.

## Het toevoegen van images:
Een image kan worden toegevoegd door een ! en een alt-tekst en link naar het bestand op te geven. Deze link staat bij GitHub in de lokale "includes" directory.
De syntax is hier \!\[Een alt tekst voor de afbeeldin\]\(url/link naar de afbeelding\).