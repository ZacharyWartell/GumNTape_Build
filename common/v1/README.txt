GumNTape_Build/common/v1

v1 assumes a specific standard layout will be created for storing the .h
files, .lib and .dll's.  The layout keeps the different configurations and
platforms generated by various modified open source build scripts in seperate
directories.

At the moment the documentation for the layout is implied by the scripts:

	msvs_set_install_paths.bat

Any major change to this layout should probably be handled by creating a
separate /v2 subdirectory since various of my git forks of open source
libraries rely on the /v1 layout.
