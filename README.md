# Dynamic routing through IPSEC VTI
Few configs for strongswan and bird routing daemon. After establishing IPSEC connection, strongswan executes shell script which creates VTI interface, assigns IP address (based on leftid parameter) and generates a new bird config which pointed to previously defined BGP template. Visual scheme for this stuff:

    1.2.3.4                           2.3.4.5
     host1--10.1.1.1--mark1--10.1.1.2--host2
    10.2.1.1                          10.3.1.1 
          \                           /
           \                         /
            \                       /
             \                     /
              \                   /
              mark2            mark3
                \               /
                 \             /
                  \           /
                   \         /
               10.2.1.2   10.3.1.2
                      host3
                     3.4.5.6
    
1.2.3.4, 2.3.4.5 & 3.4.5.6 are WAN IP addresses of host1, host2 & host3 respectively. Interface names use vti + connection_name scheme. 
More info about VTI could be found here https://wiki.strongswan.org/projects/strongswan/wiki/RouteBasedVPN

P.S. DON'T FORGET TO DISABLE install_routes IN charon.conf!!!
