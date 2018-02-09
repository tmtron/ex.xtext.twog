package com.tmtron.ex.xtext.twog.tests

import org.junit.runner.RunWith
import org.eclipse.xtext.testing.XtextRunner
import javax.inject.Inject
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.junit.Test
import static extension org.junit.Assert.*

@RunWith(XtextRunner)
class CompilerTest extends CompilerTestBase {
	
	@Inject extension CompilationTestHelper

	@Test
	def void asssertWithExplicitPackage() {
		'''
		package com.tmtron {
		  def Def1 java.lang.String
		}'''	
		.compile[
			'''
			package com.tmtron;
			
			@SuppressWarnings("all")
			public class Def1 {
			  private String def1;
			}
			'''.toString.assertEquals(singleGeneratedCode)
			compiledClass
		]
	}	
	
}