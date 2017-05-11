//
//  NovelSendTempCacheImp.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

struct NovelSendTempCacheImp: NovelSendTempCache {
    func cacheNovel(title: String?, content: String?, id: String) -> Bool {
        return false
    }
    
    func readCache(id: String) -> (title: String?, content: String?)? {
        return nil
    }
}
