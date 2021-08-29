//
//  ViewController.swift
//  TransferApp
//
//  Created by Артур Карачев on 28.08.2021.
//

import UIKit

protocol UpdatableDataController: AnyObject {
    var updatedData: String { get set }
}

class ViewController: UIViewController, UpdatableDataController, DataUpdateProtocol {
    
    func onDataUpdate(data: String) {
        updatedData = data
        updateLabel(withText: data)
    }
    
    @IBOutlet var dataLabel: UILabel!
    
    var updatedData: String = "Test data"
    
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditScreen":
            prepareEditScreen(segue)
        default:
            break
        }
    }
    
    // переход от А к Б
    // передача данных с помощью свойства и установка делегата
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
        // безопасно извлекаем опциональное значение
        guard let destinationController = segue.destination as? SecondViewController else
        {
            return
            
        }
        destinationController.updatingData = dataLabel.text ?? ""
        
    }
    
    // переход от А к Б
    // передача данных с помощью свойства и инициализация замыкания
    @IBAction func editDataWithСlosure(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // передаем необходимое замыкание
        editScreen.completionHandler = { [unowned self] updatedValue in
            updatedData = updatedValue
            updateLabel(withText: updatedValue) }
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    
    // Обновляем данные в текстовой метке
    private func updateLabel(withText text: String) {
        dataLabel.text = updatedData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контроллер, в который происходит переход
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! UpdatingDataController
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""
        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen as! UIViewController, animated: true)
    }
    
}

