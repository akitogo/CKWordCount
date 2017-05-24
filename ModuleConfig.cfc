/**
* ContentBox - A Modular Content Platform
* Copyright since 2012 by Ortus Solutions, Corp
* www.ortussolutions.com/products/contentbox
* ---
* This module enhances ckeditor to allow them to use code mirror for its source editing
**/
component {

	// Module Properties
	this.title 				= "CKWordCount";
	this.author 			= "Aktigo Internet and Media Applications GmbH";
	this.webURL 			= "http://www.akitogo.com";
	this.description 		= "Adds WordCount support to CKEditor";
	this.version			= "1.0.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "CKWordCount";

	function configure(){


		// Compressor Settings
		settings = {
			showParagraphs    = true,
			showWordCount     = true,
			showCharCount     = true,
			maxWordCount      = 7000,
			maxCharCount      = 70000
		};




		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Interceptors
		interceptors = [
		];

		// map objects
		binder.map( "fileUtils@CKWordCount" ).to( "coldbox.system.core.util.FileUtils" );
	}

	/**
	* CKEditor Plugin Integrations
	*/
	function cbadmin_ckeditorExtraPlugins( event, interceptData ){
		arrayAppend( arguments.interceptData.extraPlugins, "wordcount" );
	}

	/**
	* CKEditor Config Integration
	*/
	function cbadmin_ckeditorExtraConfig( event, interceptData ){
		var settingService 	= wirebox.getInstance("SettingService@cb");
		var args 			= { name="cbox-CKWordCount" };
		var allSettings 	= deserializeJSON( settingService.findWhere( criteria=args ).getValue() );


		var extraConfigExists = "";
		if( len(arguments.interceptData.extraConfig) ){
			extraConfigExists = ",";
		}

		arguments.interceptData.extraConfig &= "#extraConfigExists# wordcount : { 'maxWordCount': #allSettings.maxWordCount#, 'maxCharCount': #allSettings.maxCharCount#, 'showParagraphs': #allSettings.showParagraphs#, 'showWordCount': #allSettings.showWordCount#, 'showCharCount': #allSettings.showCharCount#}";

	    }

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// Let's add ourselves to the main menu in the Modules section
		var menuService = wirebox.getInstance( "AdminMenuService@cb" );
		// Add Menu Contribution
		menuService.addSubMenu(
			topMenu 	= menuService.MODULES,
			name 		= "CKWordCount",
			label 		= "CK Word Count",
			href 		= "#menuService.buildModuleLink( 'CKWordCount', 'home.settings' )#"
		);
		// Override settings?
		var settingService 	= wirebox.getInstance( "SettingService@cb" );
		var args 			= { name="cbox-CKWordCount" };
		var setting 		= settingService.findWhere( criteria=args );

		if( !isNull( setting ) ){
			// override settings from contentbox custom setting
			controller.getSetting( "modules" ).CKWordCount.settings = deserializeJSON( setting.getvalue() );
		}
	}

	/**
	* Fired when the module is activated
	*/
	function onActivate(){
		var settingService = wirebox.getInstance( "SettingService@cb" );
		// store default settings
		var findArgs = { name="cbox-CKWordCount" };
		var setting = settingService.findWhere( criteria=findArgs );
		if( isNull( setting ) ){
			var args = { name="cbox-CKWordCount", value=serializeJSON( settings ) };
			var wordCountSettings = settingService.new( properties=args );
			settingService.save( wordCountSettings );
		}

		// Install the ckeditor plugin
		var ckeditorPluginsPath = controller.getSetting( "modules" )[ "contentbox-admin" ].path & "/modules/contentbox-ckeditor/includes/ckeditor/plugins/wordcount";
		var fileUtils  			= wirebox.getInstance( "fileUtils@CKWordCount" );
		var pluginPath  		= controller.getSetting( "modules" )[ "CKWordCount" ].path & "/includes/wordcount";

		fileUtils.directoryCopy( source=pluginPath, destination=ckeditorPluginsPath );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = wirebox.getInstance( "AdminMenuService@cb" );
		// Remove Menu Contribution
		menuService.removeSubMenu( topMenu=menuService.MODULES, name="CKWordCount" );
	}

	/**
	* Fired when the module is deactivated by ContentBox Only
	*/
	function onDeactivate(){
		var settingService 	= wirebox.getInstance( "SettingService@cb" );
		var args  			= { name="cbox-CKWordCount" };
		var setting  		= settingService.findWhere( criteria=args );
		if( !isNull( setting ) ){
			settingService.delete( setting );
		}
		// Uninstall the ckeditor plugin
		var ckeditorPluginsPath = controller.getSetting( "modules" )[ "contentbox-admin" ].path & "/modules/contentbox-ckeditor/includes/ckeditor/plugins/wordcount";
		var fileUtils  			= wirebox.getInstance( "fileUtils@CKWordCount" );
		fileUtils.directoryRemove( path=ckeditorPluginsPath, recurse=true );
	}
}