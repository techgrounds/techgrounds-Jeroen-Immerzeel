# NTW-04 Counting in Binary and Hex


## Key-terms
- Binary
- Decimal
- Hexadecimal

# Opdracht
Deze opdracht gaat over het rekenen/tellen in binary en hexadecimal noteringen en kent een aantal opdrachten tot het omrekenen van hex en binary naar decimale getallen.


## Gebruikte bronnen
- Het boek CompTIA Network+ Study guide Fifth Edition
- https://www.techtarget.com/whatis/definition/nibble voor de afbeelding

## Ervaren problemen
Weinig. Deze stof kende ik al vanuit zowel mijn MBO opleiding als een leuke manier van puzzelen. 

# Uitwerking
Wat zijn de verschillen tussen **decimal** **hexadecimal** en **binary**??
- **Decimal** zijn de cijfers die we kennen 0-9.
- **Hexadecimal** is een base 16 systeem waarbij er naast 0-9 ook ABCDEF wordt gebruikt voor de notatie van de cijfers 10 t/m 15.
- **Binary** is het systeem waarbij er alleen met 0 en 1 gewerkt wordt en deze samen een byte vormen. 

## Binary
Een binair getal bestaat uit 8 bits welke een byte vormen. Bit kennen 2 mogelijke posities; 0 of 1.  

Als een positie een 1 is, wordt deze gebruikt; is het 0 wordt deze niet gebruikt.  

Een byte positie bestaat uit 8 bits welke een macht van 2 vormen. Hierbij heeft de meest rechter bit de waarde 1 is en de meest linker bit de waarde 128; oftewel 2^1(1) en 2^8(128). Het decimale getal 0 is 2^0 en dus staan dan alle bits uit c.q. op 0.
Binaire getallen kunnen hierom 256 waardes hebben; 0 - 255.


Om dit uit te beelden in 5 decimale getallen:  
00000000  is 0   
01010101 is 85  
00001111 is 15  
11110000 is 240   
1111111 is 255  

Om van een decimaal getal een binair getal te maken wordt deze verminderd met de waardes van elke positie van links(128) naar rechts (1) zolang deze geen negatief getal geven.  

Als voorbeeld:  
141 ->
- 141 kan met 128 worden verminderd waarbij 13 overblijft, dus de 128 positie wordt een 1.
- 13 is niet te verminderen met 64, 32 of 16 zonder op een negatief getal uit te komen, dus die posities blijven opp 0 staan. 
- 13 is te verminderen met 8 waarbij er 5 overblijft, dus de 8 positie wordt een 1 
- 5 is te verminderen met 4 waarbij er 1 over blijft, dus de 4 positie wordt een 1 , en er blijft 1 over.
- 1 is niet te verminderen met 2, maar wel met 1, dus de 2 blijft een 0, en de 1 wordt een 1   

Dus de uiteindelijke binaire notatie van het decimale getal 141 is: 10001101


Om van een binair getal een decimaal getal te maken worden de waardes van de 1-bits bij elkaar opgeteld.  
Voorbeeld:  
01010111 ->
- 128 -> 0   
- 64 -> 1  
- 32 -> 0  
- 16 -> 1  
- 8 -> 0  
- 4 -> 1  
- 2 -> 1  
- 1 -> 1 

Vervolgens worden de getallen die een 1 hebben bij elkaar opgeteld:  
64 + 16 + 4 + 2 + 1 = 87  
01010111 is dus 87



## Hexadecimal:
Bij hexadecimal wordt een decimaal getal omgerekend naar hex door een **_nibble_** te maken. Een nibble is een binair getal door tweeën gesplitst: 0000 ipv 00000000. 
Voor de eerste nibble zijn de waardes van de postities:  
- 128  
- 64  
- 32  
- 16  


Voor de tweede nibble zijn de waardes:  
8  
4  
2   
1  
Deze bestaat dus uit de waardes 0 t/m 15; oftewel 0-F.

Door de *nibbles* om te rekenen kan je van een Hex een decimaal getal maken of v.v. door of beide nibbles apart te nemen (bij dec naar Hex) of samen te voegen en op te tellen zoals bij binair naar dec (bij Hex naar dec) 

![De vergelijking tussen nibbles, Hex en decimale getallen](/00_includes/Networking_Images/nibble_hex_dec.png)
*De vergelijking tussen nibbles, Hex en decimale getallen*

### Voorbeelden:  
Omrekenen van Hex naar dec gaat zo:   
F6 ->
F is binair 1111  
6 is 6   
De eerste nibble is 1111 dus 128 + 64 + 32 + 16 = 240  
6 is 6  
240 + 6 is 246; F6 is dus 246.

Omrekenen van dec naar Hex gaat zo:  
157 ->
- 157 vetaald naar binair is 10011101  (128 + 16 + 8 + 4 + 1)
- Maak nibbels van het binaire getal: 1001 1101   
- Reken beide nibbles uit:
- 1001 is 8 + 1 = 9 
- 1101 is 8 + 4 + 1 = 13  
- Zet getallen van 10 tot 15 om in letter notering: 
- 13 is D  
- Zet beide tekens naast elkaar.
- De uitkomst is dan 9D



## *"Translate the following decimal numbers into binary:"* 

Decimal | Binary  
---
16   --> 0001 0000   
128 -->  1000 0000  
228 --> 1110 0100  
112 --> 0111 0010  
73  --> 0100 0111




## *Translate the following binary numbers into decimal:*  
Binary | Decimal 
---
1010 1010 --> 170  
1111 0000 ---> 240  
1101 1011 --> 221  
1010 0000 --> 160  
0011 1010 --> 58  




## *Translate the following decimal numbers into hexadecimal:*  
Decimal | Hex
---
15 --> 0000 1111 -> 0F  
37 --> 0010 0101 -> 25   
246 --> 1111 0110 -> F6  
125 --> 0111 1110 > 7D  
209 --> 1101 0001 -> D3 




## *Translate the following hexadecimal numbers into decimal:*
Hex | Decimal 
---
88 -> 10001000 -> 136  
e0 -> 1110 0000 -> 224  
cb -> 1100 1011 -> 203   
2f -> 0010 1111 -> 47  
d8 -> 1101 -> 1000 -> 216 



