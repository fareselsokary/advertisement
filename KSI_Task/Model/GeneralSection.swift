//
//  GeneralSection.swift
//  KSI_Task
//
//  Created by fares elsokary on 13/11/2021.
//

import RxDataSources

struct GeneralSection<Item: IdentifiableType & Equatable>: AnimatableSectionModelType {
    typealias Identity = Int

    var identity: Identity
    var items: [Item]

    init(identity: Identity, items: [Item]) {
        self.identity = identity
        self.items = items
    }

    init(original: GeneralSection<Item>, items: [Item]) {
        self = original
        self.items = items
    }
}
