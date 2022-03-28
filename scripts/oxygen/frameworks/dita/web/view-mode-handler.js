
if(sync.ext.Registry.extension.type === 'ditamap') {
  sync.ext.Registry.extension.registerActionsHandler(function(editor, actionsConfig) {
    var actionsManager = editor.getActionsManager();

    var BASIC_ACTION_ID = "Author/DitaMapBasicMode";
    var basicAction = new sync.actions.review.DitaMapBasicModeAction(editor);
    actionsManager.registerAction(BASIC_ACTION_ID, basicAction);

    var TOPIC_TITLES_ACTION_ID = "Author/DitaMapTopicTitlesMode";
    var topicTitlesAction = new sync.actions.review.DitaMapTopicTitlesModeAction(editor);
    actionsManager.registerAction(TOPIC_TITLES_ACTION_ID, topicTitlesAction);

    var TOPIC_CONTENT_ACTION_ID = "Author/DitaMapTopicContentMode";
    var topicContentAction = new sync.actions.review.DitaMapTopicContentModeAction(editor);
    actionsManager.registerAction(TOPIC_CONTENT_ACTION_ID, topicContentAction);

    var EDIT_EXPANDED_MAP_ACTION_ID = "Author/DitaMapEditWithExpandedTopics";
    var editWithExpandedTopicsAction  = new sync.actions.dita.EditMapWithExpandedTopics(editor);
    actionsManager.registerAction(EDIT_EXPANDED_MAP_ACTION_ID, editWithExpandedTopicsAction);

    for (var i = 0; i < actionsConfig.toolbars.length; i++) {
      var toolbar = actionsConfig.toolbars[i];
      if (toolbar.name === 'DITA Map') {
        var canEditTopicContent = editor.options.inplaceReferenceEditingSupported
          && !editor.getEditingSupport().getConcurrentEditingManager().isInRoom();
        var viewModeConfig =  getDropdownConfig(canEditTopicContent);
        toolbar.children.unshift(
         viewModeConfig,
          {
            type: 'sep'
          });
        break;
      }
    }

    /**
     * Getter for the view mode dropdown configuration.
     *
     * @param inplaceReferenceEditingSupported whether the in-place reference editing is supported.
     *
     * @return the view mode select config.
     */
    function getDropdownConfig(inplaceReferenceEditingSupported) {
      var viewModeConfig = {
        type: "list",
        name: tr(msgs.VIEW_MODE_NAME_),
        iconDom: sync.util.renderLargeIcon(sync.ext.Registry.extensionURL + sync.util.computeHdpiIcon('img/DitaMapViewMode24.png')),
        children: [
        {
          type: "action",
          id: BASIC_ACTION_ID
        },
        {
          type: "action",
          id: TOPIC_TITLES_ACTION_ID
        },
        {
          type: "action",
          id: TOPIC_CONTENT_ACTION_ID
        }
      ]
      };

      if(inplaceReferenceEditingSupported) {
        viewModeConfig.children.push(
          {
            type: 'sep'
          },
          {
            type: "action",
            id: EDIT_EXPANDED_MAP_ACTION_ID
          }
        );
      }

      return viewModeConfig;
    }
  });
}
