//
//  ViewController.swift
//  LaunchesDemo
//
//  Created by hadi on 26/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var blocker: CustomBlocker!
    @IBOutlet weak var floating_space_image: UIImageView!
    @IBOutlet weak var floating_space_dim_view: UIView!
    @IBOutlet weak var rocketCollectionView: UICollectionView!
    
    
    var sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    var cellHeight: CGFloat = 0
    var cellsPerRow: CGFloat = 0
    var cellWidth: CGFloat = 0
    var didSelectThisIndex:Int=0
    
    
    var launchesViewModelArray=[LaunchViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        // Do any additional setup after loading the view.
        callWebService()
    }
    
    func setDesign(){
        blocker.initParams()
        errorView.isHidden=true
        floating_space_dim_view.addoverlay(color: .black, alpha: 0.5)
        floating_space_image.addRoundEdge(rounding: 6)
        floating_space_dim_view.addRoundEdge(rounding: 6)
        
        floating_space_dim_view.roundCorners([.bottomLeft,.bottomRight,.topRight,.topLeft], radius: 6)

        
        sectionInsets.top=LAUNCH_CONS.TODAY_CELL_VERTICAL_SPACING
        sectionInsets.left=LAUNCH_CONS.TODAY_CELL_HORIZONTAL_SPACING
        sectionInsets.bottom=LAUNCH_CONS.TODAY_CELL_VERTICAL_SPACING
        sectionInsets.right=LAUNCH_CONS.TODAY_CELL_HORIZONTAL_SPACING
        
        // cells per row depending on the size class
        if (LAUNCH_CONS.DEVICE_WIDTH > LAUNCH_CONS.MAX_NORMAL_IPAD_WIDTH_CLASS){
            cellsPerRow = 5   // iPad 12.9"
        } else if (LAUNCH_CONS.MAX_NORMAL_IPAD_WIDTH_CLASS > LAUNCH_CONS.DEVICE_WIDTH && LAUNCH_CONS.DEVICE_WIDTH > LAUNCH_CONS.MAX_PHONE_WIDTH_CLASS) {
            cellsPerRow = 4
        } else {
            cellsPerRow = 2
        }
        
        // calculating the cell's width using the determined itemsPerRow value
        let paddingSpace = 4 * (cellsPerRow + 1)
        let availableWidth = LAUNCH_CONS.DEVICE_WIDTH - (paddingSpace)
        cellWidth = availableWidth / cellsPerRow
        cellHeight = cellWidth*LAUNCH_CONS.TODAY_CELL_RATIO
    }
    
    func callWebService(){
        self.errorView.isHidden=true
        self.blocker.start()
        webServiceController.CallGetLaunchesWebservice(respondToController: self, passOnDict: nil)
    }
    
    func getLaunchesSuccess(_ res:GetLaunchesResponse){
        self.blocker.stop()
        loop:for item in res.launchesArray {
            if let dateLocal = item.dateLocal {
            guard checkIfDateIsValid(dateString: dateLocal) == true else {
                continue loop
            }
                
                let viewModel = LaunchViewModel(success: item.success, upcoming: item.upcoming, dateLocal: getFormattedDateFromString(dateString: dateLocal), flight_number: item.flight_number, details: item.details, name: item.name, wikipediaLink: item.links?.wikipedia)
                 launchesViewModelArray.append(viewModel)
            }
        }
        
        guard launchesViewModelArray.count > 0 else {
            return
        }
        
        rocketCollectionView.reloadData()
        
        
    }
    
    
    func getLaunchesFailure() {
        self.errorView.isHidden=false
        self.blocker.stop()
    }
    

    func checkIfDateIsValid(dateString:String)->Bool{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        if let luanchDate = dateFormatter.date(from: String(dateString)) {
        let currentDate = Date()
        let finalDate = currentDate.addYear(n: -3)
            
        if finalDate > luanchDate {
         return false
        }
        } else {
            return false
        }
        return true
    }
    
    
    func getFormattedDateFromString(dateString:String)->String{
        let date = dateString.dateFormatter(givenPattern: "yyyy-MM-dd'T'HH:mm:ss.SSSZ" ,pattern:"dd MMM yyyy, HH:mm z Z")
        return date
    }

    @IBAction func retryTapped(_ sender: Any) {
        callWebService()
    }
    
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
          if let dest = segue.destination as? LaunchDetailsVC {
              dest.viewModel = launchesViewModelArray[didSelectThisIndex]
          }
      }
    
    @IBAction func unwindToMainViewController(segue: UIStoryboardSegue) {
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return launchesViewModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rocketCollectionViewCell", for: indexPath) as! RocketCollectionViewCell
          let currentViewModel = launchesViewModelArray[indexPath.row]
          cell.setData(viewModel:currentViewModel)
          return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         self.didSelectThisIndex = indexPath.row
         self.performSegue(withIdentifier: "gotoLaunchDetailsVCfromMainVC", sender: nil)
      }

}

extension ViewController:UICollectionViewDelegateFlowLayout {

    // return the calculated cell's width and height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:cellWidth , height: cellHeight)
    }

   //  top,left,bottom,right collection view padding
    func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       insetForSectionAt section: Int
     ) -> UIEdgeInsets {
       return sectionInsets
     }

    // inBetween cells Horizantal Spacing
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return LAUNCH_CONS.TODAY_CELL_HORIZONTAL_SPACING
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LAUNCH_CONS.TODAY_CELL_HORIZONTAL_SPACING
    }
}

