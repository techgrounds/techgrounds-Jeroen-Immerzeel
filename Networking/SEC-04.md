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

## *"1: Find one more historic cipher besides the Caesar cipher."  
Het **Enigma Cipher**.

Dit is het cipher dat de Duitsers gebruikte tijdens de Tweede Wereldoorlog en door het gebruik van een Enigma machine zo moeilijk te kraken was dat de Britten onder leiding van Alexander Turing er een computer voor bouwden genaamd de "Bombe Machine".

Dit cipher maakte gebruik van substitutie, net als het Cesar Cipher, maar ook van een dagelijks veranderde "seed" (een basis getal of letter) en een systeem waarbij bij elke input de substitutie veranderde. Waar het Cesar cipher binnen dezelfde en/decodering een A altijd een C wordt, was het bij het enigma cipher zo dat een A eerst een C werd en daarna elk andere letter kon zijn.
Daarnaast was er een systeem van switch boards en rotors om de codering nog complexer te maken.

Er was slechts 1 zwak punt in het enigma cipher: een letter kon nooit in zichzelf gecodeerd worden; een A kon dus nooit een A zijn. Daarnaast werden er veelgebruikte teksten gebruikt zoals het weerbericht, of een groet als "Heil Hitler". Dit gaf de mogelijkheid om via logica de codering te breken. 

___

## *"2: Find two digital ciphers that are being used today."

**RSA**  
RSA is een asymmetrisch cipher dat aan de basis ligt van het Public Key Interface (**PKI**) waarbij er een Public/Private keypair wordt aangemaakt. 
 

Bij een **PKI** wordt data met de public key versleuteld waarna het alleen met de private key kan worden ontsleuteld. Iedereen mag het public key kennen; de private key is wat er geheim gehouden moet worden.

**AES**

AES is een symmetrisch cipher dat de opvolger is van DES dat in 2001 door het NIST is verkozen.   
Als zijnde een symmetrisch cipher, word AES met dezelfde sleutel versleuteld als deze ontsleuteld wordt. 

AES wordt voor heel veel dingen gebruikt; van versleuteling door BitLocker tot compressie met RAR en 7ZIP als voor end-to-end encryption in WhatsApp en andere apps. Dit cipher is dus zeer belangrijk in de huidige praktijk.
___
## *"3: Send a symmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key you share with them. Try to think of a way to share this encryption key without revealing it to everyone. You are not allowed to use any private messages or other communication channels besides the public Slack channel. Analyse the shortcomings of symmetric encryption for sending messages."*

Dit is een leuke opdracht en heeft wat logisch omdenken nodig. En de enige oplossing die wel kan werken binnen de beperkingen van de opdracht is eigenlijk vals spelen door de symmetrische sleutel te versleutelen met een symmetrische sleutel. Maar dat was wel de oplossing volgens onze learning coach.

De stappen om deze oplossing uit te voeren zijn: 
- Het aanmaken van de symmetrische sleutel en een asymmetrisch sleutel paar. (beide partijen)
- Het delen van de publieke sleutel van de ontvanger
- Het maken van een bericht en deze versleutelen met de symmetrische sleutel
- Het versleutelen van de symmetrische sleutel in de asymmetrische publieke sleutel van de ontvanger
- Het versturen van het versleutelde bericht en de versleutelde symmetrische sleutel naar de ontvanger
- De ontvanger ontsleuteld dan eerst de versleutelde sleutel en daarna het bericht met de symmetrisch sleutel

Een andere mogelijkheid om in het geheim berichten te verzenden is via steganography: het verbergen van data van het ene bestand in een ander bestand. Hierbij kan de **Alternate Data Stream (ADS)** van het NFS filesysteem in Windows worden gebruikt of bepaalde gespecialiseerde programma's als ```steghide``` in Linux. 

# Extra opdracht:
## *"Asymmetric Key generation on our VM. Instead of using an online tool, in this exercise we're going to use the GPG program on our VM to generate a key."* 

Voor ```GPG``` is de syntax redelijk simpel: ```gpg [OPTIONS][FILES]```
In deze moet er een assymmetrische sleutel worden aangemaakt daarvoor is de optie ```--generate-key```

Om zeker te zijn dat alles werkt zoals de verwachting is kan er gekozen worden om een "dry run" te draaien waarbij wel alle stappen worden doorlopen maar er geen echte keys worden aangemaakt.   
Dit kan met de ```-n```optie.

Het eerste commando wordt dan ```gpg -n --generate-key```.  
De stappen welke dan worden doorlopen zijn:
- Het vragen van persoonlijke informatie als naam en e-mailadres.
- Het vragen naar een passphrase.
- Het genereren van de keys waarbij extra muisbewegingen en toetsaanslagen worden gevraagd voor "entropy"(de basis van de willekeurige tekens)
- Het aanmaken van de opslag locaties mocht dit nodig zijn
- Het rapporteren van de handelingen.

![Enter Passphrase](/00_includes/Networking_Images/gpg_passphrase_is_Techgrounds.png)  
*Enter Passphrase* 

![Melding van een zwak wachtwoord](/00_includes/Networking_Images/gpg_passphrase_Techgrounds_insecure.png)  
*passphrase is weak* 

![gpg dry run](/00_includes/Networking_Images/gpg_dryRun.png)
*GPG dry run* 

Een echte run is bijna hetzelfde als een dry run, echter wordt de ```-n``` optie niet gebruikt en is het commando dus ```gpg --generate-key```

![aanmaken van GPG key pair](/00_includes/Networking_Images/gpg_fullrun.png)
*aanmaken van GPG key pair*

Nadat een keypair is aangemaakt word de public key getoond in de output en de private key opgeslagen in de private-keys-v1.d subdirectory in de .gnupgp directory:
![.gnugpg directory](/00_includes/Networking_Images/gpg_folder.png)
*gnupgp directory*

![gpg public key](/00_includes/Networking_Images/gpg_public_key.png)
*de public key*
