//
//  TRMosaicColumns.swift
//  MemeME
//
//  Created by Abhishek Prajapati on 5/8/17.
//  Copyright © 2017 abhi. All rights reserved.
//

import UIKit

/**
 Collection view cell class
 free class library from github
 https://github.com/vinnyoodles/TRMosaicLayout
 **/

struct TRMosaicColumns {
    
    var columns:[TRMosaicColumn]
    
    var smallestColumn:TRMosaicColumn {
        return columns.sorted().first!
    }
    
    init() {
        columns = [TRMosaicColumn](repeating: TRMosaicColumn(), count: 3)
    }
    
    subscript(index: Int) -> TRMosaicColumn {
        get {
            return columns[index]
        }
        set(newColumn) {
            columns[index] = newColumn
        }
    }
}

struct TRMosaicColumn {
    
    var columnHeight:CGFloat
    
    init() {
        columnHeight = 0
    }
    
    mutating func appendToColumn(withHeight height:CGFloat) {
        columnHeight += height
    }
}

extension TRMosaicColumn: Equatable { }
extension TRMosaicColumn: Comparable { }

// MARK: Equatable
func ==(lhs: TRMosaicColumn, rhs: TRMosaicColumn) -> Bool {
    return lhs.columnHeight == rhs.columnHeight
}

// MARK: Comparable
func <=(lhs: TRMosaicColumn, rhs: TRMosaicColumn) -> Bool {
    return lhs.columnHeight <= rhs.columnHeight
    
}

func >(lhs: TRMosaicColumn, rhs: TRMosaicColumn) -> Bool {
    return lhs.columnHeight > rhs.columnHeight
}

func <(lhs: TRMosaicColumn, rhs: TRMosaicColumn) -> Bool {
    return lhs.columnHeight < rhs.columnHeight
}

func >=(lhs: TRMosaicColumn, rhs: TRMosaicColumn) -> Bool {
    return lhs.columnHeight >= rhs.columnHeight
}
