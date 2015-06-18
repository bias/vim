% DB overview
% blah
% blah

# Documentation (what is happening?)
* no overview (design and planning is happening at same time)
* Platform Transformation /.../ Dotcom Oracle Upgrade
* diagrams for enterprise security


# What are we talking about ???
* calling this a production like enviroment
* production environment
* interconnects / san (infiniband 8tb)
* 250k / month lease on HW

* use chef / kickstart servers for setup (redhat servers)
* logical standby (transition of production environment failure)
* vlan tagging (sakru)
* liscensing during migration
* zfs - exadata?


# Thoughts ???

## how many clusters/enviroments exist?
* 5-6 enviroments
* clone of environments for development work (oracle xe)
* dev 1,2 
* qa 1,3

Server admins vs dba admins vs network admins (infrastructure / architecture / CM)
networking and ops [anything server base]
Configuration management spanning all infrastructure (nagios like)
