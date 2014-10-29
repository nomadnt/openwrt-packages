#!/bin/sh
# Copyright (C) 2009-2013 nomadnt.com

. /lib/functions.sh

CFG_FILE="/var/etc/nodogsplash.conf"

[ -d /tmp/etc ] || mkdir /tmp/etc

nds_config_gateway(){
	local interface external name address port range

	config_get interface gateway interface "lan"

	[ -d /sys/class/net/$interface ] || {
		interface="$(uci_get_state network $interface ifname)"
		[ -d /sys/class/net/$interface ] || exit 1
	}

	[ -n "$interface" ] || exit 1

	config_get external gateway external
	config_get name gateway name
	config_get address gateway address
	config_get port gateway port
	config_get range gateway range

	[ -n "$external" ] && printf "ExternalInterface %s\n" "$external" >> $CFG_FILE
	[ -n "$interface" ] && printf "GatewayInterface %s\n" "$interface" >> $CFG_FILE
	[ -n "$name" ] && printf "GatewayName %s\n" "$name" >> $CFG_FILE
	[ -n "$address" ] && printf "GatewayAddress %s\n" "$address" >> $CFG_FILE
	[ -n "$port" ] && printf "GatewayPort %s\n" "$port" >> $CFG_FILE
	[ -n "$range" ] && printf "GatewayIPRange %s\n" "$range" >> $CFG_FILE
}

nds_config_general(){
	local redirect_url idle_timeout force_timeout
    
	config_get redirect_url general redirect_url
	config_get idle_timeout general idle_timeout
	config_get force_timeout general force_timeout
    
	[ -n "$redirect_url" ] && printf "RedirectURL %s\n" "$redirect_url" >> $CFG_FILE
	[ -n "$idle_timeout" ] && printf "ClientIdleTimeout %s\n" "$idle_timeout" >> $CFG_FILE
	[ -n "$force_timeout" ] && printf "ClientForceTimeout %s\n" "$force_timeout" >> $CFG_FILE
}

nds_config_limit(){
	local clients download upload
    
	config_get clients limit clients
	config_get download limit download
	config_get upload limit upload
    
	[ -n "$clients" ] && printf "MaxClients %s\n" "$clients" >> $CFG_FILE
	[ -n "$download" -a -n "$upload" ] && {
		printf "TrafficControl yes"
		printf "DownloadLimit %s\n" "$download" >> $CFG_FILE
		printf "UploadLimit %s\n" "$upload" >> $CFG_FILE
	}
}

nds_config_mac_mechanism(){
	local list role mechanism
    
	nds_config_mac(){
		append list "$1" ","
	}
    
	config_get role mac role "block"
	config_list_foreach mac mac nds_config_mac
    
	case "$role" in
		allow) mechanism="AllowedMACList" ;;
		block|*) mechanism="BlockedMACList" ;;
	esac
    
	[ -n "$list" ] && {
		printf "MACMechanism %s\n" "$role" >> $CFG_FILE
		printf "%s %s\n" "$mechanism" "$list" >> $CFG_FILE
	}
    
	unset list
	config_list_foreach mac trust nds_config_mac
	[ -n "$list" ] && printf "TrustedMACList %s\n" "$list" >> $CFG_FILE
}

nds_config_user_authentication(){
	local immediate attempts username password
    
	config_get immediate authentication immediate
	config_get attempts authentication attempts
	config_get username authentication username
	config_get password authentication password
    
	[ -n "$immediate" ] && printf "AuthenticateImmediately %s\n" "$immediate" >> $CFG_FILE
    
	[ -n "$username" ] && {
		printf "UsernameAuthentication yes\n" >> $CFG_FILE
		printf "Username %s\n" "$username" >> $CFG_FILE
	}
    
	[ -n "$password" ] && {
		printf "PasswordAuthentication yes\n" >> $CFG_FILE
		[ -n "$attempts" ] && printf "PasswordAttempts %s\n" "$attempts" >> $CFG_FILE
		printf "Password %s\n" "$password" >> $CFG_FILE
	}
}

nds_config_empty_rule_policies(){
	local cfg="empty_rule_policy"
	local authenticated_users preauthenticated_users users_to_router trusted_users trusted_users_to_router

	config_get authenticated_users $cfg authenticated_users
	config_get preauthenticated_users $cfg preauthenticated_users
	config_get users_to_router $cfg users_to_router
	config_get trusted_users $cfg trusted_users
	config_get trusted_users_to_router $cfg trusted_users_to_router

	[ -n "$authenticated_users" ] && printf "EmptyRuleSetPolicy authenticated-users %s\n" "$authenticated_users" >> $CFG_FILE
	[ -n "$preauthenticated_users" ] && printf "EmptyRuleSetPolicy preauthenticated-users %s\n" "$preauthenticated_users" >> $CFG_FILE
	[ -n "$users_to_router" ] && printf "EmptyRuleSetPolicy users-to-router %s\n" "$users_to_router" >> $CFG_FILE
	[ -n "$trusted_users" ] && printf "EmptyRuleSetPolicy trusted-users %s\n" "$trusted_users" >> $CFG_FILE
	[ -n "$trusted_users_to_router" ] && printf "EmptyRuleSetPolicy trusted-users-to-router %s\n" "$trusted_users_to_router" >> $CFG_FILE
}

nds_config_firewall(){

	nds_config_rules(){
		local cfg="$1"
		local rule proto port dest
	
		config_get rule $cfg rule "allow"
		config_get proto $cfg proto
		config_get port $cfg port
		config_get dest $cfg dest
	
		[ ! -n "$port" ] && [ ! -n "$dest" ] && return 1
	
		[ -n "$port" ] && port=" port $port"
		[ -n "$dest" ] && dest=" to $dest"
	
		if [ -n "$proto" ]; then
			for p in $proto; do
				printf "\tFirewallRule %s%s%s%s\n" "$rule" " $p" "$port" "$dest" >> $CFG_FILE
			done
		else
			printf "\tFirewallRule %s%s%s\n" "$rule" "$port" "$dest" >> $CFG_FILE
		fi
	}
    
	printf "\n" >> $CFG_FILE
	printf "FirewallRuleSet preauthenticated-users {\n" >> $CFG_FILE
	config_foreach nds_config_rules preauthenticated
	printf "}\n\n" >> $CFG_FILE

	printf "FirewallRuleSet authenticated-users {\n" >> $CFG_FILE
	config_foreach nds_config_rules authenticated
	printf "}\n\n" >> $CFG_FILE

	printf "FirewallRuleSet users-to-router {\n" >> $CFG_FILE
	config_foreach nds_config_rules userstorouter
	printf "}\n\n" >> $CFG_FILE
}

# init CFG_FILE
printf "# file autogenerated by nodogsplash\n\n" > $CFG_FILE

config_load nodogsplash

# Configuring gateway options
nds_config_gateway

# Configuring general options
nds_config_general

# Configuring mac mechanism
nds_config_mac_mechanism

# Configuring user authentication
nds_config_user_authentication

# Configuring EmptyRuleSetPolicy
nds_config_empty_rule_policies

# Configuring firewall rules
nds_config_firewall
