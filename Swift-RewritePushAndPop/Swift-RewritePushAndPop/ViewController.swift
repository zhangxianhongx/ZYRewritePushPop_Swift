//
//  ViewController.swift
//  Swift-RewritePushAndPop
//
//  Created by ybon on 2017/3/31.
//  Copyright © 2017年 ybon. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var _tableView:UITableView?;
    private var _typeArray = ["翻页效果","淡入淡出","立方体翻转","吸纸效果","水波效果","缩放效果","切圆效果","翻转效果","单一填充效果","旋转效果","左右扫描","上下扫描"];
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false;
        _tableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-64));
        _tableView?.delegate = self;
        _tableView?.dataSource = self;
        self.view.addSubview(_tableView!);
        _tableView?.tableFooterView = UIView.init();
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _typeArray.count;
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ID = "cell";
        var cell = tableView.dequeueReusableCell(withIdentifier: ID);
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: ID);
        }
        cell?.textLabel?.text = _typeArray[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        let VC = PushViewController.init(nibName:"PushViewController",bundle:nil);
 
        switch indexPath.row {
        case 0:
            VC.animationType = .pageCurlAnimation;
        case 1:
            VC.animationType = .fadeAnimation;
        case 2:
            VC.animationType = .cubeAnimation;
        case 3:
            VC.animationType = .suckEffectAnimation;
        case 4:
            VC.animationType = .rippleEffectAnimation;
        case 5:
            VC.animationType = .scaleAnimation;
        case 6:
            VC.animationType = .roundAnimation;
        case 7:
            VC.animationType = .flipOverAnimation;
        case 8:
            VC.animationType = .accumulateAnimation;
        case 9:
            VC.animationType = .revolveAnimation;
        case 10:
            VC.animationType = .rlScanAnimation;
        case 11:
            VC.animationType = .tbScanAnimation;
        default:
            break;
        }
        
         self.navigationController?.pushViewController(VC, animated: true);
        
    }
}

