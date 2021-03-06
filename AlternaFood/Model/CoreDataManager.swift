//
//  CoreDataManager.swift
//  AlternaFood
//
//  Created by Leonardo Gomes Fernandes on 20/11/20.
//
//swiftlint:disable function_parameter_count

import Foundation
import CoreData
import UIKit

class CDManager {

    let viewContext = ((UIApplication.shared.delegate as? AppDelegate) ?? AppDelegate()).persistentContainer.viewContext
    
    let coordinator = ((UIApplication.shared.delegate as? AppDelegate) ?? AppDelegate()).persistentContainer.persistentStoreCoordinator
    
    func saveContext() -> Bool {
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
        
        return true
    }

    func saveAlimento(uuidAlimento: String, nomeAlimento: String, pathImageAlimento: String ) -> Bool {

        let alimento = Alimento(context: self.viewContext)
        alimento.idAlimento = UUID(uuidString: uuidAlimento)
        alimento.nomeAlimento = nomeAlimento
        alimento.pathImageAlimento = pathImageAlimento

        return saveContext()
    }

    func saveSubstituto(uuidSubstituto: String, nomeSubstituto: String, descricaoSubstituto: String, pathImage: String, pathIcon: String) -> Bool {
        
        let substituto = Substituto(context: self.viewContext)
        substituto.idSubstituto = UUID(uuidString: uuidSubstituto)
        substituto.nomeSubstituto = nomeSubstituto
        substituto.descricaoSubstituto = descricaoSubstituto
        substituto.pathImageSubstituto = pathImage
        substituto.pathIconSubstituto = pathIcon
        
       return saveContext()
    }

    func listaAlimentos() -> [Alimento] {

        var listaDeAlimentos: [Alimento] = []
        do {
            let request = Alimento.fetchRequest() as NSFetchRequest<Alimento>

            listaDeAlimentos = try viewContext.fetch(request)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        return listaDeAlimentos
    }

    func listaSubstitutos() -> [Substituto] {
        
        var listaDeSubstitutos: [Substituto] = []
        
        do {
            let request = Substituto.fetchRequest() as NSFetchRequest<Substituto>
            
            listaDeSubstitutos = try viewContext.fetch(request)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return listaDeSubstitutos
    }
    
    func requestAlimentoByID(uuid: String) -> Alimento {
        let requestAlim = Alimento.fetchRequest() as NSFetchRequest<Alimento>
        requestAlim.predicate = NSPredicate(format: "idAlimento == %@", uuid)
        
        do {
            let alimentos = try viewContext.fetch(requestAlim)
            return alimentos[0]
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return Alimento()
    }
    
    func requestSubstitutoByID(uuid: String) -> Substituto {
        let requestSubst = Substituto.fetchRequest() as NSFetchRequest<Substituto>
        requestSubst.predicate = NSPredicate(format: "idSubstituto == %@", uuid)
        
        do {
            let substitutos = try viewContext.fetch(requestSubst)
            return substitutos[0]
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return Substituto()
    }
    
    func requestAlimentoByName(nome: String) -> [Alimento] {
        let requestAlim = Alimento.fetchRequest() as NSFetchRequest<Alimento>
        //NSPredicate(format: "SELF CONTAINS %@", "anc")
        requestAlim.predicate = NSPredicate(format: "nomeAlimento CONTAINS[CD] %@", nome)
        //requestAlim.predicate = NSPredicate(format: "nomeAlimento == %@", nome)
        
        do {
            let alimentos = try viewContext.fetch(requestAlim)
            return alimentos
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return [Alimento()]
    }
    
    func requestReceitaByName(nome: String) -> [Receita] {
        let requestRecei = Receita.fetchRequest() as NSFetchRequest<Receita>
        //NSPredicate(format: "SELF CONTAINS %@", "anc")
        requestRecei.predicate = NSPredicate(format: "nomeReceita CONTAINS[CD] %@", nome)
        //requestAlim.predicate = NSPredicate(format: "nomeAlimento == %@", nome)
        
        do {
            let receitas = try viewContext.fetch(requestRecei)
            return receitas
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return [Receita()]
    }
    
    func saveReceita(idAReceita: String, nomeReceita: String, porcoes: String, tempo: String, ingredientes: [String], preparo: [String], pathImage: String, idAlimentoFrom: String, idSubstituto: String) -> Bool {
        
        let receita = Receita(context: self.viewContext)
        receita.idReceita = UUID(uuidString: idAReceita)
        receita.nomeReceita = nomeReceita
        receita.porcaoReceita = porcoes
        receita.tempoPreparoReceita = tempo
        receita.ingredientesReceita = ingredientes
        receita.preparoReceita = preparo
        receita.imageReceita = pathImage
        receita.idAlimentoFrom = UUID(uuidString: idAlimentoFrom)
        receita.idSubstituto = UUID(uuidString: idSubstituto)
     
        return saveContext()
    }
    
    func listaReceitas() -> [Receita] {
        
        var receitas: [Receita] = []
        
        do {
            let request = Receita.fetchRequest() as NSFetchRequest<Receita>
            
            receitas = try viewContext.fetch(request)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return receitas
    }
    
    func clearDatabase(entity: String ) {
        let context = viewContext
        let coord = coordinator
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity )
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.execute(deleteRequest, with: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
}
