//
//  FirstViewController.swift
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/25.
//  Copyright © 2017年 何韬. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var cpuView: UIView!
    @IBOutlet var batteryPanel: UIView!
    var panel : GaugePanel!
    var panel2 : GaugePanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // CPU表盘
        // 初始化绘制范围参数
        let frame = CGRect(x: 10, y: 10, width: 151, height: 151)
        // 初始化控件
        panel = GaugePanel(frame: frame)
        cpuView.addSubview(panel)
        
        // 电池表盘
        // 初始化绘制范围参数
        let frame2 = CGRect(x: 10, y: 10, width: 151, height: 151)
        // 初始化控件
        panel2 = GaugePanel(frame: frame2)
        // 更换表盘
        panel2.gaugeView = UIImage(named: "batteryPanel")
        batteryPanel.addSubview(panel2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

