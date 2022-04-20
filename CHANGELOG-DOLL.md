## DOLL-CHANGELOG

https://github.com/dol-lab/

We use trellis for provisioning spaces servers and merge their updates.
In this changelog you find the (significant) "customizations" we did.

### April 2022
* Set xdebug.log_level to 0

### December 2020
* We added the variable ``composer_env_dependencies`` (``group_vars/all/main.yml``) It contains a cloneable repo/gist with a composer.json, which can be used to extend the composer.json in the root of your repository.
* Undo composer version limitation (from October).

### October 2020
* ~~[Use composer v1](https://github.com/dol-lab/trellis/commit/5cc9be88305d90f0f82897fc6e994b6191de4b69)~~

### June 2020
* Allow to execute composer scripts on prod ([see](https://github.com/dol-lab/trellis/commit/53b0be3eca9e69e2e87fffaedec24b694af59f2f#diff-43e894bdafa34adb4874fcd2ef07bf243ecbc835dd7f46c55cdd6332726ed3fd)).
* Add a seperate task to updated your .env file so switching between different environments is less painful ([see](https://github.com/dol-lab/trellis/commit/53b0be3eca9e69e2e87fffaedec24b694af59f2f#diff-03d6164e659445d014c36faae1823910a4a1c96cecb017a47c78aa62f4db7365)).

### October 2019
* We use [secure-file](https://github.com/dol-lab/secure-file) to add privacy to files.
This requires some [nginx configuration ](https://github.com/dol-lab/trellis/commit/f437b49f87df2f8559c45607d35a330bf1836fbc).

### August 2019
* Caching for scripts & images ([see](https://github.com/dol-lab/trellis/commit/51c12178dcbe883c87725bc2b0151259cc1033f9))

### June 2019
 * Improve the vault.sh so it encrypts/decrypts all relevant files at the same time.
  [See](https://github.com/dol-lab/trellis/commit/e4f8f5d2d3a79f0a04c7c72f49ce5f8306f8cae6)
 * When WordPress is installed in dev environment the plugin spaces-setup is activated (the wordpress-install role only runs on dev).
  [See](https://github.com/dol-lab/trellis/blob/7a193efc3c5bd6801ccc9d77e01ca903d52fcff3/roles/wordpress-install/tasks/main.yml)

