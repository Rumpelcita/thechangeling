The Changeling
=============

GGJ 2014 exploration horror videogame.

## How to run project with project sprouts

This assumes you already cloned the repo running: git clone https://github.com/Rumpelcita/thechangeling

Install ruby 1.9.3 https://www.ruby-lang.org/en/

### Install project sprouts:
gem install sprout

#### Install the ActionScript 3 / Flash Bundle:
gem install flashsdk --pre

#### Move into the project:
cd thechangelling

#### Install dependencies:
bundle install

#### Compile and run the main project:
rake 

From now on you just have to run rake whenever you wish to run the game. This way you don't have to set a dev enviroment if you need to test the game.

There is an executable inside the bin folder, but it's not always up to date so the rake command is the recommended method to test the game.
