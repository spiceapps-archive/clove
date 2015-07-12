##### beta 1.21

Added:
 - proper error handling for content
 - youtube plugin
 - Scene Sync Plugin
 - Branded versions of Clove
 - Share feeds online in html

Removed:
 - runtime RSL's used as plugins (for now).

Optimized:
 - refactored codebase to allow support for multiple platforms outside of flash (Vanilla)

##### beta 1.24

Fixed:
 - fixed problem where Clove would freeze on startup
 - problem where feed preference pane showed up randomly
 - problem where blank rows would show up
 - columns can be renamed again
 - problem with youtube where videos would be larger than the column  
 - problem where some columns would show up blank when synchronizing content
 - problem where windows maximized beyond the screen resolution
 - auto-pagination jumpiness

Removed:
 - skip button on installer

Added:
 - clove installer is always on top
 - Authorization prompt for Twitter if the "Unauthorized" error is
	  returned
 - Columns flip to the preference pane if a feed is blank, or if
	there are none
 - filtering content for columns
 - feeds now automatically load
 - error handling for the clove service if the server goes down, or
	  sends back a bad response

Changed:
 - the application doesn't launch until the installer has completed.

Optimized:
 - memory/CPU consumption decreases when hiding Clove
 - removed performance bottleneck when writing setting files


##### beta 1.25

Fixed:
 - memory leak. Youtube videos would continue to play after they've been stopped.
 - problem where RSS html would show up inline
 - removed "null" in RSS inline text view
 - problem where feed editor would close when switching feeds
 - problem where title wouldn't change for columns
 - fixed problem where new accounts wouldn't show up in the most window under the +
 - problem where OAuth would ask to verify twice for twitter
 - fixed problem where twitter OAuth would show up blank if a second account was added.
 - problem where not all selected groups in scene sync would show up
 - problem in Windows where video players would float above everything else

Added:
 - "show hello screen on startup" checkbox for the installer window
 - fantasy victory plugin
 - "share this app" button
 - fixed problem where "Manage Scenes" view was cut off
 - added a backup mechanism incase anything breaks
 - expanded HTML view for RSS feeds
 - atom / RSS 1.0 support
 - launch on startup option
 - open / save column backups

Changed:
 - groups are no longer color coded
 - groups now auto collapse. Users will be able to toggle this off in the preference pane.
 - added sorting capabilities
 - only the selected group is loaded now. This can be changed in the preferences.
 - columns automatically flip back around to the front when a feed is selected.
 - only one column can be edited at a time. Others get flipped back to the front.

Optimized:
 - caching responses that are re-used throughout the application. These are usually feeds with filters
