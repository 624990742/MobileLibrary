//
//  MLSearchBookController.swift
//  MobileLibrary
//
//  Created by jcmac on 2024/4/6.
//  Copyright © 2024 www.jiachen.com. All rights reserved.
//

import UIKit


import UIKit

enum ViewDisplayType: UInt {
    case viewDisplayHistoryTableViewType   // 显示历史搜索
    case viewDisplayResultViewType         // 显示结果
    case viewDisplayDataBlankType          // 数据为空
}

class MLBookSearchController: UIViewController{

    private let kHistroySearchData = "kHistroySearchData"
    private let kMaxHistroyNum = 20
    private var historyData = NSMutableArray()
    private var resultData = NSMutableArray()
    private var _viewDisplayType: ViewDisplayType = .viewDisplayHistoryTableViewType

    // MARK: - Lazy Load

    private lazy var navigationBar: CJSearchNaviBar = {
        let navBar = CJSearchNaviBar(frame: CGRect(x: 0, y: 0, width: ML_ScreenWidth, height: ML_NavigationHeight),
                                            beginEdit: { [weak self] searchBar in
            self?.stopSearchAction()
        },
                                            clickSearch: { [weak self] searchBar in
            self?.saveHistoryKeyWord(searchBar?.text ?? "")
                                            })

        navBar?.backgroundColor = ML_AppThemeColor
        navBar?.clickCancelBlock = {[weak self] in
            self?.backToSuperView()
            self?.navigationController?.popViewController(animated: true)
        }
        // 开启联想搜索
        // navBar.tfdDidChangedBlock = { key in
        //     guard key != "" else { return }
        //
        //     weakSelf.loadResultData(key)
        // }

        return navBar ?? CJSearchNaviBar()
    }()

    private lazy var historyTBView: CJSearchTbView = {
        
        let historyTBView = CJSearchTbView(frame: CGRect(x: 0, y: CGFloat(CGRectGetMaxY(navigationBar.frame)), width: ML_ScreenWidth, height: ML_ScreenHeight - ML_NavigationHeight),
                                           style: .grouped)
        historyTBView.type = "0"
        historyTBView.backgroundColor = .white
        historyTBView.separatorColor = UIColor(hexString: "0xf0f0f0")
        historyTBView.rowHeight = 44
        historyTBView.tableHeaderView = self.hotHeadView

        
        historyTBView.clickResultBlock = {[weak self] key in
            self?.navigationBar.searchBar.text = key
            self?.loadResultData(key ?? "r")
        }
        historyTBView.clickDeleteBlock = {[weak self] in
            self?.deleteHistoryData()
        }

        return historyTBView
    }()

    private lazy var resultTBView: MLSearchResultTableView = {
        let resultTBView = MLSearchResultTableView(frame: CGRect(x: 0, y: CGFloat(CGRectGetMaxY(navigationBar.frame)), width: ML_ScreenWidth, height: ML_ScreenHeight - ML_NavigationHeight),
                                           style: .plain)
        resultTBView.backgroundColor = .white
        resultTBView.separatorColor = UIColor(hexString: "0xf0f0f0")
        resultTBView.type = "1"
        resultTBView.rowHeight = 50

        return resultTBView
    }()

    private lazy var hotHeadView: CJSearchHotView = {
        let hotHeadView = CJSearchHotView(frame: CGRect(x: 0, y: 0, width: ML_ScreenWidth, height: 0),
                                          tagColor: .red,
                                         tagBlock: {[weak self] key in
            print("点击热搜", key ?? "为nil")
            self?.saveHistoryKeyWord(key ?? "R")
                                         })
        hotHeadView?.hotKeyArr = ["红楼梦", "水浒传", "三体", "孔子", "老子", "108条好汉", "我是一个帅小伙", "才华横溢", "为中华崛起而读书"]

        return hotHeadView!
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        
    }

    private func createView() {
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.historyTBView)
        self.view.addSubview(self.resultTBView)
        navigationBar.searchBar.becomeFirstResponder()
        // 加载历史
        loadSearchHistoryData()
        self.resultTBView.clickSearchResultBlock = {[weak self] row in
        
            if self?.resultData.count == 0 {
                return
            }
                
            let model = self?.resultData[row]
            let vc = MLBookDetailController.init()
            vc.book = model as? MLBookInfoModel
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

    // MARK: - Actions

    private func backToSuperView() {
        navigationBar.searchBar.resignFirstResponder()
        dismiss(animated: true) {
            // ...
        }
    }

    // MARK: - Data

    private func loadResultData(_ key: String) {
        viewDisplayType = .viewDisplayResultViewType
        self.resultData.removeAllObjects()
        MLNetManager.loadNetData(API: MLNetAPI.self, target: .searchBook(userId: MLUserInfoManager.userId ?? "", searchKeyWord: key)) { code, dict, msg in
            guard let dict = dict as? [String: Any],
                  let result = dict["Data"] as? [Any] else {
                MLDeugLog(message: "无法解析响应结果")
                return
            }
            
            if result.isEmpty{
                MLDeugLog(message: "搜索无结果")
                self.resultTBView.isUserInteractionEnabled = false
                self.resultTBView.sourceData.removeAllObjects()
                self.resultTBView.showDataCount(count: 0)
                self.resultTBView.reloadData()
                return
            }
            let arr = [MLBookInfoModel].deserialize(from: result)
            if arr?.isEmpty == false {
                self.resultData.addObjects(from: arr! as [Any])
                self.resultTBView.isUserInteractionEnabled = true
                self.resultTBView.sourceData.removeAllObjects()
                self.resultTBView.sourceData.addObjects(from: self.resultData as! [MLBookInfoModel])
                self.resultTBView.showDataCount(count: self.resultData.count)
                self.resultTBView.reloadData()
            }
            
        } failure: { code, msg in
            MLAlert.show(type: MLAlert.AlertType.error, text: msg)
        }

        

        if !navigationBar.openAssociativeSearch {
            navigationBar.searchBar.resignFirstResponder()
        }
    }

    private func stopSearchAction() {
        viewDisplayType = .viewDisplayHistoryTableViewType
        historyTBView.sourceData.removeAllObjects()
        historyTBView.sourceData.addObjects(from: self.historyData as! [String])
        historyTBView.reloadData()
    }

    /**
     切换显示的view
     */
    var viewDisplayType: ViewDisplayType {
          get {
              return _viewDisplayType
          }
          set {
              _viewDisplayType = newValue
              switch viewDisplayType {
              case .viewDisplayHistoryTableViewType:
                  // 显示历史搜索
                  resultTBView.isHidden = true
                  historyTBView.isHidden = false
                  view.bringSubviewToFront(historyTBView)
                  historyTBView.isUserInteractionEnabled = true
              case .viewDisplayResultViewType:
                  // 显示搜索结果
                  historyTBView.isHidden = true
                  resultTBView.isHidden = false
                  view.bringSubviewToFront(resultTBView)
              default:
                  break
              }
          }
      }
    
    
    
    // MARK: - Local Search History

    /**
     本地搜索历史记录
     */
    private func loadSearchHistoryData() {
        guard let originData = UserDefaults.standard.array(forKey: kHistroySearchData) as? [String],
              originData.count > 0 else {
            
            return
        }
        historyData.addObjects(from: originData)
        historyTBView.sourceData.removeAllObjects()
        historyTBView.sourceData.addObjects(from: historyData as! [String])
        historyTBView.reloadData()
        viewDisplayType = .viewDisplayHistoryTableViewType
    }

    /**
     保存搜索记录
     */
    private func saveHistoryKeyWord(_ keyword: String) {
        let searchKey = keyword.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !searchKey.isEmpty else { return }

        if historyData.contains(searchKey) {
            // 如果之前存在，则排序置顶
            historyData.remove(searchKey)
            historyData.insert(searchKey, at: 0)
        } else {
            // 如果之前不存在，则插入置顶
            historyData.insert(searchKey, at: 0)
        }

        // 保存最大数量
        if historyData.count > kMaxHistroyNum {
            historyData.removeLastObject()
        }

        UserDefaults.standard.set(historyData, forKey: kHistroySearchData)
        UserDefaults.standard.synchronize()
        historyTBView.sourceData.removeAllObjects()
        historyTBView.sourceData.addObjects(from: historyData as! [Any])
        historyTBView.reloadData()

        resultTBView.isUserInteractionEnabled = false

        navigationBar.searchBar.text = keyword
        loadResultData(keyword)
    }

    /**
     清除搜索记录
     */
    private func deleteHistoryData() {
        let alertController = UIAlertController(title: "删除提示", message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .default) { _ in
            self.historyData.removeAllObjects()
            UserDefaults.standard.set(self.historyData, forKey: self.kHistroySearchData)
            UserDefaults.standard.synchronize()

            self.historyTBView.sourceData.removeAllObjects()
            self.historyTBView.sourceData.addObjects(from: self.historyData as! [String])
            self.historyTBView.reloadData()
        })
        alertController.addAction(UIAlertAction(title: "取消", style: .default))

        present(alertController, animated: true, completion: nil)
    }

    
}

