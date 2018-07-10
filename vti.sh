#!/bin/bash

MARK=${PLUTO_MARK_IN%/*}
IF=vti$PLUTO_CONNECTION
BIRDCFG=/etc/bird/bgp_$PLUTO_CONNECTION.conf

case "$PLUTO_VERB:$1" in
up-client:)
  ip tunnel add $IF local $PLUTO_ME remote $PLUTO_PEER mode vti key $MARK
  ip link set $IF up
  sysctl -w net.ipv4.conf.$IF.disable_policy=1
  ip a a $PLUTO_MY_ID/30 dev $IF
cat > $BIRDCFG << EOF
protocol bgp $PLUTO_CONNECTION from bgp_template {                  
  neighbor $PLUTO_PEER_ID as 64512;                                               
} 
EOF
  ;;
down-client:)
  ip link delete $IF
  rm $BIRDCFG
  ;;
esac
birdc configure

