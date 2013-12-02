============
INSTALLATION
============

Run installation script: ::

  ./install.sh

Install Proper Ruby and Chef versions: ::

  # if not installed complains about 
  sudo apt-get install libssl-dev
  
  rbenv rehash
  rbenv install 1.9.3-p385
  rbenv shell   1.9.3-p385
  rbenv global  1.9.3-p385

  # pry is installed by chef, but if it's left for gem
  # to resolve dependencies, then it produces some errors:
  # https://github.com/rdoc/rdoc/issues/175
  # Install rdoc and rb-readline for proper pry installation

Chef requires 'pry', but it has problems with doc compilation, outpu is shown below. Installing rdoc first removes this problem.

| ERROR:  While generating documentation for pry-0.9.12.4
| ... MESSAGE:   undefined method `name' for #<RDoc::RubyToken::TkDOT:0x000000034bf7f0>
| ... RDOC args: --ri --op /home/pawel/.rbenv/versions/1.9.3-p385/lib/ruby/gems/1.9.1/doc/pry-0.9.12.4/ri lib --title pry-0.9.12.4 Documentation --quiet
::

  gem install rdoc
  rbenv rehash
  gem install rb-readline pry
  rbenv rehash

Now install chef: ::

  gem install chef -v '= 11.8.0'
  rbenv rehash

Install knife-solo: ::
  
  gem install knife-solo
  rbenv rehash

Install berkshelf: ::

  gem install berkshelf
  rbenv rehash

Initialize repository: ::

  mkdir -p ~/repo
  cd ~/repo
  # clone repo form opscode
  knife solo init .
  berks init
  
  

