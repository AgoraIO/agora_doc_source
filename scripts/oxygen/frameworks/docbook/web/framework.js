sync.docbook = sync.docbook || {};

/**
 * Constructor for the docbook Extension.
 *
 * @constructor
 */
sync.docbook.DocbookExtension = function(){
  sync.ext.Extension.call(this);
  this.editorCustomizers_ = [];
};
goog.inherits(sync.docbook.DocbookExtension, sync.ext.Extension);

/**
 * The docbook version.
 */
sync.docbook.DocbookExtension.prototype.version =
  (decodeURIComponent(decodeURIComponent(sync.ext.Registry.extensionURL))).indexOf("5") !== -1? 5 : 4;

/**
 * Extend the base insert web link action for DocBook.
 * @param {sync.Editor} editor The editor.
 */
sync.docbook.DocbookExtension.prototype.extendWebLinkAction = function (editor) {
  var insertWebLinkActionId =
    sync.docbook.DocbookExtension.prototype.version === 5 ? "insert.web.link" : "insert.web.ulink";
  var actionsManager = editor.getActionsManager();
  var originalInsertWebLinkAction = actionsManager.getActionById(insertWebLinkActionId);
  if(originalInsertWebLinkAction) {
    var webLinkOperationClass = sync.docbook.DocbookExtension.prototype.version === 5 ?
      "ro.sync.ecss.extensions.docbook.link.InsertExternalLinkOperation" :
      "ro.sync.ecss.extensions.docbook.link.InsertULink";
    var insertWebLinkAction = new sync.actions.InsertWebLink(
      originalInsertWebLinkAction,
      webLinkOperationClass,
      editor,
      'url_value');
    actionsManager.registerAction(insertWebLinkActionId, insertWebLinkAction);
  }
};

/**
 * Extend the base insert image action for DocBook.
 *
 * @param {goog.structs.Map<String, sync.actions.AbstractAction>} actionsMap The map between actions id and action.
 * @param {sync.api.EditingSupport} editingSupport The editing support.
 */
sync.docbook.DocbookExtension.prototype.extendInsertImageAction = function(actionsMap, editingSupport) {
  var actionId = 'insert.graphic';
  var originalInsertImageAction = actionsMap.get(actionId);
  if (originalInsertImageAction) {
    var insertImageAction = new sync.actions.InsertImage(
      originalInsertImageAction,
      sync.docbook.DocbookExtension.prototype.version === 5 ?
        "ro.sync.ecss.extensions.docbook.InsertImageDataOperation" :
        "ro.sync.ecss.extensions.docbook.InsertGraphicOperation",
      editingSupport);
    actionsMap.set(actionId, insertImageAction);
  }
};

/**
 * Extend the base insert table action for DocBook.
 *
 * @param {goog.structs.Map<String, sync.actions.AbstractAction>} actionsMap The map between actions id and action.
 * @param {sync.api.EditingSupport} editingSupport The editing support.
 */
sync.docbook.DocbookExtension.prototype.extendInsertTableAction = function(actionsMap, editingSupport) {
  var actionId = 'insert.table';
  var originalInsertTableAction = actionsMap.get(actionId);
  var namespace = sync.docbook.DocbookExtension.prototype.version === 5 ?
    "http://docbook.org/ns/docbook" : "";
  if (originalInsertTableAction) {
    var insertTableAction = new sync.actions.InsertTable(
      originalInsertTableAction,
      "ro.sync.ecss.extensions.docbook.table.InsertTableOperation",
      editingSupport,
      [sync.actions.InsertTable.TableTypes.CALS, sync.actions.InsertTable.TableTypes.HTML],
      [sync.actions.InsertTable.ColumnWidthTypes.PROPORTIONAL,
        sync.actions.InsertTable.ColumnWidthTypes.DYNAMIC,
        sync.actions.InsertTable.ColumnWidthTypes.FIXED],
      "Title",
      namespace
    );
    actionsMap.set(actionId, insertTableAction);
  }
};

/**
 * Editor created callback.
 *
 * @param {sync.Editor} editor The currently created editor.
 */
sync.docbook.DocbookExtension.prototype.editorCreated = function(editor) {
  goog.events.listen(editor, sync.api.Editor.EventTypes.ACTIONS_LOADED, goog.bind(function(e) {
      // call only when the actions were loaded.
    if(e.actionsConfiguration.actions) {
      var i;
      for (i = 0; i < this.editorCustomizers_.length; i++) {
        this.editorCustomizers_[i](editor, e.actionsConfiguration);
      }
    }

    // Wrap the Insert Web Link action.
    this.extendWebLinkAction(editor);

    addOldStyleTableActions(e.actionsConfiguration, "DocBook", editor);
  }, this), true);
};

sync.docbook.DocbookExtension.prototype.registerActionsHandler = function(handler) {
  this.editorCustomizers_.push(handler);
};

/**
 * Filter the actions available for the current editing support.
 *
 * @param {goog.structs.Map<String, sync.actions.AbstractAction>} actionsMap The map between actions id and action.
 * @param {sync.api.EditingSupport} editingSupport The actions manager containing all the actions.
 */
sync.docbook.DocbookExtension.prototype.filterActions = function(actionsMap, editingSupport) {
  this.extendInsertImageAction(actionsMap, editingSupport);
  this.extendInsertTableAction(actionsMap, editingSupport);
};

/**
 * Adds old-style (selection-based actions to the current configuration.
 *
 * @param {object} actionsConfiguration The actions configuration.
 * @param {string} toolbarName name of the toolbar defined in the framework.
 * @param {sync.api.Editor} editor The current editor.
 */
function addOldStyleTableActions(actionsConfiguration, toolbarName, editor) {
  if (isFrameworkActions(actionsConfiguration, toolbarName)) {
    var join_action = [
      {"id": "table.join", "type": "action"}
    ];
    var split_action = [
      {"id": "table.split", "type": "action"}
    ];
    var row_actions = [
      {"id": "insert.table.row.above", "type": "action"},
      {"id": "insert.table.row.below", "type": "action"},
      {"id": "delete.table.row", "type": "action"}
    ];
    var column_actions = [
      {"id": "insert.table.column.before", "type": "action"},
      {"id": "insert.table.column.after", "type": "action"},
      {"id": "delete.table.column", "type": "action"}
    ];

    // Make table-related actions context-aware.
    [].concat(join_action, split_action, row_actions, column_actions).forEach(function(action) {
      sync.actions.TableAction.wrapTableAction(editor, action.id);
    });

    // Wrap the table split action
    var splitActionId = 'table.split';
    var originalSplitAction = editor.getActionsManager().getActionById(splitActionId);
    if (originalSplitAction) {
      var splitTableAction = new sync.actions.SplitTableCell(
        originalSplitAction,
        editor);
      editor.getActionsManager().registerAction(splitActionId, splitTableAction);
    }

    var contextualItems = actionsConfiguration.contextualItems;
    for (var i = 0; i < contextualItems.length; i++) {
      if (contextualItems[i].name === tr(msgs.TABLE_)) {
        var items = contextualItems[i].children;

        var row_actions_index = indexOfId(items, row_actions[2].id);
        goog.bind(items.splice, items, row_actions_index, 1).apply(items, row_actions);

        var column_actions_index = indexOfId(items, column_actions[2].id);
        goog.bind(items.splice, items, column_actions_index, 1).apply(items, column_actions);
        break;
      }
    }
  }
}

/**
 * @param {Array<{id:string}>} items The array of items.
 * @param {string} id The ID that we search for.
 * @return {number} The index of the element with the given ID.
 */
function indexOfId(items, id) {
  for (var i = 0; i < items.length; i++) {
    if (items[i].id === id) {
      return i;
    }
  }
  return -1;
}

/**
 * @param {object} actionsConfiguration The actions configuration.
 * @param {string} toolbarName name of the toolbar defined in the framework.
 *
 * @return {boolean} true if the actions loaded come from the framework.
 */
function isFrameworkActions(actionsConfiguration, toolbarName) {
  var toolbars = actionsConfiguration.toolbars;
  return toolbars && toolbars.length > 0 && toolbars[0].name === toolbarName;
}

// Publish the extension.
sync.ext.Registry.extension = new sync.docbook.DocbookExtension();