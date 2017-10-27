//
//  AboutViewController.swift
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/25.
//  Copyright © 2017年 何韬. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnGuide: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnClick(_ sender: Any) {
        exit(0)
    }
    
    @IBAction func abtClick(_ sender: Any) {
        let aboutAlert = UIAlertController(title: "关于", message: "Copyright © 2011-2017 Sawatari Inc. All rights reserved.\nhttp://www.katouspace.com",preferredStyle: .alert)
        let aboutCancel = UIAlertAction(title: "确定", style: .destructive, handler: nil)
        aboutAlert.addAction(aboutCancel)
        self.present(aboutAlert, animated: true, completion: nil)
    }
    
    @IBAction func callClick(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "telprompt://+8618655629450")!)
    }
    
    @IBAction func guiClick(_ sender: Any) {
        let guideAlert = UIAlertController(title: "使用说明", message: "本简易APP可用于监测手机各部件工作状态，以及查询手机内部配置、网络状况等情况。",preferredStyle: .alert)
        let guideCancel = UIAlertAction(title: "确定", style: .destructive, handler: nil)
        guideAlert.addAction(guideCancel)
        self.present(guideAlert, animated: true, completion: nil)
    }
}
