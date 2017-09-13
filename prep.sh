#/bin/bash
	clear
	echo -e '\e[104mgappsbuilder by LuckyRepo v0.0.2\e[0m'
	echo -e '\e[91mThis build still contains test code. Not for daily use. Devs and testers Only.\e[0m'
		arm=$(./download_sources.sh [--shallow] [arm])
		arm64=$(./download_sources.sh [--shallow] [arm64])
		x86=$(./download_sources.sh [--shallow] [x86])
		x8664=$(./download_sources.sh [--shallow] [x86_64])
# Ask if they want to set up
	echo -e '\e[32mDo you want to set the SDK path?\e[0m'
	select yn in "Yes" "No"; do
    		case $yn in
        		Yes ) echo -e '\e[96mSetting path\e[0m'; ./sdk.sh && break;;
        		No ) echo -e '\e[96mSkipping\e[0m'; break;;
    		esac
	done
# 
	echo -e '\e[32mspecify architecture\e[0m'
	select sa in "arm" "arm64" "x86" "x86_64"; do
    		case $sa in
        		arm ) echo -e '\e[96msync arm submodules\e[0m'; echo $arm >> archpath.txt && echo arm >> arch.txt && break;;
        		arm64 ) echo -e '\e[96msync arm64 submodules\e[0m'; $arm64 >> archpath.txt && echo arm64 >> arch.txt && break;;
			x86 ) echo -e '\e[96msync x86 submodules\e[0m'; $x86 >> archpath.txt && echo x86 >> arch.txt &&  break;;
			x86_64 ) echo -e '\e[96msync x86_64 submodules\e[0m'; $x8664 >> archpath.txt && echo X86_64 >> arch.txt &&  break;;
    		esac
	done	
# Assign the build path
	line=$(head -n 1 sdkpath.txt)
	cd $line
# Assign arch sync
	arch=$(head -n 1 archpath.txt)
# Assign arch type sync
	archt=$(head -n 1 arch.txt)
#Set PATH for all needed commands
	PATH=~/bin:$PATH
  export ANDROID_HOME=$line
  export PATH=$ANDROID_HOME/tools:$PATH
  export PATH=$ANDROID_HOME/platform-tools:$PATH
	echo -e '\e[32mChanged BIN Path to current folder to allow for Repo commands\e[0m'
# Set CCACHE up
		prebuilts/misc/linux-x86/ccache/ccache -M 100G
		export CCACHE_DIR=/CCACHE
		export USE_CCACHE=1
		export CCACHE_COMPRESS=1
    	echo -e '\e[32mSet CCACHE to 100G, set compression and set use to 1\e[0m'
# Ask if they want to sync in yes or no
	echo -e '\e[32mDo you wish to sync?\e[0m'
	select yn in "Yes" "No"; do
    		case $yn in
        		Yes ) echo -e '\e[96mStarting Sync\e[0m'; $arch && break;;
        		No ) echo -e '\e[96mSkipping Sync\e[0m'; break;;
    		esac
	done
# Start Build
	    echo -e '\e[32mMarking start of build\e[0m'
            sleep 1
		make $archt
	    echo -e '\e[91mTurning controls back to you.\e[0m'
            exit
