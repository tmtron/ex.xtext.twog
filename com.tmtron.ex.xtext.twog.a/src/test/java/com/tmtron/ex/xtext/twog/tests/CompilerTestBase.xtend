package com.tmtron.ex.xtext.twog.tests

import org.junit.Rule
import javax.inject.Inject
import org.eclipse.xtext.xbase.testing.TemporaryFolder
import org.eclipse.xtext.testing.InjectWith

@InjectWith(AInjectorProvider)
class CompilerTestBase {
	@Rule
	@Inject
	public TemporaryFolder temporaryFolder	
}