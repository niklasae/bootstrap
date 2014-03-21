bootstrap
=========

Install and setup scripts for my boxes

## Setting up encrypted ssh keys

	# Generate the key
	$ ssh-keygen -t rsa
	$ openssl pkcs8 -topk8 -v2 des3 -in id_rsa.old -out id_rsa_enc
	$ rm id_rsa
	$ mkdir ~/.ssh/pub
	$ mv ~/.ssh/id_rsa.pub ~/.ssh/pub/.
	$ chmod 600 ~/.ssh/id_rsa_enc
	$ ssh-add ~/.ssh/id_rsa_enc

	# Put on sites
	$ sudo apt-get xclip
	$ xclip -sel clip < ~/.ssh/pub/id_rsa.pub

	# Test
	$ ssh -T git@github.com
	$ ssh -T git@bitbucket.com


## The following packages has to be installed manually

* Install Chrome
* Install DbVisulizer (8?)
* Install Dropbox + run setup
* Install IE (http://www.modern.ie/en-us/virtualization-tools)
* Install redis-cli (http://redis.io/topics/quickstart)
* Install Vagrant
* Install Valentina Studio (VStudio) + import bookmarks
* Install Virtualbox


## The following packages has to be configured manually

* Configure Parcellite"
* Configure Synapse"


## Other

[Don't forget the dotfiles...](http://www.github.com/niklasae/dotfiles)
