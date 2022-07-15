if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    if(!actionsConfig.actions) {
      // the actions were not yet registered
      return;
    }

    var actionsManager = editor.getActionsManager();

    // Replace Conref Action
    var replaceConrefAction = actionsManager.getActionById('all.keyref.conref.replace');
    if(replaceConrefAction) {
      wrapIsEnabled(replaceConrefAction)
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
        // disable the action when in read-only documents.
        if(editor.getReadOnlyStatus().isReadOnly()) {
          isEnabled = false;
        }
        return isEnabled;
      };
    }
  });
}
