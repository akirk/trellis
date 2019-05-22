# Trellis for Spaces

Contains a WordPress LEMP stack for local development and to provision and deploy to remote servers for the SLE Spaces. Fork of [Trellis](https://github.com/roots/trellis) with minor adjustments. Checkout the Trellis [Documentation](https://roots.io/trellis/docs) and [GitHub repository](https://github.com/roots/trellis).

- Local development environment with Vagrant
- High-performance production servers
- Zero-downtime deploys for your [Bedrock](https://roots.io/bedrock/)-based WordPress sites

## Quick Start

Be sure to have installed the following requirements:

- [Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-osx)
- [Virtualbox](https://www.virtualbox.org/wiki/Downloads) >= 4.3.10
- [Vagrant](https://www.vagrantup.com/downloads.html) >= 2.1.0
- [vagrant-hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager) (optional)
- **Windows user?** [Read the Windows getting started docs](https://roots.io/getting-started/docs/windows-development-environment-trellis/) for slightly different installation instructions.

### 1. Clone Repository

```sh
    # Create and enter project directory
    mkdir doll
    cd doll
    # Clone Trellis into `trellis` and checkout `spaces` branch.
    git clone --recursive git@bitbucket.org:lukasbesch/trellis-spaces.git trellis -b spaces
    # Clone Spaces into `spaces` and checkout `merge-bedrock` branch.
    git clone --recursive git@bitbucket.org:lukasbesch/spaces.git spaces -b merge-bedrock
```

Checkout the [instructions how to manage (multiple) remote instances](#markdown-header-managing-multiple-remote-instances).

See a complete working example in the [roots-example-project.com repo](https://github.com/roots/roots-example-project.com).

### 2. Start and provision your local server

This will take 10-30 minutes on your first run and set up a virtual server from ground up. It installs spaces with some default blogs & settings. Check the `./roles/wordpress-install/tasks/main.yml` for more info.

```sh
    cd trellis
    vagrant up
```

### 3. SSH into your (local virtual vagrant) server to run commands.

```sh
    vagrant ssh -- -t 'cd /srv/www/spaces/current; /bin/bash'
    # run commands from here, for example:
    # composer install
    exit
```

### 4. done :) access via *spaces.test*

---

## Managing (multiple) remote instances

Create your own private fork of Trellis with multiple sites configured in its `wordpress_sites.yml`. Clone it into `trellis`. All sites will run on the same virtual machine.

Ideally create a separate, private fork of Trellis for each instance so you can give exclusive access to customers or their DevOps.

For provisioning and deploying, read the [Remote Server Setup Documentation](https://roots.io/trellis/docs/remote-server-setup/).
Be sure to encrypt sensitive data using a [`.vault_pass`](https://roots.io/trellis/docs/vault/) file! (check `./bin/vault.sh`).

Also create forks for the Spaces repository and clone them next to the `trellis` folder.
Ideally, they should have a child theme and eventually slightly different plugins defined in `composer.json`. Plugins and themes related to spaces that are gitunignored right now can be outsourced to their own repositories in the future so they can also be installed with Composer (for production use).

You should have a folder structure like this:

```sh
doll                  # Project directory
├─── spaces           # Public Spaces repository (Open Source), used by (most) clients.
├─── trellis          # Personal fork of Trellis for development
|    └── group_vars
|        └── development
|            └── wordpress_sites.yml  # Add all your instances here
└── trellis-client1                   # Private Fork of Trellis to provision and deploy to server of Client 1
└── trellis-client2                   # Private Fork of Trellis to provision and deploy to server of Client 2

```

## Use a database from your live server in your development environment

Put the dump into your `trellis` directory, then enter your virtual machine and import using WP-CLI:

```sh
    vagrant ssh
    cd /srv/www/spaces/current
    wp db import /home/vagrant/trellis/YOUR_DATABASE_DUMP.sql
```

You probably need to search and replace the old domain with `spaces.test`:

```sh
    wp --url=spaces.kisd.local search-replace 'spaces.kisd.local' 'spaces.test' --all-tables --skip-columns=guid --precise --recurse-objects --verbose
```
