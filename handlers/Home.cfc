component{

	// DI
	property name="settingService" 	inject="settingService@cb";
	property name="cb" 				inject="cbHelper@cb";

	function settings( event, rc, prc ){
		// Exit handler
		prc.xehSave = cb.buildModuleLink( "CKWordCount", "home.saveSettings" );
		prc.tabModules_CKWordCount = true;
		// settings
		prc.settings = getModuleSettings( "CKWordCount" );

		param name="prc.settings.maxWordCount"   default="1000";
		param name="prc.settings.maxCharCount"   default="20000";
 		param name="prc.settings.showParagraphs" default="true";
 		param name="prc.settings.showWordCount"  default="true";
 		param name="prc.settings.showCharCount"  default="true";

		// view
		event.setView( "home/settings" );
	}

	function saveSettings( event, rc, prc ){
		// Get compressor settings
		prc.settings = getModuleSettings( "CKWordCount" );

		// iterate over settings
		for( var key in prc.settings ){
			if( structKeyExists( rc, key ) ){
				// save only sent in setting keys
				prc.settings[ key ] = rc[ key ];
			} else {
				// all settings start with show are boolean values
				// these are checkboxes in UI, if not checked value
				// does not exist
				if(left(key,4) eq 'show')
					prc.settings[ key ] = false;
			}
		}

		// Save settings
		var args 	= { name="cbox-CKWordCount" };
		var setting = settingService.findWhere( criteria=args );
		setting.setValue( serializeJSON( prc.settings ) );
		settingService.save( setting );

		// Messagebox
		getModel( "messagebox@cbMessagebox" ).info( "Settings Saved & Updated!" );
		// Relocate via CB Helper
		cb.setNextModuleEvent( "CKWordCount", "home.settings" );
	}

}