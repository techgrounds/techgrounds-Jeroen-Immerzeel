# SEC-05 Asymmetric Encryption

# Key-terms
- Private/public key
- PKI
- RSA

# Opdracht

De opdracht vraag het volgende:
- Generate a key pair.
- Send an asymmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key. The recipient should be able to read the message, but it should remain a secret to everyone else. You are not allowed to use any private messages or other communication channels besides the public Slack channel. Analyse the difference between this method and symmetric encryption.

# Gebruikte bronnen
De website https://travistidwell.com/jsencrypt/demo/
# Ervaren problemen
Geen.

# Resultaat

*"1: Generate a key pair"*

Dit gaat via de in de opdracht gelinkte website https://travistidwell.com/jsencrypt/demo/

De private key is in mijn geval:
----BEGIN RSA PRIVATE KEY-----
MIICWgIBAAKBgHueF8o6TCsE7VRHZth5eP/rxBRfPc3LlH12tKhqR/pRiQl+AFyL
BtUhy3p9gCi3nxQz2+9a7NlA95i/fBSziD6WHMGJS/BHATS8m3qzKL58rjD4Zfuc
LagxSNN4VU9Vy00JSUMMyPmjVCf4Kfdit0+37sZqSrX0IWqYppY2hkL/AgMBAAEC
gYAkl0RFeQIozbmOc+Aufa5iWqBcw2Bg9TzL8oJBQ8xwfQgKRkDHI+Pu3KUFafaw
lsHA0iTs8cYf/MoNbcjFu+q85dIOGXG0+xPuWbl561MjyaR/E1dxJjThS9+CztJt
AEnWU3uoYhhaGLt31S/d71KAcYspYHro0hPI9YjjVeoViQJBAO/9tcQ8zMsQI4yB
oNIY2+SVQN9KLyfSBCO15Y4uzpPttnqX5ZY2ASF9lIJBcVVI4rOsNKROVcRaMsCa
xaP6200CQQCD3Rc0X+i8ZRKJ2mFe7hZXOCom4QPEE/a00QKaOp3piVwNhnA+wZQU
jNAhNBymKZvghAnhRcVgxN5hWFtB9fl7AkA7lyLYHES5s0Mwc0uMf5GyO4FFMHVv
DM3sVBEw8dxnjOH/pNHkL3quZzFF+pv6kkOAW6UimzTesYrimkuzAOoNAkARPcI/
9d5fa7O91JDwsZ64Lr7MMJWmeJnEUKPPeKSXGX+wwQhCHFt5SGQaQ08Pptcbxwfn
rZC+M1+ESOI9wKSrAkAbSkgIN7bSFSRTeeoosFJfAOwV5NlfMZgBRL3P9kgwkoWM
Bznr1RakDNOelUkuXl0rMWoxcgO8V4PADQzi2Whe
-----END RSA PRIVATE KEY-----

En de public key:

-----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgHueF8o6TCsE7VRHZth5eP/rxBRf
Pc3LlH12tKhqR/pRiQl+AFyLBtUhy3p9gCi3nxQz2+9a7NlA95i/fBSziD6WHMGJ
S/BHATS8m3qzKL58rjD4ZfucLagxSNN4VU9Vy00JSUMMyPmjVCf4Kfdit0+37sZq
SrX0IWqYppY2hkL/AgMBAAE=
-----END PUBLIC KEY-----

---

*"2: Send an asymmetrically encrypted message to one of your peers via the public Slack channel. They should be able to decrypt the message using a key. The recipient should be able to read the message, but it should remain a secret to everyone else. You are not allowed to use any private messages or other communication channels besides the public Slack channel. Analyse the difference between this method and symmetric encryption."* 

Het verzenden van een asymmetrisch versleuteld bericht is zeer simpel en gaat via deze stappen:
- Aanmaken van 2 public/private keypairs; 1 voor ieder
- Het delen van elkaars public keys
- Het versleutelen van het bericht met de public key van de ontvanger
- Het opsturen van het bericht
- Het ontsleutelen met de private key



Bij een private/public key pair is de (wiskundige) handeling tot versleuteling met de public key alleen terug te draaien door ontsleuteling met de private key.   De public key wordt in deze dus gedeeld en gebruikt voor versleuteling; de private key blijft geheim en gebruikt voor ontsleuteling.

Dit is dus veel veiliger dan bij symmetrisch versleutelen omdat de sleutel waarmee versleuteld wordt niet hetzelfde is als de sleutel waarmee ontsleuteld wordt; dit waar de sleutel bij symmetrische versleuteling wel hetzelfde is.

![Aanmaken RSA](/00_includes/Networking_Images/RSA1.png)


Een asymmetrische sleutel werkt met een zogenaamde "one-way function": een term in de informatica voor een wiskundige functie die, theoretisch, maar op 1 manier kan worden uitgevoerd. De vraag is echter of dit werkelijk bestaat; de complexiteit van de huidige implementaties laat hier nog geen duidelijk antwoord over zijn. Voor assymetrische sleutels is het echter zo dat deze voldoende complex zijn en er nog geen manieren zijn gevonden om deze op een andere manier te ontsleutelen dan met de private key.