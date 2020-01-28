//
//  HomeViewController.swift
//  Service Operations Monitor
//
//  Created by thirumal on 10/24/17.
//  Copyright © 2017 Benz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var collectionView : UICollectionView!
   
        let titleList : [String] = ["Request Doctor", "My Doctor","Notification","Activity","Schedule","Instant Messaging" , "Reports", "Personal Info","Analystic","Bill Payment","Calendar","Prescription" , "Pickups", "Map","Email","History"]
      let IdendifierList : [String] = ["Request Doctor", "My Doctor","Notification","Activity","Schedule","instantmessage" , "Reports", "Personal Info","Analystic","Bill Payment","Calendar","Prescription" , "Pickups", "Map","Email","History"]
        let imageList : [String] = ["request", "mydoctor","notification","activity","schedule","instantmessaging" , "report1", "personalinfo","report","billpayment","calendar","prescription" , "pickup", "map","email","history"]
    
    //MARK:- View life cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        self.navigationItem.setHidesBackButton(true, animated: true);

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
      
        
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return self.titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCellIdentifier.Home, for: indexPath) as! HomeCollectionViewCell
        cell.titleLable.text = self.titleList[indexPath.row]
        cell.imageView.image = UIImage(named : self.imageList[indexPath.row])
      
//        let borderHexColor = ["7085C6","339C4D","1D7C63","307BB8","C85223","C88110","CE2121"][indexPath.item]
////        let borderHexColor = borderHexColor[indexPath.row]
//        let borderColor = UIColor.init(hexString: borderHexColor, a: 1.0)
//        cell.outerView.layer.borderColor = borderColor?.cgColor
//        cell.outerView.layer.borderWidth = 1.0
//        cell.imageView.backgroundColor = borderColor
//        cell.outerView.backgroundColor = UIColor.init(hexString: borderHexColor, a: 0.4)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        if indexPath.row == 5 {
            let identifiername = self.IdendifierList[indexPath.row]
                   if identifiername != ""
                   {
//                      let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                       let controller = storyboard.instantiateViewController(withIdentifier: "instantmessage")
//                       self.present(controller, animated: true, completion: nil)

//                       // Safe Present
//                       if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peerchat") as? PeerViewController
//                       {
//                           present(vc, animated: true, completion: nil)
//                       }
                    
                    // Safe Push VC
                    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "peerchat") as? PeerViewController {
                        if let navigator = navigationController {
                            navigator.pushViewController(viewController, animated: true)
                        }
                    }
                   }
        }else{
            
        }
//        let identifiername = self.IdendifierList[indexPath.row]
//        if identifiername != ""
//        {
//            let next_VC = CommonFunctions.shared.getViewControllerWithIdentifier(identifier: identifiername)
//            self.navigationController?.pushViewController(next_VC, animated: true)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: collectionView.frame.size.width / 4, height: collectionView.frame.size.height / 3)
    }
    
    private func setDataList()
    {
      
       
        self.collectionView.reloadData()
    }
    
   
    
}

