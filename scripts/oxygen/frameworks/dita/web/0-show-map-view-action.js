/**
 * Action that displays the DITA Map view.
 *
 * @constructor
 */
sync.dita.ShowMapViewAction = function() {
  sync.actions.AbstractAction.call(this);
};
goog.inherits(sync.dita.ShowMapViewAction, sync.actions.AbstractAction);

/** @override */
sync.dita.ShowMapViewAction.prototype.actionPerformed = function (opt_callback) {
  sync.dita.DitaMapViewInstaller.installView(opt_callback);
};

/** @override */
sync.dita.ShowMapViewAction.prototype.getDisplayName = function () {
  return tr(msgs.SHOW_DITA_MAP_VIEW);
};

/** @override */
sync.dita.ShowMapViewAction.prototype.getDescription = function () {
  return tr(msgs.SHOW_DITA_MAP_VIEW);
};

/** @override */
sync.dita.ShowMapViewAction.prototype.renderSmallIcon = function () {
  return goog.dom.createDom("div", ['dita-maps-manager-button', 'ui-action-small-icon']);
};

/** @override */
sync.dita.ShowMapViewAction.prototype.renderLargeIcon = function () {
  return goog.dom.createDom("div", ['dita-maps-manager-button', 'ui-action-large-icon']);
};