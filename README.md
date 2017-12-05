# OmegaScripts

## Prerequisite
All my scripts are only working with a installation of "7 Days to Die - Linux Server Management scripts" from Alloc.
Instructions can be found here: https://7dtd.illy.bz/wiki/Installation

## 7 Days to die Scripts by Devidian
Below you can find all included scripts in this repository

### 7Drestart.sh INSTANCE TELNETPORT [LANGUAGE]
* restarts the INSTANCE with a 5 minute (60/10/5 seconds) warning to all players
* creates Maintainance file (MTF) while shutdown and restarting the INSTANCE

### 7Doom.sh INSTANCE TELNETPORT [LANGUAGE]
* checks if OutOfMemory exception is occured in the given instance and shutdown the instance
* creates Maintainance file (MTF) while shutdown and restarting the INSTANCE

### 7Dzp.sh INSTANCE
* detects if the INSTANCE is running but not connect-able (when the zombie game becomes a zombie itself)
* kills all processes for this INSTANCE and restarts the INSTANCE
* also detects if the INSTANCE is not running and restarts it if no Maintainance file (MTF) exists

### 7D16G.sh INSTANCE TELNETPORT [LANGUAGE]
* detects if the INSTANCE memory allocation (not usage) is about to go further than 16000000K (close to 16G)
* it logs into the server and tells everyone that the server will restart due to unity memory limit of 16G (until 7D upgrades to Unity 5.4)
* it gives a timer of 60 seconds before it shutdown the server and restart the instance

## Examples

I'm using this cronjobs for my server
```
10  3 * * *     /root/OmegaScripts/7Drestart.sh OZCOOPII 8081   >> /root/cronlog/7Drestart.log
*/2 * * * *     /root/OmegaScripts/7Dzp.sh      OZCOOPII        >> /root/cronlog/7Dzp.log
*   * * * *     /root/OmegaScripts/7D16G.sh     OZCOOPII 8081   >> /root/cronlog/7D16G.log
*/2 * * * *     /root/OmegaScripts/7Doom.sh     OZCOOPII 8081   >> /root/cronlog/7Doom.log
```

## Troubleshooting
If you have any problems or questions feel free to open an issue.