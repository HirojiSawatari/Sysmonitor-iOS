//
//  Gauge.swift
//  Sysmonitor
//
//  Created by 何韬 on 2017/10/26.
//  Copyright © 2017年 何韬. All rights reserved.
//

import Foundation
import QuartzCore
import UIKit

//最大偏转角度
let MAXOFFSETANGLE : Float = 120.0
//初始化指针偏移量
let POINTEROFFSET : Float = 90.0
//最大显示数值
let MAXVALUE : Float = 100.0
//大格子间的分度数目
let CELLMARKNUM : Int = 5
//大格子数目
let CELLNUM : Int = 5
//表盘中心显示的文字
let GAUGESTRING : String = "单位:Km/h"
//缺省的表盘尺寸（正方形）
let DEFLUATSIZE : Int =  300

struct GaugeParam{
    var maxNum: Float = MAXVALUE
    var minNum: Float = 0.00
    
    var maxAngle: Float = MAXOFFSETANGLE
    var minAngle: Float = -MAXOFFSETANGLE
    
    var gaugeValue: Float = 0.00
    var gaugeAngle: Float = -MAXOFFSETANGLE
    var frame: CGRect
    
    var angleperValue: Float{
        get{
            return (self.maxAngle - self.minAngle)/(self.maxNum - self.minNum)
        }
    }
    var scaleNum: Float{
        get{
            return (Float(DEFLUATSIZE)/Float(self.frame.size.width))
        }
    }
    
    init(frame:CGRect){
        self.frame = frame
    }
    
}


class GaugePanel : UIView {
    var context: CGContext!
    var gaugeView: UIImage!
    var pointer: UIImageView!
    var frameCurr: CGRect!
    var labelArray: NSMutableArray!
    var gv: GaugeParam!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        self.pointer = UIImageView(image: UIImage(named: "needle"))
        self.gaugeView = UIImage(named: "cpuPanel")
        self.frameCurr = frame
        self.gv = GaugeParam(frame: frame)
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
        // self.setTextLabel(labelNum: CELLNUM)
        //经过测试CABaseAnimation是按最短路径不能使用，下同
        pointer.layer.transform = CATransform3DMakeRotation(self.transToRadian(angle: CGFloat(-MAXOFFSETANGLE)) , 0, 0, 1)
    }
    
    /*
    //设置文本表盘标记
    func setTextLabel(labelNum:Int){
        labelArray = NSMutableArray(capacity: labelNum)
        var textDis: CGFloat = CGFloat((gv.maxNum - gv.minNum)/Float(labelNum))
        var angelDis: CGFloat = CGFloat(Float(gv.maxAngle-gv.minAngle)/Float(labelNum))
        var radius: CGFloat
        if self.frame.width > 250{
            radius = CGFloat(Float(self.center.x - CGFloat(55/gv.scaleNum))/Float(gv.scaleNum))
        } else if self.frame.width > 200 {
            radius = CGFloat(Float(self.center.x - CGFloat(35/gv.scaleNum))/Float(gv.scaleNum))
        } else if self.frame.width > 150{
            radius = CGFloat(Float(self.center.x - CGFloat(25/gv.scaleNum))/Float(gv.scaleNum))
        } else {
            radius = CGFloat(Float(self.center.x - CGFloat(8/gv.scaleNum))/Float(gv.scaleNum))
        }
        
        var currText: CGFloat = 0.00
        let centerPoint: CGPoint = self.center
        var currAngle:CGFloat
        
        //添加仪表单位
        var title = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        title.autoresizesSubviews = true
        title.textAlignment = NSTextAlignment.center
        title.text = GAUGESTRING
        title.font = UIFont(name:"Helvetica", size: CGFloat(18.0/gv.scaleNum))
        title.center = CGPoint(x: centerPoint.x, y: centerPoint.y+CGFloat(60/gv.scaleNum))
        title.textColor = UIColor.white
        title.backgroundColor = UIColor.clear
        labelArray.add(title)
        self.addSubview(title)
        
        for i in 0 ... labelNum {
            //文本位置颜色
            currAngle = CGFloat(gv.minAngle) + CGFloat(i)*angelDis - CGFloat(POINTEROFFSET)
            currText = CGFloat(gv.minNum) + CGFloat(i)*textDis
            var label = UILabel(frame: CGRect(x: 0 , y: 0 , width: 30, height: 50))
            label.autoresizesSubviews = true
            label.textColor = UIColor.white
            label.backgroundColor = UIColor.clear
            label.font = UIFont(name:"Helvetica", size: CGFloat(16.0/gv.scaleNum))
            
            //文本对齐
            if i < labelNum/2 {
                label.textAlignment = NSTextAlignment.left
            } else if i == labelNum/2 {
                label.textAlignment = NSTextAlignment.center
            } else {
                label.textAlignment = NSTextAlignment.right
            }
            label.text = "\(Int(currText))"
            
            label.center = CGPoint(x: centerPoint.x + self.parseToX(radius: radius, angle: currAngle), y: centerPoint.y + self.parseToY(radius: radius, angle: currAngle))
            
            labelArray.add(label)
            self.addSubview(label)
        }
        
    }
    */
    
    /*
    //设置表盘刻度
    func setLineMark(labelNum:Int){
        var angelDis: CGFloat = CGFloat(Float(gv.maxAngle-gv.minAngle)/Float(labelNum))
        var radius: CGFloat
        var beginPoint: CGPoint
        var endPoint: CGPoint
        
        if self.frame.width > 250 {
            radius = CGFloat(Float(self.center.x - CGFloat(15*gv.scaleNum)))
        } else if self.frame.width > 200 {
            radius = CGFloat(Float(self.center.x - CGFloat(12*gv.scaleNum)))
        } else if self.frame.width > 150 {
            radius = CGFloat(Float(self.center.x - CGFloat(7*gv.scaleNum)))
        } else  {
            radius = CGFloat(Float(self.center.x - CGFloat(3*gv.scaleNum)))
        }
        
        let centerPoint: CGPoint = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        var currAngle:CGFloat
        for i in 0 ... labelNum {
            currAngle = CGFloat(gv.minAngle) + CGFloat(i)*angelDis - CGFloat(POINTEROFFSET)
            if i > labelNum*2/3 {
                context.setStrokeColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.8).cgColor)
            } else if i > labelNum/3 {
                context.setStrokeColor(UIColor(red: 1, green: 1, blue: 0, alpha: 0.8).cgColor)
            } else {
                context.setStrokeColor(UIColor(red: 0, green: 1, blue: 0, alpha: 0.8).cgColor)
            }
            
        }
        
    }
     */
    
    //旋转到指定的值
    func setCurrGaugeValue(value: CGFloat,animation: Bool){
        let temp = self.parseToAngle(val: value)
        gv.gaugeValue = Float(value)
        if animation{
            self.pointToAngle(duration: 0.6, angle: temp)
        }else{
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
        // self.setLineMark(labelNum: CELLNUM * CELLMARKNUM)
        context.strokePath()
    }
    
}
