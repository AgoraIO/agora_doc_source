if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
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

    enhanceDeleteRowAction(editor);
    
    // Wrap the table split action
    var splitActionId = 'table.split';
    var originalSplitAction = editor.getActionsManager().getActionById(splitActionId);
    if (originalSplitAction) {
      var splitTableAction = new sync.actions.SplitTableCell(
        originalSplitAction,
        editor);
      editor.getActionsManager().registerAction(splitActionId, splitTableAction);
    }

    if (shouldInstallTableActions(actionsConfig)) {
      addOldStyleTableActions(actionsConfig);
    }

    function addOldStyleTableActions(actionsConfiguration) {
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

    function shouldInstallTableActions(actionsConfiguration) {
      var toolbars = actionsConfiguration.toolbars;
      if (toolbars && toolbars.length > 0 && toolbars[0].name == "DITA") {
        var items = toolbars[0].children;
        return indexOfId(items, 'table.join') != -1;
      }
      return false;
    }

    /**
     * @param {Array<{id:string}>} items The array of items.
     * @param {string} id The ID that we search for.
     *
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
     * Improve the enabled status detection of the Delete Table Row action.
     *
     * @param editor the current editor.
     */
    function enhanceDeleteRowAction(editor) {
      // the delete rows action should be enabled disabled when
      var deleteRowAction = editor.getActionsManager().getActionById("delete.table.row");
      if (deleteRowAction) {
        var oldIsEnabled = goog.bind(deleteRowAction.isEnabled, deleteRowAction);
        deleteRowAction.isEnabled = function() {
          var isEnabled = oldIsEnabled();
          if(isEnabled && (editor.getReadOnlyStatus().getReadOnlyState().readOnly || sync.select.evalSelectionFunction(sync.util.isInReadOnlyContent))) {
            isEnabled = false;
          }
          return isEnabled;
        };
      }
    }
  });
}