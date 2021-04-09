//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 9.04.2021.
//

import Foundation
import AnnotatedSentence
import NamedEntityRecognition

public class SentenceAutoNER : AutoNER{
    
    /**
     * The method should detect PERSON named entities. PERSON corresponds to people or
     * characters. Example: {\bf Atatürk} yurdu düşmanlardan kurtardı.
     - Parameters:
        - sentence: The sentence for which PERSON named entities checked.
     */
    public func autoDetectPerson(sentence: AnnotatedSentence){}

    /**
     * The method should detect LOCATION named entities. LOCATION corresponds to regions,
     * mountains, seas. Example: Ülkemizin başkenti {\bf Ankara'dır}.
     - Parameters:
        - sentence: The sentence for which LOCATION named entities checked.
     */
    public func autoDetectLocation(sentence: AnnotatedSentence){}

    /**
     * The method should detect ORGANIZATION named entities. ORGANIZATION corresponds to companies,
     * teams etc. Example:  {\bf IMKB} günü 60 puan yükselerek kapattı.
     - Parameters:
        - sentence: The sentence for which ORGANIZATION named entities checked.
     */
    public func autoDetectOrganization(sentence: AnnotatedSentence){}

    /**
     * The method should detect MONEY named entities. MONEY corresponds to monetarial
     * expressions. Example: Geçen gün {\bf 3000 TL} kazandık.
     - Parameters:
        - sentence: The sentence for which MONEY named entities checked.
     */
    public func autoDetectMoney(sentence: AnnotatedSentence){}

    /**
     * The method should detect TIME named entities. TIME corresponds to time
     * expressions. Example: {\bf Cuma günü} tatil yapacağım.
     - Parameters:
        - sentence: The sentence for which TIME named entities checked.
     */
    public func autoDetectTime(sentence: AnnotatedSentence){}

    /**
     * The main method to automatically detect named entities in a sentence. The algorithm
     * 1. Detects PERSON(s).
     * 2. Detects LOCATION(s).
     * 3. Detects ORGANIZATION(s).
     * 4. Detects MONEY.
     * 5. Detects TIME.
     * For not detected words, the algorithm sets the named entity "NONE".
     - Parameters:
        - sentence: The sentence for which named entities checked.
     */
    public func autoNER(sentence: AnnotatedSentence){
        autoDetectPerson(sentence: sentence)
        autoDetectLocation(sentence: sentence)
        autoDetectOrganization(sentence: sentence)
        autoDetectMoney(sentence: sentence)
        autoDetectTime(sentence: sentence)
        for i in 0..<sentence.wordCount() {
            let word = sentence.getWord(index: i) as! AnnotatedWord
            if word.getNamedEntityType() == nil {
                word.setNamedEntityType(namedEntity: "NONE")
            }
        }
    }

    
}
