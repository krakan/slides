.. -*- mode: rst -*-
.. This document is formatted for rst2s5
.. http://docutils.sourceforge.net/

===========
 Micronomy
===========

|

|

.. image:: img/b3-tagline-grey.png
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

.. default-role:: literal

Vad?
====

* Micronomy är en webapp som pratar med Maconomys backend
* med andra ord en alternativ frontend till Maconomy

.. class:: illustration
.. image:: img/question.png

Varför?
=======

* GUI:t i Maconomy är irriterande
* Calle ville ha fler deltagare till Init-hack
* Därför!

.. class:: illustration
.. image:: img/deltek-touch.jpg

API?
====

* Maconomy RESTful Web Services - Programmer's Guide 2018
* Firefox Web Developer tools

.. class:: illustration
.. image:: img/firebug.png

Språk?
======

* Javascript

  * fördel: ingen extra server
  * nackdel: riskerar att bli långsamt

* bash, curl & jq

  * fördel: enkelt
  * nackdel: svårt

* Raku

  * fördel: ett riktigt språk
  * nackdel: extra server

.. class:: illustration
.. image:: img/curl.jpg

Första steget - autentisering
=============================

* alternativ

  * Basic
  * OpenID
  * Kerberos
  * Reconnect
  * 2FA

* val

  * Basic + Reconnect

.. class:: illustration
.. image:: img/padlock.png

Första steget - autentisering
=============================

 .. code::

  server=b3iaccess.deltekenterprise.com
  url=https://$server/containers/v1/b3/timeregistration

  token=$(curl -Ins -H Maconomy-Authentication:X-Reconnect $url |
            sed -n 's/^Maconomy-Reconnect: //pi' | tr -d '\r\n')

  curl -s -H Authorization:"X-Reconnect $token" \
       "$url/data;any?card.datevar=2019-12-06" | jq -C . | less

.. class:: illustration
.. image:: img/dominoes.png

Data
====

 .. code::

  {
    "meta": {},
    "links": {},
    "panes": {
      "card": {},
      "table": {
        "meta": {},
        "links": {},
        "records": [
          {
            "meta": {},
            "links": {},
            "data": {}
          },
        ],
        ...
      }
    }
  }

.. class:: right
.. image:: img/425.jpg

Registrera timmar
=================

 .. code::

  curl -H "Authorization: X-Reconnect $token"
       -H "Maconomy-Concurrency-Control: $concurrency" \
       -H "Content-Type: application/json" \
       -d '{"data": {"numberday5": 3}}' \
       "$url/data;any/table/$rownum?card.datevar=2019-12-06"

* där

  * `$concurrency` kommer från `.panes.table.records[$rownum].meta.concurrencyControl`
  * `$rownum` pekar på vilket projekt datat gäller
  * veckodag anges med siffran i `numberday5`
  * vecka anges med `card.datevar`

.. class:: illustration
.. image:: img/clock.jpg

Cro
===

* en bunt Raku-moduler för att bygga reaktiva distribuerade system
* inbyggd HTTP-server
* inbyggd HTTP-klient
* flexibel request router
* utbyggbar content decoder

.. class:: illustration
.. image:: img/cro.png

Cro::WebApp
===========
  .. code::

   ├ service.p6
   ├ lib/
   │ ├ Micronomy.pm6
   │ └ Routes.pm6
   └ resources/
     ├ b3.png
     ├ script/
     │ ├ jquery-3.4.1.slim.min.js
     │ └ nav.js
     ├ styles/
     │ └ micronomy.css
     └ templates/
       ├ login.html.tmpl
       └ timesheet.html.tmpl

.. class:: right
.. image:: img/206.jpg

Raku
====

* `Perl6` har bytt namn till `Raku`
* Nya filändelser `.raku` och `.rakumod` istället för `.p6` och `.pm6`

  * i specifikationsversion `6.e` (under 2020)

* Perl-familjen består nu av Perl, CPerl, RPerl och Raku

* Perl6 akilleshäl var från början att det var långsamt

  * Raku är ofta snabbare än Python
  * Raku är oftast inte mycket långsammare än Perl5
  * Raku är snabbare än Perl5 i vissa fall

.. class:: illustration
.. image:: img/camelia-logo.png

:single:`Tack för ordet!`
=========================

.. class:: illustration
.. image:: img/dominoes2.jpg

.. class:: right
.. image:: img/509.jpg
   :target: https://http.cat/
