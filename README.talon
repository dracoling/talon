talon - an open source IRC bot written in Perl.
http://github.com/mindfuzz/talon

###### Getting Started ######
1. Make sure you have all the required Perl modules installed.
   (see README_PERL)
2. Create a database,
	cd ./talon/db
	./newdb databasename.db
3. Add a user to the database
	./adduser dabasename.db yournick
4. Setup the config, a default configuration is provided.
	cd ../conf/
	vim default.conf
5. Run talon!
	cd ../
	./talon

###### To Do ######
[ ] Statistics
[ ] Threading
[ ] Console control
[ ] Webfront end
[-] Proper command line options, override configuration
[ ] Master password, MD5 encrypted, for recovery/killing/etc
[ ] Per user password incase of different hostname, MD5 encrypted
[ ] Customisable command trigger (currently !)
[ ] Optional colours to messages
[ ] Quote voting
[ ] Logging -> hostmarks
[ ] Users, custom fields.
[-] Comment fully.
