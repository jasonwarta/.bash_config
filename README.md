# ..bash_config

## Installation

Run

```bash
curl https://jasonwarta.github.io/.bash_config/install.sh | bash
```

Or clone the repo, and source `index.sh` in your `.bashrc` or `.profile`.
For example, if you cloned this repo in your home directory, use this line:

```bash
. ~/.bash_config/index.sh
```

By default, local settings will be loaded from the `local_settings` directory at the root of this repo. This folder can be changed by editing the `LOCAL_SETTINGS` variable, found in `index.sh`.