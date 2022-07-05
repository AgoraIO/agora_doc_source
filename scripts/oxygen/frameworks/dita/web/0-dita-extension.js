sync.dita = sync.dita || {};

/**
 * Constructor for the DITA Extension.
 *
 * @constructor
 */
sync.dita.DitaExtension = function() {
  sync.ext.Extension.call(this);

  var decodedExtensionUrl = decodeURIComponent(decodeURIComponent(sync.ext.Registry.extensionURL));
  if(goog.string.caseInsensitiveContains( decodedExtensionUrl, "ditamap") ||
    goog.string.caseInsensitiveContains( decodedExtensionUrl, "dita map") ||
    goog.string.caseInsensitiveContains( decodedExtensionUrl, "dita-map") ||
    goog.string.caseInsensitiveContains( decodedExtensionUrl, "dita_map")) {
    
    if (goog.string.caseInsensitiveContains( decodedExtensionUrl, "resolved_topics")) {
        this.type = 'ditamap_resolved_topics';
    } else {
        this.type = 'ditamap';
    }
  } else {
    this.type = 'dita';
  }

  this.editorCustomizers = [];

  this.actionsFilters = [];
};
goog.inherits(sync.dita.DitaExtension, sync.ext.Extension);


sync.dita.DitaExtension.prototype.registerActionsHandler = function(handler) {
  this.editorCustomizers.push(handler);
};

sync.dita.DitaExtension.prototype.registerActionsFilter = function(filter) {
  this.actionsFilters.push(filter);
};


/** 
 * Editor created callback.
 *
 * @param {sync.Editor} editor The currently created editor.
 */
sync.dita.DitaExtension.prototype.editorCreated = function(editor) {
  // Listening on capture so we can add actions to the toolbar before
  // plugins have a chance to remove actions.
  goog.events.listen(editor, sync.api.Editor.EventTypes.ACTIONS_LOADED, goog.bind(function(e) {
    // call only when the actions were loaded.
    if(e.actionsConfiguration.actions) {
      this.customizeEditor(editor, e.actionsConfiguration);
    }
  }, this), true);

  if(this.type === 'ditamap') {
    // Override the open link action to provide the current ditamap as a param.
    goog.events.listen(editor, sync.api.Editor.EventTypes.LINK_OPENED, function(e) {
      if (! e.external) {
        if (!e.params['ditamap']) {
          e.params['ditamap'] = editor.options.url;
        } else {
          // If the ditamap is already specified, it means that the current map is a
          // sub-map and the links must be opened in the context of the parent map.
        }
      }
    }, true);

  }
  
  // Promote the guessed DITA map to active.
  var contextManager = workspace.getEditingContextManager();
  if (!contextManager.getDitaContext().ditamapUrl) {
    var ditamap; 
    if (this.type === 'ditamap') {
      // We prefer the map itself to the guessed one. 
      ditamap = editor.options.url; 
    } else {
      ditamap = editor.options.guessedDitamap;
    }
    if (ditamap) {
      var currentContext = contextManager.getDitaContext();
      contextManager.updateDitaContext(new sync.api.DitaContext(ditamap, currentContext.filterUrl, true));
    }
  }
  // Delete the temporary guessedDitamap property.
  delete editor.options.guessedDitamap;
};

/**
 * Filter the actions available for the current editing support.
 *
 * @param {goog.structs.Map<String, sync.actions.AbstractAction>} actionsMap The map between actions id and action.
 * @param {sync.api.EditingSupport} editingSupport The actions manager containing all the actions.
 */
sync.dita.DitaExtension.prototype.filterActions = function(actionsMap, editingSupport) {
  for (var i = 0; i < this.actionsFilters.length; i++) {
    this.actionsFilters[i](actionsMap, editingSupport);
  }
};

/**
 * Customize the editor based on the actions configuration.
 *
 * @param {sync.api.Editor} editor The editor.
 * @param {sync.api.Editor.ActionsLoadedEvent.ActionsConfiguration} actionsConfiguration The actions configuration.
 */
sync.dita.DitaExtension.prototype.customizeEditor = function(editor, actionsConfiguration) {
  for (var i = 0; i < this.editorCustomizers.length; i++) {
    this.editorCustomizers[i](editor, actionsConfiguration);
  }
};

/**
 * This file will be loaded by the Oxygen XML Web Author in order to
 * provide some custom behaviour for DITA files.
 */

sync.ext.Registry.extension = new sync.dita.DitaExtension();