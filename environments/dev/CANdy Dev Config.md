Steps to complete after `indy-node` installation

This document provides a condensed set of steps to follow when initializing the new network.  For more information regarding the initial setup and software installation and the processes to follow after the network has been initialized refer to the documentation here; [node-installation](../../doc/node-installation)

1. Set Network Name in config.py

    `sudo sed -i -re "s/(NETWORK_NAME = ')\w+/\1candy-dev/" /etc/indy/indy_config.py`

2. Create Network Directory

    `sudo -i -u indy mkdir /var/lib/indy/candy-dev`

3. Initialize The Node using Internal IPs

    Example:

    `sudo -i -u indy init_indy_node <ALIAS> <node ip> <node port> <client ip> <client port>`

    `sudo -i -u indy init_indy_node dev-bc-1 172.31.100.224 9701 172.31.101.201 9702`

4. Add Node information to Steward Spreadsheet

5. Generate Trustee DID(s) using the [CANdy Dev Trustee Transaction Endorser tool](https://docs.google.com/document/d/1cEOicdXGLfQsCinmAq0Dp19Gh7XXLT_0ImZypm8cV1U/edit#heading=h.hrwyfidyppgk) instructions and add to Steward Spreadsheet

6. Generate Steward DID(s) using tools in [von-network](https://github.com/bcgov/von-network) and add to Steward Spreadsheet

    `./manage generateDID`

7. Generate Genesis files using tools in [von-network](https://github.com/bcgov/von-network)

    `./manage generategenesisfiles "./tmp/CANdy Dev Genesis File Node info - Trustees.csv" "./tmp/CANdy Dev Genesis File Node info - Stewards.csv"`
    
    Wade will do this and publish the files to the repo.

8. Copy Genesis files to `/var/lib/indy/candy-dev`

9. Run `sudo chown indy:indy *` in `/var/lib/indy/candy-dev`

10. Start the network

Misc. Admin commands:
```
sudo systemctl start indy-node
sudo systemctl stop indy-node

sudo systemctl status indy-node.service
sudo systemctl enable indy-node.service
sudo systemctl disable indy-node.service

sudo validator-info
```