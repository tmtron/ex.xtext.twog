# Testproject for Xtext with 2 Grammars

The repository contains 2 xtext projects:

* `.a`: grammar a which is independent
* `.b`: grammar b, which references grammar a

and 2 simple demo-project that use the grammars and have each a very simple model file:
* `demo/demoA`: uses grammar `.a` (which is independent)
* `demo/demoB`: uses grammar `.b` (which references grammar a) and is dependent on `demoA` 

[![Build Status](https://travis-ci.org/tmtron/ex.xtext.twog.svg?label=travis)](https://travis-ci.org/tmtron/ex.xtext.twog/builds) 

## Building the DSL: 

* just execute `gradlew build install` in the root project - it will install the projects to the local maven repository

## Building the Demo project
in the `demo` folder, execute `gradlew build`

## DerivedStateComputer
An example how to use DerivedStateComputer is in the [DerivedStateComputer branch](../../tree/DerivedStateComputer)

Links:

* Xtext forum discussion: [Compiler tests for multi-DSLs?](https://www.eclipse.org/forums/index.php/t/1091347/)

