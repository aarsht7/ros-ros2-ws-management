# ros-ros2-ws-management
Modified bashrc file to make your life easy with running ROS and ROS2 in parallel on same machine that allow you to jump between both with just one command. 

## Features
- If you open the terminal into pre-built ros workspace, it will automatically recognize the ros version and source the require setup.bash file.
- If you want to re-source the workspace, use commands from workspace folder.
	- ```$ sb1``` (for ros1 workspace) 
	- ```$ sb2``` (for ros2 workspace) 

- If you want to initialize ros and source only setup.bash file from ros installation space you can use 
	- ```$ ros1ws``` (to only source the setup.bash from main ros1 path)    
	- ```$ ros1ws <path-to-ws>``` (to source the ros1 workspace and move to the workspace) 
	- ```$ ros2ws``` (to only source the setup.bash from main ros2 path)    
	- ```$ ros2ws <path-to-ws>``` (to source the ros2 workspace and move to the workspace) 
- ```$ exit_ros``` To exit any of the ros workspace and remove all the ros related variable from current bash prompt. You can jump to other version of ros from the same terminal flawlessly. 

## How to use it
- You can simply replace your ```~/.bashrc``` with the new one provided here and make the change to your source path for ros in line 62&63.![60-63](https://user-images.githubusercontent.com/53620577/138263544-1524c282-b26c-4887-adbc-90ff80acaf1f.png)

- In case if you do not want to replace it, copy from line 59 to 175 and follow the instruction from line 176.

## Demo
Demo shows how to use updated bashrc file to make your workflow better


https://user-images.githubusercontent.com/53620577/138263405-63c63dfe-5e0b-4dce-80a9-9e42b7b36ae5.mp4

If you like it, a star to the repo would be a great to keep me motivated.
Thanks.!
