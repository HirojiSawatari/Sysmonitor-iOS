//
//  FirstViewController.swift
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/25.
//  Copyright © 2017年 何韬. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet var perLabel: UILabel!
    @IBOutlet var cpuView: UIView!
    @IBOutlet var batteryPanel: UIView!
    @IBOutlet var ramPanel: UIView!
    @IBOutlet var romProgress: UIProgressView!
    var panel : GaugePanel!
    var panel2 : GaugePanel!
    var panel3 : GaugePanelRAM!
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
        let frame = CGRect(x: 0, y: 0, width: 151, height: 151)
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
        
        // RAM表盘（定制）
        // 初始化绘制范围参数
        let frame3 = CGRect(x: 10, y: 10, width: 230, height: 230)
        // 初始化控件
        panel3 = GaugePanelRAM(frame: frame3)
        ramPanel.addSubview(panel3)

        // CPU表盘初始值
        panel.setCurrGaugeValue(value: CGFloat(detail.cpuUsage()), animation: false)
        // 电量表盘初始值
        panel2.setCurrGaugeValue(value: CGFloat(UIDevice.current.batteryLevel * 100), animation: false)
        // RAM表盘初始值
        let ramper = (1 - (CGFloat(detail.getAvailableMemorySize()) / CGFloat(detail.getTotalMemorySize()))) * 100
        panel3.setCurrGaugeValue(value: ramper, animation: false)
        
        // ROM进度条初始值
        // 高度拉伸
        romProgress.transform = CGAffineTransform(scaleX: 1.0, y: 5.0)
        let romper = 1 - (CGFloat(detail.getAvailableDiskSize()) / CGFloat(detail.getTotalDiskSize()))
        let pertext = "\(Int(romper * 100))" + "%%"
        perLabel.text = String(format: pertext)
        romProgress.progress = Float(romper)
        
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
        // RAM
        let ramper = (1 - (CGFloat(detail.getAvailableMemorySize()) / CGFloat(detail.getTotalMemorySize()))) * 100
        panel3.setCurrGaugeValue(value: ramper, animation: false)
        // ROM
        let romper = 1 - (CGFloat(detail.getAvailableDiskSize()) / CGFloat(detail.getTotalDiskSize()))
        let pertext = "\(Int(romper * 100))" + "%%"
        perLabel.text = String(format: pertext)
        romProgress.progress = Float(romper)
    }

}

