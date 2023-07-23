# [Vault Hunters]([https://vaulthunters.gg](https://www.curseforge.com/minecraft/modpacks/vault-hunters-official-modpack))
<!-- MarkdownTOC autolink="true" indent="  " markdown_preview="github" -->

- [Description](#description)
- [Fast Start](#fast-start)
- [Requirements](#requirements)
- [Options](#options)
- [Adding Minecraft Operators](#adding-minecraft-operators)
- [Source](#source)

<!-- /MarkdownTOC -->

## Description


Docker Container for Vault Hunters Minecraft Modpack

The docker on first run will download the same version as tagged of Vault Hunters and install it.  This can take a while as the Forge installer can take a bit to complete. You can watch the logs and it will eventually finish.

After the first run it will simply start the server.

## Fast Start...

The easiest way to stary using this container is to use the `docker-compose.yaml` as it has everything you need to get going quick.

Simply run...
`docker-compose up`
After a while (if you don't want the console to be stuck in that logging) you can do `Ctrl-C` to shut it down and then `docker-compose start` which will run it as a service instead. Unfortunately on first run you have to do `up` for it to create the environment.

## Requirements

- Make sure that the environment variable EULA is set to `true`
- `/data` mounted to a persistent disk volume - otherwise your world will not be saved !!!
    - Examples:
        - Anonymous volume `-v :/data`
        - Labelled volume `-v vault-hunter-volume:/data`
        - Specific host directory `-v /home/vault-hunters:/data`
- Open up the default Minecraft network port to the host network so that you can connect to the server
    - Note that if you map the port to a different port number on the host the Minecraft Multiplayer user interface will not find the server on the local network
    - `-p 25565:25565`


This is the default world, generated from scratch on first boot
> `LEVEL` Vault-Hunters

## Options

These environment variables can be set at run time to override their defaults.

Set to true to create the server the first time, then disable if you need to customize config files or mods. 
Re-enable to update to a newer version after switching docker images, but make sure to back up and config/mod edits
> `NUCLEAR_UPDATE`

Java virtual machine memory - 6 Gigabytes maximum, increase by ~2G per player
> `JVM_OPTS` "-Xmx6g"

Minecraft server name
> `MOTD` "A Minecraft (Vault Hunters 1.13.9h) Server Powered by Docker"

Minecraft World name (and what world is automatically started when the server starts)
> `LEVEL` Vault-Hunters

The Level Type - not used currently
> `LEVELTYPE`

The Mode of the World
> `GAMEMODE` survival     [adventure, creative, spectator, survival]

The Difficulty of the World
> `DIFFICULTY` normal     [peaceful, easy, normal, hard]

## Adding Minecraft Operators

Set the enviroment variable `OPS` with a comma separated list of players.

example:
> `OPS="OpPlayer1,OpPlayer2"`

## Original Source
Github:
> https://github.com/Ratomas/cave-factory
Docker:
> https://hub.docker.com/r/ratomas/cave-factory

## Forked Source
> NOTE: Each modded minecraft server is in a dedicated fork
This is the Vault-Hunters branch.
The main branch is dead. Do not use it.

#### Vault Hunters Github:
> https://github.com/Wotupfoo/minecraft-container/tree/vault-hunters

#### Cave Factory Github: (not functional yet)
> https://github.com/Wotupfoo/minecraft-container/tree/cave-factory

## DockerHub image
Full URI
> *docker.io/wotupfoo/vault-hunters:latest* 
or
> *docker.io/wotupfoo/vault-hunters:3rd-edition* 

Shorthand
> *wotupfoo/vault-hunters:latest*
> *wotupfoo/vault-hunters:3rd-edition*

DockerHub webpage
> https://hub.docker.com/r/wotupfoo/vault-hunters/tags

