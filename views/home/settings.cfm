<cfoutput>

<div class="row">
    <div class="col-md-12">
        <h1 class="h1"><i class="fa fa-code fa-lg"></i> CKWordCount Settings</h1>
    </div>
</div>


<div class="row">
	<div class="col-md-9">

		<div class="panel panel-default">
		    <div class="panel-body">

				<div class="body" id="mainBody">
					#getInstance( "MessageBox@cbMessageBox" ).renderit()#

					<p>
						Below you can modify the settings used by the CK Code Word Count module.
					</p>

					#html.startForm( action="cbadmin.module.ckwordcount.home.saveSettings", name="settingsForm" )#



						<fieldset>
							<legend><i class="fa fa-cogs"></i> <strong>Options</strong></legend>


								#html.textfield(
			                        label="Max Word Count:",
			                        name="maxWordCount",
			                        maxlength="7",
			                        required="required",
			                        title="maxWordCount",
			                        class="form-control",
			                        wrapper="div class=controls",
			                        labelClass="control-label",
			                        groupWrapper="div class=form-group",
			                        value="#prc.settings.maxWordCount#"
			                    )#


			                     #html.textfield(
			                        label="Max Char Count:",
			                        name="maxCharCount",
			                        maxlength="7",
			                        required="required",
			                        title="maxCharCount",
			                        class="form-control",
			                        wrapper="div class=controls",
			                        labelClass="control-label",
			                        groupWrapper="div class=form-group",
			                        value="#prc.settings.maxCharCount#"
			                    )#



								<br />
			       			 	<div class="controls">
						 		#html.checkbox(
										name    = "showParagraphs",
										label   = "Show Paragraphs:&nbsp;",
										checked	= prc.settings.showParagraphs
									)#
			       			 	</div>

								<br />
			       			 	<div class="controls">
						 		#html.checkbox(
										name    = "showWordCount",
										label   = "Show Word Count:&nbsp;",
										checked	= prc.settings.showWordCount
									)#
			       			 	</div>

			       			 	<br />
			       			 	<div class="controls">
						 		#html.checkbox(
										name    = "showCharCount",
										label   = "Show Char Count:&nbsp;",
										checked	= prc.settings.showCharCount
									)#
			       			 	</div>

						</fieldset>

						<!--- Submit --->
						<div class="actionBar center">
							#html.submitButton(
								value="Save Settings",
								class="btn btn-lg btn-primary",
								title="Save Settings"
							)#
						</div>

					#html.endForm()#

				</div>
			</div>
		</div>

	</div>
	<div class="col-md-3">
		<!--- Info Box --->
		<div class="panel panel-primary">
		    <div class="panel-heading">
		        <h3 class="panel-title"><i class="fa fa-medkit"></i> Need Help?</h3>
		    </div>
		    <div class="panel-body">
		    	#renderview(view="_tags/needhelp", module="contentbox-admin" )#
		    </div>
		</div>
	</div>
</div>

</cfoutput>