# Packer Example - Red Hat Enterprise Linux 7 Vagrant Box

This example build configuration installs and configures RHEL 7 x86_64, and then generates a Vagrant box file, for:

  - VirtualBox

The example can be modified to use more Ansible roles, plays, and included playbooks to fully configure (or partially) configure a box file suitable for deployment for development environments.

## Paternity

This repo is a shamelessly fork from [Tinsjourney](https://github.com/tinsjourney/packer-rhel-7), modified to create a Red Hat Enterprise Linux Vagrant Box with some simplifaction.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build the Vagrant box file:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/)

You must have a Red Hat Subscription to download the Red Hat Enterprise Linux 7 iso. If you don't, [create an account](https://developers.redhat.com) and accept the terms and conditions of the Red Hat Developer Program, which provides no-cost subscriptions for development use only.

## Usage

  - Make sure all the required software (listed above) is installed.
  - cd to the directory containing this README.md file,
  - Create `iso/` directory and move inside your Red Hat Enterprise Linux iso.
  - Edit rhel7.json file, check if `iso_urls` and `iso_checksum` match your RHEL iso.
  - Create file secret.json, with your RHSM information. Put this in the same directory as rhel7.json
```
    {
      "rhsm_username": "XXXXXXXX",
      "rhsm_password" : "XXXXXXXX"
    }
```
- Finally run:
```
    $ packer build --var-file=secret.json rhel7.json
```
After a few minutes, Packer should tell you the box was generated successfully.

## Testing built boxes

###  Prerequisite

The following vagrant plugins should be installed:

 - [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest)
 - [vagrant-registration](https://github.com/projectatomic/adb-vagrant-registration)

During the build of the RHEL7 box, a 'yum update' is launched. The VirtualBox Guest Additions installed are probably not the one for the newly installed kernel. So when the VM will start using this box, it will need to re-compile de VirtualBox Guest Additions. This is done using the vagrant plugins vagrant-vbguest.d

Also we want to register the VM to RHSM, so we do that with vagrant-registration plugin.

File .vagrantplugins make sure those vagrant plugins are installed.

### Let's roll !!! <--I can't get this to work on Windows, see Let's roll 2

There's an included Vagrantfile that allows quick testing of the built Vagrant boxes. From this same directory, run one of the following commands after building the boxes:
```
    # For VirtualBox:
    $ eval $(./jsonenv < secret.json) vagrant up virtualbox --provider=virtualbox
```
[jsonenv](jsonenv) is a small python script stolen from [Keith Rarick](https://gist.github.com/kr/6161118) which convert a json dictionary into environment variables.

### Let's roll 2

Run the following commands (this is for running on Windows):
```
    # Each of these are single line, hit enter after each one.  Make sure you are in the folder where the Vagranfile is located:
    $ set "rhsm_username=<ENTER YOUR RedHat Developer USERNAME>"
    $ set "rhsm_password=<ENTER YOUR RedHat Developer PASSWORD>"
    $ vagrant up
```

## License

MIT license.

## Author Information

Created in 2014 by [Jeff Geerling](http://jeffgeerling.com/), author of [Ansible for DevOps](http://ansiblefordevops.com/).
Modified in 2017 by [Tinsjourney](https://www.gnali.org/)
Modified in 2020 by [AaronHilton-OLSS](http://www.olsssystems.com/)
