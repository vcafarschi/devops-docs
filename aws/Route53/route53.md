# DNS overview
<table border="0">
 <tr>
    <td><img src="images/dns-hierarcy.svg"></td>
</table>

## How DNS works ?
![](images/domain-resolution.svg)

0. Let's assume we bought a domain name **vcafarschi.com**
1. A user opens a web browser, enters **vcafarschi.com** in the address bar, and presses Enter.
2. The first stop for the DNS request is the local DNS cache
3. If the IP address is NOT found in **local DNS cache**, then the request is routed to a DNS resolver, which is typically managed by the user's Internet service provider (ISP), such as a cable Internet provider, a DSL broadband provider, or a corporate network.
4. The ISP DNS resolver forwards the request for **vcafarschi.com** to a DNS root name server.
5. The root server then responds to the resolver with the address of a Top Level Domain **.com**
6. The DNS resolver for the ISP forwards the request for **vcafarschi.com** again, this time to one of the TLD name servers for **.com** domains. 
7. The **TLD** name server for **.com** domains responds to the request with the names of the four Amazon Route 53 Authoritative name servers that are associated with the **vcafarschi.com** domain.
8. The DNS resolver for the ISP chooses an Amazon Route 53 Authoritative name server and forwards the request for **vcafarschi.com** to that name server.
9. The Amazon Route 53 Authoritative name server looks in the **vcafarschi.com** hosted zone (Zone file) for the **vcafarschi.com** record, gets the associated value, such as the IP address for a web server, 192.0.2.44, and returns the IP address to the DNS resolver.
10. The DNS resolver for the ISP finally has the IP address that the user needs. The resolver returns that value to the web browser. The DNS resolver also caches (stores) the IP address for example.com for an amount of time that you specify so that it can respond more quickly the next time someone browses to example.com. For more information, see time to live (TTL).



## DNS Components
- Zone file
- There are 4 DNS servers involved in loading a webpage (DNS resolving)
  - DNS Resolver
  - Root Nameserver
  - Top Level Domain (**TLD**) Name Servers
  - Authoritative Name servers (NS) (The most important part when you buy a Domain name)


### Zone file
- A DNS zone file is a text file stored on **Name Servers**.
- It **contains** all the **records** for every domain within that zone. (mappings between domain names and IP addresses)
- It is mandatory for the zone file to have the TTL (Time to Live) listed before any other information. The TTL specifies how long a DNS record is in the server’s cache memory. 
- The zone file can only list one record per line.
- It will display the Start of Authority (SOA) record listed first. 
- The SOA record contains essential domain name information including the primary authoritative name server for the DNS Zone.


### DNS Resolver
- is a server designed to receive DNS queries from web browsers and other applications
- for example resolver receives a query for **www.vcafarschi.com** and is responsible for tracking down the IP address for that hostname
- resolver might be operated by the local network, an Internet Service Provider (ISP), a mobile carrier, a WIFI network, or other third party.


### Root Name Servers
- Get the Root Name Servers
    ```
    $ dig NS .
    ;; ANSWER SECTION:
    .			75641	IN	NS	m.root-servers.net.
    .			75641	IN	NS	b.root-servers.net.
    .			75641	IN	NS	c.root-servers.net.
    .			75641	IN	NS	d.root-servers.net.
    .			75641	IN	NS	e.root-servers.net.
    .			75641	IN	NS	f.root-servers.net.
    .			75641	IN	NS	g.root-servers.net.
    .			75641	IN	NS	h.root-servers.net.
    .			75641	IN	NS	a.root-servers.net.
    .			75641	IN	NS	i.root-servers.net.
    .			75641	IN	NS	j.root-servers.net.
    .			75641	IN	NS	k.root-servers.net.
    .			75641	IN	NS	l.root-servers.net.

    ;; ADDITIONAL SECTION:
    m.root-servers.net.	3514406	IN	A	202.12.27.33
    m.root-servers.net.	3597829	IN	AAAA	2001:dc3::35
    b.root-servers.net.	3580519	IN	A	199.9.14.201
    b.root-servers.net.	3543529	IN	AAAA	2001:500:200::b
    c.root-servers.net.	451848	IN	A	192.33.4.12
    c.root-servers.net.	3543527	IN	AAAA	2001:500:2::c
    d.root-servers.net.	3564565	IN	A	199.7.91.13
    d.root-servers.net.	3556395	IN	AAAA	2001:500:2d::d
    e.root-servers.net.	3566545	IN	A	192.203.230.10
    e.root-servers.net.	3514408	IN	AAAA	2001:500:a8::e
    f.root-servers.net.	3562318	IN	A	192.5.5.241
    f.root-servers.net.	3580519	IN	AAAA	2001:500:2f::f
    g.root-servers.net.	3564565	IN	A	192.112.36.4
    g.root-servers.net.	3562516	IN	AAAA	2001:500:12::d0d
    h.root-servers.net.	3559105	IN	A	198.97.190.53
    h.root-servers.net.	3552213	IN	AAAA	2001:500:1::53
    a.root-servers.net.	3562919	IN	A	198.41.0.4
    a.root-servers.net.	3577300	IN	AAAA	2001:503:ba3e::2:30
    i.root-servers.net.	3560004	IN	A	192.36.148.17
    i.root-servers.net.	3514407	IN	AAAA	2001:7fe::53
    j.root-servers.net.	3548151	IN	A	192.58.128.30
    j.root-servers.net.	3594726	IN	AAAA	2001:503:c27::2:30
    k.root-servers.net.	3550880	IN	A	193.0.14.129
    k.root-servers.net.	3562921	IN	AAAA	2001:7fd::1
    l.root-servers.net.	3572844	IN	A	199.7.83.42
    l.root-servers.net.	3580519	IN	AAAA	2001:500:9f::42
    ```
- There are more than 600 Root Server instances around the world
- They are reachable using 13 numeric IP addresses
- Each of the 13 IP addresses is assigned to multiple servers around the world, which use Anycast routing to distribute requests based on load and proximity.
- Root servers contain pointers to the Authoritative Name Servers for all top-level domains (*TLD*) as *.com* *.org* *.net*
  - Let's ask one of Root Name Servers (**a.root-servers.net.**) to get the **com.** Name Servers.
  - But you can just **dig NS com.** and during the request one of the Root Name Servers (a.root-servers.net. till m.root-servers.net.) will be picked.
    ```
    $ dig NS com. @a.root-servers.net.
    ;; AUTHORITY SECTION:
    com.			172800	IN	NS	a.gtld-servers.net.
    com.			172800	IN	NS	b.gtld-servers.net.
    com.			172800	IN	NS	c.gtld-servers.net.
    com.			172800	IN	NS	d.gtld-servers.net.
    com.			172800	IN	NS	e.gtld-servers.net.
    com.			172800	IN	NS	f.gtld-servers.net.
    com.			172800	IN	NS	g.gtld-servers.net.
    com.			172800	IN	NS	h.gtld-servers.net.
    com.			172800	IN	NS	i.gtld-servers.net.
    com.			172800	IN	NS	j.gtld-servers.net.
    com.			172800	IN	NS	k.gtld-servers.net.
    com.			172800	IN	NS	l.gtld-servers.net.
    com.			172800	IN	NS	m.gtld-servers.net.

    ;; ADDITIONAL SECTION:
    a.gtld-servers.net.	172800	IN	A	192.5.6.30
    b.gtld-servers.net.	172800	IN	A	192.33.14.30
    c.gtld-servers.net.	172800	IN	A	192.26.92.30
    d.gtld-servers.net.	172800	IN	A	192.31.80.30
    e.gtld-servers.net.	172800	IN	A	192.12.94.30
    f.gtld-servers.net.	172800	IN	A	192.35.51.30
    g.gtld-servers.net.	172800	IN	A	192.42.93.30
    h.gtld-servers.net.	172800	IN	A	192.54.112.30
    i.gtld-servers.net.	172800	IN	A	192.43.172.30
    j.gtld-servers.net.	172800	IN	A	192.48.79.30
    k.gtld-servers.net.	172800	IN	A	192.52.178.30
    l.gtld-servers.net.	172800	IN	A	192.41.162.30
    m.gtld-servers.net.	172800	IN	A	192.55.83.30
    a.gtld-servers.net.	172800	IN	AAAA	2001:503:a83e::2:30
    b.gtld-servers.net.	172800	IN	AAAA	2001:503:231d::2:30
    c.gtld-servers.net.	172800	IN	AAAA	2001:503:83eb::30
    d.gtld-servers.net.	172800	IN	AAAA	2001:500:856e::30
    e.gtld-servers.net.	172800	IN	AAAA	2001:502:1ca1::30
    f.gtld-servers.net.	172800	IN	AAAA	2001:503:d414::30
    g.gtld-servers.net.	172800	IN	AAAA	2001:503:eea3::30
    h.gtld-servers.net.	172800	IN	AAAA	2001:502:8cc::30
    i.gtld-servers.net.	172800	IN	AAAA	2001:503:39c1::30
    j.gtld-servers.net.	172800	IN	AAAA	2001:502:7094::30
    k.gtld-servers.net.	172800	IN	AAAA	2001:503:d2d::30
    l.gtld-servers.net.	172800	IN	AAAA	2001:500:d937::30
    m.gtld-servers.net.	172800	IN	AAAA	2001:501:b1f9::30
    ```


### Top Level Domain (**TLD**) Name Servers
- the TLD Name Server takes the domain name provided in the query google.com - and provides the **Authoritative Name Server**
  - Let's ask one of TLD Name Servers (**d.gtld-servers.net.**) to get the Name Servers of **google.com**
  - But you can just **dig NS google.com.** and during the request one of the TLD Servers (a.gtld-servers.net. till m.gtld-servers.net. ) will be picked
  ```
  $ dig NS google.com. d.gtld-servers.net.
  ;; ANSWER SECTION:
  google.com.		284354	IN	NS	ns1.google.com.
  google.com.		284354	IN	NS	ns3.google.com.
  google.com.		284354	IN	NS	ns4.google.com.
  google.com.		284354	IN	NS	ns2.google.com.

  ;; ADDITIONAL SECTION:
  ns1.google.com.		276203	IN	A	216.239.32.10
  ns1.google.com.		284736	IN	AAAA	2001:4860:4802:32::a
  ns3.google.com.		344446	IN	A	216.239.36.10
  ns3.google.com.		338856	IN	AAAA	2001:4860:4802:36::a
  ns4.google.com.		296566	IN	A	216.239.38.10
  ns4.google.com.		338669	IN	AAAA	2001:4860:4802:38::a
  ns2.google.com.		276770	IN	A	216.239.34.10
  ns2.google.com.		284736	IN	AAAA	2001:4860:4802:34::a
  ```
- **Now, the question arises: how does the TLD name server know the address of the Authoritative Name server?**
- **The answer is simple: when you purchase any domain with the registrars like Godaddy or Namecheap, the registrars also communicate the domains to the TLD name server**
- CONTROLLED BY A REGISTRY OPERATOR

### Authoritative Name Server (Domain's Name Server)
- There are 2 type of Authoritative Name Servers:
  - Primary Name Server
    - Has read-write copy of the zine records
    - Each primary name server requires at least 1 secondary server for redundancy
  - Secondary Name Server
    - Has read-only copy of the zone record
- Authoritative Name Servers are organized using DNS Zones
- They are called “authoritative” because they can provide an authoritative, correct response as to what is the current IP for a specific domain
- **Authoritative Name Server** is a DNS server that contains **DNS records** for the specific domain.
- The Authoritative Name Server takes the domain name and subdomain, and if it has access to the DNS records, it returns the correct IP address to the DNS Resolver
- In some cases, the **Authoritative Name Server** will route the DNS Resolver to **another Name Server** that contains specific records for a **subdomain**, for example, **support.example.com**.
  - Let's ask one of **Authoritative Name Server** (**ns3.google.com.**) to get the IP address of **google.com**
  - But you can just **dig google.com** nd during the request one of the **Authoritative Name Server** (ns1.google.com. till ns4.google.com. ) will be picked
  ```
  dig A google.com. ns3.google.com.
  ;; ANSWER SECTION:
  google.com.		102	IN	A	142.250.184.110
  ```


## What happens when you buy a Domain ?

### Registry
- A domain name registry is an organization that manages top-level domain names. 
- They create domain name extensions, set the rules for that domain name, and work with registrars to sell domain names to the public.
- For example, **VeriSign** manages the registration of **.com** domain names and their associated domain name system

### Registrar
- The registrar is an accredited organization, such as **GoDaddy**, **AWS Route53** which sells domain names to the public.

### Registrant
- A registrant is the person or company that registers a domain name.
- Registrants can manage their domain name settings through their registrar.

![](images/domain-purchase-godaddy.svg)

0. Go to site **godaddy.com**
1. Make a request to buy **vcafarschi.com** domain name at **GoDaddy** Registrar (Fill in Techincal details, Contact Info and pay Registration fee).
    - Godaddy check the **vcafarschi.com** at **Verisign**, if it's available (Let's assume it's available). 
    - We check at **VeriSign**, because **VeriSign** is the registry responsible for **.com** TLD
2. **GoDaddy** Registrar allocates **Name Servers** (*ns-55.domaincontrol.com* ; *ns-56.domaincontrol.com*) for **vcafarschi.com** domain.
    - These 2 Name Servers are owned and controlled by GoDaddy Registrar
3. **GoDaddy** Registrar sends a request to **VeriSign** that **vcafarschi.com** domain should be resolved to *ns-55.domaincontrol.com* and *ns-56.domaincontrol.com* Name Servers (NS).
4. **VeriSign** then create 2 Name Server Records on their TLD Name Server, which host the .**com** TLD zone


## Routing traffic for subdomains
- When you want to route traffic to your resources for a subdomain, such as **dev.vcafarschi.com** or **prod.vcafarschi.com**, you have two options:
  - Create records in the hosted zone for the domain
  - Create a hosted zone for the subdomain, and create records in the new hosted zone (This way you can easily delegate the responsibility of the new hosted zone to a different team or aws account)
https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-routing-traffic-for-subdomains.html
https://www.youtube.com/watch?v=Hgv0__itc8Q&ab_channel=TheCloudAdvisory
dig trace

## DNS delegation
When you delegate multiple levels of subdomains in DNS, it is important to always delegate from the parent zone. For example, if you are delegating www.dept.example.com, you should do so from the dept.example.com zone, not from the example.com zone. Delegations from a grandparent to a child zone might not work at all or work only inconsistently- 

https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/CreatingNewSubdomain.html
https://www.youtube.com/watch?v=COaARRYXdts&ab_channel=MahendraPandey

## Key Features
- Domain registration
- Public and private DNS Service
- Healt-checks and traffic management via routing policy
- R53 resolver, rules and endpoints
- You can buy a domain for example from daddy.com but use the infrastructure from Route53
- Route53 offers 100% SLA.
  - this is done by allocating to hosted zone of 4 Name servers to be responsible for the zone
    - check the every NS is .com .net .co.uk .org; So if one goes down, all other will work
STRIPES add image



## Hosted Zones
- A hosted zone is a collection of records for a specified domain.
- A hosted zone is analogous to a traditional DNS zone file; it represents a collection of records that can be managed together.
- There are two types of zones:
  - Public host zone
  - Private hosted zone for VPC
- Amazon Route 53 automatically creates the Name Server (NS) and Start of Authority (SOA) records for the hosted zones.
- Amazon Route 53 creates a set of 4 unique name servers (a delegation set) within each hosted zone.
- You can create multiple hosted zones with the same name and different records.


## Public hosted zone
- Register domain names
- Route internet traffic to the resources for your domain
- Advanced routing policies
- Check the health of your resources

## Domain registration in AWS Route 53
![](images/domain-purchase-route53.svg)

## What if you accidently deleted the public hosted zone. 
- Let's suppose you accidentely *deleted* the **vcafarschi.com** **Public Hosted Zone**.
- After you Created *New* **Public Hosted Zone** with the same name **vcafarschi.com**, but your domain is not resolving to the records you put in the new hosted zone.

- Use whoiz to check what NS are used or use dig NS <domain-name>
- If you are using Route 53 as registrar, In the navigation pane, choose Registered Domains.
  - Choose the name of the domain for which you want to edit settings.
    ![](images/registered_domains.png)
- Change the NS records to match the new ones from your Newly created public hosted zone
  ![](images/pub-hosted-zone.png)
https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/domain-name-servers-glue-records.html#domain-name-servers-glue-records-adding-changing

 
## How to use a domain in AWS Route53 if you purchased it in a different registrar ( for example GoDaddy)?

![](images/godaddy_to_route53.svg)
0. Let's assume you bought **vcafarschi.com** domain in **Godaddy** (or other Domain Registrars) and you want to make Route53 the DNS Service for this domain.
1. Create a **Public hosted zone** that has the **same name as your domain**. It will tell Amazon Route 53 how you want to route traffic for your domain
    - When you create a hosted zone, Route 53 automatically creates a name server (NS) record and a start of authority (SOA) record for the zone. 
    - The NS record identifies the four name servers that Route 53 associated with your hosted zone.
2.  To make Route 53 the DNS service for your domain, you replace the Name Servers on **Godaddy** with these four name servers.
      - This way Godaddy will communicate the new **Name Servers** to the **TLD** name server.
    -  So whenever a request comes for **vcafarschi.com**, the TLD server will return Route53 NS and not the Godaddy ones.

## Private hosted zone
- Should be associated with VPC's
- Only accesible from those VPC'c
- For private hosted zones you can see a list of VPCs in each region and must select one.
- For private hosted zones you must set the following VPC settings to “true”:
  - enableDnsHostname
  - enableDnsSupport
- DNS queries for **private hosted zones** can be resolved by the Amazon-provided **VPC DNS** server only.
- You also need to create a DHCP options set.
- You cannot automatically register EC2 instances with private hosted zones (would need to be scripted).
- Integrate with on-premise private zones using forwarding rules and endpoints
QUESTIONABLE, is it ? // TODO check hybrid DNS
- You can extend an on-premises DNS to VPC
- You cannot extend Route 53 to on-premises instances.

## Aliases
- "**A**" record maps a Name to an IP Address
  - Example: vladcaf.com ==> 10.5.7.9
- "**CNAME**" maps a Name to another Name
  - Example: www.vladcaf.com ==> vladcaf.com
  - CNAME is invalid for naked/apex domains
  - Many AWS Services use a DNS Name (ELB's)
  - With just CNAME vladcaf.com ==> ELB (would not be valid)
- "**ALIAS**" record map a NAME to an AWS resource
  - Can be used for both for naked/apex and normal records
  - There is no charge for ALIAS requests pointing at AWS resources
  - You can have "**A**" record ALIAS and "**CNAME**" record ALIAS
  - Should be the same "Type" as what the record is pointing at
    - Example: ELB DNS is an "**A**" record, which mean you have to create an "A" record alias for ELB domain name


### Name servers
- When you create a hosted zone, it will create 2 records:
 - **NS** (Name servers)
 - **SOA** (Start of Authority)
- **NS** are actual servers which contain the information about domain name and perform the conversion/resolution
- **SOA** is a point towards Primary Name Server

- How Name Servers are chosen ?
 - No more than 2 name servers are overlapping (Shuffle-sharding)

## Anycast

## R53 Health checks
- Let you track the health status of your resources
- There are 2 enteties:
  - Health checkers
  - Health checks
- Health checks are separate from records, but are used by records
- Health checkers are located globally
- Health checkers, check every 30s (every 10 sec for extra cost)
- There are 3 types of checks:
  - Endpoint: health of specified resource
  - Calculated Health check : You can have 3 health-checks and then a calculated health-check status
  - CloudWatch alarm
![](images/)
- you can do for private as well with some lambda
- You can create an ALARM with SNS Notification when a Health checks fails so you get notified

ARCHITECTURE
ADD IMAGE


## Routing policy
- **Simple routing**
ADD IMAGE
  - Supports one record per Name
  - Each record can have multiple values
  - All values are returned in a random order
  - Client chooses and uses 1 value
  - *USE CASE*: use it when you want to route requests towards one service such as web server
  - DOES NOT support healtchecks, all values are returned for a record when queried
- **Failover routing**
ADD IMAGE
  - If the target of the health-check is "**Healthy**" the "**Primary**" record is used
  - If the target of the health-check is "**Unhealthy**" the "**Secondary**" record of the same Domane name is used
  - A nice bonus is that, because you dont create any health checks of your own, DNS Failover for ELB endpoints is available at no additional charge-you arent charged for any health checks.When setting up DNS Failover for an ELB Endpoint, you simply set Evaluate Target Health to true-you dont create a health check of your own for this endpoint:
  - *USE CASE*: When you want to configure **active/passive** failover architecture
ADD EXPLANATION
ADD IMAGE
USE CASE
- Weighted
ADD EXPLANATION
ADD IMAGE
USE CASE
- Geolocation
ADD EXPLANATION
ADD IMAGE
USE CASE
- Latency based
ADD EXPLANATION
ADD IMAGE
USE CASE
- Geoproximity
ADD EXPLANATION
ADD IMAGE
USE CASE



Geolocation vs Latency based

![](images/img1.png)

# Multi layer routing policy


# R53 logs to CloudWatch

- So you can run any analitycs Send the logs to:
  - cloudwatch
  - S3
  - Kinesis Firehose



![](images/img2.png)

- domain or subdomain that aws requested
- date and time of the request
- DNS record type (as A, AAAA)
- Route53 edge location that responded to the DNS query
- DNS response code ans as NoError and ServerFail
- You can create Cloudwatch Contributor Insights

# R53 Resolver Endpoints
- Enables hybrid DNS resolution over AWS Direct Connect and Managed VPN via Resolver Endpoints
- There are 2 types of Endpoints:
  -  Resolver **Inbound** Endpoints
  -  Resolver **Outbound** Endpoints

## R53 Resolver Inbound Endpoints
- Allows on-premise DNS servers to query Route53 Resolver attached to VPC
- ENI's reachable over AWS Direct Connect or VPN
- One Endpoint = one or more ENI's
- Limit 10.000 QPS per ENI

## R53 Resolver Outbound Endpoints