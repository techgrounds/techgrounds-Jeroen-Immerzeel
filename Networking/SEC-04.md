# SEC-04 Symmetric Encryption

# Key-terms
- Ciphers
- Encryption


# Opdracht

De opdracht vraag het volgende:
- Find one more historic cipher besides the Caesar cipher.
- Find two digital ciphers that are being used today.
- Send a symmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key you share with them. Try to think of a way to share this encryption key without revealing it to everyone. You are not allowed to use any private messages or other communication channels besides the public Slack channel. Analyse the shortcomings of symmetric encryption for sending messages.


# Gebruikte bronnen

Stuk over het Enigma Cipher: <https://brilliant.org/wiki/enigma-machine/>

# Ervaren problemen
Het was onduidelijk wat deelopdracht 3 nu werkelijk vraagt. 


# Resultaat

*"1: Find one more historic cipher besides the Caesar cipher."  
Het **Enigma Cipher**.

Dit is het cipher dat de Duitsers gebruikte tijdens de Tweede Wereldoorlog en door het gebruik van een Enimga machine zo moeilijk te kraken was dat de Britten onder leiding van Alexander Turing er een computer voor bouwden genaamd de "Bombe Machine".

Dit cipher maakte gebruik van substitutie, net als het Cesar Cipher, maar ook van een dagelijks veranderde "seed" (een basis getal of letter) en een systeem waarij bij elke input de substitutie veranderde. Waar het Cesar cipher binnen dezelfde en/decodering een A altijd een C wordt, was het bij het enigma cipher zo dat een A eerst een C werd en daarna elk andere letter kon zijn.
Daarnaast was er een systeem van switch boards en rotors om de codering nog complexer te maken.

Er was slechts 1 zwak punt in het enimga cipher: een letter kon nooit in zichzelf geencodeerd worden; een A kon dus nooit een A zijn. Daarnaast werden er veelgebruikte teksten gebruikt zoals het weerbericht, of een groet als "Heil Hitler". Dit gaf de mogelijkheid om via logica de codering te breken. 

___

*"2: Find two digital ciphers that are being used today."

**RSA**  
RSA is een asymmetrisch cipher dat aan de basis ligt van het Public Key Interface (**PKI**) waarbij er een Public/Private keypair wordt aangemaakt. 
 

Bij een **PKI** wordt data met de public key versleuteld waarna het alleen met de private key kan worden ontsleuteld. Iedereen mag het public key kennen; de private key is wat er geheim gehouden moet worden.

**AES**

AES is een symmetrisch cipher dat de opvloger is van DES dat in 2001 door het NIST is verkozen.   
Als zijnde een symmetrisch cipher, word AES met dezelfde sleutel versleuteld als deze ontsleuteld wordt. 

AES wordt voor heel veel dingen gebruikt; van versleuteling door BitLocker tot compressie met RAR en 7ZIP als voor end-to-end encryption in WhatsApp en andere apps. Dit cipher is dus zeer belangrijk in de huidige praktijk.
___
*"3: Send a symmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key you share with them. Try to think of a way to share this encryption key without revealing it to everyone. You are not allowed to use any private messages or other communication channels besides the public Slack channel. Analyse the shortcomings of symmetric encryption for sending messages."*

Dit is een leuke opdracht en heeft wat logisch omdenken nodig. En de enige oplossing die wel kan werken binnen de beperkingen van de opdracht is eigenlijk vals spelen door de symetrische sleutel te versleutelen met een symmetrische sleutel.

De stappen zijn dan: 
- Het aanmaken van de symmetrische sleutel en een assymetrisch sleutel paar. (beide partijen)
- Het delen van de publieke sleutel van de ontvanger
- Het maken van een bericht en deze versleutelen met de symmetrische sleutel
- Het versleutelen van de symmetrische sleutel in de asymetrische publieke sleutel van de ontvanger
- Het versturen van het versleutelde bericht en de versleutelde symmetriche sleutel naar de ontvanger
- De ontvanger ontsleuteld dan eerst de versleutelde sleutel en daarna het bericht met de symmetrisch sleutel

Een andere mogelijkheid is steganography: het verbergen van data van het ene bestand in een ander bestand. Hierbij kan de **Alternate Data Stream (ADS)** van het NFS filesysteem in Windows worden gebruikt of met bepaalde programma's als ```steghide``` in Linux. 