#!/bin/zsh
# make a tar.gz of files and then move originals to Trash
#
# From:	Timothy J. Luoma
# Mail:	luomat at gmail dot com
# Date:	2013-08-22

NAME="$0:t:r"

	# this is where the .tar.gz file will be created
DESTINATION_DIR="$HOME/Desktop"

	#needed for 'strftime'
zmodload zsh/datetime

	# This creates a timestamp we can use later
TIME=$(strftime "%Y-%m-%d--%H.%M.%S" "$EPOCHSECONDS")

	# this is the default filename for the archive
FILENAME="Archive ($TIME).tar.gz"


####|####|####|####|####|####|####|####|####|####|####|####|####|####|####
#
#		You should not have to change anything below this line
#

if [ "$#" = "0" ]
then


			# if you want to trash the original files after they are archived, change this to $HOME/.Trash/
			#MOVE_ORIGINAL_FILES_TO="$HOME/.Trash/"
		MOVE_ORIGINAL_FILES_TO="$DESTINATION_DIR"

		PLIST="$HOME/Library/LaunchAgents/com.tjluoma.mktgz.plist"

			# if no arguments are given to the script, it will look for any files in this directory
		SOURCE_DIR=$(sed '1,/QueueDirectories/d ; /<\/array>/,$d; s#.*<array>##g ; s#</string>##g; s#.*<string>##g' "$PLIST" | egrep -v '^$')

		cd "$SOURCE_DIR" || exit 0

				# get a list of all of the files
		IFS=$'\n' INPUT=($(find * -type f -print )) 2>/dev/null

		if [ "$INPUT" = "" ]
		then
				echo "	$NAME: nothing found in $SOURCE_DIR"
				exit 0
		fi

else
		MOVE_ORIGINAL_FILES_TO=""
		INPUT="$@"
fi

OUTPUT="$DESTINATION_DIR/$FILENAME"

echo "	$NAME: [info] creating $OUTPUT from:\n${INPUT}"

	# -v[erbose] -c[reate] -g[z]ip -f[ilename]
tar -v -c -z --options gzip=9 -f "$OUTPUT" ${INPUT}

EXIT="$?"

if [ "$EXIT" = "0" ]
then

		echo "	$NAME: [info] successfully created $OUTPUT"

		if [ "$MOVE_ORIGINAL_FILES_TO" != "" ]
		then
					# move the input files
				mv -vf ${INPUT} "$MOVE_ORIGINAL_FILES_TO/"
		fi

			# Show/Reveal the file in Finder
		open -R "$OUTPUT"

			# exit cleanly, our work here is done
		exit 0
else
		echo "$NAME: 'tar' failed (\$EXIT = $EXIT)"

		exit 1
fi


exit
#
#EOF
