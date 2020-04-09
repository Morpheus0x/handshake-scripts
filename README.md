# Handshake Script Collection
## Requirements
- curl
- jq
- notify-send (should be installed with any desktop environment)

Debian based install example: `sudo apt install curl jq notify-send`

## Server Setup
This script is able to connect to a remote instance of hsd via curl

On the server open port 12037 (user [ufw](https://help.ubuntu.com/community/UFW) for easy firewall setup)  
Use `openssl rand -hex 32` to create a strong api key  
Use [screen](https://linux.die.net/man/1/screen) or [byobu](https://www.byobu.org/) to see what the output of hsd is, otherwise use the --daemon option for hsd  
Example command: ./hsd --http-host 'yourdomain.com' --api-key 'your_key'

## Usage
Edit the script to change the server and api key, cli coming soon&trade;

Just make the script executeable with `chmod +x script.sh` and run `./script.sh`

## Tips
Use screen to run the script in the background

Pipe the output of the script to a file `./script.sh > log.txt`
