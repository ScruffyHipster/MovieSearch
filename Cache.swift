//
//  Cache.swift
//  MovieSearch
//
//  Created by Thomas Murray on 31/08/2019.
//  Copyright © 2019 Tom Murray. All rights reserved.
//

import UIKit

/// A caching API which which allows quick, updating, insertion and removal of values
final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifeTime: TimeInterval

    init(dateProvider: @escaping () -> Date = Date.init, entryLifeTime: TimeInterval = 12 * 60 * 60) {
        self.dateProvider = dateProvider
        self.entryLifeTime = entryLifeTime
    }

    /// Insert values into the cache
    ///
    /// - Parameters:
    ///   - value: Value to insert
    ///   - key: key in which to relate to the passed value
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifeTime)
        let entry = Entry(value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    /// Returns optional value for passed key.
    ///
    /// - Parameter key: key for value to return
    /// - Returns: optional return value
    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key))
            else {
                return nil
            }

        guard dateProvider() < entry.epxirationDate else {
            removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    /// Removes value from cache
    ///
    /// - Parameter key: key for removal of value associated.
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            guard let value = newValue else {
                //If nil was assigned to the key we then remove it from the cache.
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
}

extension Cache {
    ///Wrapper which wraps a key
    final class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key) {
            self.key = key
        }

        override var hash: Int {
            return self.key.hashValue
        }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {return false}
            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let value: Value
        let epxirationDate: Date

        init(value: Value, expirationDate: Date) {
            self.value = value
            self.epxirationDate = expirationDate
        }
    }
}
