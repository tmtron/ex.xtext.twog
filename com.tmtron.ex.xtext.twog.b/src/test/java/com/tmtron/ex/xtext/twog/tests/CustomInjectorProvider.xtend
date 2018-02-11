package com.tmtron.ex.xtext.twog.tests

import com.tmtron.ex.xtext.twog.tests.BInjectorProvider
import com.tmtron.ex.xtext.twog.AStandaloneSetup

class CustomInjectorProvider extends BInjectorProvider {
	
	override internalCreateInjector() {
		AStandaloneSetup.doSetup
		super.internalCreateInjector()
	}
	
}