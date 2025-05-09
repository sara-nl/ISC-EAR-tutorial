# Energy Management and Optimization with EAR
## Tutorial ISC 2025
https://app.swapcard.com/event/isc-high-performance-2025/planning/UGxhbm5pbmdfMjU4MTc5NA==

## Schedule
### June 13 2025 (start 09:00 end 13:00)
- (09:00-10:00) Welcome  & Introduction to EAR
- (10:00-11:30) Energy Monitoring (Basic use cases)
   - Running CPU/GPU kernals with EAR
   - Job energy monitoring & accounting
   - Energy efficiency vs resource consumption
   - Energy efficiency vs architecture
   - CPU DVFS
- (11:30-13:00) Energy Optimization (Advanced use cases)
   - Singularity
   - Energy optimization policies
   - EAR data visualization

## Tutorials
The tutorials of this class can be found in the directory [tutorials](https://github.com/sara-nl/ISC-2024-EAR-tutorial/tree/main/tutorials)

1. [General Monitoring tutorial](tutorials/monitoring_general/README.md)
2. [EAR Monitoring tutorial](tutorials/monitoring_ear/README.md)
3. [DVFS tutorial](tutorials/dvfs/README.md)
4. [Energy Optimization tutorial](tutorials/policies/README.md)
5. [EAR Data visualization](tutorials/visualization/README.md)


## Practical information
- [How to connect to Snellius](#how-to-connect-to-snellius)
- [How to interact with the course.](#how-to-interact-with-the-course)

### How to connect to Snellius

#### OpenOnDemand

https://ondemand.snellius.surf.nl/

#### SSH
>Snellius uses a white-list of ip-addresses and only from those locations you can access the system. 

If you are connecting with eduroam (from the SURF Amsterdam office) you should be able to go directly to snellius. This IP has been whitelisted. 
```
ssh username@snellius.surf.nl
```

If you are connecting from outside SURF Amsterdam you will have to have your IP whitelisted by us. Please send us your IP address to be white listed. 
You can find the blocked ip-address when logging in to Snellius using ssh -v [login]@snellius.surf.nl.

If whitelisting is not an option for you, you can always access Snellius via the "Doornode"
```
ssh user@doornode.surfsara.nl
```
The doornode is separate login server, that can be accessed from anywhere in the world: doornode.surfsara.nl (thus using `ssh user@doornode.surfsara.nl`). This server can be accessed with your usual login and password, after which you get a menu with systems that you can login to. Select 'Snellius' and type your password a second time. You are now logged on to Snellius. Please note that you cannot copy files or use X11 when using the door node.



### How to interact with the course.

This course is a "command line" course. We assume that you are somewhat comfortable with using the command line. This comes with some caveats, mainly its not so "nice" to view images or GUIs. Though not essential to have nice "viewing" capabilities, for this course we will be looking at some nice plots `.pngs`. Here are some suggested remedies.

1. Window forwarding `ssh -X username@snellius.surf.nl`. To redirect any graphics output from the HPC system to your own system, you'll need an X-server like [XQuartz](https://www.xquartz.org). Download and install it. Then, login to the HPC system using (note that X is capitalized). 
   - To view a png while on snellius use `display file.png`
2. [MobaXterm](https://mobaxterm.mobatek.net) (windows) 
3. Visual Studio Code we have documentation on how to set it up [here](https://servicedesk.surf.nl/wiki/display/WIKI/Visual+Studio+Code+for+remote+development) (go to the Running the VS Code Server on a login node section)

