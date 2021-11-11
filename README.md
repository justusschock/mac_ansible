# IOP’s Ansible Playbooks

This evolving set of Ansible playbooks automates Mac user creation and designer workstation maintenance at [Ideas On Purpose][iop]. While these are ultimately very specific to our needs, there's likely something here which will be helpful in other situations.

A few of the things these playbooks accomplish:

- Set a default Dock from a simple Yaml list
- Reset Safari
- Install [Homebrew][] and several packages from Homebrew
- Install [Homebrew Cask][cask] and several common applications via Cask

### Initial Setup

Pre-run steps are annoying. I've tried mightily to get around these, but it seems like it's just easier to suck it up and deal with a little bit of manual configuration.

#### Target computer pre-run setup

1.  Set the computer's name in **System Preferences** > **Sharing**. Make a note of the local hostname, a computer named "iMac 3" will probably have the local hostname `imac-3.local`. Ansible will find the target computer by its local hostname or IP address. Recently hostnames haven't been sticking in the terminal, run this on the target to set the local hostname: `sudo scutil –-set HostName new_hostname`
2.  Turn on **Remote Login** in **System Preferences** > **Sharing** to enable SSH connections.

#### Controller Setup

The controller is the computer the playbooks are run from (eg. _your_ computer). This should be every step necessary to set up a clean macOS system to run the playbooks. This should only need to be done once.

1.  Install **Command Line Tools for Xcode** by running `xcode-select --install` in **Terminal**
2.  Install [Ansible](http://docs.ansible.com/ansible) and ssh-copy-id with `brew install ssh-copy-id ansible`
3.  Clone this repository:
    - `git clone https://github.com/justusschock/ansible-mac.git`
4.  `cd ansible-mac`
5.  Install from the `requirements.txt` file: `pip install -r requirements.txt`
6.  Install ansible roles and collections with `ansible-galaxy install -r requirements.yml`

### Running the playbooks

These first steps make sure the controller can talk to the target and execute commands.

#### First run

1.  Copy your SSH public key to the target:  
    `ssh-copy-id justusschock@target-mac.local` If you don't want to use ssh-keys, make sure to pass the `--ask-pass` parameter in 3.
2. Update the `hosts` file
3. Run the playbook with `ansible-playbook --extra-vars "target=YOUR_TARGET_NAME_OR_IP admin_user=YOUR_ADMIN_USER mail_adress_1password=YOUR_ONEPASSWORD_MAIL_ADRESS" playbook.yml`  
4. To run the playbook locally, you can simply exchange the target in `extra_vars` with `localhost` and setting the `--connection=local` flag.

[homebrew]: http://brew.sh
[cask]: https://github.com/phinze/homebrew-cask
