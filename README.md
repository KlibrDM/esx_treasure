# esx_treasure
## Description
Treasure crates with loot for ESX FiveM servers. The crates can contain money (dirty/clean), weapons or items. Supports multiple crates and the script keeps track of which one was opened by who.
## Dependencies
* [es_extended](https://github.com/ESX-Org/es_extended)
###
* If you're going to keep the default crates, you'll need esx_drugs
* [esx_drugs](https://github.com/ESX-Org/esx_drugs)
## Setup
* Install into resources/[esx]
* Import `esx_treasure.sql` in your database
* Add the following line to your server.cfg
```
start esx_treasure
```

* If you want the crate to be opened only once/server, you have to set `Config.OnePersonOpen` to `true` in `config.lua`. On `false`, each player can open the crate once.
* If you don't want a circle around the crate, you have to set `Config.MarkerCircle` to `-1` in `config.lua`.
* If you want the crates to give dirty money instead of clean cash, you have to set `Config.IsMoneyDirtyMoney` to `true` in `config.lua`.
## Screenshots
### With marker
![screenshot](https://i.imgur.com/VcsQnDj.jpg)
##
### Without marker
![screenshot](https://i.imgur.com/qnE9oZF.jpg)
