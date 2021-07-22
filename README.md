# Hanguu Manuu

```
       __  __    ___     _   __   ______   __  __   __  __        ._________
      / / / /   /   |   / | / /  / ____/  / / / /  / / / /       _|_        |
     / /_/ /   / /| |  /  |/ /  / / __   / / / /  / / / /       /x x\       |
    / __  /   / ___ | / /|  /  / /_/ /  / /_/ /  / /_/ /        \___/       |
   /_/ /_/   /_/  |_|/_/ |_/   \____/   \____/   \____/ 	 /|\        |
   								/ | \       |
       __  ___    ___     _   __   __  __   __  __                -         |
      /  |/  /   /   |   / | / /  / / / /  / / / /               / \        |
     / /|_/ /   / /| |  /  |/ /  / / / /  / / / /               /   \       |
    / /  / /   / ___ | / /|  /  / /_/ /  / /_/ /                            |
   /_/  /_/   /_/  |_|/_/ |_/   \____/   \____/                       ______|___
```   
   
``` 
      .-----------------------------------------------------------------.
     /  .-.                       HOW TO PLAY                       .-.  \
    |  /   \ Mistakenly accused of murder, Mr. Juju was sentenced  /   \  |
    | |\_.  |to death through hanging. Help prolong his life by   |    /| |
    |\|  | /|guessing the right letters to complete the word and  |\  | |/|
    | `---' |proceed to the next level. Be careful in picking a   | `---' |
    |       |letter because every mistake is a step closer to Mr. |       | 
    |       |Juju's death. 					  |       |
    |       |-----------------------------------------------------|       |
    \       |                                                     |       /
     \     /                                                       \     /
      `---'                                                         `---'
```

###	CONTROLS:
####	All characters keys that could possibly complete the hidden word
	
###	NOTE:
####	You can't enter the same character more than once in a round


## HOW TO RUN THE PROGRAM

#### Download these 2 files first
- DOS Box Installer – https://sourceforge.net/projects/dosbox/
- 8086 Assembler – http://www.mediafire.com/file/2aaozt0olkbd2qv/8086.rar/file
#### Running the program
- Extract files from `8086` folder. Place this folder into your `C drive`.
- Place individual Hanguu-Manuu files inside `8086` folder
- Run `DosBox`
- Type `MOUNT C C:\8086` in `DosBox`
- Change directories to 8086 folder. To do that, type `C:`
- Assemble the code by typing `masm hangm.asm` (just select defaults)
- Link the object created after assembling by typing `link hangm.obj` (just select defaults)
- Load the game by running `hangm.exe`


