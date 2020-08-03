//
//  GlobalConfig.swift
//  Mememe
//
//  Created by Elena Rybina on 7/30/20.
//  Copyright © 2020 Elena Rybina. All rights reserved.
//

import UIKit
import Foundation

class GlobalConfig {
    static let singleton: GlobalConfig = GlobalConfig()
    private var _onMemeListChanged: [(([Meme])->Void)] = []
    
    var memeList: [Meme] {
        set {
            guard let encodedMemeList = try? PropertyListEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(encodedMemeList, forKey: "MemeList")
            
            _onMemeListChanged.forEach { $0(memeList) }
        }
        get {
            guard let memeListData = UserDefaults.standard.data(forKey: "MemeList"),
                let decodedMemeList = try? PropertyListDecoder().decode([Meme].self,
                                                                        from: memeListData) else { return [] }
            return decodedMemeList
        }
    }
        
    func subscribeOnChange(_ onChanged: (([Meme])->Void)? = nil) {
        guard let onChanged = onChanged else { return }
        _onMemeListChanged.append(onChanged)
    }
}
