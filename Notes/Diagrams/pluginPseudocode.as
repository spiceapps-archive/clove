var pm:PluginManager = new PluginManager("PluginSettings.cloveSettings");
pm.addPlugin(new InternalInstalledPlugin());


pm.addEventListener(Event.COMPLETE,onPluginsLoaded);

pm.loadPlugins();



............somewhere in the code


var c:PluginController = new PluginController(PluginManager,new InternalInstalledPlugin());
				plugin.initialize(this);