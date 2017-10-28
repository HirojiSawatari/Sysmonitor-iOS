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
    @IBOutlet var detailLabel: CustomLabel!
    let detail = GetCPU()
    let device = UIDevice.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 详细信息卡片初始化
        // 内边距
        detailLabel.textInsets = UIEdgeInsetsMake(0, 10, 1, 0)
        // 内容
        let deName = "手机名：\(device.name)\n"
        let deModel = "手机型号：\(device.model)\n"
        let deCompany = "手机品牌：Apple\n"
        let deVersion = "iOS版本号：\(device.systemVersion)\n"
        let deLocaModel = "设备定位型号：\(device.localizedModel)\n\n\n"
        let totRAM = CGFloat(detail.getTotalMemorySize()) / 1024.0 / 1024.0 / 1024.0
        let deRAM = "RAM大小：\(String(format: "%.2f", totRAM))GB\n"
        let totROM = CGFloat(detail.getTotalDiskSize()) / 1024.0 / 1024.0 / 1024.0
        let deROM = "ROM大小：\(String(format: "%.2f", totROM))GB\n"
        let avaROM = CGFloat(detail.getAvailableDiskSize()) / 1024.0 / 1024.0 / 1024.0
        let deUseROM = "可用ROM大小：\(String(format: "%.2f", avaROM))GB\n"
        let deBattery = "电池电量：\(device.batteryLevel * 100)%%\n"
        // 电池状态
        var deBattSta = "电池状态：未知\n\n\n"
        switch UIDevice.current.batteryState {
            case .charging:
                deBattSta = "电池状态：正在充电\n\n\n"
            case .full:
                deBattSta = "电池状态：满电量\n\n\n"
            case .unplugged:
                deBattSta = "电池状态：在放电\n\n\n"
            default:
                deBattSta = "电池状态：未知\n\n\n"
        }
        // 用户界面风格
        var deIdiom = "用户界面风格：未知\n"
        switch device.userInterfaceIdiom {
        case .carPlay:
            deIdiom = "用户界面风格：车载屏\n"
        case .pad:
            deIdiom = "用户界面风格：iPad\n"
        case .phone:
            deIdiom = "用户界面风格：iPhone\n"
        case.tv:
            deIdiom = "用户界面风格：TV\n"
        default:
            deIdiom = "用户界面风格：未知\n"
        }
        // 设备方向
        var deOrient = "设备方向：未知\n\n\n"
        switch UIDevice.current.orientation {
            case .faceDown:
                deOrient = "设备方向：脸朝地\n\n\n"
            case .faceUp:
                deOrient = "设备方向：脸朝上\n\n\n"
            case .landscapeLeft:
                deOrient = "设备方向：头朝左\n\n\n"
            case .landscapeRight:
                deOrient = "设备方向：头朝右\n\n\n"
            case .portrait:
                deOrient = "设备方向：正立\n\n\n"
            case .portraitUpsideDown:
                deOrient = "设备方向：倒立\n\n\n"
            default:
                deOrient = "设备方向：未知\n\n\n"
        }
        let uuid = String(describing: device.identifierForVendor)
        // 获取索引（截取第十个字符串后36个字符）
        let stauuid = uuid.index(uuid.startIndex, offsetBy: 9)
        let enduuid = uuid.index(stauuid, offsetBy: 36)
        let uuid1 = uuid.substring(with: stauuid..<enduuid)
        let deUUID = "UUID：" + uuid1
        
        detailLabel.text = String(format: deName + deModel + deCompany + deVersion + deLocaModel + deRAM + deROM + deUseROM + deBattery + deBattSta + deIdiom + deOrient + deUUID + "\n \n")
        
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

