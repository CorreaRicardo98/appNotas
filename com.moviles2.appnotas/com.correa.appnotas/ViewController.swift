//
//  ViewController.swift
//  com.correa.appnotas
//
//  Created by Mac17 on 15/04/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var Notas:[String] = ["ir al Gym","Dormir","Comer","Comprar Comida"]
    var fechas:[String] =  ["20/04/2021","20/04/2021","20/04/2021","20/04/2021","20/04/2021","20/04/2021"]
    var index: Int?
    var nota: String?
    
    var defaultBD = UserDefaults.standard
   
    
    @IBOutlet weak var tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //estos dos metodos se implementan de a fuerza
        tabla.delegate = self
        tabla.dataSource = self
        
        if defaultBD.array(forKey:"notas") == nil {
            
        }else{
            Notas = defaultBD.array(forKey: "notas") as! [String]
            fechas = defaultBD.array(forKey: "fechas") as! [String]
        }
        
        if defaultBD.array(forKey:"fechas") == nil {
            
        }else{
            fechas = defaultBD.array(forKey: "fechas") as! [String]
        }
       
        
        
    }
    
    override func viewWillAppear(_ animated:Bool){
        self.tabla.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Notas.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Notas"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = indexPath.row
        
        performSegue(withIdentifier: "enviar", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.Notas.remove(at: indexPath.row)
            self.fechas.remove(at:indexPath.row)
            self.defaultBD.set(self.Notas,forKey:"notas")
            self.defaultBD.set(self.fechas,forKey:"fechas")
            self.tabla.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "enviar" {
            
            let ObjDetalle = segue.destination as! DetallesController
            
            
            nota = Notas[index!]
            
            
            ObjDetalle.titulo = nota ?? ""
            ObjDetalle.notas = self.Notas
            ObjDetalle.index = index
        
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCelda = tabla.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        objCelda.textLabel?.text = Notas[indexPath.row]
        objCelda.detailTextLabel?.text = fechas[indexPath.row]
        
        return objCelda
    }
    
    
    //MARK: - boton de agregar
    @IBAction func AgregarNota(_ sender: Any) {
        var textFiel = UITextField()
        let alerta = UIAlertController(
            title: "agregar nueva nota", message: "agregue los datos de la nota", preferredStyle: .alert
        )
        
        let accionAceptar = UIAlertAction(title: "Aceptar", style: .default){(_) in
            print("aceptar agregar nota")
            let today = Date()
            let dateFormatter = DateFormatter()
            self.fechas.append(dateFormatter.string(from:today))
            self.Notas.append(textFiel.text ?? "no hay nota")
            
            self.tabla.reloadData()
            
            self.defaultBD.set(self.Notas, forKey: "notas")
            self.defaultBD.set(self.fechas,forKey:"fechas")
        }
        
        let accionCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
        
        alerta.addTextField { (textFieldAlert) in
            textFieldAlert.placeholder = "Nueva Nota..."
            textFiel = textFieldAlert
            
        }
        
        alerta.addAction(accionAceptar)
        alerta.addAction(accionCancelar)
        
        present(alerta, animated: true, completion: nil)
    }
    
}

