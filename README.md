bootstrap
=========

Install and setup scripts for my boxes

## Setting up encrypted ssh keys

	# Generate the key - [newish](http://www.tedunangst.com/flak/post/new-openssh-key-format-and-bcrypt-pbkdf)
	$ ssh-keygen -o -a 64
	$ mv ~/.ssh/id_rsa ~/.ssh/id_rsa_enc
	$ mv ~/.ssh/id_rsa.pub ~/.ssh/pub/.

	# Or generate the key the (old) way
	$ ssh-keygen -t rsa
	$ openssl pkcs8 -topk8 -v2 des3 -in ~/.ssh/id_rsa -out ~/.ssh/id_rsa_enc
	$ rm ~/.ssh/id_rsa
	$ mkdir -p ~/.ssh/pub
	$ mv ~/.ssh/id_rsa.pub ~/.ssh/pub/.
	$ chmod 600 ~/.ssh/id_rsa_enc

	# Put public key on sites
	$ sudo apt-get install -y xclip
	$ xclip -sel clip < ~/.ssh/pub/id_rsa.pub

	# Add private key to authentication agent
	$ ssh-add ~/.ssh/id_rsa_enc

	# Test
	$ ssh -T git@github.com
	$ ssh -T git@bitbucket.com



## Setup directory and clone bootstrap and dotfiles repo

    $ mkdir -p ~/Code/niklasae
    $ cd ~/Code/niklasae
    $ git clone git@github.com:niklasae/bootstrap
    $ git clone git@github.com:niklasae/dotfiles


## The following packages has to be installed manually

* Install Chrome
* Install DbVisulizer (8?)
* Install Dropbox + run setup
* Install [Google Web Designer](https://www.google.com/webdesigner)
* Install [IE](http://www.modern.ie/en-us/virtualization-tools)
* Install [ngrok](https://ngrok.com)
* Install [redis-cli](http://redis.io/topics/quickstart)
* Install RescueTime
* Install Skype
* Install Vagrant
* Install Valentina Studio (VStudio) + import bookmarks
* Install Virtualbox


## The following packages has to be configured manually

* Configure ClipIt/Parcellite
* Configure Albert/Synapse


## Other

[Don't forget the dotfiles...](http://www.github.com/niklasae/dotfiles)
