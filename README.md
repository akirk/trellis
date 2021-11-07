# Trellis for Spaces

Contains a WordPress LEMP stack for local development and to provision and deploy to remote servers for the SLE Spaces.
Fork of [Trellis](https://github.com/roots/trellis) with minor adjustments ([our changelog](DOLL-CHANGELOG.md)).
Checkout the Trellis [Documentation](https://roots.io/trellis/docs) and [GitHub repository](https://github.com/roots/trellis).


## Quick Start Local Development

### [1. Install the requirements](https://github.com/roots/trellis#requirements)

Note that the newest version of Virtualbox is not compatible at the moment. Please use Virtualbox Version 6.1.26. [You can download it here](https://www.virtualbox.org/wiki/Download_Old_Builds_6_1)

### 2. Clone Repository

```sh
    # Create and enter project directory
    mkdir your-project-name
    cd your-project-name
    # Clone Trellis into `trellis` folder.
    git clone git@github.com:dol-lab/trellis.git
    # Clone Spaces into `spaces` folder.
    git clone git@github.com:dol-lab/spaces.git
```

### 3. Start and provision your local server

This will take 10-30 minutes on your first run and set up a virtual server from ground up.
It installs spaces with some default blogs & settings.
Check the `./roles/wordpress-install/tasks/main.yml` for more info.

```sh
    cd trellis
    vagrant up
```

### 4. Done! Access via `spaces.test`

You can execute [WP-CLI Commands](https://developer.wordpress.org/cli/commands/) on the virtual machine.

```sh
    # ... in the trellis folder:
    vagrant ssh -- -t 'cd /srv/www/spaces/current; /bin/bash'
    composer install
    composer install-dependencies

    # or more useful things like WP-CLI https://developer.wordpress.org/cli/commands/
    # crate users
    wp user generate --count=10
    wp post create --post_title='Post!' --post_status=publish --post_author=1 --post_content='R2D2'
```

## Remote Server Setup
https://github.com/roots/trellis#remote-server-setup-stagingproduction
The WordPress installer is not automatically running on remote instances, so you currently need to do that manually with WP-CLI.
https://developer.wordpress.org/cli/commands/core/multisite-install/

## Managing (multiple) remote instances

Create your own private fork of Trellis with multiple sites configured in its `wordpress_sites.yml`. Clone it into `trellis`. All sites will run on the same virtual machine.

Ideally create a separate, private fork of Trellis for each instance so you can give exclusive access to customers or their DevOps.

For provisioning and deploying, read the [Remote Server Setup Documentation](https://roots.io/trellis/docs/remote-server-setup/).
Be sure to encrypt sensitive data using a [`.vault_pass`](https://roots.io/trellis/docs/vault/) file! (check `./bin/vault.sh`).

Also create forks for the Spaces repository and clone them next to the `trellis` folder.
Ideally, they should have a child theme and eventually slightly different plugins defined in `composer.json`. Plugins and themes related to spaces that are gitunignored right now can be outsourced to their own repositories in the future so they can also be installed with Composer (for production use).

You should have a folder structure like this:

```sh
your-project-name                  # Project directory
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
    wp --url=spaces.kisd.local search-replace 'spaces.kisd.de' 'spaces.test' --all-tables --skip-columns=guid --precise --recurse-objects --verbose
```

## Merge changes from roots

```bash
git remote add roots-trellis git@github.com:roots/trellis.git
git fetch --tags roots-trellis

# the name of the release tag. https://github.com/roots/trellis/releases
git merge roots-trellis/v1.4.0
```
