# Linux opdrachten 5 tot en met 8
*Dit zijn de laatste 4 opdrachten voor Linux samengevoegd**

# Opdracht LNX-05: File Permissions

Deze opdracht gaat over het beheren van de rechten binnen Linux.

Binnen deze opdracht worden de volgende 6 deelopdrachten gevraagd:

- Create a text file.
- Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?
- Make the file executable by adding the execute permission (x).
- Remove the read and write permissions (rw) from the file for the group and everyone else, but not for the owner. Can you still read it?
- Change the owner of the file to a different user. If everything went well, you shouldn’t be able to read the file unless you assume root privileges with ‘sudo’.
- Change the group ownership of the file to a different group.

### *"1:Create a text file."*
Deze opdracht is simpel en kan op meerdere manieren:
- echo "tekst" > file.txt
- touch > file.txt
- met een tekst editor als VIM, Nano of Emac 

Wat ook leuk is om te weten is dat in Linux elke file een tekstbestand is, en dat een extensie niet nodig is; deze zijn er puur voor de gebruiker om snel te zien waarvoor een bestand gebruikt wordt. 

![Het aanmaken van een tekstfile]()


### *2: Make a long listing to view the file’s permissions. Who is the file’s owner and group? What kind of permissions does the file have?*

Deze deelopdracht ken een aantal onderdelen.
Een *long listing* gaat via het **ls -l** commando.

![Long listing van de aangemaakte permissions.txt]

De file's owner en group worden hierbij getoond: er staan na de effectieve permissions en het aantal links, 2 namen in de listing: de eerste is de user en de tweede de group waartoe een file toe behoort.  
Dus de aangemaakte file kent als **owner jeroen_** en als **group jeroen_**.
De permissions op de file zijn: *-rw-rw-r--*. 
Hierbij worden de permissions onderverdeeld in:
- read (r)
- write (w)
- execute (x)  

Omdat de permissies worden gelezen als *file type code* user, group, others kent deze file de volgende permissions per onderdeel:
- User: read en write
- Group read en write
- Others read

```
Files en directories kennen iets andere definities voor de permissions:
Files:
**Read** geeft permission om de inhoud van de file te lezen.
**write** geeft permission om de inhoud van een file aan te passen.
**execute" geeft de permission tot het uitvoeren van de file als zijne een binary of script.

Directories:
**read** geeft permission om de inhoud in de directory te bekijken.
**write** geeft permission om het aanpassen van de files in de directory.
**execute** geeft permission om de directory als working directory te gebruiken, dit zolang dit ook geldt voor parent directories.
```





# Opdracht naam

Deze opdracht gaat over

Binnen deze opdracht worden de volgende n deelopdrachten gevraagd:

### *"n: "*