sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
  if('true' === editor.options.showDitaMapView) {
    sync.dita.DitaMapViewInstaller.installView();

  } else if(sync.ext.Registry.extension.type === 'dita' ||
    sync.ext.Registry.extension.type === 'ditamap_resolved_topics') {
    var SHOW_MAP_ACTION_ID = 'DITA/ShowMapView';

    editor.getActionsManager().registerAction(SHOW_MAP_ACTION_ID, new sync.dita.ShowMapViewAction());

    // Add a "set ditamap" button to the DITA toolbar
    for (var i = 0; i < actionsConfig.toolbars.length; i ++) {
      var toolbar = actionsConfig.toolbars[i];
      if (toolbar.name === 'DITA') {
        toolbar.children.unshift({
          id: SHOW_MAP_ACTION_ID,
          type: 'action'
        }, {
          type: 'sep'
        });
        break;
      }
    }
  }
});