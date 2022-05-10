# Aleph
Aleph is an index system for Pharo.
It implements an interface for all the users of system navigation including Calypso.

[![CI matrix](https://github.com/pharo-project/Aleph/actions/workflows/build.yml/badge.svg)](https://github.com//pharo-project/Aleph/actions/workflows/build.yml)

## Install

```
Metacello new 
	repository: 'github://pharo-project/Aleph/src';
	baseline: 'Aleph';
	load.
 ```

## The Index Manager

It has an index manager, charged with the task of concentrate all system indexes and accessors to it. 
The find* methods provide access to the contained indexes.
The manager subscribes to SystemAnnouncer to listen system changes (method addition, modification and removals), 
in order to keep the indexes up-to date.

Aleph uses [TaskIt](https://github.com/sbragagnolo/taskit) to handle the run of indexing tasks.
We use a special task it runner in low priority to update the indexes in background, when the system is idle.

The method rebuildAll will discard all previously existing indexes and re-build all from scratch. 

There is only one instance of the index manager (well, that is the idea) and it can be activated or not. 
If it is activated it is used by Spotter and all the users of SystemNavigation. 
Even if it is deactivated I still listen to the events in the system to keep update.
To uninstall it, send the message reset to its class side.

## The indexes

All the indexes are subclasses of AlpIndex.
They are stored in an AlpIndexManager and the indexes should be used through it.

There are two different behaviors: 

 - During the build of the index, the manager will call #beginRebuild, 
 and then classAdded: and methodAdded: for each class and method in the system. 
 Finally the indexes will receive #endRebuild. 

 - During normal image modification the indexes will be notified by the manager by #methodAdded:, 
 #methodRemoved: and #methodModifiedFrom:to: and #classAdded: , #classRemoved: and #class:renamedFrom:to:

Also the indexes have an statistics Dictionary with some information passed by the manager so the 
indexes can improve the process of generation of the index. 

## Types of Indexes

### Basic Indexes

These are the subclasses of AlpBasicIndex. 
The subclasses should implement the response to the different system events that an index is interested in. 

Basically, AlpBasicIndex implements a Dictionary with all the index entries. 
Inside each entry there is an array to store the elements that correspond to the entry.

The subclasses should provide also the initialTableSize to customize how the table is initialized
during the building of the index.

There are two concrete implementations of Basic Indexes:

- AlpReferencesIndex: it is the index to store the references to a given class.
It indexes the name of the global accessible variables and store them in a table with the class that they refer to.

- AlpSendersIndex: it is an index to improve the lookup of senders of a given selector.
It goes over all the methods and store which messages are sent. 
It handles the implicit literals encoded in the bytecode by using #AlpEncodedSpecialLiteralMapProvider

### Trie Indexes

The Trie indexes are all the subclasses of AlpTrieIndex
The trie indexes use two CTOptimizedTrie as the storage of the index.
One trie is used to store the beginnings of the keys and the other the suffixes.
The subclasses provide fulltext search on top of the index. 
This indexes are heavily used by the implementation of Spotter.

The creation goes in two stages:

1) During the building of the index, all the collection of the information is done 
using two Dictionaries to store the intermediate data. 

2) Aftr all the data is calculated, the Optimized Tries are built to enhance the access to the index.

Once the index is created the update is done directly on the tries.

There are two implementations:

- AlpClassesIndex: This index takes all the classes in the system and indexes them. 
- AlpImplementorsIndex: This index takes all the methods in the system and index them using the selector of the method.
