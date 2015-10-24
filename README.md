# Ansible keywords completion for Emacs
[![MELPA Stable](http://stable.melpa.org/packages/company-ansible-badge.svg)](http://stable.melpa.org/#/company-ansible)
[![MELPA](http://melpa.org/packages/company-ansible-badge.svg)](http://melpa.org/#/company-ansible)

This library enables the completion of [Ansible](https://github.com/ansible/ansible) keywords
using [Company Mode](https://github.com/company-mode/company-mode) for [Emacs](https://www.gnu.org/software/emacs/).

![Screenshot](/docs/screen.png "")

## How to install
The recommended way to install is via [MELPA](https://github.com/milkypostman/melpa#usage).

## How to configure Company
You need to add `company-ansible` to backends used by company.
```
(add-to-list 'company-backends 'company-ansible)
```

## Coverage
Dictionary contains all modules, parameters and choices from:
* [Ansible Modules - Core](https://github.com/ansible/ansible-modules-core)
* [Ansible Modules - Extras](https://github.com/ansible/ansible-modules-extras)
