[]: {{{1

    File        : README.md
    Maintainer  : Felix C. Stegerman <flx@obfusk.net>
    Date        : 2014-01-28

    Copyright   : Copyright (C) 2014  Felix C. Stegerman

[]: }}}1

## Description
[]: {{{1

  ib2013vm - vm for aangifte inkomstenbelasting 2013

  A set of scripts to create and run a (Ubuntu) VM for the "aangifte
  inkomstenbelasting 2013" program.  For those who need to use it, but
  don't want to run non-free programs on their computer directly.

### Security

[]: {{{2

  **NB**: vagrant **is very insecure** by default.  Older versions run
  ssh listening on all IP addresses -- newer versions still listen on
  localhost; publicly known ssh keys and passwords are used; the
  directory containing the Vagrantfile is shared read-write with the
  VM by default, allowing the guest to compromise the host.

  I've taken steps to mitigate these risks, but you should be very
  careful and review the security yourself.

  The supplied Vagrantfile should disable the default share; you
  should be very careful when adding additional shares.

  The build script will replace the default ssh keys and the
  provisioning script will lock the user password, but -- until the VM
  is built -- someone with access to the VM via ssh (which could be
  anyone on your local network with older versions of vagrant) could
  still compromise the VM using the default keys/password.

[]: }}}2

### Usage

#### Install

  NB: you should install virtualbox and vagrant via your package
  manager if possible.

  1.  Install [virtualbox](https://www.virtualbox.org)
  2.  Install [vagrant](https://www.vagrantup.com)
  3.  Download and unpack the .zip
  4.  Run "Install ib2013vm" (ib2013vm-install.desktop)

#### Use

  1.  Run "Run ib2013vm" (ib2013vm-run.desktop)
  2.  Use the `shared` folder to share files with the VM
  3.  Enter a command (to run in the VM):
        - `ib2013`  runs the "aangifte inkomstenbelasting 2013" program
        - `firefox` runs firefox
        - `mc`      runs the midnight commander file manager
        - `shell`   runs a shell
        - `quit`    quits

#### Remove

  *   Run "Remove ib2013vm" (ib2013vm-remove.desktop)

#### Update

  *   Remove, redownload, reinstall.  You may want to keep the base
      box when removing to speed up the reinstall.

[]: }}}1

## Am I in any way connected to the Belastingdienst?

  No, I don't work for them.  (I do pay taxes.)

## License

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  General Public License for more details.

  GPLv3+ [1].

## References

  [1] GNU General Public License, version 3
  --- http://www.gnu.org/licenses/gpl-3.0.html

[]: ! ( vim: set tw=70 sw=2 sts=2 et fdm=marker : )
