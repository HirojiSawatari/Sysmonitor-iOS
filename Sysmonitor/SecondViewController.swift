//
//  SecondViewController.swift
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/25.
//  Copyright © 2017年 何韬. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 详细信息卡片初始化
        detailLabel.text = String(format: "大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father\n大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹大儿啊我是你爹\nすみません、俺はお前の父上だぜ、覚悟しなさい\nDear my son, I'm your father")
        
        // 设置mainScroll属性
        mainScroll.autoresizingMask = UIViewAutoresizing.flexibleHeight
        mainScroll.isScrollEnabled = true
        mainScroll.showsHorizontalScrollIndicator = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

