.. _readme:

cloudfoundry-formula
====================

Formula to manage Cloud Foundry. Currently supports:

* `cf cli`
* `bosh cli`


|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/cloudfoundry-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/cloudfoundry-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

A SaltStack formula for CloudFoundry

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.  If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``, which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.  See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available states
----------------

.. contents::
   :local:

``cloudfoundry``
^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs from cloudfoundry solution. The default installation source is package.

``cloudfoundry.cli``
^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry-cli only.

``cloudfoundry.cli.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall cloudfoundry-cli only.

``cloudfoundry.cli.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry-cli package only.

``cloudfoundry.cli.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall cloudfoundry-cli package only.

``cloudfoundry.cli.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry-cli package-repository only.

``cloudfoundry.cli.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall cloudfoundry-cli package-repository only.

``cloudfoundry.cli.archive``
^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry-cli archive only.

``cloudfoundry.cli.archive.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``cloudfoundry.bosh_cli``
^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry bosh-cli only.

``cloudfoundry.bosh_cli.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall cloudfoundry bosh-cli only.

``cloudfoundry.bosh_cli.package``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry bosh-cli package only (MacOS).

``cloudfoundry.bosh_cli.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall the cloudfoundry bosh-cli package only (MacOS).

``cloudfoundry.bosh_cli.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry bosh-cli package-repository only (MacOS).

``cloudfoundry.bosh_cli.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall cloudfoundry bosh-cli package repository only (MacOS).

``cloudfoundry.bosh_cli.binary``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will install cloudfoundry bosh-cli binary archive only (Linux/Windows).

``cloudfoundry.bosh_cli.binary.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will uninstall the cloudfoundry bosh-cli binary archive only.



Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``cloudfoundry`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

