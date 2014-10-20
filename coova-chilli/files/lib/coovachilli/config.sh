#!/bin/sh

config_reload(){
	local cfg="$1"

	# Getting boolean options
	config_get_bool dhcpbroadcast $cfg dhcpbroadcast 0
	config_get_bool nodynip $cfg nodynip 0
	config_get_bool vlanlocation $cfg vlanlocation 0
	config_get_bool locationstopstart $cfg locationstopstart 0
	config_get_bool locationcopycalled $cfg locationcopycalled 0
	config_get_bool locationimmediateupdate $cfg locationimmediateupdate 0
	config_get_bool locationopt82 $cfg locationopt82 0
	config_get_bool coanoipcheck $cfg coanoipcheck 0
	config_get_bool noradallow $cfg noradallow 0
	config_get_bool proxymacaccept $cfg proxymacaccept 0
	config_get_bool proxyonacct $cfg proxyonacct 0
	config_get_bool dhcpmacset $cfg dhcpmacset 0
	config_get_bool dhcpradius $cfg dhcpradius 0
	config_get_bool noc2c $cfg noc2c 0
	config_get_bool eapolenable $cfg eapolenable 0
	config_get_bool uamanydns $cfg uamanydns 0
	config_get_bool uamanyip $cfg uamanyip 0
	config_get_bool uamnatanyip $cfg uamnatanyip 0
	config_get_bool nouamsuccess $cfg nouamsuccess 0
	config_get_bool nowispr1 $cfg nowispr1 0
	config_get_bool nowispr2 $cfg nowispr2 0
	config_get_bool domaindnslocal $cfg domaindnslocal 0
	config_get_bool radsec $cfg radsec 0
	config_get_bool macauth $cfg macauth 0
	config_get_bool macreauth $cfg macreauth 0
	config_get_bool macauthdeny $cfg macauthdeny 0
	config_get_bool macallowlocal $cfg macallowlocal 0
	config_get_bool strictmacauth $cfg strictmacauth 0
	config_get_bool strictdhcp $cfg strictdhcp 0
	config_get_bool ieee8021q $cfg ieee8021q 0
	config_get_bool only8021q $cfg only8021q 0
	config_get_bool radiusoriginalurl $cfg radiusoriginalurl 0
	config_get_bool swapoctets $cfg swapoctets 0
	config_get_bool statusfilesave $cfg statusfilesave 0
	config_get_bool wpaguests $cfg wpaguests 0
	config_get_bool openidauth $cfg openidauth 0
	config_get_bool papalwaysok $cfg papalwaysok 0
	config_get_bool mschapv2 $cfg mschapv2 0
	config_get_bool chillixml $cfg chillixml 0
	config_get_bool acctupdate $cfg acctupdate 0
	config_get_bool dnsparanoia $cfg dnsparanoia 0
	config_get_bool seskeepalive $cfg seskeepalive 0
	config_get_bool usetap $cfg usetap 0
	config_get_bool noarpentries $cfg noarpentries 0
	config_get_bool framedservice $cfg framedservice 0
	config_get_bool scalewin $cfg scalewin 0
	config_get_bool redir $cfg redir 0
	config_get_bool injectwispr $cfg injectwispr 0
	config_get_bool redirurl $cfg redirurl 0
	config_get_bool routeonetone $cfg routeonetone 0
	config_get_bool nousergardendata $cfg nousergardendata 0
	config_get_bool uamgardendata $cfg uamgardendata 0
	config_get_bool uamotherdata $cfg uamotherdata 0
	config_get_bool withunixipc $cfg withunixipc 0
	config_get_bool uamallowpost $cfg uamallowpost 0
	config_get_bool redirssl $cfg redirssl 0
	config_get_bool uamuissl $cfg uamuissl 0
	config_get_bool layer3 $cfg layer3 0
	config_get_bool patricia $cfg patricia 0
	config_get_bool redirdnsreq $cfg redirdnsreq 0
	config_get_bool dhcpnotidle $cfg dhcpnotidle 0
	config_get_bool ipv6 $cfg ipv6 0
	config_get_bool ipv6only $cfg ipv6only 0

	# Getting other options
	config_get interval $cfg interval 3600
	config_get pidfile $cfg pidfile
	config_get statedir $cfg statedir
	config_get uid $cfg uid
	config_get gid $cfg gid
	config_get net $cfg net
	config_get dhcpstart $cfg dhcpstart
	config_get dhcpend $cfg dhcpend
	config_get dynip $cfg dynip
	config_get statip $cfg statip
	config_get uamanyipex $cfg uamanyipex
	config_get uamnatanyipex $cfg uamnatanyipex
	config_get dns1 $cfg dns1
	config_get dns2 $cfg dns2
	config_get domain $cfg domain
	config_get ipup $cfg ipup
	config_get ipdown $cfg ipdown
	config_get conup $cfg conup
	config_get condown $cfg condown
	config_get macup $cfg macup
	config_get macdown $cfg macdown
	config_get vlanupdate $cfg vlanupdate
	config_get locationupdate $cfg locationupdate
	config_get txqlen $cfg txqlen
	config_get tundev $cfg tundev
	config_get mtu $cfg mtu
	config_get autostatip $cfg autostatip
	config_get ringsize $cfg ringsize
	config_get sndbuf $cfg sndbuf
	config_get rcvbuf $cfg rcvbuf
	config_get childmax $cfg childmax
	config_get peerid $cfg peerid
	config_get peerkey $cfg peerkey
	config_get radiuslisten $cfg radiuslisten
	config_get radiusserver1 $cfg radiusserver1
	config_get radiusserver2 $cfg radiusserver2
	config_get radiusauthport $cfg radiusauthport
	config_get radiusacctport $cfg radiusacctport
	config_get radiussecret $cfg radiussecret
	config_get radiustimeout $cfg radiustimeout
	config_get radiusretry $cfg radiusretry
	config_get radiusretrysec $cfg radiusretrysec
	config_get radiusnasid $cfg radiusnasid
	config_get radiuslocationid $cfg radiuslocationid
	config_get radiuslocationname $cfg radiuslocationname
	config_get locationname $cfg locationname
	config_get radiusnasporttype $cfg radiusnasporttype
	config_get coaport $cfg coaport
	config_get proxylisten $cfg proxylisten
	config_get proxyport $cfg proxyport
	config_get proxyclient $cfg proxyclient
	config_get proxysecret $cfg proxysecret
	config_get proxylocattr=STRING  
	config_get dhcpif $cfg dhcpif
	config_get moreif $cfg moreif
	config_get dhcpmac $cfg dhcpmac
	config_get nexthop $cfg nexthop
	config_get dhcpgateway $cfg dhcpgateway
	config_get dhcpgatewayport=INT
	config_get dhcprelayagent $cfg dhcprelayagent
	config_get lease $cfg lease
	config_get leaseplus $cfg leaseplus
	config_get uamserver $cfg uamserver
	config_get uamhomepage $cfg uamhomepage
	config_get uamsecret $cfg uamsecret
	config_get uamlisten $cfg uamlisten
	config_get dhcplisten $cfg dhcplisten
	config_get uamport $cfg uamport
	config_get uamuiport $cfg uamuiport
	config_get uamallowed $cfg uamallowed
	config_get uamdomain $cfg uamdomain
	config_get uamdomainttl $cfg uamdomainttl
	config_get uamregex $cfg uamregex
	config_get wisprlogin $cfg wisprlogin
	config_get uamlogoutip $cfg uamlogoutip
	config_get uamaliasip $cfg uamaliasip
	config_get uamaliasname $cfg uamaliasname
	config_get uamhostname $cfg uamhostname
	config_get uamaaaurl $cfg uamaaaurl
	config_get defsessiontimeout $cfg defsessiontimeout
	config_get defidletimeout $cfg defidletimeout
	config_get defbandwidthmaxdown $cfg defbandwidthmaxdown
	config_get defbandwidthmaxup $cfg defbandwidthmaxup
	config_get definteriminterval $cfg definteriminterval
	config_get bwbucketupsize $cfg bwbucketupsize
	config_get bwbucketdnsize $cfg bwbucketdnsize
	config_get bwbucketminsize $cfg bwbucketminsize
	config_get macallowed $cfg macallowed
	config_get macsuffix $cfg macsuffix
	config_get macpasswd $cfg macpasswd
	config_get wwwdir $cfg wwwdir
	config_get wwwbin $cfg wwwbin
	config_get uamui $cfg uamui
	config_get adminuser $cfg adminuser
	config_get adminpasswd $cfg adminpasswd
	config_get adminupdatefile $cfg adminupdatefile
	config_get rtmonfile $cfg rtmonfile
	config_get ethers $cfg ethers
	config_get nasmac $cfg nasmac
	config_get nasip $cfg nasip
	config_get ssid $cfg ssid
	config_get vlan $cfg vlan
	config_get cmdsocket $cfg cmdsocket
	config_get cmdsocketport $cfg cmdsocketport
	config_get usestatusfile $cfg usestatusfile
	config_get localusers $cfg localusers
	config_get postauthproxy $cfg postauthproxy
	config_get postauthproxyport $cfg postauthproxyport
	config_get routeif $cfg routeif
	config_get tcpwin $cfg tcpwin
	config_get tcpmss $cfg tcpmss
	config_get maxclients $cfg maxclients
	config_get dhcphashsize
	config_get radiusqsize
	config_get challengetimeout $cfg challengetimeout
	config_get challengetimeout2 $cfg challengetimeout2
	config_get inject $cfg inject
	config_get injectext $cfg injectext
	config_get sslkeyfile $cfg sslkeyfile
	config_get sslkeypass $cfg sslkeypass
	config_get sslcertfile $cfg sslcertfile
	config_get sslcafile $cfg sslcafile
	config_get unixipc $cfg unixipc
	config_get natip $cfg natip
	config_get natport $cfg natport
	config_get dnslog $cfg dnslog
	config_get ipwhitelist $cfg ipwhitelist
	config_get uamdomainfile $cfg uamdomainfile
	config_get kname $cfg kname
	config_get moddir $cfg moddir
	config_get module $cfg module
	config_get dhcpopt $cfg dhcpopt
	config_get extadmvsa $cfg extadmvsa
}

