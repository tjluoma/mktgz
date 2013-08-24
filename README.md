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

**Option B)** If you call `mktgz.sh` with no arguments, it will look for files in a specific directory which you can specify by editing this line:

		SOURCE_DIR="$HOME/Action/Gzip"

What's the point of that? Simple. Need to pack up some files quickly? Grab them all and dump them into that folder, wait a few seconds, and out will pop a new .tar.gz file. Boom. Done.

***NOTE:*** Due to the way that `QueueDirectories` works in `launchd` 





[1]: http://apple.stackexchange.com/questions/99718/how-do-i-create-a-folder-action-script-to-tar-items-dropped-in-folder/99724

[2]: http://apple.stackexchange.com/a/99724/9226