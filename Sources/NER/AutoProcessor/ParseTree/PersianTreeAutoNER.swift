//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import AnnotatedSentence
import AnnotatedTree

public class PersianTreeAutoNER : TreeAutoNER{
    
    public override init(secondLanguage: ViewLayerType) {
        super.init(secondLanguage: .PERSIAN_WORD)
    }
    
    override func autoDetectPerson(parseTree: ParseTreeDrawable){
    }

    override func autoDetectLocation(parseTree: ParseTreeDrawable){
    }

    override func autoDetectOrganization(parseTree: ParseTreeDrawable){
    }

    override func autoDetectMoney(parseTree: ParseTreeDrawable){
    }

    override func autoDetectTime(parseTree: ParseTreeDrawable){
    }

}
