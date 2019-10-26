echo "*** Setup general rules for UFW..."

ufw status verbose

######################
#  Incoming Traffic  #
######################

sudo ufw default deny incoming comment 'deny all incoming traffic'

######################
#  Outgoing Traffic  #
######################

if [[ $1 == "strict" ]]; then
    echo "*** Strict Mode"
    sudo ufw default deny outgoing comment 'deny all outgoing traffic'
    # allow traffic out on port 53 -- DNS
    sudo ufw allow out 53 comment 'allow DNS calls out'
    # allow traffic out on port 123 -- NTP
    sudo ufw allow out 123 comment 'allow NTP out'
    # allow traffic out for HTTP, HTTPS, or FTP
    # apt might needs these depending on which sources you're using
    sudo ufw allow out http comment 'allow HTTP traffic out'
    sudo ufw allow out https comment 'allow HTTPS traffic out'
    sudo ufw allow out ftp comment 'allow FTP traffic out'
    # allow whois
    sudo ufw allow out whois comment 'allow whois'
    # allow traffic out on port 68 -- the DHCP client
    # you only need this if you're using DHCP
    sudo ufw allow out 68 comment 'allow the DHCP client to update'
else
    echo "*** Normal Mode"
    sudo ufw default allow outgoing comment 'allow all outgoing traffic'
fi


echo "*** The current status of UFW after setup:"
ufw status verbose
