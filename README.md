# Testproject for Xtext with 2 Grammars

The repository contains 2 projects:

* `.a`: grammar a which is independent
* `.b`: grammar b, which references grammar a

[![Build Status](https://travis-ci.org/tmtron/ex.xtext.twog.svg?label=travis)](https://travis-ci.org/tmtron/ex.xtext.twog/builds) 

## Building the DSL: 

* just execute `gradlew build` in the root project

Links:

* Xtext forum discussion: [Compiler tests for multi-DSLs?](https://www.eclipse.org/forums/index.php/t/1091347/)


## DerivedStateComputer

* When I build demoB, the AjvmModelInferrer is invoked twice
* The build does not fail, but xtext prints some error-messages:

```
:demoB:generateXtext
Auto-Package is off because an explicit package is used for: archive:file:/D:/projects/learning/xtext_2grammars/prj/demo/demoA/build/libs/demoA-1.0.0-SNAPSHOT.jar!/com/tmtron/modelA.dsla
AJvmMdelInferrer: definition=DefStr isPreIndexingPhase:true
AJvmMdelInferrer: definition=DefInt isPreIndexingPhase:true
AJvmMdelInferrer: definition=DefStr isPreIndexingPhase:false
AJvmMdelInferrer: definition=DefInt isPreIndexingPhase:false
BJvmMdelInferrer: use=UseStrCls isPreIndexingPhase:true
BJvmMdelInferrer: use=UseStrCls isPreIndexingPhase:false
AJvmMdelInferrer: definition=DefStr isPreIndexingPhase:false
AJvmMdelInferrer: definition=DefInt isPreIndexingPhase:false
WARNING:The import 'com.tmtron.UseStrCls' is never used. (file:/D:/projects/learning/xtext_2grammars/prj/demo/demoB/src/main/java/com/tmtron/modelB.dslb line : 1 column : 1)
:demoB:compileJava
```