package com.tmtron.ex.xtext.twog.tests

import com.google.inject.Inject
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.XtextRunner
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.Rule
import org.eclipse.xtext.xbase.testing.TemporaryFolder
import org.eclipse.xtext.xbase.testing.CompilationTestHelper
import org.eclipse.xtext.xbase.testing.CompilationTestHelper.Result
import org.eclipse.xtext.diagnostics.Severity

import static extension org.junit.Assert.*

@RunWith(XtextRunner)
@InjectWith(BInjectorProvider)
class BCompilerTest {
	
	@Rule
	@Inject
	public TemporaryFolder temporaryFolder
	
	@Inject extension CompilationTestHelper
	
	@Test
	def void testReferences() {
		resourceSet(#[
				"a.dsla" -> '''
				def DefStr java.lang.String
				def DefInt java.lang.Integer
				''',
				'b.dslb' -> '''
				use UseStrCls DefStr
				'''
				])
		.compile[
			checkValidationErrors
			'''
			@SuppressWarnings("all")
			public class UseStrCls {
			  public DefStr defStr;
			}
			'''.toString().assertEquals(getGeneratedCode('UseStrCls'))
			compiledClass
		]
	}	
	
	@Test
	def void testReferencesWithPackage() {
		resourceSet(#[
				"a.dsla" -> '''
				package com.tmtron {
				  def DefStr java.lang.String
				  def DefInt java.lang.Integer
				}''',
				'b.dslb' -> '''
				import com.tmtron.DefStr;
				use UseStrCls DefStr
				'''
				])
		.compile[
			checkValidationErrors
			'''
			import com.tmtron.DefStr;
			
			@SuppressWarnings("all")
			public class UseStrCls {
			  public DefStr defStr;
			}
			'''.toString().assertEquals(getGeneratedCode('UseStrCls'))
			compiledClass
		]
	}	
		
	@Test
	def void testReferencesWithinSamePackage() {
		resourceSet(#[
				"a.dsla" -> '''
				package com.tmtron {
				  def DefStr java.lang.String
				  def DefInt java.lang.Integer
				}''',
				'b.dslb' -> '''
				package com.tmtron {
				  use UseStrCls DefStr
				}'''
				])
		.compile[
			checkValidationErrors
			'''
			package com.tmtron;
			
			import com.tmtron.DefStr;
			
			@SuppressWarnings("all")
			public class UseStrCls {
			  public DefStr defStr;
			}
			'''.toString().assertEquals(getGeneratedCode('com.tmtron.UseStrCls'))
			compiledClass
		]
	}		
		
	@Test
	def void testReferencesWithinSamePackageImplicit() {
		resourceSet(#[
				"src/main/java/com/tmtron/a.dsla" -> '''
				def DefStr java.lang.String
				def DefInt java.lang.Integer
				''',
				'b.dslb' -> '''
				package com.tmtron {
				  use UseStrCls DefStr
				}'''
				])
		.compile[
			checkValidationErrors
			'''
			package com.tmtron;
			
			import com.tmtron.DefStr;
			
			@SuppressWarnings("all")
			public class UseStrCls {
			  public DefStr defStr;
			}
			'''.toString().assertEquals(getGeneratedCode('com.tmtron.UseStrCls'))
			compiledClass
		]
	}	
			
	private def void checkValidationErrors(Result it) {
		val allErrors = getErrorsAndWarnings.filter[severity == Severity.ERROR]
		if (!allErrors.empty) {
			throw new IllegalStateException(
				"One or more resources contained errors : " +
				allErrors.map[toString].join(", ")
			);
		}
	}	
}