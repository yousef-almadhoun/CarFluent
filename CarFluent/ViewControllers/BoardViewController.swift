//
//  BoardViewController.swift
//  CarFluent
//
//  Created by mac on 10/26/19.
//  Copyright © 2019 CarFluent. All rights reserved.
//

import UIKit
import FSPagerView

class BoardViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtDescription: UILabel!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = FSPagerView.automaticSize
            
        }
    }
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = self.imageNames.count
            self.pageControl.contentHorizontalAlignment = .left
            pageControl.setFillColor(UIColor.hexColor(hex: "#D2D2D2"), for: .normal)
            pageControl.setFillColor(UIColor.hexColor(hex: "#FFB02B"), for: .selected)
        }
    }
    
    var imageNames: [String] = ["bgBoard(1)", "bgBoard(2)", "bgBoard(3)", "bgBoard(4)"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }

    @IBAction func btnSkip(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "CarFluentViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func nextItem(_ sender: Any) {
        if pageControl.currentPage == 3 {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "CarFluentViewController")
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        self.pageControl.currentPage += 1
        self.pagerView.selectItem(at: Int(pageControl.currentPage), animated: true)
        self.pagerView.deselectItem(at: Int(pageControl.currentPage), animated: true)
    }
}

extension BoardViewController {
    
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UserDefaults.standard.set(true, forKey: "key")
    }
    
    func localized() {
        
    }
    
    func setupData() {
        
    }
    
    func fetchData() {
        
    }
    
}

extension BoardViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.imageNames.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let boradDescription: [board] = [board.board_1, board.board_2, board.board_3, board.board_4]
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        lblTitle.text = boradDescription[index].title.uppercased()
        txtDescription.text = boradDescription[index].description
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.clipsToBounds = true
        cell.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
}

