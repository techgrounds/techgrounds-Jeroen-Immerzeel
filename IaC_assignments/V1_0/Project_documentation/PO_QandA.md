# Product owner information
Vragen aan de product owner:

Q: Which location/region?:
A: Free to choose due to the lack of options with some resources
(nearest region first)

Q: How and when must de webserver be automatically installed? 
A: At deployment.

Q: What operating system do the servers need?
A: Our own choice; must be logic/reasoned

Q: What has to be stored in storage account?
A: Scripts, data

Q: What data replication?
A: None is needed; back-ups are used
(may be done as an extra improvement later on)

Q: What storage tiers? 
A: Not part of of the assignment; so keep "hot"

Q: Is there need to access the data from the internet?
A: No, just the admin

Q: Is public IP needed?
A: Yes, but access limited to the admins

Q: Which assignment type of the IP?
A: Static

Q: Which IP is the admin IP?
A: IP for Admin is our home

Q: Need for multiple storage account?
A: No

Q: There are 2 subnets, part of seperate Vnets?
A: Yes, separate vnets

Q: Specs of the VMs?
A: No requirements, no heavy traffic or processing. Just the basic needs.

Q: Protection of network is basic, or more involved?
A: Just basic allow/deny rules.

Q: Extra requirements for the admin server?
A: Just that it is only reachable by admin, as by the paper.

Q: Are there alerts needed?
A: Not part of this version.

Q: Back-ups: daily full or snapshots? 
A: Just daily back-ups/snapshots of both servers.
(back-ups are in Azure of all services)
(time is by convenience)

Q: What is the budget for usage?
A: Part of justification, but not a particular demand as of yet. Just the €50 budget for building. 

Q: Availability zones are needed?
A: By justification you can choose differently.
 

Extra:
no hybrid, complete migration
No need for higher tier compute and the likes; just the basic
PO tip: do not experiment yet; next part is a better moment.