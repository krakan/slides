.. -*- mode: rst -*-
.. This document is formatted for rst2s5
.. http://docutils.sourceforge.net/

=================
 DevOps Kundcase
=================

|

|

|

.. image:: img/b3-tagline.png
   :alt: B3 Init
   :target: http://b3.se/
   :width: 50%

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

Kundbeskrivning
===============

* ett företag i finansbranchen
* vill förbättra shoppingupplevelsen
* huvudsakligen digitala tjänster

.. class:: illustration
.. image:: img/online_shopping.jpg

Organisation
============

* några hundra produktteam om vardera 5-10 personer

  * varje team har fullt ansvar för sin tjänst

* de flesta teamen har tjänster som hanterar konsumentdata
* ingen driftsorganisation

  * några team har tjäster som används av andra team

.. class:: illustration
.. image:: img/crossfunctional.png

Tekniska val
============

* huvudsakligen AWS
* ett fåtal egna servrar
* Tech Radar

.. class:: illustration
.. image:: img/tools.jpg

Tech Radar
==========

.. image:: img/tech_radar.jpg
     :width: 60%

Tekniska rekommendationer
=========================

* kommunikation

  * G Suite
  * Slack

* versionshantering

  * Bitbucket

* platform

  * GNU Linux - CentOS
  * virtuella servrar (AWS EC2)
  * docker (AWS ECS)

* mätning, monitorering och loggning

  * Datadog
  * Splunk

.. class:: illustration-right
.. image:: img/dominoes.png

Tekniska rekommendationer
=========================

* larmhantering

  * OpsGenie

* automatisering

  * Jenkins
  * Concourse

* konfigurationshantering

  * Ansible

* språk

  * Java
  * Node
  * Python

.. class:: illustration-right
.. image:: img/dominoes.png

DevOps?
=======

* empowered teams
* end-to-end responsibility
* automated builds and testing
* metrics and monitoring
* blameless post mortems
* experimentation platform

.. class:: illustration
.. image:: img/checkbox.gif

DevOps i praktiken
==================

* ...
