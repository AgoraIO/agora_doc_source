/**
 * Custom DITA Map view renderer.
 */
sync.dita.ViewRenderer = function() {
  sync.view.ViewRenderer.call(this);

  // Listen for DITA Map changes to update the rendered map.
  var contextManager = workspace.getEditingContextManager();
  goog.events.listen(contextManager, sync.api.EditingContextManager.EventTypes.CONTEXT_CHANGED, goog.bind(function(e) {
    this.setMap(contextManager.getDitaContext().ditamapUrl);
  }, this));

  this.contextManager_ = workspace.getEditingContextManager();
};
goog.inherits(sync.dita.ViewRenderer, sync.view.ViewRenderer);

/**
 * @override
 */
sync.dita.ViewRenderer.prototype.getTitle = function() {
  return  tr(msgs.DITA_Map);
};

/** The view does not depend on the opened editor */
sync.dita.ViewRenderer.prototype.supportsEditor = function() {
  return true;
};

/**
 * Install the DITA Map view.
 *
 * @param container the container in which to install.
 */
sync.dita.ViewRenderer.prototype.install = function(container) {
  this.container = container;
  container.classList.add('dita-map-view-container');

  var cD = goog.dom.createDom;

  this.mapNameRendering = cD('div', 'dita-map-view-input');

  this.chooseMapButtonContainer_ = cD('div');
  var mapChoose = cD('div', 'dita-map-view-map', this.chooseMapButtonContainer_, this.mapNameRendering);
  container.appendChild(mapChoose);

  this.treeContainer = cD('div', 'dita-map-view-tree');
  container.appendChild(this.treeContainer);

  this.renderView();
};

sync.dita.ViewRenderer.prototype.createChooseMapButton_ = function () {
  var chooseButton;
  var cD = goog.dom.createDom;
  var urlChooser = workspace.getUrlChooser();
  if(urlChooser) {
    chooseButton = cD('button', {className: 'dita-map-view-choose', title: tr(msgs.SET_DITA_MAP_)}, cD('div', 'Open16_dark'));
    goog.events.listen(chooseButton, goog.events.EventType.CLICK, goog.bind(function() {
      var context = new sync.api.UrlChooser.Context(sync.api.UrlChooser.Type.GENERIC);
      urlChooser.chooseUrl(context, goog.bind(this.setEditorKeysAndRenderView_, this), sync.api.UrlChooser.Purpose.CHOOSE);
    }, this));
  }
  return chooseButton;
};

/**
 * Set the editor keys context and re-render the side-views.
 *
 * @param {string} url The URL.
 *
 * @private
 */
sync.dita.ViewRenderer.prototype.setEditorKeysAndRenderView_ = function (url) {
  if (!url) {
    // Cancel in dialog.
    return;
  }
  this.ditamap = url;
  this.updateMapNameRendering_();

  var isDirty = this.editor.isDirty();
  var spinner = this.showSpinner_();
  var filterUrl = this.contextManager_.getDitaContext().filterUrl;
  var newDitaContext = new sync.api.DitaContext(url, filterUrl);
  var params = {
    ditamap: url,
    ditaval: filterUrl,
    render: true};
  var invokeOperation = this.editor.getActionsManager()
      .invokeOperation('ro.sync.servlet.operation.SetDitaMapOperation', params);
  if (invokeOperation) {
    invokeOperation
        .then(goog.bind(function (result) {
          spinner.hide();
          if (result === 'FAIL') {
            this.renderError(this.treeContainer);
          } else {
            this.contextManager_.updateDitaContext(newDitaContext);
            this.renderMapTree(JSON.parse(result), this.treeContainer);
          }
        }, this))
        .thenCatch(goog.bind(function () {
          spinner.hide();
          this.renderError(this.treeContainer);
        }, this))
        .thenAlways(goog.bind(function() {
          // Setting the DITA Map should not modify the dirty state of the document.
          this.editor.setDirty(isDirty);
        }, this));
  } else {
    this.retrieveMap(url)
      .then(goog.bind(function(mapJson) {
          this.renderMapTree(mapJson);
          this.contextManager_.updateDitaContext(newDitaContext);
        },this))
      .thenCatch(goog.bind(this.renderError, this));
  }
};

/**
 * Render the rendered DITA Map.
 *
 * @param {String} mapUrl the DITA Map URL.
 */
sync.dita.ViewRenderer.prototype.setMap = function(mapUrl) {
  if(mapUrl === this.ditamap) {
    return;
  }

  this.ditamap = mapUrl;
  this.renderView(mapUrl);
};

/**
 * Update the map name rendering.
 *
 * @private
 */
sync.dita.ViewRenderer.prototype.updateMapNameRendering_ = function() {
  var mapName = new sync.util.Url(this.ditamap).getFileName();
  this.mapNameRendering.textContent = mapName;
  this.mapNameRendering.title = mapName;
};

/**
 * Render the DITA Map view in a container.
 *
 * @param mapUrl the url of the ditamap.
 */
sync.dita.ViewRenderer.prototype.renderView = function(mapUrl) {
  if(mapUrl) {
    this.updateMapNameRendering_(mapUrl);
    this.retrieveMap(mapUrl)
      .then(goog.bind(this.renderMapTree, this))
      .thenCatch(goog.bind(this.renderError, this));

  } else {
    // clear the tree container
    goog.dom.removeChildren(this.treeContainer);

    this.mapNameRendering.textContent = tr(msgs.CHOOSE_DITA_MAP_);
  }
};

/**
 * Show a spinner.
 *
 * @return {sync.view.Spinner} the spinner.
 *
 * @private
 */
sync.dita.ViewRenderer.prototype.showSpinner_ = function() {
  goog.dom.removeChildren(this.treeContainer);
  // show spinner.
  var spinner = new sync.view.Spinner(this.treeContainer, 1);
  spinner.show();
  return spinner;
};

/**
 * Retrieves and renders the DITA Map.
 *
 * @param {string} mapUrl the map url.
 *
 * @return {goog.Promise} a promise for the map loading.
 */
sync.dita.ViewRenderer.prototype.retrieveMap = function(mapUrl) {
  var spinner = this.showSpinner_();

  var params = {
    url: encodeURIComponent(mapUrl)
  };

  var ditaval = this.contextManager_.getDitaContext().filterUrl;
  if(ditaval) {
    params.ditaval = encodeURIComponent(ditaval);
  }

  return sync.rest.callAsync('RESTDitamapSupport.getDitamapRepresentation', params)
    .thenAlways(function() {
      spinner.hide();
    });
};

/**
 * Render the map view based on the map descriptor.
 *
 * @param ditaMap the DITA Map descriptor.
 */
sync.dita.ViewRenderer.prototype.renderMapTree = function(ditaMap) {
  // reset found flag
  this.foundCurrentDocumentInMap = false;
  var container = this.treeContainer;
  goog.dom.removeChildren(container);

  var config = [this.generateNodeConfig(ditaMap.root)];
  // dispose previous tree
  this.tree && this.tree.dispose();

  var tree = new sync.dita.DitaMapTreeStructure(container, config, this.ditamap);
  tree.setChildrenDraggable(true);
  this.tree = tree;
  if (tree.isSelected()) {
    tree.getChildAt(0).expand();
  }

  // scroll the selected topic into view
  goog.style.scrollIntoContainerView(
    tree.getSelectedItem().getElement(),
    container);

  // handle the open event
  goog.events.listen(tree, sync.ui.TreeStructure.EventTypes.OPEN, goog.bind(function(e) {
    if (e.node instanceof sync.ui.TreeNode) {
      e.preventDefault();
      this.openNode(e.node, e.newTab);
    }
  }, this));
  // Handle the drag child event.
  goog.events.listen(tree, sync.ui.TreeStructure.EventTypes.CHILD_DRAGSTART, goog.bind(function(e) {
    if (e.node instanceof sync.ui.TreeNode && e.node.getUrl()) {
      e.preventDefault();
      var editingSupport = this.editor.getEditingSupport();
      var rdh = editingSupport.getResourceDragHandler && editingSupport.getResourceDragHandler();
      if (rdh) {
        var dragStartEvent = e.originalEvent;
        var dataTransfer = dragStartEvent.getBrowserEvent().dataTransfer;
        rdh.addCustomData(dataTransfer, { url: e.node.getUrl() });
      }
    }
  }, this));
};

/**
 * Open the node in a new tab.
 *
 * @param {sync.dita.DitaMapTreeNode} node The node to open.
 * @param {boolean} newTab <code>true</code> if should be opened in a new tab.
 */
sync.dita.ViewRenderer.prototype.openNode = function(node, newTab) {
  var url = node.getUrl();
  if (!url) {
    return;
  }

  if(!newTab && this.editor.isDirty() && !this.editor.isAutoSaveEnabled()) {
    this.showDirtyDialog(url);
  } else {
    this.openUrl(url, newTab);
  }
};

/**
 * Shows a dialog informing the user that he should save the document prior to
 * opening the topic from the Map View.
 */
sync.dita.ViewRenderer.prototype.showDirtyDialog = function(url) {
  if(! this.dirtyDialog) {
    this.dirtyDialog = workspace.createDialog();
    this.registerDisposable(this.dirtyDialog);

    this.dirtyDialog.setButtonConfiguration([
      {key: 'new-tab', caption: tr(msgs.OPEN_IN_NEW_TAB)},
      {key: 'cancel', caption: tr(msgs.CANCEL_)}]);

    this.dirtyDialog.setTitle(tr(msgs.UNSAVED_CHANGES));
    var dialogContent = this.dirtyDialog.getElement();
    dialogContent.classList.add('map-view-dirty-dialog');
    dialogContent.appendChild(
      goog.dom.createTextNode(tr(msgs.FILE_HAS_UNSAVED_CHANGES)));
  }

  this.dirtyDialog.onSelect(goog.bind(function(key) {
    if (key === 'new-tab') {
      this.openUrl(url, true);
    }
  }, this));
  this.dirtyDialog.show();
};

/**
 * Open the document url.
 *
 * @param url the document url.
 * @param newTab whether to open it in a new tab or use the current one.
 */
sync.dita.ViewRenderer.prototype.openUrl = function(url, newTab) {
  var linkTarget = newTab ? sync.api.Editor.LinkOpenedEvent.Target.BLANK : sync.api.Editor.LinkOpenedEvent.Target.SELF;
  var linkOpenedEvent = new sync.api.Editor.LinkOpenedEvent(url, false, null, linkTarget);

  // the built-in WA listener will open the document.
  workspace.openLink(linkOpenedEvent);
};

/**
 * Rewrite a map node object into a treeNode configuration object.
 *
 * @param mapNode the map node.
 *
 * @return {{}} the treeNode configuration.
 */
sync.dita.ViewRenderer.prototype.generateNodeConfig = function(mapNode) {
  var node = {};
  node.name = mapNode.title;
  node.href = mapNode.href;
  node.titleComputed = mapNode.titleComputed;
  var nodeType = mapNode.nodeType;
  node.relativePath = nodeType;

  if(nodeType === 'MAP' || nodeType === 'MAPREF') {
    node.smallIcon = '/images/DitaMapRoot16.png';
  } else if(nodeType === 'KEYDEF') {
    node.smallIcon = '/images/DitaKeydefWithKeyword16.png';
  } else {
    node.smallIcon = '@6%2Fdita%2Fditamap.framework%2FDITA%20Map/img/Topic16.png';
  }

  // select the first occurrence of the current topic.
  if(!this.foundCurrentDocumentInMap && this.editor.getUrl() === mapNode.href) {
    node.selected = true;
    this.foundCurrentDocumentInMap = true;
  }
  // if the current element is a map it's children are resolved to it.
  if(mapNode.children) {
    node.type = 'folder';
    node.children = mapNode.children.map(this.generateNodeConfig, this);
  }
  return node;
};

/**
 * Render error loading DITA Map.
 */
sync.dita.ViewRenderer.prototype.renderError = function() {
  var container = this.treeContainer;
  goog.dom.removeChildren(container);
  var cD = goog.dom.createDom;

  var linkText = this.ditamap.substring(this.ditamap.lastIndexOf('/') + 1);
  var openLink = 'oxygen.html?url=' + encodeURIComponent(this.ditamap);

  var mapLink = cD('div', null, cD('a', {
    href: openLink,
    target: '_blank'
  }, linkText));

  // dispatch sync.api.Editor.EventTypes.LINK_OPENED event
  goog.events.listen(mapLink, goog.events.EventType.CLICK, goog.bind(function(e) {
      e.preventDefault();
      this.openUrl(this.ditamap, true);
  }, this));

  container.appendChild(
    cD('div', 'dita-map-error-view', tr(msgs.DITA_MAP_LOAD_FAILED), mapLink));
};

sync.dita.ViewRenderer.prototype.disableChooseMapButton_ = function() {
  if (this.chooseMapButton_) {
    this.chooseMapButton_.setAttribute("disabled", "disabled");
    this.chooseMapButton_.setAttribute("title", tr(msgs.SET_DITA_MAP_) + " " + tr(msgs.DISABLED_IN_CONCURRENT_EDITING_));
  }
}

/**
 * @override
 */
sync.dita.ViewRenderer.prototype.editorChanged = function(editor) {
  var isInRoom = false;

  var editingSupport = editor.getEditingSupport();
  if (editingSupport) {
    var concurrentEditingManager = editingSupport.getConcurrentEditingManager();
    if (concurrentEditingManager) {
      isInRoom = concurrentEditingManager.isInRoom();
      concurrentEditingManager.listen(
        sync.api.ConcurrentEditingManager.EventType.CONCURRENT_EDITING_STARTED,
        this.disableChooseMapButton_.bind(this));
    } else {
      // Maybe it's a markdown editing support.
    }
  } else {
    // Maybe failed to load document.
  }

  if (!this.chooseMapButton_ && !isInRoom) {
    this.chooseMapButton_ = this.createChooseMapButton_();
    if (this.chooseMapButton_) {
      this.chooseMapButtonContainer_.appendChild(this.chooseMapButton_);
    }
  }

  this.editor = editor;
  var editorUrl = editor.getUrl();

  if(this.tree && this.tree.getSelectedItem().getUrl() !== editorUrl) {
    this.tree.selectItemByUrl(editorUrl);
  }
};

/** @override */
sync.dita.ViewRenderer.prototype.getIcon = function(devicePixelRation) {/*NOSONAR*/
  return sync.ext.Registry.extensionURL + sync.util.computeHdpiIcon('img/DITAMap24.png');
};