//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import AnnotatedSentence
import AnnotatedTree

public class TreeAutoNER{
    
    var secondLanguage: ViewLayerType
    
    /// The method should detect PERSON named entities. PERSON corresponds to people or
    /// characters. Example: {\bf Atatürk} yurdu düşmanlardan kurtardı.
    /// - Parameter parseTree: The tree for which PERSON named entities checked.
    func autoDetectPerson(parseTree: ParseTreeDrawable){
    }
    
    /// The method should detect LOCATION named entities. LOCATION corresponds to regions,
    /// mountains, seas. Example: Ülkemizin başkenti {\bf Ankara'dır}.
    /// - Parameter parseTree: The tree for which LOCATION named entities checked.
    func autoDetectLocation(parseTree: ParseTreeDrawable){
    }
    
    /// The method should detect ORGANIZATION named entities. ORGANIZATION corresponds to companies,
    /// teams etc. Example:  {\bf IMKB} günü 60 puan yükselerek kapattı.
    /// - Parameter parseTree: The tree for which ORGANIZATION named entities checked.
    func autoDetectOrganization(parseTree: ParseTreeDrawable){
    }
    
    /// The method should detect MONEY named entities. MONEY corresponds to monetarial
    /// expressions. Example: Geçen gün {\bf 3000 TL} kazandık.
    /// - Parameter parseTree: The tree for which MONEY named entities checked.
    func autoDetectMoney(parseTree: ParseTreeDrawable){
    }
    
    /// The method should detect TIME named entities. TIME corresponds to time
    /// expressions. Example: {\bf Cuma günü} tatil yapacağım.
    /// - Parameter parseTree: The tree for which TIME named entities checked.
    func autoDetectTime(parseTree: ParseTreeDrawable){
    }
    
    /// Constructor for the TreeAutoNER. Sets the language for the NER annotation. Currently, the system supports Turkish
    /// and Persian.
    /// - Parameter secondLanguage: Language for NER annotation.
    public init(secondLanguage: ViewLayerType){
        self.secondLanguage = secondLanguage
    }
    
    /// The main method to automatically detect named entities in a tree. The algorithm
    /// 1. Detects PERSON(s).
    /// 2. Detects LOCATION(s).
    /// 3. Detects ORGANIZATION(s).
    /// 4. Detects MONEY.
    /// 5. Detects TIME.
    /// For not detected nodes, the algorithm sets the named entity "NONE".
    /// - Parameter parseTree: The tree for which named entities checked.
    public func autoNER(parseTree: ParseTreeDrawable){
        autoDetectPerson(parseTree: parseTree)
        autoDetectLocation(parseTree: parseTree)
        autoDetectOrganization(parseTree: parseTree)
        autoDetectMoney(parseTree: parseTree)
        autoDetectTime(parseTree: parseTree)
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTransferable(secondLanguage: secondLanguage))
        let leafList = nodeDrawableCollector.collect()
        for parseNode in leafList{
            if !parseNode.layerExists(viewLayerType: .NER){
                parseNode.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "NONE")
            }
        }
    }

}
