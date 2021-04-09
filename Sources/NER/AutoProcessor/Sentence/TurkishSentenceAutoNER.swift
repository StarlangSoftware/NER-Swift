//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 9.04.2021.
//

import Foundation
import AnnotatedSentence
import Dictionary
import MorphologicalAnalysis

public class TurkishSentenceAutoNER : SentenceAutoNER{
    
    /**
     * The method assigns the words "bay" and "bayan" PERSON tag. The method also checks the PERSON gazetteer, and if
     * the word exists in the gazetteer, it assigns PERSON tag.
     - Parameters:
        - sentence: The sentence for which PERSON named entities checked.
     */
    public override func autoDetectPerson(sentence: AnnotatedSentence) {
        for i in 0..<sentence.wordCount() {
            let word = sentence.getWord(index: i) as! AnnotatedWord
            if word.getNamedEntityType() == nil && word.getParse() != nil {
                if Word.isHonorific(surfaceForm: word.getName()) {
                    word.setNamedEntityType(namedEntity: "PERSON")
                }
                word.checkGazetteer(gazetteer: personGazetteer)
            }
        }
    }

    /**
     * The method checks the LOCATION gazetteer, and if the word exists in the gazetteer, it assigns the LOCATION tag.
     - Parameters:
        - sentence: The sentence for which LOCATION named entities checked.
     */
    public override func autoDetectLocation(sentence: AnnotatedSentence) {
        for i in 0..<sentence.wordCount() {
            let word = sentence.getWord(index: i) as! AnnotatedWord
            if word.getNamedEntityType() == nil && word.getParse() != nil {
                word.checkGazetteer(gazetteer: locationGazetteer)
            }
        }
    }

    /**
     * The method assigns the words "corp.", "inc.", and "co" ORGANIZATION tag. The method also checks the
     * ORGANIZATION gazetteer, and if the word exists in the gazetteer, it assigns ORGANIZATION tag.
     - Parameters:
        - sentence: The sentence for which ORGANIZATION named entities checked.
     */
    public override func autoDetectOrganization(sentence: AnnotatedSentence) {
        for i in 0..<sentence.wordCount() {
            let word = sentence.getWord(index: i) as! AnnotatedWord
            if word.getNamedEntityType() == nil && word.getParse() != nil {
                if Word.isOrganization(surfaceForm: word.getName()) {
                    word.setNamedEntityType(namedEntity: "ORGANIZATION")
                }
                word.checkGazetteer(gazetteer: organizationGazetteer)
            }
        }
    }

    /**
     * The method checks for the TIME entities using regular expressions. After that, if the expression is a TIME
     * expression, it also assigns the previous texts, which are numbers, TIME tag.
     - Parameters:
        - sentence: The sentence for which TIME named entities checked.
     */
    public override func autoDetectTime(sentence: AnnotatedSentence) {
        for i in 0..<sentence.wordCount() {
            let word = sentence.getWord(index: i) as! AnnotatedWord
            let wordLowercase = Word.lowercase(s: word.getName())
            if word.getNamedEntityType() == nil && word.getParse() != nil {
                if Word.isTime(surfaceForm: wordLowercase) {
                    word.setNamedEntityType(namedEntity: "TIME")
                    if i > 0 {
                        let previous = sentence.getWord(index: i - 1) as! AnnotatedWord
                        if previous.getParse()!.containsTag(tag: MorphologicalTag.CARDINAL) {
                            previous.setNamedEntityType(namedEntity: "TIME")
                        }
                    }
                }
            }
        }
    }

    /**
     * The method checks for the MONEY entities using regular expressions. After that, if the expression is a MONEY
     * expression, it also assigns the previous text, which may included numbers or some monetarial texts, MONEY tag.
     - Parameters:
        - sentence: The sentence for which MONEY named entities checked.
     */
    public override func autoDetectMoney(sentence: AnnotatedSentence) {
        for i in 0..<sentence.wordCount() {
            let word = sentence.getWord(index: i) as! AnnotatedWord
            let wordLowercase = Word.lowercase(s: word.getName())
            if word.getNamedEntityType() == nil && word.getParse() != nil {
                if Word.isMoney(surfaceForm: wordLowercase) {
                    word.setNamedEntityType(namedEntity: "MONEY")
                    var j : Int = i - 1
                    while j >= 0 {
                        let previous = sentence.getWord(index: j) as! AnnotatedWord
                        if previous.getParse() != nil && (previous.getName() == "amerikan" || previous.getParse()!.containsTag(tag: MorphologicalTag.REAL) || previous.getParse()!.containsTag(tag: MorphologicalTag.CARDINAL) || previous.getParse()!.containsTag(tag: MorphologicalTag.NUMBER)) {
                            previous.setNamedEntityType(namedEntity: "MONEY")
                        } else {
                            break
                        }
                        j -= 1
                    }
                }
            }
        }
    }

}
