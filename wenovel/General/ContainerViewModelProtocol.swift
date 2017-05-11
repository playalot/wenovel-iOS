//
//  ContainerViewModelProtocol.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

protocol ContainerViewModelProtocol: class {
    var page: Int { get set }
}

extension ContainerViewModelProtocol {
    func changePage(forNew new: Bool) -> Int {
        page = new ? 0 : (page + 1)
        return page
    }
    
    func resetPageWhenError(forNew new: Bool) {
        page = new ? 0 : (page - 1)
    }
}
