.. -*- mode: rst -*-
.. This document is formatted for rst2s5
.. http://docutils.sourceforge.net/

==================
 CfgMgmtCamp 2023
==================

|

|

|

|

.. image:: img/b3-tagline.png
   :alt: B3 Init
   :target: http://b3.se/
   :width: 30%

.. class:: right
.. image:: img/cfgmgmtcamp.png
   :alt: [CfgMgmtCamp logo]

|

.. class:: center

    Jonas Linde <jonas.linde@b3.se>

.. raw:: pdf

      PageBreak oneColumn

.. footer::
  jonas.linde@b3.se

.. role:: single
   :class: single

.. role:: grey
   :class: grey

.. default-role:: literal

Config Management Camp 2023
===========================

* 6-8 February 2023
* Ghent, Belgium
* 2 dagar föredrag
* 1 dag workshops

.. class:: illustration
.. image:: img/cfgmgmtcamp.png

System Initiative
=================

* *What if Infrastructure as Code never existed?*
* *DevOps without papercuts*
* Adam Jacob

.. class:: illustration
.. image:: img/si-black.png

MgmtConfig
==========

* Next Generation Config Management
* *Mgmt Config: The Road to 0.1* - James Shubin

  + mgmt 0.0.1 presenterades på FOSDEM och CfgMgmtCamp 2016

* Directed Acyclic Graph
* real-time automation ::

   $ ./mgmt run lang examples/lang/file0.mcl > mgmt.log 2>&1 &
   $ rm -f /tmp/file1; ls -l /tmp/file1
   -rw-rw-r-- 1 jonas jonas 0 Apr  4 09:27 /tmp/file1
   $

.. class:: illustration
.. image:: img/mgmt.png
