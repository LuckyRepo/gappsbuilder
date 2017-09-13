#/bin/bash
# Assign the build path from AOSiP build folder
    		read -p "Enter the path where you installed your Android SDK: " sdkpath
    		echo $sdkpath >> sdkpath.txt
        echo -e '\e[96mStored build path. Your settings are saved.\e[0m'
        echo -e '\e[91mgappsbuilder is now auto shutting down. Relaunch to see settings applied.\e[0m'	
