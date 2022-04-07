sync.dita.DitaMapViewInstaller = {
  /**
   * Install the DITA Map view if it is not already installed.
   *
   * @param opt_callback optional callback.
   */
  installView: function(opt_callback) {
    opt_callback = opt_callback || goog.nullFunction;

    var viewManager = workspace.getViewManager();
    var installedViews = viewManager.getViewIds();

    // if the view was not installed we install it.
    if (! goog.array.contains(installedViews, 'dita-map-view')) {
      var renderer = new sync.dita.ViewRenderer();
      viewManager.addView('dita-map-view');
      viewManager.installView('dita-map-view', renderer, 'left');
      var mapUrl = workspace.getEditingContextManager().getDitaContext().ditamapUrl;
      renderer.setMap(mapUrl);
    }
    viewManager.focusView('dita-map-view');

    opt_callback();
  }
};