if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    if(!actionsConfig.actions) {
      // the actions were not yet registered
      return;
    }

    var actionsManager = editor.getActionsManager();

    // Replace Conref Action
    var replaceConrefAction = actionsManager.getActionById('conref.replace');
    if(replaceConrefAction) {
      wrapIsEnabled(replaceConrefAction)
    }

    // Remove content reference
    var removeContentReference = actionsManager.getActionById('remove_content_reference');
    if(removeContentReference) {
      wrapIsEnabled(removeContentReference)
    }

    /**
     * Wrap the action's is enabled method to take the context in consideration.
     *
     * @param action the action whose isEnabled method to be wrapped.
     */
    function wrapIsEnabled(action) {
      var oldIsEnabled = action.isEnabled;

      action.isEnabled = function() {
        // keep the old enabled logic
        var isEnabled = oldIsEnabled.call(action);

        if(editor.getReadOnlyStatus().isReadOnly()) {
          isEnabled = false;
        } else if(isEnabled ) {
          // The action's enabled status should be context aware
          isEnabled = sync.select.evalSelectionFunction(sync.select.SelectionUtil.isInsideReferencedContent);
        }
        return isEnabled;
      };
    }
  });
}
