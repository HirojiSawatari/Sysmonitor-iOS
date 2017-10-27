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
    var timer : Timer!
    let detail = GetCPU()
    let device = UIDevice.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // 启用电池监控
        device.isBatteryMonitoringEnabled = true
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

        // CPU表盘初始值
        panel.setCurrGaugeValue(value: CGFloat(detail.cpuUsage()), animation: false)
        // 电量表盘初始值
        panel2.setCurrGaugeValue(value: CGFloat(UIDevice.current.batteryLevel * 100), animation: false)
        
        // 启用计时器，控制每秒执行一次refreshCPU方法
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(self.refreshUI), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode:RunLoopMode.commonModes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func refreshUI() {
        // CPU
        panel.setCurrGaugeValue(value: CGFloat(detail.cpuUsage()), animation: false)
        // 电量
        panel2.setCurrGaugeValue(value: CGFloat(UIDevice.current.batteryLevel * 100), animation: false)
    }

}

