nssm.exe = create the service for syncthing.  use: "nssm edit syncthing". can ignore unless editing.
syncthing management (shortcut) = copy to desktop or wherever to execute management script
syncthing_management.bat = start / stop syncthing & management
syncthing_service_installer.bat = install the syncthing service.  
Need to make a symbolic link in the syncthing directory pointing to the shared / personal_sync folder.  usage below from cygwin:
	ln -s -v /cygdrive/c/Users/mike/sync/tools/syncthing/windows/ /cygdrive/c/Syncthing/tools/windows_shared
	ln -s -v /cygdrive/c/Users/mike/sync/ /cygdrive/c/Syncthing/tools/personal_sync