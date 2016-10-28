# OmegaScripts
## 7 Days to die Scripts by Devidian

### 7Drestart.sh INSTANCE [LANGUAGE]
* restarts the INSTANCE with a 5 minute (60/10/5 seconds) warning to all players
* creates Maintainance file (MTF) while shutdown and restarting the INSTANCE

### 7Doom.sh INSTANCE [LANGUAGE]
* checks if OutOfMemory exception is occured in the given instance and shutdown the instance
* creates Maintainance file (MTF) while shutdown and restarting the INSTANCE  

### 7Dzp.sh INSTANCE
* detects if the INSTANCE is running but not connect-able (when the zombie game becomes a zombie itself)
* kills all processes for this INSTANCE and restarts the INSTANCE
* also detects if the INSTANCE is not running and restarts it if no Maintainance file (MTF) exists 
