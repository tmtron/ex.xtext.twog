# Testproject for Xtext with 2 Grammars

The repository contains 2 projects:

* `.a`: grammar a which is independent
* `.b`: grammar b, which references grammar a

[![Build Status](https://travis-ci.org/tmtron/ex.xtext.twog.svg?label=travis)](https://travis-ci.org/tmtron/ex.xtext.twog/builds) 

## Building the DSL: 

* just execute `gradlew build` in the root project

## DerivedStateComputer
An example how to use DerivedStateComputer is in the [DerivedStateComputer branch](../../tree/DerivedStateComputer)

Links:

* Xtext forum discussion: [Compiler tests for multi-DSLs?](https://www.eclipse.org/forums/index.php/t/1091347/)

