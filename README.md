mktgz
=====

**Summary:** zsh script and launchd plist to automatically gzip any files placed into a specific directory

Over on [AskDifferent][1] someone was trying to create a Folder Action which would automatically create a tar.gz out of files put into a specific folder.

The first problem with that approach is that it requires AppleScript (I kid! I kid! … Mostly…)

The second (and bigger) problem is that Folder Actions are notoriously unreliable.

While I stand by [my suggestion to use Hazel][2] to solve this, it did occur to me that this could be done fairly easily using a shell script and `launchd` which I have found to be *much* more reliable than Folder Actions.

## Usage ##

**Option A)** You can use `mktgz.sh` in Terminal.app by calling it with a couple of files that you want to put into a .tar.gz, like this: 

		mktgz.sh file.doc file2.xml file3.txt

It will take all of those files and put them into a new .tar.gz file (by default it will be created on your Desktop, but you can set that in `mktgz.sh`)

**Option B)** Edit [com.tjluoma.mktgz.plist] and change the directory listed in `<string>` and `</string>`:

		<key>QueueDirectories</key>
		<array>
			<string>/Users/luomat/Action/Gzip</string>
		</array>

Then move the file to `~/Library/LaunchAgents/com.tjluoma.mktgz.plist` and enter this in Terminal:

		launchctl load "$HOME/Library/LaunchAgents/com.tjluoma.mktgz.plist"
		
Then you can just put files into ~/Action/Gzip/ (or whatever directory you put in the .plist file) and a few seconds later a .tar.gz will be created in ~/Desktop/

***NOTE:*** Due to the way that `QueueDirectories` works, the files need to be moved after they are processed. So they too will be moved to ~/Desktop/. 

You can change the output directory by changing 

		DESTINATION_DIR="$HOME/Desktop"

in the `mktgz.sh` file.


[1]: http://apple.stackexchange.com/questions/99718/how-do-i-create-a-folder-action-script-to-tar-items-dropped-in-folder/99724

[2]: http://apple.stackexchange.com/a/99724/9226