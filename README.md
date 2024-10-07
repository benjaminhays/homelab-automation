# DEPRECATED
# See: https://git.benhays.org/BenHays42/homelab-automation

# Homelab Automation

This is a repo containing some of the PowerShell/Bash scripts and Ansible playbooks I've written and utilized within my personal network/homelab. Most of the scripts/playbooks should be self-explanatory by the name alone, but there's (hopefully) descriptions and comments in each file to explain the purpose and actions taken by each script.

## Using Ansible Playbooks
For any given Ansible playbook, say for example `openssh.yml`, the generic command-line options for running it would be:
```bash
ansible-playbook -i inventory.ini openssh.yml --ask-become-pass
```

## Using Shell Scripts
Most/all of the shell scripts will display a list of arguments and options when called incorrectly or without arguments. As an example, see ssh-compliance.sh:
```
Usage: ssh-compliance.sh (--install-deps) (--docker) <file-with-hosts>
```
