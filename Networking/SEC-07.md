# SEC-07 Passwords

# Key-terms


# Opdracht

De opdracht vraag het volgende:
- Find out what hashing is and why it is preferred over symmetric encryption for storing passwords.
- Find out how a Rainbow Table can be used to crack hashed passwords.
- Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table.
**03F6D7D1D9AAE7160C05F71CE485AD31**
**03D086C9B98F90D628F2D1BD84CFA6CA**
- Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table.
Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes.

# Gebruikte bronnen

# Ervaren problemen

# Resultaat

*"1: Find out what hashing is and why it is preferred over symmetric encryption for storing passwords."
"*2: Find out how a Rainbow Table can be used to crack hashed passwords."*
*"3: Below are two MD5 password hashes. One is a weak password, the other is a string of 16 randomly generated characters. Try to look up both hashes in a Rainbow Table."*
Hash 1: **03F6D7D1D9AAE7160C05F71CE485AD31**
Hash 2: **03D086C9B98F90D628F2D1BD84CFA6CA**

*"4_1: Create a new user in Linux with the password 12345. Look up the hash in a Rainbow Table."

*"4_2: Despite the bad password, and the fact that Linux uses common hashing algorithms, you won’t get a match in the Rainbow Table. This is because the password is salted. To understand how salting works, find a peer who has the same password in /etc/shadow, and compare hashes."*