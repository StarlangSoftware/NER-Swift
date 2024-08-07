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
    
    /// The method assigns the words "bay" and "bayan" PERSON tag. The method also checks the PERSON gazetteer, and if
    /// the word exists in the gazetteer, it assigns PERSON tag. The parent node should have the proper noun tag NNP.
    /// - Parameter parseTree: The tree for which PERSON named entities checked.
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
    
    /// The method checks the LOCATION gazetteer, and if the word exists in the gazetteer, it assigns the LOCATION tag.
    /// - Parameter parseTree: The tree for which LOCATION named entities checked.
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
    
    /// The method assigns the words "corp.", "inc.", and "co" ORGANIZATION tag. The method also checks the
    /// ORGANIZATION gazetteer, and if the word exists in the gazetteer, it assigns ORGANIZATION tag.
    /// - Parameter parseTree: The tree for which ORGANIZATION named entities checked.
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
    
    /// The method checks for the MONEY entities using regular expressions. After that, if the expression is a MONEY
    /// expression, it also assigns the previous nodes, which may included numbers or some monetarial texts, MONEY tag.
    /// - Parameter parseTree: The tree for which MONEY named entities checked.
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
    
    /// The method checks for the TIME entities using regular expressions. After that, if the expression is a TIME
    /// expression, it also assigns the previous texts, which are numbers, TIME tag.
    /// - Parameter parseTree: The tree for which TIME named entities checked.
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
