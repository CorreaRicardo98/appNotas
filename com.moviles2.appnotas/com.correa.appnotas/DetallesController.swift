//
//  DetallesController.swift
//  com.correa.appnotas
//
//  Created by Mac17 on 15/04/21.
//

import UIKit

class DetallesController: UIViewController {

    
    var titulo: String?
    var index:Int?
    var notas:[String]?
    
    @IBOutlet weak var notaEditarTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        notaEditarTextField.text = titulo

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func guardarNOtaEditada(_ sender: Any) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
