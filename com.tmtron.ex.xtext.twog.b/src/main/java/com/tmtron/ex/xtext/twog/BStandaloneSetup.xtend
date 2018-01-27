/*
 * generated by Xtext 2.13.0
 */
package com.tmtron.ex.xtext.twog

import com.google.inject.Injector

/**
 * Initialization support for running Xtext languages without Equinox extension registry.
 */
class BStandaloneSetup extends BStandaloneSetupGenerated {

	def static void doSetup() {
		new BStandaloneSetup().createInjectorAndDoEMFRegistration()
	}
	
	override Injector createInjectorAndDoEMFRegistration() {
		AStandaloneSetup.doSetup()
		super.createInjectorAndDoEMFRegistration()
	}		
}