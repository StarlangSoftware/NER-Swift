//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import AnnotatedTree
import Dictionary
import NamedEntityRecognition

public class TurkishTreeAutoNER : TreeAutoNER{
    
    public init(){
        super.init(secondLanguage: .TURKISH_WORD)
    }
    
    override func autoDetectPerson(parseTree: ParseTreeDrawable){
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTurkishLeafNode())
        let leafList = nodeDrawableCollector.collect()
        for parseNode in leafList{
            if !parseNode.layerExists(viewLayerType: .NER){
                let word = parseNode.getLayerData(viewLayer: .TURKISH_WORD)?.lowercased()
                if Word.isHonorific(surfaceForm: word!) && parseNode.getParent()?.getData()?.getName() == "NNP"{
                    parseNode.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "PERSON")
                }
                parseNode.checkGazetteer(gazetteer: AutoNER().personGazetteer, word: word!)
            }
        }
    }

    override func autoDetectLocation(parseTree: ParseTreeDrawable){
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTurkishLeafNode())
        let leafList = nodeDrawableCollector.collect()
        for parseNode in leafList{
            if !parseNode.layerExists(viewLayerType: .NER){
                let word = parseNode.getLayerData(viewLayer: .TURKISH_WORD)?.lowercased()
                parseNode.checkGazetteer(gazetteer: AutoNER().locationGazetteer, word: word!)
            }
        }
    }

    override func autoDetectOrganization(parseTree: ParseTreeDrawable){
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTurkishLeafNode())
        let leafList = nodeDrawableCollector.collect()
        for parseNode in leafList{
            if !parseNode.layerExists(viewLayerType: .NER){
                let word = parseNode.getLayerData(viewLayer: .TURKISH_WORD)?.lowercased()
                if Word.isOrganization(surfaceForm: word!) {
                    parseNode.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "ORGANIZATION")
                }
                parseNode.checkGazetteer(gazetteer: AutoNER().organizationGazetteer, word: word!)
            }
        }
    }

    override func autoDetectMoney(parseTree: ParseTreeDrawable){
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTurkishLeafNode())
        let leafList = nodeDrawableCollector.collect()
        for i in 0..<leafList.count{
            let parseNode = leafList[i]
            if !parseNode.layerExists(viewLayerType: .NER){
                let word = parseNode.getLayerData(viewLayer: .TURKISH_WORD)?.lowercased()
                if Word.isMoney(surfaceForm: word!){
                    parseNode.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "MONEY")
                    var j : Int = i - 1
                    while j >= 0{
                        let previous = leafList[j]
                        if previous.getParent()?.getData()?.getName() == "CD"{
                            previous.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "MONEY")
                        } else {
                            break
                        }
                        j = j - 1
                    }
                }
            }
        }
    }

    override func autoDetectTime(parseTree: ParseTreeDrawable){
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTurkishLeafNode())
        let leafList = nodeDrawableCollector.collect()
        for i in 0..<leafList.count{
            let parseNode = leafList[i]
            if !parseNode.layerExists(viewLayerType: .NER){
                let word = parseNode.getLayerData(viewLayer: .TURKISH_WORD)?.lowercased()
                if Word.isTime(surfaceForm: word!){
                    parseNode.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "TIME")
                    let previous = leafList[i - 1]
                    if previous.getParent()?.getData()?.getName() == "CD"{
                        previous.getLayerInfo().setLayerData(viewLayer: .NER, layerValue: "TIME")
                    }
                }
            }
        }
    }

}
