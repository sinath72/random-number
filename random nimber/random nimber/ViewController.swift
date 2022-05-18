//
//  ViewController.swift
//  random nimber
//
//  Created by Sina Taherkhani on 6/4/1400 AP.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var num_lbl: UILabel!
    @IBOutlet var luck_lbl: UILabel!
    @IBOutlet var lucky_btn: UIButton!
    let randomColor = [UIColor.blue,UIColor.purple,UIColor.black,UIColor.systemPink,
                       UIColor.gray,UIColor.green,UIColor.cyan,UIColor.orange]
    let randomText=["0s","1s","2s","3s","4s","5s","6s","7s"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupview()
    }
    func getNumber() {
        print(getRandomNumber(index: 0))
        roundWheel()
    }
    func getRandomNumber(index:Int) -> UInt32 {
        let lower : UInt32=0
        let upper : UInt32=8
        
        let randomNumber=arc4random_uniform(upper-lower)+lower
        self.lucky_btn.setTitle((String)(randomNumber), for: .normal)
        return randomNumber
    }
    func setupview(){
        self.lucky_btn.layer.shadowColor=UIColor(rgb:0xFFfddb3a).withAlphaComponent(0.5).cgColor
        self.lucky_btn.layer.shadowOffset=CGSize(width: 4.0, height: 4.0)
        self.lucky_btn.layer.shadowOpacity=1.0
        self.lucky_btn.layer.shadowRadius=0.0
        self.lucky_btn.layer.masksToBounds=false
        self.lucky_btn.layer.cornerRadius=4.0
        self.lucky_btn.makeRadius(radius: 15)
        
        self.num_lbl.text="0"
        self.luck_lbl.text=""
    }
    func roundWheel(){
        var RLN :UInt32!
        DispatchQueue.global(qos: .background).async {
            for i in 0...7{
                DispatchQueue.main.async {
                    RLN=self.getRandomNumber(index: i)
                    self.lucky_btn.backgroundColor=self.randomColor[i]
                    print(i)
                    if (i==7){
                        self.lucky_btn.isEnabled=true
                        self.luck_lbl.text=self.randomText[Int(RLN)]
                        self.num_lbl.text=String(RLN)
                        self.lucky_btn.setTitle("TRY AGAIN",for: .normal)
                        self.lucky_btn.backgroundColor=self.randomColor[Int(RLN)]
                    }else{
                        self.lucky_btn.isEnabled=false
                        self.luck_lbl.text=""
                    }
                }
                usleep(useconds_t(200000))
            }
        }
    }
    @IBAction func lucky_btn(_ sender: Any) {
        getNumber()
    }
}
extension UIColor{
    convenience init(red:Int,green:Int,blue:Int) {
        assert(red >= 0 && red <= 255,"invalid")
        assert(green >= 0 && green <= 255,"invalid")
        assert(blue >= 0 && blue <= 255,"invalid")
        
        self.init(red: CGFloat(red) / 255.0,green: CGFloat(green) / 255.0,blue:CGFloat(blue) / 255.0,alpha:1.0)
    }
    convenience init(rgb:Int) {
        self.init(red:(rgb >> 16) & 0xFF
                  ,green:(rgb >> 8) & 0xFF,
                  blue: rgb & 0xFF
        )
    }
}

extension UIButton{
    func makeRadius(radius:CGFloat) {
        assert(radius > 0, "invalid radius")
        
        self.layer.cornerRadius=radius
    }
}
