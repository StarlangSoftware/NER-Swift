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
    
    func autoDetectPerson(parseTree: ParseTreeDrawable){
    }

    func autoDetectLocation(parseTree: ParseTreeDrawable){
    }

    func autoDetectOrganization(parseTree: ParseTreeDrawable){
    }

    func autoDetectMoney(parseTree: ParseTreeDrawable){
    }

    func autoDetectTime(parseTree: ParseTreeDrawable){
    }
    
    public init(secondLanguage: ViewLayerType){
        self.secondLanguage = secondLanguage
    }
    
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
