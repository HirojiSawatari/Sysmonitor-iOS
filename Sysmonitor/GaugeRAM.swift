//
//  GaugeRAM.swift
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/28.
//  Copyright © 2017年 何韬. All rights reserved.
//

// RAM定制表盘
import Foundation
import QuartzCore
import UIKit

//最大偏转角度（逆时针）
let MAXOFFSETANGLE2 : Float = 90.0
//初始化指针偏移量
let POINTEROFFSET2 : Float = 90.0
//最大显示数值
let MAXVALUE2 : Float = 100.0
//大格子间的分度数目
let CELLMARKNUM2 : Int = 5
//大格子数目
let CELLNUM2 : Int = 5
//表盘中心显示的文字
let GAUGESTRING2 : String = "单位:Km/h"
//缺省的表盘尺寸（正方形）
let DEFLUATSIZE2 : Int =  300

struct GaugeParamRAM{
    var maxNum: Float = MAXVALUE2
    var minNum: Float = 0.00
    
    var maxAngle: Float = MAXOFFSETANGLE2
    var minAngle: Float = -MAXOFFSETANGLE2
    
    var gaugeValue: Float = 0.00
    var gaugeAngle: Float = -MAXOFFSETANGLE2
    var frame: CGRect
    
    var angleperValue: Float{
        get{
            return (self.maxAngle - self.minAngle)/(self.maxNum - self.minNum)
        }
    }
    var scaleNum: Float{
        get{
            return (Float(DEFLUATSIZE2)/Float(self.frame.size.width))
        }
    }
    
    init(frame:CGRect){
        self.frame = frame
    }
    
}


class GaugePanelRAM : UIView {
    var context: CGContext!
    var gaugeView: UIImage!
    var pointer: UIImageView!
    var frameCurr: CGRect!
    var labelArray: NSMutableArray!
    var gv: GaugeParamRAM!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        self.pointer = UIImageView(image: UIImage(named: "needle_ram"))
        self.gaugeView = UIImage(named: "ramPanel")
        self.frameCurr = frame
        self.gv = GaugeParamRAM(frame: frame)
        super.init(frame: frame)
        self.setFrameInit(frame: frame)
    }
    
    //初始化绘图框架
    func setFrameInit(frame : CGRect)
    {
        let x = frame.width/2
        let y = frame.height/2
        self.center = CGPoint(x: x, y: y)
        self.backgroundColor = UIColor.clear
        //通过锚点精确定位指针
        pointer.center = self.center
        pointer.layer.anchorPoint = CGPoint(x: 0.50, y: 0.78)
        pointer.transform = CGAffineTransform(scaleX: CGFloat(gv.scaleNum), y: CGFloat(gv.scaleNum))
        self.addSubview(pointer)
        // self.setTextLabel(labelNum: CELLNUM2)
        //经过测试CABaseAnimation是按最短路径不能使用，下同
        pointer.layer.transform = CATransform3DMakeRotation(self.transToRadian(angle: CGFloat(-MAXOFFSETANGLE2)) , 0, 0, 1)
    }
    
    //旋转到指定的值
    func setCurrGaugeValue(value: CGFloat,animation: Bool){
        let temp = self.parseToAngle(val: value)
        gv.gaugeValue = Float(value)
        if animation{
            self.pointToAngle(duration: 0.6, angle: temp)
        } else {
            self.pointToAngle(duration: 0.0, angle: temp)
        }
    }
    
    //动画的方式旋转
    func pointToAngle(duration: CGFloat,angle: CGFloat)
    {
        var ani: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        var values: NSMutableArray = NSMutableArray()
        var distance: CGFloat = (angle)/10
        var v: CATransform3D
        
        ani.duration = CFTimeInterval(duration)
        ani.autoreverses = false
        ani.fillMode = kCAFillModeForwards;
        ani.isRemovedOnCompletion = false
        
        var i: Int = 1
        for i in 0 ... 10 {
            v = CATransform3DRotate(CATransform3DIdentity, self.transToRadian(angle: CGFloat(gv.gaugeAngle) + distance*CGFloat(i)), 0, 0, 1)
            values.add(NSValue(caTransform3D: v))
        }
        //产生指针抖动效果
        v = CATransform3DRotate(CATransform3DIdentity, self.transToRadian(angle: CGFloat(gv.gaugeAngle) + distance*CGFloat(i)), 0, 0, 1)
        values.add(NSValue(caTransform3D: v))
        v = CATransform3DRotate(CATransform3DIdentity, self.transToRadian(angle: CGFloat(gv.gaugeAngle) + distance*CGFloat(i-2)), 0, 0, 1)
        values.add(NSValue(caTransform3D: v))
        v = CATransform3DRotate(CATransform3DIdentity, self.transToRadian(angle: CGFloat(gv.gaugeAngle) + distance*CGFloat(i-1)), 0, 0, 1)
        values.add(NSValue(caTransform3D: v))
        ani.values = values as! [Any]
        pointer.layer.add(ani, forKey: "any")
        gv.gaugeAngle = Float(angle)+gv.gaugeAngle
        
    }
    
    //根据半径和角度换算出X
    func parseToX(radius: CGFloat,angle: CGFloat) -> CGFloat{
        let temp = self.transToRadian(angle: angle)
        return radius*cos(temp)
    }
    
    //根据半径和角度换算出Y
    func parseToY(radius: CGFloat,angle: CGFloat) -> CGFloat{
        let temp = self.transToRadian(angle: angle)
        return radius*sin(temp)
    }
    
    //换算成弧度
    func transToRadian(angle:CGFloat) -> CGFloat {
        return angle * CGFloat(M_PI/180)
    }
    
    //变量值换算成要旋转的角度
    func parseToAngle(val:CGFloat) -> CGFloat{
        //超过范围数据不处理
        if val < CGFloat(gv.minNum) {
            return CGFloat(gv.minNum)
        } else if val > CGFloat(gv.maxNum){
            return CGFloat(gv.maxNum)
        }
        let temp: CGFloat = (val-CGFloat(gv.gaugeValue))*CGFloat(gv.angleperValue)
        
        return temp;
    }
    
    
    //已经旋转的角度换算成变量值，此功能未使用，保留
    func parseToValue(angle: CGFloat) ->CGFloat{
        let temp1 = angle/CGFloat(gv.angleperValue)
        let temp2 = CGFloat(gv.maxNum)/2 + temp1
        if temp2 > CGFloat(gv.maxNum){
            return CGFloat(gv.maxNum)
        } else if temp2 < CGFloat(gv.minNum)
        {
            return CGFloat(gv.minNum)
        }
        return temp2
    }
    
    //绘制仪表
    override func draw(_ rect: CGRect) {
        self.context = UIGraphicsGetCurrentContext()
        context.setFillColor((self.backgroundColor?.cgColor)!)
        context.fill(rect)
        self.gaugeView?.draw(in: self.bounds)
        // self.setLineMark(labelNum: CELLNUM2 * CELLMARKNUM2)
        context.strokePath()
    }
    
}

