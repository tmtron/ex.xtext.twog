package com.tmtron.ex.xtext.twog

import org.eclipse.xtext.resource.DerivedStateAwareResource
import org.eclipse.xtext.xbase.jvmmodel.JvmModelAssociator
import com.tmtron.ex.xtext.twog.a.ModelA
import com.tmtron.ex.xtext.twog.a.PackageDeclaration
import com.tmtron.ex.xtext.twog.a.AFactory

class CustomDerivedStateComputer extends JvmModelAssociator {

	override installDerivedState(DerivedStateAwareResource resource, boolean preLinkingPhase) {
		if (resource.getContents().isEmpty())
			return;
		val eObject = resource.contents.head
		if (eObject instanceof ModelA) {
			if (preLinkingPhase) eObject.handleAutoPackage
		}
		
		super.installDerivedState(resource, preLinkingPhase)	
	}
	
	def handleAutoPackage(ModelA model) {
		val firstEle = model.elements.head
		if (firstEle instanceof PackageDeclaration) {
			println('''Auto-Package is off because an explicit package is used for: «model.eResource.URI»''')
			return
		} 
		
		val autoPackageString = model.packageNameOrNull
		if (autoPackageString === null) {
			println('''Failed to get Auto-Package name from: «model.eResource.URI»''')
			return 
		}
		val autoPackage = AFactory.eINSTANCE.createPackageDeclaration() => [
			name = autoPackageString
			elements.addAll(model.elements)
		]
		println('''Auto-Package: «autoPackage.name» / «firstEle?.name»''')
		model.elements.add(autoPackage)	
	}	

	// some logic to get a package name from the URI
	// e.g. '.../com/tmtron/mymodel.mydsl'
	// returns "com.tmtron"
	def getPackageNameOrNull(ModelA model) {
		val uriStr = model.eResource.URI.toString
		val splitResult = uriStr.split('com/')
		if (splitResult.size != 2) return null
		
		val relPath = splitResult.get(1)
		val pathParts = relPath.split('/')
		return 'com.'+pathParts.removeLast.join('.')
	}
	
	def static <T> removeLast(Iterable<T> items) {
		items.take(items.size - 1)
	}
		
}