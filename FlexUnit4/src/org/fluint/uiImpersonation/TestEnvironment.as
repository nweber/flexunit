/**
 * Copyright (c) 2007 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 **/ 
package org.fluint.uiImpersonation {
	import flash.utils.getDefinitionByName;
	
	import mx.core.Container;
	import mx.core.FlexVersion;
	import mx.events.FlexEvent;
	import mx.managers.FocusManager;
	import mx.managers.ILayoutManagerClient;
	import mx.managers.SystemManager;

	/** 
	 * TestEnvironment is a singleton class that allows tests to have 
	 * visual components. 
	 * 
	 * The TestCase has a series of fascade methods such as addChild() 
	 * and removeChild() which actually call those methods on this class.
	 **/
	public class TestEnvironment extends Container {
        /**
         * @private
         */
		protected static var instance:TestEnvironment; 

		/** 
		 * Returns a reference to the single instance of this class 
		 * where all visual components will be created during testing.
		 * 
		 * @return A reference to the TestEnvironment class.
		 */
		public static function getInstance():TestEnvironment {
			if ( !instance ) {
				//need to eventually go this route
				//instance = buildInstance();
				instance = new TestEnvironment();
				
				var systemManager:SystemManager;

				//TO-DO: need to deal with this, can't reference 4, likely 3_4 or some other # 				
				if ( FlexVersion.CURRENT_VERSION > FlexVersion.VERSION_3_0 ) {
					var flexGlobals:Class = Class(getDefinitionByName("mx.core::FlexGlobals"));
					systemManager = flexGlobals.topLevelApplication.systemManager;
				} else {
					var appGlobals:Class = Class(getDefinitionByName("mx.core::ApplicationGlobals"));
					systemManager = appGlobals.application.systemManager;
				}
				
				 //= ApplicationGlobals.application.systemManager;
				systemManager.addChild( instance );
				
				//If the SystemManager tries to remove a child bridge from the instance, from say a SWFLoader,
				//and there isn't a FocusManager, the SystemManager will throw an error.  To circumvent this,
				//we'll give the instance a valid FocusManager.
				//We need to be sure that the FocusManager is created *AFTER* adding the instance to the
				//SystemManager, because the FocusManager uses the instance's SystemManager property
				//during construction.
				if ( !instance.focusManager ) {
					instance.focusManager = new FocusManager(instance);
				}
			}
			
			return instance;
		}
		
/*		
		private static function buildInstance():TestEnvironment {
			var child:TestEnvironment = new TestEnvironment();
			var systemManager:SystemManager = ApplicationGlobals.application.systemManager;

			child.systemManager = systemManager;
			child.document = systemManager.document;
       		ILayoutManagerClient(child).nestLevel = 2;

			child.parentChanged(systemManager);
			child.regenerateStyleCache(true);
			child.styleChanged(null);
			//child.initThemeColor();
			child.stylesInitialized();
			

			child.dispatchEvent(new FlexEvent(FlexEvent.ADD));
			child.initialize(); // calls child.createChildren()
						        	
        	return instance;
		}
*/
	}
}







