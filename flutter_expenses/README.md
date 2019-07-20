# Notes:

Flutter updates the screen 60 times per second
Flutter reuses previously calculated paints when possible

Widget and Element tree:

Widget tree is basically just a configuration that rebuilds frequently and links to the
actual rendered objects in the Element Tree. 

Element tree does not rebuild every time build is called, and is linked to the Render tree, which is what is actually rendered to the screen

an element references the widget that it is defined by, and is added when the widget is seen for the first time

state objects are not elements, but other objects persisted in memory

each element also references the rendered object on the screen

calling setState leads to build being called (marks that widget as dirty for the next refresh)
This means that flutter will take a look at that widget, and make changes based on the new configuration defined by that widget. This also means that all children widgets under that one are created brand new (have their build methods called)

Querying Media query will also cause a rebuild whenever something in the media query changes (screen size, orientation, etc. including the keyboard showing)

When widgets are rebuilt, the element tree compares the widget tree with the element tree and updates references to accomodate the changes. It then passes "configuration" changes from the widget to the render object

so media query, setState and theme calls should be nested below the top of the tree to keep the entire tree from being rebuilt every time if possible

const widgets and constructors are also useful for limiting widget tree rebuilds

Code standard to call super methods first.

stateful didUpdateWidget passes the old widget for you to be able to compare changes when that widget is rebuilt

dispose method is run when the widget is disposed due to rebuild (removal from the tree)

Widget Context

Every widget has its own context that is the element in the element tree of that widget.
The contexts build a skeleton that know the placement of the widget in the tree and what is around it

InheritedWidget is a special widget used by MediaQuery and Theme behind the scenes and acts as a direct tunnel to some data
from anywhere in the tree that is accessing this widget, passing the context to the special constructors of these widgets lets the widget know about
what place in the tree is calling it
