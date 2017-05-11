//
//  RxScrollViewRefresh.swift
//  wenovel
//
//  Created by Tbxark on 11/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import Foundation
import MJRefresh
import RxSwift
import RxCocoa


// 对 MJRefresh 进行 Swift 封装
typealias RefreshAction = () -> ()
typealias RefreshHeaderView = MJRefreshHeader
typealias RefreshFooterView = MJRefreshFooter

protocol UIScrollViewEndRefresh: class {
    func wn_endRefresh(reloadData flag: Bool)
}


enum RxRefreshState {
    case header(refresh: Bool)
    case footer(refresh: Bool)
    
    
    var isRefresh: Bool {
        switch self {
        case .header(let refresh):
            return refresh
        case .footer(let refresh):
            return refresh
        }
    }
    
    var isNew: Bool {
        switch self {
        case .header(_):
            return true
        case .footer(_):
            return false
        }
    }
    
    var isNext: Bool {
        return !isNew
    }
}


extension UIScrollView: UIScrollViewEndRefresh {
    
    var wn_header: RefreshHeaderView? {
        get {
            if let h = mj_header {
                return h
            } else {
                return nil
            }
        }
        set {
            mj_header = newValue
        }
    }
    var wn_footer: RefreshFooterView? {
        get {
            if let h = mj_footer {
                return h
            } else {
                return nil
            }
        }
        set {
            mj_footer = newValue
        }
    }
    
    
    fileprivate var rx_headerRefreshState: Observable<RxRefreshState> {
        if let header = wn_header as? RxRefreshHeader {
            return header.rx_refresh
        } else {
            let header = RxRefreshHeader.refreshHeader()
            mj_header = header
            return header.rx_refresh
        }
    }
    
    
    fileprivate var rx_footerRefreshState: Observable<RxRefreshState> {
        if let footer = wn_footer as? RxRefreshFooter {
            return footer.rx_refresh
        } else {
            let footer = RxRefreshFooter.refreshFooter()
            mj_footer = footer
            return footer.rx_refresh
        }
    }
    
    
    fileprivate func rx_refreshState() -> Observable<RxRefreshState> {
        return Observable.of(rx_headerRefreshState,
                             rx_footerRefreshState).merge()
    }
    
    
    func bindCanLoadMoreSignal(_ signal: Observable<Bool>) {
        _ = signal.takeUntil(rx.deallocating)
            .subscribe(onNext: { [weak self]
                (flag: Bool) in
                guard let `self` = self else {
                    return
                }
                self.wn_footer?.noMoreData = !flag
            })
    }
    
    func rx_beginRefreshHeader() -> Observable<Void> {
        return rx_headerRefreshState.asObservable()
            .filter {
                $0.isRefresh
            }
            .mapToValue(())
    }
    
    
    func rx_beginRefreshFooter() -> Observable<Void> {
        return rx_footerRefreshState.asObservable()
            .filter {
                $0.isRefresh
            }
            .mapToValue(())
    }
    
    
    func rx_beginRefresh() -> Observable<Bool> {
        return rx_refreshState()
            .filter {
                $0.isRefresh
            }
            .map {
                $0.isNew
        }
    }
    
    
    func wn_endRefresh(reloadData flag: Bool) {
        headerEndRefresh()
        wn_footer?.endRefreshing()
    }
    
    func headerBeginRefresh() {
        if let h = wn_header as? RxRefreshHeader {
            h.forceRefreshing()
        } else {
            wn_header?.beginRefreshing()
        }
    }
    
    func headerEndRefresh() {
        wn_header?.endRefreshing()
    }
    
    func footerBeginRefresh() {
        wn_footer?.beginRefreshing()
    }
    
    func footerEndRefresh() {
        wn_footer?.endRefreshing()
    }
    
    
    func setFooterNoMoreData(_ noMore: Bool) {
        wn_footer?.noMoreData = noMore
    }
    
    
}

extension UITableView {
    override func wn_endRefresh(reloadData flag: Bool = false) {
        headerEndRefresh()
        wn_footer?.endRefreshing()
        if flag {
            reloadData()
        }
    }
}

extension UICollectionView {
    override func wn_endRefresh(reloadData flag: Bool = false) {
        headerEndRefresh()
        wn_footer?.endRefreshing()
        if flag {
            reloadData()
        }
    }
    
    
    func wn_endRefreshWithoutAnimation(reloadData flag: Bool = false) {
        headerEndRefresh()
        wn_footer?.endRefreshing()
        if flag {
            UIView.performWithoutAnimation({
                self.reloadData()
            })
        }
    }
    
}

extension MJRefreshFooter {
    var noMoreData: Bool {
        set {
            if newValue {
                isHidden = true
                endRefreshingWithNoMoreData()
            } else {
                isHidden = false
                resetNoMoreData()
            }
        }
        get {
            return isHidden
        }
    }
    
    
}


// 下拉刷新

class RxRefreshHeader: MJRefreshGifHeader {
    
    fileprivate let rx_refresh = PublishSubject<RxRefreshState>()
    
    class func refreshHeader() -> RxRefreshHeader {
        let header = RxRefreshHeader(refreshingBlock: nil)
        header?.lastUpdatedTimeLabel!.isHidden = true
        header?.setTitle("", for: .idle)
//        header?.stateLabel.isHidden = true
        return header!
    }
    
    override func beginRefreshing() {
        super.beginRefreshing()
        rx_refresh.onNext(RxRefreshState.header(refresh: true))
    }
    
    func forceRefreshing() {
        super.beginRefreshing()
        rx_refresh.onNext(RxRefreshState.header(refresh: true))
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        rx_refresh.onNext(RxRefreshState.header(refresh: false))
    }
}


class RxRefreshFooter: MJRefreshAutoNormalFooter {
    fileprivate let rx_refresh = PublishSubject<RxRefreshState>()
    
    class func refreshFooter() -> RxRefreshFooter {
        let footer = RxRefreshFooter(refreshingBlock: nil)
        footer?.triggerAutomaticallyRefreshPercent = 0
        footer?.isAutomaticallyHidden = true
        footer?.setTitle("", for: .idle)
        footer?.setTitle("Load More", for: .pulling)
        footer?.setTitle("Loading", for: .refreshing)
        footer?.setTitle("  ", for: .noMoreData)
        
        return footer!
    }
    
    
    override func beginRefreshing() {
        super.beginRefreshing()
        rx_refresh.onNext(RxRefreshState.footer(refresh: true))
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        rx_refresh.onNext(RxRefreshState.footer(refresh: false))
    }
    
}
